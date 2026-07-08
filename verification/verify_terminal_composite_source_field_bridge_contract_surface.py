#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_source_field_bridge_contract_surface.json"

REQUIRED_FROM = [
    "RestrictedCompositionTarget.source_fields.TerminalComposite(C,T)",
    "RestrictedCompositionTarget.source_fields.RestrictedBoundaryInvariant(T)",
    "RestrictedCompositionTarget.source_fields.TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
]

REQUIRED_NON_CLAIMS = {
    "does_not_accept_any_candidate",
    "does_not_supply_terminal_composite",
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "TerminalCompositeSourceFieldBridgeContractSurface"
    assert data["status"] == "SOURCE_FIELD_BRIDGE_CONTRACT_ONLY"
    assert data["target_missing_object"] == "source-field bridge constructed"
    assert data["accepted_candidates"] == []

    bridge = data["bridge"]
    assert bridge["from"] == REQUIRED_FROM
    assert bridge["to"] == "terminal_composite.executable_payload"
    assert bridge["mapping_status"] == "DECLARED_NOT_ACCEPTED"

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("TERMINAL_COMPOSITE_SOURCE_FIELD_BRIDGE_CONTRACT_SURFACE_OK")

if __name__ == "__main__":
    main()
