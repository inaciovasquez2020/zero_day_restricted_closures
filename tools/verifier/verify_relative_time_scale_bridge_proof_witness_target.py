#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def load(rel):
    path = ROOT / rel
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {rel}")
    return json.loads(path.read_text(encoding="utf-8"))

def has(payload, token):
    return token in json.dumps(payload, sort_keys=True)

def req(condition, message):
    if not condition:
        raise SystemExit("RELATIVE_TIME_SCALE_BRIDGE_PROOF_WITNESS_TARGET_FAIL: " + message)

def main():
    physical = load("core/physical_system_context_witness_target_surface.json")
    variable = load("core/variable_domain_and_guards_witness_target_surface.json")
    non_toy = load("core/non_toy_structure_source_witness_target_surface.json")
    derivation = load("core/derivation_evidence_for_F_physical_witness_target_surface.json")
    obligation = load("core/f_physical_derivation_input_witness_obligation_surface.json")
    ranking = load("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")
    target = load("core/relative_time_scale_bridge_proof_witness_target_surface.json")
    receipt = load("core/relative_time_scale_bridge_proof_witness_next_dependency_receipt_2026_07_07.json")

    for label, payload in {
        "physical": physical,
        "variable": variable,
        "non_toy": non_toy,
        "derivation": derivation,
        "obligation": obligation,
        "ranking": ranking,
        "fixture": fixture,
        "target": target,
        "receipt": receipt,
    }.items():
        req(has(payload, "physical_time_dilation"), f"{label} missing physical_time_dilation boundary")
        req(has(payload, "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"), f"{label} missing upstream object")

    for payload, expected in [
        (physical, "physical_system_context_witness"),
        (variable, "variable_domain_and_guards_witness"),
        (non_toy, "non_toy_structure_source_witness"),
        (derivation, "derivation_evidence_for_F_physical_witness"),
    ]:
        req(payload.get("target") == expected, f"prior target changed: {expected}")
        req(payload.get("available") is False, f"prior target became available: {expected}")
        req(payload.get("inhabited") is False, f"prior target became inhabited: {expected}")

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    req(len(ranked) >= 5, "ranking must contain rank 5")
    req(ranked[4].get("rank") == 5, "rank-5 index changed")
    req(ranked[4].get("gap") == "relative_time_scale_bridge_proof_witness", "rank-5 gap changed")
    req(has(obligation, "relative_time_scale_bridge_proof_witness"), "obligation must name rank-5 witness")

    req(target.get("object") == "relative_time_scale_bridge_proof_witness_target_surface", "target object changed")
    req(target.get("status") == "witness_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "relative_time_scale_bridge_proof_witness", "target name changed")
    req(target.get("rank") == 5, "target rank changed")
    req(target.get("depends_on_prior_missing_inputs") == [
        "physical_system_context_witness",
        "variable_domain_and_guards_witness",
        "non_toy_structure_source_witness",
        "derivation_evidence_for_F_physical_witness"
    ], "prior dependency chain changed")
    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")
    req(target.get("boundary") == "not(physical_time_dilation)", "target boundary changed")
    req(has(target, "F_physical := F_toy"), "target must preserve shortcut rejection")
    req(has(target, "does_not_identify_F_toy_with_F_physical"), "target must preserve no-identification")

    req(receipt.get("object") == "relative_time_scale_bridge_proof_witness_next_dependency_receipt", "receipt object changed")
    req(receipt.get("status") == "next_dependency_receipt_only", "receipt status changed")
    nxt = receipt.get("next_ranked_missing_input", {})
    req(nxt.get("rank") == 5, "receipt rank changed")
    req(nxt.get("name") == "relative_time_scale_bridge_proof_witness", "receipt target changed")
    req(nxt.get("available") is False, "receipt made rank-5 available")
    req(has(receipt, "RelativeTimeScale_x_equals_F_physical_bridge"), "receipt must block bridge")
    req(has(receipt, "F_physical := F_toy"), "receipt must preserve shortcut rejection")
    req(has(receipt, "does_not_identify_F_toy_with_F_physical"), "receipt must preserve no-identification")

    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "fixture shortcut changed")
    req(fixture.get("expected_verdict") == "rejected", "fixture verdict changed")

    print("RELATIVE_TIME_SCALE_BRIDGE_PROOF_WITNESS_TARGET_OK")

if __name__ == "__main__":
    main()
