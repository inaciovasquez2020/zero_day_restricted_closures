#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_acceptance_blocker_inventory_surface.json"

REQUIRED_BLOCKERS = [
    "TerminalComposite(C,T) supplied",
    "terminal_composite_content_executable_payload",
    "source_field_bridge_constructed",
    "accepted_candidate_registry_entry",
]

REQUIRED_NON_CLAIMS = {
    "does_not_accept_any_candidate",
    "does_not_supply_terminal_composite",
    "does_not_construct_source_field_bridge",
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "TerminalCompositeAcceptanceBlockerInventorySurface"
    assert data["status"] == "BLOCKER_INVENTORY_ONLY"
    assert data["target_missing_object"] == "accepted executable terminal-composite witness candidate"
    assert data["accepted_candidates"] == []

    blockers = data.get("ranked_blockers", [])
    observed = [entry["missing_object"] for entry in blockers]
    if observed != REQUIRED_BLOCKERS:
        raise AssertionError(f"unexpected blocker order: {observed}")

    ranks = [entry["rank"] for entry in blockers]
    if ranks != [1, 2, 3, 4]:
        raise AssertionError(f"unexpected blocker ranks: {ranks}")

    for entry in blockers:
        if not entry.get("reason"):
            raise AssertionError(f"missing reason for blocker: {entry}")

    missing_non_claims = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing_non_claims:
        raise AssertionError(f"missing non_claims: {sorted(missing_non_claims)}")

    print("TERMINAL_COMPOSITE_ACCEPTANCE_BLOCKER_INVENTORY_SURFACE_OK")

if __name__ == "__main__":
    main()
