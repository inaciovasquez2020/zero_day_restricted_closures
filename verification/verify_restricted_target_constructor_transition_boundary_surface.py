#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_constructor_transition_boundary_surface.json"

REQUIRED_NON_CLAIMS = {
    "does_not_construct_restricted_composition_target",
    "does_not_supply_constructor_realization",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "RestrictedTargetConstructorTransitionBoundarySurface"
    assert data["status"] == "CONSTRUCTOR_TRANSITION_BOUNDARY_ONLY"
    assert data["transition"] == "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget"
    assert data["constructor_realization"]["status"] == "ABSENT"
    assert data["restricted_composition_target"]["status"] == "UNCONSTRUCTED"

    obligations = data.get("constructor_obligations", [])
    fields = {entry["field"] for entry in obligations}

    required = {
        "terminal_composite.executable_payload",
        "RestrictedBoundaryInvariant(T)",
        "TargetRealizesRestrictedLiftSourceChainComposition(C,T)"
    }

    if fields != required:
        raise AssertionError(f"unexpected obligation fields: {sorted(fields)}")

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("RESTRICTED_TARGET_CONSTRUCTOR_TRANSITION_BOUNDARY_SURFACE_OK")

if __name__ == "__main__":
    main()
