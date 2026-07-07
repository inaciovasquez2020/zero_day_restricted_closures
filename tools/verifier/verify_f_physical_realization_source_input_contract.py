#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

INPUT_TARGETS = [
    ("non_toy_source_law_evidence", "core/non_toy_source_law_evidence_target_surface.json"),
    ("F_physical_not_equal_F_toy_guard", "core/f_physical_not_equal_f_toy_guard_target_surface.json"),
    ("variable_domain_and_guards_witness", "core/variable_domain_and_guards_witness_target_surface.json"),
    ("relative_time_scale_bridge_proof_witness", "core/relative_time_scale_bridge_proof_witness_target_surface.json"),
]

def load(rel):
    p = ROOT / rel
    if not p.exists():
        raise SystemExit(f"MISSING_OBJECT := {rel}")
    return json.loads(p.read_text(encoding="utf-8"))

def has(obj, token):
    return token in json.dumps(obj, sort_keys=True)

def req(cond, msg):
    if not cond:
        raise SystemExit("F_PHYSICAL_REALIZATION_SOURCE_INPUT_CONTRACT_FAIL: " + msg)

def main():
    contract = load("core/f_physical_realization_source_input_contract_surface.json")
    exhaustion = load("core/f_physical_realization_source_input_targets_exhaustion_receipt_2026_07_07.json")
    source = load("core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json")
    f_constructor = load("core/f_physical_constructor_target_surface.json")
    fixture = load("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    req(contract.get("object") == "F_physical_realization_source_input_contract_surface", "contract object changed")
    req(contract.get("status") == "input_contract_surface_only", "contract status changed")
    req(contract.get("target_source") == "F_physical_derivation_input_witness_constructor_contract_realization_source", "target source changed")
    req(contract.get("would_supply") == "F_physical_derivation_input_witness_constructor_contract_realization_source", "would-supply changed")

    req(contract.get("available") is False, "contract became available")
    req(contract.get("inhabited") is False, "contract became inhabited")
    req(contract.get("contract_present") is True, "contract surface not present")
    for field in ["source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        req(contract.get(field) is False, f"{field} must remain false")

    req(exhaustion.get("status") == "source_input_target_exhaustion_receipt_only", "exhaustion receipt status changed")
    req(exhaustion.get("source_input_targets_exhausted") is True, "source input exhaustion flag changed")
    req(exhaustion.get("remaining_missing_object") == "F_physical_derivation_input_witness_constructor_contract_realization_source", "remaining object changed")

    req(source.get("available") is False and source.get("inhabited") is False, "realization source became available")
    req(f_constructor.get("available") is False and f_constructor.get("inhabited") is False, "F_physical constructor became available")

    for name, path in INPUT_TARGETS:
        target = load(path)
        req(target.get("target") == name, f"input target changed: {name}")
        req(target.get("available") is False, f"{name} became available")
        req(target.get("inhabited") is False, f"{name} became inhabited")
        req(has(source, name), f"source target no longer requires {name}")
        req(has(exhaustion, name), f"exhaustion receipt missing {name}")
        req(has(contract, name), f"contract missing {name}")

    for token in [
        "F_physical := F_toy",
        "F_physical(x) := 1 + x",
        "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_F_physical_not_equal_F_toy_guard",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_F_physical_not_equal_F_toy",
        "does_not_prove_physical_time_dilation",
    ]:
        req(has(contract, token), f"contract missing {token}")

    req(fixture.get("candidate_shortcut") == "F_physical := F_toy", "shortcut fixture changed")
    req(fixture.get("expected_verdict") == "rejected", "shortcut fixture verdict changed")

    print("F_PHYSICAL_REALIZATION_SOURCE_INPUT_CONTRACT_OK")

if __name__ == "__main__":
    main()
