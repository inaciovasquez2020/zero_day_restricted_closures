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
        raise SystemExit("F_PHYSICAL_DERIVATION_INPUT_WITNESS_TARGET_FAIL: " + message)

def main():
    target = load("core/f_physical_derivation_input_witness_target_surface.json")
    obligation = load("core/f_physical_derivation_input_witness_obligation_surface.json")
    exhaustion = load("core/f_physical_ranked_missing_input_targets_exhaustion_receipt_2026_07_07.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(target.get("object") == "F_physical_derivation_input_witness_target_surface", "target object changed")
    req(target.get("status") == "witness_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "F_physical_derivation_input_witness", "target name changed")
    req(target.get("available") is False, "target became available")
    req(target.get("inhabited") is False, "target became inhabited")
    for field in ["witness_present", "constructor_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")

    req(target.get("ranked_input_targets_exhausted") is True, "ranked target exhaustion not recorded")
    req(exhaustion.get("status") == "ranked_target_chain_exhaustion_receipt_only", "exhaustion receipt status changed")
    req(exhaustion.get("remaining_missing_object") == "F_physical_derivation_input_witness", "remaining object changed")
    req(exhaustion.get("ranked_gap_count") == 5, "ranked gap count changed")

    for token in [
        "physical_system_context_witness",
        "variable_domain_and_guards_witness",
        "non_toy_structure_source_witness",
        "derivation_evidence_for_F_physical_witness",
        "relative_time_scale_bridge_proof_witness",
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "physical_time_dilation",
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
    ]:
        req(has(target, token), f"target missing {token}")

    req(has(obligation, "F_physical_derivation_input_witness"), "obligation lost witness target")
    req(has(exhaustion, "does_not_supply_F_physical_derivation_input_witness"), "exhaustion receipt lost non-claim")
    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_DERIVATION_INPUT_WITNESS_TARGET_OK")

if __name__ == "__main__":
    main()
