#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path
from typing import NoReturn

ROOT = Path(__file__).resolve().parents[1]

INSTANCE_PATH = (
    ROOT
    / "core"
    / "vasquez_directional_flow_fraction_b_first_edge_instance_surface.json"
)
METRIC_PATH = ROOT / "core" / "vasquez_bounded_closure_equation_surface.json"
SOURCE_PATH = (
    ROOT
    / "core"
    / "directional_flow_fraction_b_conditional_bound_theorem_surface.json"
)
TARGET_PATH = (
    ROOT
    / "core"
    / "directional_flow_fraction_b_lean_conditional_integral_bound_surface.json"
)
LEAN_PATH = (
    ROOT
    / "lean"
    / "Chronos"
    / "Frontier"
    / "DirectionalFlowFractionBConditionalIntegralBound.lean"
)

EXPECTED_BITS = {
    "m_proof": 0,
    "m_witness": 0,
    "m_invariant": 0,
    "m_verifier": 1,
    "m_evidence": 1,
    "m_guard": 0,
}

EXPECTED_WEIGHTS = {
    "m_proof": 32,
    "m_witness": 16,
    "m_invariant": 8,
    "m_verifier": 4,
    "m_evidence": 2,
    "m_guard": 1,
}


def fail(message: str) -> NoReturn:
    raise SystemExit(f"MISSING_OBJECT := {message}")


def load_json(path: Path) -> dict:
    if not path.is_file():
        fail(str(path.relative_to(ROOT)))
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"valid JSON at {path.relative_to(ROOT)} ({exc})")
    if not isinstance(value, dict):
        fail(f"JSON object at {path.relative_to(ROOT)}")
    return value


def main() -> int:
    instance = load_json(INSTANCE_PATH)
    metric = load_json(METRIC_PATH)
    source = load_json(SOURCE_PATH)
    target = load_json(TARGET_PATH)

    if not LEAN_PATH.is_file():
        fail(str(LEAN_PATH.relative_to(ROOT)))

    lean_text = LEAN_PATH.read_text(encoding="utf-8")

    if instance.get("surface") != (
        "VasquezDirectionalFlowFractionBFirstEdgeInstanceSurface"
    ):
        fail("first-edge instance surface name")

    if instance.get("classification") != (
        "BOUNDED_REAL_REPOSITORY_EDGE_COST_INSTANCE_ONLY"
    ):
        fail("first-edge bounded classification")

    if metric.get("surface") != "VasquezBoundedClosureEquationSurface":
        fail("Vasquez metric dependency")

    edge = instance.get("edge")
    if not isinstance(edge, dict):
        fail("edge object")

    if edge.get("source_node") != source.get("surface"):
        fail("edge source node matches source surface")

    if edge.get("target_node") != target.get("surface"):
        fail("edge target node matches target surface")

    if target.get("dependency_theorem_surface") != source.get("surface"):
        fail("target dependency points to source surface")

    theorem_pattern = re.compile(
        r"\btheorem\s+"
        r"directionalFlowFractionB_conditionalIntegralBound\b"
    )
    forbidden_pattern = re.compile(r"\b(axiom|opaque|sorry|admit)\b")

    proof_ok = (
        theorem_pattern.search(lean_text) is not None
        and ":= by" in lean_text
        and forbidden_pattern.search(lean_text) is None
    )

    proof_assistant = target.get("proof_assistant")
    if not isinstance(proof_assistant, dict):
        fail("target proof_assistant object")

    witness_ok = (
        proof_assistant.get("theorem")
        == "Chronos.Frontier.directionalFlowFractionB_conditionalIntegralBound"
        and target.get("encoded_statement", {}).get("status")
        == "LEAN_THEOREM_INHABITED"
        and theorem_pattern.search(lean_text) is not None
        and ":= by" in lean_text
    )

    expected_interpretation_boundary = {
        "is_detector_realization": False,
        "is_empirical_confirmation": False,
        "is_e_equals_m_c_cubed_claim": False,
        "is_alternative_energy_law": False,
        "is_zero_day_closure": False,
    }
    interpretation_boundary = target.get("interpretation_boundary")

    invariant_ok = (
        source.get("bounded_region") == target.get("bounded_region")
        and source.get("assumptions") == target.get("assumptions")
        and target.get("assumption_change_status") == "UNCHANGED"
        and target.get("physical_claim_status") == "NONE_ADDED"
        and interpretation_boundary == expected_interpretation_boundary
    )

    validation_command = proof_assistant.get("validation_command")
    validation_receipt = proof_assistant.get("validation_receipt")

    verifier_ok = (
        isinstance(validation_command, str)
        and bool(validation_command.strip())
        and isinstance(validation_receipt, str)
        and bool(validation_receipt.strip())
        and (ROOT / validation_receipt).is_file()
    )

    lakefile_present = (
        (ROOT / "lakefile.toml").is_file()
        or (ROOT / "lakefile.lean").is_file()
    )
    evidence_ok = (
        (ROOT / "lean-toolchain").is_file()
        and lakefile_present
        and (ROOT / "lake-manifest.json").is_file()
    )

    blocked = set(target.get("blocked_promotions", []))
    required_blocked = {
        "Lean conditional integral bound -> unconditional directional-flow theorem",
        "Lean conditional integral bound -> detector realization",
        "Lean conditional integral bound -> empirical confirmation",
        "Lean conditional integral bound -> E equals m c cubed",
        "Lean conditional integral bound -> ZeroDayClosure",
        "global novelty established",
        "unrestricted ZeroDayClosure",
    }

    guard_ok = (
        blocked == required_blocked
        and interpretation_boundary == expected_interpretation_boundary
        and target.get("novelty_status") == "GLOBAL_NOVELTY_NOT_ESTABLISHED"
    )

    computed_bits = {
        "m_proof": 0 if proof_ok else 1,
        "m_witness": 0 if witness_ok else 1,
        "m_invariant": 0 if invariant_ok else 1,
        "m_verifier": 0 if verifier_ok else 1,
        "m_evidence": 0 if evidence_ok else 1,
        "m_guard": 0 if guard_ok else 1,
    }

    if instance.get("weights") != EXPECTED_WEIGHTS:
        fail("first-edge six-bit weights")

    if instance.get("missingness") != computed_bits:
        fail(
            "first-edge missingness mismatch: "
            f"recorded={instance.get('missingness')} "
            f"computed={computed_bits}"
        )

    if computed_bits != EXPECTED_BITS:
        fail(f"expected initial first-edge bits {EXPECTED_BITS}")

    delta = sum(
        EXPECTED_WEIGHTS[name] * computed_bits[name]
        for name in EXPECTED_WEIGHTS
    )

    if delta != 6:
        fail("first-edge Delta_B = 6")

    if instance.get("delta_B") != delta:
        fail("recorded first-edge Delta_B")

    if instance.get("highest_active_gap") != "m_verifier":
        fail("first-edge highest active gap m_verifier")

    boundary = instance.get("boundary")
    if not isinstance(boundary, dict) or any(boundary.values()):
        fail("first-edge boundary non-claims")

    print("VASQUEZ_DIRECTIONAL_FLOW_FRACTION_B_FIRST_EDGE_INSTANCE_OK")
    print(
        "VASQUEZ_FIRST_EDGE_BITS := "
        "(m_proof,m_witness,m_invariant,m_verifier,m_evidence,m_guard)"
        "=(0,0,0,1,1,0)"
    )
    print("VASQUEZ_FIRST_EDGE_DELTA_B := 6")
    print("VASQUEZ_FIRST_EDGE_NEXT_GAP := m_verifier")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
