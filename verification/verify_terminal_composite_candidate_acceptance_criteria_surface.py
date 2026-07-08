#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_candidate_acceptance_criteria_surface.json"

REQUIRED_CRITERIA = {
    "candidate_kind_must_be_executable_terminal_composite_witness_candidate",
    "terminal_composite_field_must_be_non_null",
    "terminal_composite_field_must_be_restricted_only",
    "candidate_must_not_claim_restricted_composition_target",
    "candidate_must_not_claim_zero_day_closure",
    "candidate_must_not_claim_restricted_to_unrestricted_lift",
}

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

    assert data["surface"] == "TerminalCompositeCandidateAcceptanceCriteriaSurface"
    assert data["status"] == "ACCEPTANCE_CRITERIA_ONLY"
    assert data["accepted_candidates"] == []

    missing_criteria = REQUIRED_CRITERIA - set(data.get("acceptance_criteria", []))
    if missing_criteria:
        raise AssertionError(f"missing acceptance_criteria: {sorted(missing_criteria)}")

    missing_non_claims = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing_non_claims:
        raise AssertionError(f"missing non_claims: {sorted(missing_non_claims)}")

    print("TERMINAL_COMPOSITE_CANDIDATE_ACCEPTANCE_CRITERIA_SURFACE_OK")

if __name__ == "__main__":
    main()
