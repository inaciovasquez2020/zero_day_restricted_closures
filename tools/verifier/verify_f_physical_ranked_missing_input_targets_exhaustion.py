#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

EXPECTED = [
    (1, "physical_system_context_witness", "core/physical_system_context_witness_target_surface.json"),
    (2, "variable_domain_and_guards_witness", "core/variable_domain_and_guards_witness_target_surface.json"),
    (3, "non_toy_structure_source_witness", "core/non_toy_structure_source_witness_target_surface.json"),
    (4, "derivation_evidence_for_F_physical_witness", "core/derivation_evidence_for_F_physical_witness_target_surface.json"),
    (5, "relative_time_scale_bridge_proof_witness", "core/relative_time_scale_bridge_proof_witness_target_surface.json"),
]

def load(rel):
    path = ROOT / rel
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {rel}")
    return json.loads(path.read_text(encoding="utf-8"))

def has(payload, token):
    return token in json.dumps(payload, sort_keys=True)

def req(condition, message):
    if not condition:
        raise SystemExit("F_PHYSICAL_RANKED_INPUT_TARGETS_EXHAUSTION_FAIL: " + message)

def main():
    ranking = load("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    obligation = load("core/f_physical_derivation_input_witness_obligation_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")
    receipt = load("core/f_physical_ranked_missing_input_targets_exhaustion_receipt_2026_07_07.json")

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    req(len(ranked) == 5, "ranking must contain exactly five ranked gaps")

    for idx, (rank, name, path) in enumerate(EXPECTED):
        req(ranked[idx].get("rank") == rank, f"rank index changed for {name}")
        req(ranked[idx].get("gap") == name, f"ranking gap changed for {name}")

        target = load(path)
        req(target.get("target") == name, f"target name changed for {name}")
        req(target.get("rank") in (rank, None), f"target rank changed for {name}")
        req(target.get("available") is False, f"{name} became available")
        req(target.get("inhabited") is False, f"{name} became inhabited")
        req(has(target, "physical_time_dilation"), f"{name} missing physical boundary")
        req(has(target, "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"), f"{name} missing upstream object")

    req(receipt.get("status") == "ranked_target_chain_exhaustion_receipt_only", "receipt status changed")
    req(receipt.get("ranked_gap_count") == 5, "receipt gap count changed")
    req(receipt.get("ranked_target_surfaces_exhausted") is True, "receipt exhaustion flag changed")
    req(receipt.get("remaining_missing_object") == "F_physical_derivation_input_witness", "remaining object changed")
    req(receipt.get("upstream_missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x", "upstream object changed")
    req(receipt.get("boundary") == "not(physical_time_dilation)", "boundary changed")

    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        req(has(receipt, token), f"receipt missing {token}")

    req(has(obligation, "F_physical_derivation_input_witness"), "obligation lost derivation input witness")
    req(has(obligation, "relative_time_scale_bridge_proof_witness"), "obligation lost rank-5 witness")
    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_RANKED_INPUT_TARGETS_EXHAUSTION_OK")

if __name__ == "__main__":
    main()
