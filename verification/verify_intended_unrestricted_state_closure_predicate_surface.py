#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_unrestricted_state_closure_predicate_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedUnrestrictedStateClosurePredicateSurface",
    "scope": "predicate_target_only",
    "predicate": "IntendedUnrestrictedStateClosure",
    "definition_target": "forall x : IntendedUnrestrictedState, exists n <= 255, IntendedStep^[n](x) = IntendedClosedState(x)",
    "status": "PREDICATE_TARGET_NOT_DEFINED",
    "downstream_use": "target predicate for ProductFormRestrictedLiftClosure transport",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside transported intended-state model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_deps = {
    "IntendedUnrestrictedState",
    "IntendedStep : IntendedUnrestrictedState -> IntendedUnrestrictedState",
    "IntendedClosedState : IntendedUnrestrictedState -> IntendedUnrestrictedState",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_deps - set(depends_on):
    raise SystemExit("MISSING_OBJECT := intended closure predicate dependency")

required_non_claims = {
    "does not define IntendedStep",
    "does not define IntendedClosedState",
    "does not prove IntendedUnrestrictedStateClosure",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := intended closure predicate non-claim")

print("INTENDED_UNRESTRICTED_STATE_CLOSURE_PREDICATE_SURFACE_OK")
