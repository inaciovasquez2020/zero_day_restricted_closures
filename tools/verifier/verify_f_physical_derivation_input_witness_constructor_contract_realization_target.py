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
        raise SystemExit("F_PHYSICAL_DERIVATION_INPUT_WITNESS_CONTRACT_REALIZATION_TARGET_FAIL: " + msg)

def main():
    target = load("core/f_physical_derivation_input_witness_constructor_contract_realization_target_surface.json")
    contract = load("core/f_physical_derivation_input_witness_constructor_input_contract_surface.json")
    constructor = load("core/f_physical_derivation_input_witness_constructor_target_surface.json")
    witness = load("core/f_physical_derivation_input_witness_target_surface.json")
    f_constructor = load("core/f_physical_constructor_target_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(target.get("object") == "F_physical_derivation_input_witness_constructor_contract_realization_target_surface", "target object changed")
    req(target.get("status") == "realization_target_surface_uninhabited", "target status changed")
    req(target.get("target") == "F_physical_derivation_input_witness_constructor_contract_realization", "target name changed")
    req(target.get("would_realize") == "F_physical_derivation_input_witness_constructor_input_contract", "would-realize target changed")

    for field in ["available", "inhabited", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        req(target.get(field) is False, f"{field} must remain false")

    req(contract.get("status") == "input_contract_surface_only", "contract status changed")
    req(contract.get("available") is False and contract.get("inhabited") is False, "contract became available")
    req(constructor.get("available") is False and constructor.get("inhabited") is False, "constructor became available")
    req(witness.get("available") is False and witness.get("inhabited") is False, "witness became available")
    req(f_constructor.get("available") is False and f_constructor.get("inhabited") is False, "F_physical constructor became available")

    for token in [
        "physical_system_context_witness",
        "variable_domain_and_guards_witness",
        "non_toy_structure_source_witness",
        "derivation_evidence_for_F_physical_witness",
        "relative_time_scale_bridge_proof_witness",
        "F_physical := F_toy",
        "does_not_realize_F_physical_derivation_input_witness_constructor_input_contract",
        "does_not_supply_F_physical_derivation_input_witness_constructor",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
    ]:
        req(has(target, token), f"target missing {token}")

    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_DERIVATION_INPUT_WITNESS_CONTRACT_REALIZATION_TARGET_OK")

if __name__ == "__main__":
    main()
