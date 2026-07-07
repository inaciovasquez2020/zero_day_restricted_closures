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
        raise SystemExit("F_PHYSICAL_CONSTRUCTOR_TARGET_FAIL: " + message)

def main():
    target = load("core/f_physical_constructor_target_surface.json")
    witness = load("core/f_physical_derivation_input_witness_target_surface.json")
    exhaustion = load("core/f_physical_ranked_missing_input_targets_exhaustion_receipt_2026_07_07.json")
    obligation = load("core/f_physical_derivation_input_witness_obligation_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(target.get("object") == "F_physical_constructor_target_surface", "target object changed")
    req(target.get("status") == "constructor_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "F_physical_constructor", "target name changed")
    req(target.get("constructs") == "F_physical", "constructs target changed")

    for field in ["available", "inhabited", "constructor_present", "value_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")

    req(target.get("requires") == ["F_physical_derivation_input_witness"], "required witness changed")
    req(witness.get("target") == "F_physical_derivation_input_witness", "witness target changed")
    req(witness.get("available") is False, "witness became available")
    req(witness.get("inhabited") is False, "witness became inhabited")
    req(exhaustion.get("remaining_missing_object") == "F_physical_derivation_input_witness", "exhaustion remaining object changed")
    req(exhaustion.get("ranked_gap_count") == 5, "ranked gap count changed")

    for token in [
        "F_physical := F_toy",
        "F_physical(x) := 1 + x",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "physical_time_dilation",
    ]:
        req(has(target, token), f"target missing {token}")

    req(has(obligation, "F_physical_derivation_input_witness"), "obligation lost derivation witness")
    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_CONSTRUCTOR_TARGET_OK")

if __name__ == "__main__":
    main()
