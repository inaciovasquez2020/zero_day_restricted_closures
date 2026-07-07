#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def load(rel):
    p = ROOT / rel
    if not p.exists():
        raise SystemExit(f"MISSING_OBJECT := {rel}")
    return json.loads(p.read_text(encoding="utf-8"))

def has(obj, token):
    return token in json.dumps(obj, sort_keys=True)

def req(cond, msg):
    if not cond:
        raise SystemExit("F_PHYSICAL_NOT_EQUAL_F_TOY_GUARD_TARGET_FAIL: " + msg)

def main():
    target = load("core/f_physical_not_equal_f_toy_guard_target_surface.json")
    evidence = load("core/non_toy_source_law_evidence_target_surface.json")
    source = load("core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json")
    f_constructor = load("core/f_physical_constructor_target_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(target.get("object") == "F_physical_not_equal_F_toy_guard_target_surface", "target object changed")
    req(target.get("status") == "guard_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "F_physical_not_equal_F_toy_guard", "target name changed")

    for field in ["available", "inhabited", "guard_present", "evidence_present", "source_present", "constructor_present", "witness_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")

    req(has(source, "F_physical_not_equal_F_toy_guard"), "realization source no longer requires guard")
    req(evidence.get("available") is False and evidence.get("inhabited") is False, "non-toy evidence became available")
    req(source.get("available") is False and source.get("inhabited") is False, "realization source became available")
    req(f_constructor.get("available") is False and f_constructor.get("inhabited") is False, "F_physical constructor became available")

    for token in [
        "F_physical := F_toy",
        "F_physical(x) := 1 + x",
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "does_not_supply_F_physical_not_equal_F_toy_guard",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_F_physical_not_equal_F_toy",
        "does_not_prove_physical_time_dilation",
    ]:
        req(has(target, token), f"target missing {token}")

    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_NOT_EQUAL_F_TOY_GUARD_TARGET_OK")

if __name__ == "__main__":
    main()
