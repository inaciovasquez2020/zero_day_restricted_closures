#!/usr/bin/env python3
from __future__ import annotations

import itertools
import json
from pathlib import Path
from typing import Iterable, Sequence

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core/vasquez_bounded_closure_equation_surface.json"

EXPECTED_NAMES = [
    "m_proof",
    "m_witness",
    "m_invariant",
    "m_verifier",
    "m_evidence",
    "m_guard",
]
EXPECTED_WEIGHTS = [32, 16, 8, 4, 2, 1]


def fail(message: str) -> "NoReturn":
    raise SystemExit(f"MISSING_OBJECT := {message}")


def descending_profile(values: Iterable[int], width: int) -> tuple[int, ...]:
    profile = sorted(values, reverse=True)
    if len(profile) > width:
        fail("profile length at most |V|-1")
    return tuple(profile + [0] * (width - len(profile)))


def highest_active_weight(cost: int) -> int:
    if not 1 <= cost <= 63:
        fail("nonzero six-bit edge cost")
    return 1 << (cost.bit_length() - 1)


def verify_single_decrease(profile: Sequence[int], index: int) -> None:
    old_value = profile[index]
    if old_value == 0:
        return
    new_value = old_value - highest_active_weight(old_value)
    updated = list(profile)
    updated[index] = new_value
    old_sorted = tuple(sorted(profile, reverse=True))
    new_sorted = tuple(sorted(updated, reverse=True))
    if not new_sorted < old_sorted:
        fail("single-bit lexicographic profile decrease")


def main() -> int:
    if not SURFACE.is_file():
        fail("core/vasquez_bounded_closure_equation_surface.json")

    try:
        payload = json.loads(SURFACE.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"valid Vasquez surface JSON ({exc})")

    required_scalars = {
        "surface": "VasquezBoundedClosureEquationSurface",
        "classification": "BOUNDED_VERIFICATION_GAP_METRIC_SURFACE_ONLY",
        "scope": "finite_directed_dependency_graph_only",
        "closure_condition": "VerifiedClosure_B(S,T) iff Omega_B(S,T) = 0",
    }
    for key, expected in required_scalars.items():
        if payload.get(key) != expected:
            fail(f"Vasquez surface field {key} = {expected}")

    graph = payload.get("graph_contract")
    if not isinstance(graph, dict) or graph.get("finite") is not True:
        fail("finite graph contract")
    if graph.get("admissible_paths") != "SimplePaths_B(S,T)":
        fail("simple-path admissibility contract")
    if graph.get("profile_length") != "|V|-1":
        fail("|V|-1 profile padding contract")

    edge_cost = payload.get("edge_cost")
    if not isinstance(edge_cost, dict):
        fail("edge-cost object")
    bits = edge_cost.get("bits")
    if not isinstance(bits, list) or len(bits) != 6:
        fail("six missingness bits")

    names = [bit.get("name") for bit in bits if isinstance(bit, dict)]
    weights = [bit.get("weight") for bit in bits if isinstance(bit, dict)]
    if names != EXPECTED_NAMES:
        fail("ordered missingness bit names")
    if weights != EXPECTED_WEIGHTS:
        fail("ordered missingness bit weights")
    if sum(weights) != 63 or any(weight & (weight - 1) for weight in weights):
        fail("six-bit power-of-two encoding")
    for index, weight in enumerate(weights[:-1]):
        if weight <= sum(weights[index + 1 :]):
            fail("strict lexicographic bit priority")

    objectives = payload.get("objectives")
    if not isinstance(objectives, dict):
        fail("objective definitions")
    for key in ("Omega_B", "P_B", "Phi_B", "pi_B_phi", "e_B_phi"):
        if not isinstance(objectives.get(key), str) or not objectives[key]:
            fail(f"objective {key}")

    tie_break = payload.get("deterministic_tie_break")
    if not isinstance(tie_break, dict):
        fail("deterministic tie-break contract")
    if "stable edge identifiers" not in tie_break.get("path_rule", ""):
        fail("deterministic path tie-break")
    if "stable edge identifiers" not in tie_break.get("edge_rule", ""):
        fail("deterministic edge tie-break")

    next_step = payload.get("next_step_rule")
    if not isinstance(next_step, dict):
        fail("next-step rule")
    if next_step.get("target") != "e_B_phi":
        fail("Phi-optimal bottleneck target")
    if "Phi'_B(S,T)" not in next_step.get("acceptance", ""):
        fail("Phi-based acceptance rule")

    lemma = payload.get("monotonicity_lemma")
    if not isinstance(lemma, dict):
        fail("single-decrease monotonicity lemma")
    if lemma.get("proof_status") != "FINITE_ORDER_ARGUMENT_RECORDED_NOT_PROOF_ASSISTANT_FORMALIZED":
        fail("honest monotonicity proof status")

    boundary = payload.get("boundary")
    if not isinstance(boundary, dict):
        fail("bounded-to-unrestricted boundary")
    if boundary.get("status") != "NO_BOUNDED_TO_UNRESTRICTED_BRIDGE_SUPPLIED":
        fail("no bounded-to-unrestricted bridge status")

    blocked = payload.get("blocked_promotions")
    if not isinstance(blocked, list):
        fail("blocked-promotion list")
    required_blocked_fragments = (
        "unrestricted ZeroDayClosure",
        "proof-assistant theorem",
        "most important formula ever known",
        "global novelty established",
    )
    joined_blocked = "\n".join(str(item) for item in blocked)
    for fragment in required_blocked_fragments:
        if fragment not in joined_blocked:
            fail(f"blocked promotion containing {fragment}")

    # Exhaust the complete six-bit cost domain in all three-entry contexts.
    # This checks ties, repeated maxima, and lower-order-bit interactions.
    for profile in itertools.product(range(64), repeat=3):
        for index in range(3):
            verify_single_decrease(profile, index)

    # Check padding and the zero-edge profile convention directly.
    if descending_profile([], 4) != (0, 0, 0, 0):
        fail("zero-edge all-zero profile")
    if descending_profile([1, 32, 4], 5) != (32, 4, 1, 0, 0):
        fail("descending |V|-1 profile padding")

    print("VASQUEZ_BOUNDED_CLOSURE_EQUATION_SURFACE_OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
