#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_content_field_contract_surface.json"

REQUIRED_FIELDS = [
    "terminal_composite",
    "terminal_composite.scope",
    "terminal_composite.source_fields",
    "terminal_composite.executable_payload",
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

    assert data["surface"] == "TerminalCompositeContentFieldContractSurface"
    assert data["status"] == "CONTENT_FIELD_CONTRACT_ONLY"
    assert data["target_missing_object"] == "TerminalComposite(C,T) supplied"
    assert data["required_fields"] == REQUIRED_FIELDS
    assert data["accepted_candidates"] == []

    payload_contract = data["executable_payload_contract"]
    assert payload_contract["required_key"] == "executable_payload"
    assert payload_contract["required_status"] == "present_non_null"
    assert payload_contract["accepted"] is False

    bridge = data["source_field_bridge_construction"]
    assert bridge["status"] == "DECLARED_NOT_CONSTRUCTED"
    assert bridge["from"] == "restricted source fields"
    assert bridge["to"] == "terminal_composite.executable_payload"

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("TERMINAL_COMPOSITE_CONTENT_FIELD_CONTRACT_SURFACE_OK")

if __name__ == "__main__":
    main()
