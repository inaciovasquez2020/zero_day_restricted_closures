#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_constructor_input_field_contract_surface.json"

REQUIRED_INPUTS = [
    "accepted executable terminal-composite witness candidate",
    "RestrictedBoundaryInvariant(T) payload placeholder",
    "TargetRealizesRestrictedLiftSourceChainComposition(C,T) payload placeholder",
]

REQUIRED_PLACEHOLDERS = {
    "RestrictedBoundaryInvariant(T)",
    "TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
}

REQUIRED_NON_CLAIMS = {
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
    "does_not_claim_unrestricted_zero_day_closure",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "RestrictedTargetConstructorInputFieldContractSurface"
    assert data["status"] == "CONSTRUCTOR_INPUT_FIELD_CONTRACT_ONLY"
    assert data["target_missing_object"] == "RestrictedCompositionTarget constructor"
    assert data["required_inputs"] == REQUIRED_INPUTS
    assert data["available_inputs"] == ["restricted_terminal_composite_payload_fixture"]
    assert data["restricted_composition_target"]["status"] == "UNCONSTRUCTED"

    placeholders = data.get("placeholder_inputs", [])
    observed = {entry["field"] for entry in placeholders}
    if observed != REQUIRED_PLACEHOLDERS:
        raise AssertionError(f"unexpected placeholders: {sorted(observed)}")

    for entry in placeholders:
        assert entry["status"] == "PLACEHOLDER_ONLY_NOT_SUPPLIED"

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("RESTRICTED_TARGET_CONSTRUCTOR_INPUT_FIELD_CONTRACT_SURFACE_OK")

if __name__ == "__main__":
    main()
