#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_well_formed_unaccepted_candidate_surface.json"

FORBIDDEN_CLAIMS = {
    "restricted_composition_target",
    "zero_day_closure",
    "restricted_to_unrestricted_lift",
}

REQUIRED_NON_CLAIMS = {
    "does_not_accept_candidate",
    "does_not_supply_terminal_composite",
    "does_not_construct_source_field_bridge",
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "TerminalCompositeWellFormedUnacceptedCandidateSurface"
    assert data["status"] == "WELL_FORMED_FIXTURE_NOT_ACCEPTED"
    assert data["expected_result"] == "WELL_FORMED_BUT_UNACCEPTED"

    candidate = data["candidate"]
    assert candidate["kind"] == "executable_terminal_composite_witness_candidate"

    terminal_composite = candidate["terminal_composite"]
    assert terminal_composite is not None
    assert terminal_composite["scope"] == "restricted_only"
    assert "TerminalComposite(C,T)" in terminal_composite["source_fields"]

    claims = set(candidate.get("claims", []))
    forbidden = FORBIDDEN_CLAIMS & claims
    if forbidden:
        raise AssertionError(f"forbidden claims present: {sorted(forbidden)}")

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("TERMINAL_COMPOSITE_WELL_FORMED_UNACCEPTED_CANDIDATE_SURFACE_OK")

if __name__ == "__main__":
    main()
