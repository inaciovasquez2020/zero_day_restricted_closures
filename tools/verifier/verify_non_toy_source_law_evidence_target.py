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
        raise SystemExit("NON_TOY_SOURCE_LAW_EVIDENCE_TARGET_FAIL: " + msg)

def main():
    target = load("core/non_toy_source_law_evidence_target_surface.json")
    source = load("core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json")
    realization = load("core/f_physical_derivation_input_witness_constructor_contract_realization_target_surface.json")
    contract = load("core/f_physical_derivation_input_witness_constructor_input_contract_surface.json")
    f_constructor = load("core/f_physical_constructor_target_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(target.get("object") == "non_toy_source_law_evidence_target_surface", "target object changed")
    req(target.get("status") == "evidence_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "non_toy_source_law_evidence", "target name changed")

    for field in ["available", "inhabited", "evidence_present", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")

    req(has(source, "non_toy_source_law_evidence"), "source target no longer requires non-toy evidence")
    req(source.get("available") is False and source.get("inhabited") is False, "realization source became available")
    req(realization.get("available") is False and realization.get("inhabited") is False, "realization became available")
    req(contract.get("available") is False and contract.get("inhabited") is False, "contract became available")
    req(f_constructor.get("available") is False and f_constructor.get("inhabited") is False, "F_physical constructor became available")

    for token in [
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "F_physical := F_toy",
        "F_physical(x) := 1 + x",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        req(has(target, token), f"target missing {token}")

    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("NON_TOY_SOURCE_LAW_EVIDENCE_TARGET_OK")

if __name__ == "__main__":
    main()
