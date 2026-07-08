#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_constructor_realization_obligation_surface.json"

REQUIRED_CONTRACTS = {
    "TerminalComposite executable payload candidate acceptance surface",
    "Restricted target constructor input field contract surface",
    "Restricted target constructor transition boundary surface",
}

REQUIRED_OBLIGATIONS = {
    "construct RestrictedCompositionTarget from validated restricted inputs",
    "supply executable RestrictedBoundaryInvariant(T) payload",
    "supply executable TargetRealizesRestrictedLiftSourceChainComposition(C,T) payload",
}

REQUIRED_NON_CLAIMS = {
    "does_not_construct_restricted_composition_target",
    "does_not_supply_constructor_realization",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "RestrictedTargetConstructorRealizationObligationSurface"
    assert data["status"] == "REALIZATION_OBLIGATION_ONLY"
    assert data["constructor_realization"]["status"] == "ABSENT"
    assert data["restricted_composition_target"]["status"] == "UNCONSTRUCTED"

    contracts = set(data["required_constructor_input_contracts"])
    if contracts != REQUIRED_CONTRACTS:
        raise AssertionError(f"unexpected contracts: {sorted(contracts)}")

    obligations = data["realization_obligations"]
    observed = {item["obligation"] for item in obligations}
    if observed != REQUIRED_OBLIGATIONS:
        raise AssertionError(f"unexpected obligations: {sorted(observed)}")

    for item in obligations:
        if item["status"] != "UNDISCHARGED":
            raise AssertionError(f"premature discharge: {item}")

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("RESTRICTED_TARGET_CONSTRUCTOR_REALIZATION_OBLIGATION_SURFACE_OK")

if __name__ == "__main__":
    main()
