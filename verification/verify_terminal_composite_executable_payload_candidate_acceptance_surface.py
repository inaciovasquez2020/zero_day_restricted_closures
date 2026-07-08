#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "terminal_composite_executable_payload_candidate_acceptance_surface.json"

REQUIRED_SOURCE_FIELDS = [
    "RestrictedCompositionTarget.source_fields.TerminalComposite(C,T)",
    "RestrictedCompositionTarget.source_fields.RestrictedBoundaryInvariant(T)",
    "RestrictedCompositionTarget.source_fields.TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
]

FORBIDDEN_CLAIMS = {
    "restricted_composition_target",
    "zero_day_closure",
    "restricted_to_unrestricted_lift",
    "unrestricted_zero_day_closure",
}

REQUIRED_NON_CLAIMS = {
    "does_not_construct_restricted_composition_target",
    "does_not_construct_zero_day_closure",
    "does_not_lift_restricted_to_unrestricted",
    "does_not_claim_unrestricted_zero_day_closure",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "TerminalCompositeExecutablePayloadCandidateAcceptanceSurface"
    assert data["status"] == "ACCEPTED_CANDIDATE_FIXTURE_ONLY"
    assert data["accepted_candidates"] == ["restricted_terminal_composite_payload_fixture"]

    candidate = data["accepted_candidate"]
    assert candidate["kind"] == "executable_terminal_composite_witness_candidate"

    terminal_composite = candidate["terminal_composite"]
    assert terminal_composite["scope"] == "restricted_only"
    assert terminal_composite["source_fields"] == REQUIRED_SOURCE_FIELDS

    payload = terminal_composite["executable_payload"]
    assert payload["payload_kind"] == "restricted_terminal_composite_payload_fixture"
    assert payload["bridge_inputs_present"] is True
    assert payload["executes"] is True

    claims = set(candidate.get("claims", []))
    forbidden = FORBIDDEN_CLAIMS & claims
    if forbidden:
        raise AssertionError(f"forbidden claims present: {sorted(forbidden)}")

    missing = REQUIRED_NON_CLAIMS - set(data.get("non_claims", []))
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    print("TERMINAL_COMPOSITE_EXECUTABLE_PAYLOAD_CANDIDATE_ACCEPTANCE_SURFACE_OK")

if __name__ == "__main__":
    main()
