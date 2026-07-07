#!/usr/bin/env python3
import json
from pathlib import Path

TARGET = Path("core/restricted_composition_constructor_edge_target_surface.json")

EXPECTED = {
    "surface": "RestrictedCompositionConstructorEdgeTargetSurface",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
    "source_contract": "RestrictedLiftSourceChainCompositionInputContract",
    "target": "RestrictedCompositionTarget",
    "target_edge": "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
    "required_first_edge": "available contract inputs -> RestrictedCompositionTarget",
    "edge_role": "bounded constructor-edge target surface only",
    "positive_claim": "names the next bounded constructor edge to be supplied",
    "next_weakest_point": "Supply a verifier-guarded constructor-edge witness without touching unrestricted ZeroDayClosure.",
}

REQUIRED_DEPENDS_ON = [
    "core/restricted_lift_source_chain_composition_input_contract.json",
    "core/restricted_composition_target_definition_surface.json",
    "core/restricted_composition_target_constructor_schema_surface.json",
    "core/restricted_composition_witness_dependency_matrix_surface.json",
]

REQUIRED_NON_CLAIMS = [
    "does not prove ZeroDayClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not discharge LiftSourceChainCompositionGap",
    "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
    "does not construct RestrictedCompositionTarget",
    "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
    "does not construct an unrestricted zero-day closure",
    "does not erase the restricted boundary",
    "does not prove the restricted-to-unrestricted lift",
    "does not add SNOLAB or external empirical evidence",
]

FORBIDDEN_PROMOTIONS = [
    "proves ZeroDayClosure",
    "proves unrestricted ZeroDayClosure",
    "constructs RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
    "constructs RestrictedCompositionTarget -> ZeroDayClosure",
    "constructs an unrestricted zero-day closure",
    "erases the restricted boundary",
    "proves the restricted-to-unrestricted lift",
    "SNOLAB",
    "external empirical evidence",
]

def fail(message: str) -> None:
    raise SystemExit(f"RESTRICTED_COMPOSITION_CONSTRUCTOR_EDGE_TARGET_SURFACE_FAIL: {message}")

def walk_strings(value):
    if isinstance(value, str):
        yield value
    elif isinstance(value, list):
        for item in value:
            yield from walk_strings(item)
    elif isinstance(value, dict):
        for key, item in value.items():
            yield str(key)
            yield from walk_strings(item)

def main() -> None:
    if not TARGET.exists():
        fail(f"missing {TARGET}")

    data = json.loads(TARGET.read_text())

    for key, expected in EXPECTED.items():
        if data.get(key) != expected:
            fail(f"{key} must equal {expected!r}")

    if data.get("depends_on") != REQUIRED_DEPENDS_ON:
        fail("depends_on must pin the four prior restricted constructor-edge surfaces exactly")

    if data.get("non_claims") != REQUIRED_NON_CLAIMS:
        fail("non_claims must preserve all constructor and closure boundaries exactly")

    all_text = "\n".join(walk_strings(data))
    allowed_context = "\n".join(REQUIRED_NON_CLAIMS + [EXPECTED["next_weakest_point"]])
    for phrase in FORBIDDEN_PROMOTIONS:
        if phrase in all_text and phrase not in allowed_context:
            fail(f"forbidden promotion phrase escaped boundary guard: {phrase}")

    print("RESTRICTED_COMPOSITION_CONSTRUCTOR_EDGE_TARGET_SURFACE_OK")

if __name__ == "__main__":
    main()
