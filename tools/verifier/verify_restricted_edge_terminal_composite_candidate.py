#!/usr/bin/env python3
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SURFACE = ROOT / "core/restricted_edge_terminal_composite_executable_candidate_verifier_surface.json"

FORBIDDEN_VALUES = {
    "INPUT_CONTRACT_INHABITED",
    "EXECUTABLE_CANDIDATE_VERIFIER_ACCEPTED",
    "ACCEPTED_CANDIDATE",
    "TerminalComposite(C,T) supplied",
    "terminal-composite witness constructed",
    "terminal-composite witness candidate inhabited",
    "terminal-composite witness candidate accepted",
    "source-field bridge constructed",
    "RestrictedCompositionTarget constructed",
    "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget constructed",
    "RestrictedCompositionTarget -> ZeroDayClosure constructed",
    "unrestricted ZeroDayClosure constructed",
    "restricted-to-unrestricted lift proved",
}

def walk(value):
    if isinstance(value, dict):
        for child in value.values():
            yield from walk(child)
    elif isinstance(value, list):
        for child in value:
            yield from walk(child)
    elif isinstance(value, str):
        yield value

def main() -> int:
    if not SURFACE.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_edge_terminal_composite_executable_candidate_verifier_surface.json")

    data = json.loads(SURFACE.read_text())

    verifier = data.get("candidate_verifier")
    if not isinstance(verifier, dict):
        raise SystemExit("TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_FAILED := candidate_verifier must be an object")

    if verifier.get("verifier_status") != "EXECUTABLE_CANDIDATE_VERIFIER_RECORDED_NOT_RUN_ON_INHABITANT":
        raise SystemExit("TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_FAILED := verifier status claims execution on inhabitant")

    if verifier.get("accepted_candidate_status") != "NO_ACCEPTED_CANDIDATE":
        raise SystemExit("TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_FAILED := accepted candidate present")

    if data.get("preserved_parent_status") != "INPUT_CONTRACT_RECORDED_NOT_INHABITED":
        raise SystemExit("TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_FAILED := parent input contract not preserved")

    for value in walk(data):
        if value in FORBIDDEN_VALUES:
            raise SystemExit(f"TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_FAILED := forbidden value {value!r}")

    print("TERMINAL_COMPOSITE_CANDIDATE_VERIFIER_OK")
    return 0

if __name__ == "__main__":
    sys.exit(main())
