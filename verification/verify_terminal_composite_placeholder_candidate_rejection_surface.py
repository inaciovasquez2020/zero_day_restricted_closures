#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_placeholder_candidate_rejection_surface.json"

REQUIRED_NON_CLAIMS = {
    "does_not_supply_terminal_composite",
    "does_not_inhabit_executable_terminal_composite_witness_candidate",
    "does_not_construct_source_field_bridge",
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "TerminalCompositePlaceholderCandidateRejectionSurface"
    assert data["status"] == "NEGATIVE_FIXTURE_ONLY"
    assert data["expected_result"] == "REJECTED"

    candidate = data["candidate"]
    assert candidate["kind"] == "placeholder"
    assert candidate["terminal_composite"] is None

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("TERMINAL_COMPOSITE_PLACEHOLDER_CANDIDATE_REJECTION_SURFACE_OK")

if __name__ == "__main__":
    main()
