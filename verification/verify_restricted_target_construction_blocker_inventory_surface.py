#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_construction_blocker_inventory_surface.json"

REQUIRED_BLOCKERS = [
    "RestrictedCompositionTarget constructor",
    "RestrictedBoundaryInvariant(T) payload",
    "TargetRealizesRestrictedLiftSourceChainComposition(C,T) payload",
]

REQUIRED_NON_CLAIMS = {
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
    "does_not_claim_unrestricted_zero_day_closure",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "RestrictedTargetConstructionBlockerInventorySurface"
    assert data["status"] == "BLOCKER_INVENTORY_ONLY"
    assert data["target_missing_object"] == "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget"
    assert data["required_inputs"] == ["accepted executable terminal-composite witness candidate"]
    assert data["available_inputs"] == ["restricted_terminal_composite_payload_fixture"]
    assert data["restricted_composition_target"]["status"] == "UNCONSTRUCTED"

    blockers = data.get("ranked_blockers", [])
    observed = [entry["missing_object"] for entry in blockers]
    if observed != REQUIRED_BLOCKERS:
        raise AssertionError(f"unexpected blocker order: {observed}")

    ranks = [entry["rank"] for entry in blockers]
    if ranks != [1, 2, 3]:
        raise AssertionError(f"unexpected blocker ranks: {ranks}")

    for entry in blockers:
        if not entry.get("reason"):
            raise AssertionError(f"missing reason for blocker: {entry}")

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("RESTRICTED_TARGET_CONSTRUCTION_BLOCKER_INVENTORY_SURFACE_OK")

if __name__ == "__main__":
    main()
