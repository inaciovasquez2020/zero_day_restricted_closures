#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_closed_state_target_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedClosedStateTargetSurface",
    "scope": "closed_state_target_only",
    "target": "IntendedClosedState : IntendedUnrestrictedState -> IntendedUnrestrictedState",
    "definition_target": "IntendedClosedState(x) := fromProductForm(ClosedState(toProductForm(x)))",
    "status": "CLOSED_STATE_TARGET_NOT_DEFINED",
    "downstream_use": "IntendedUnrestrictedStateClosure",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside transported intended-state model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_deps = {
    "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
    "ClosedState : Fin 256 × Payload -> Fin 256 × Payload",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_deps - set(depends_on):
    raise SystemExit("MISSING_OBJECT := intended closed-state dependency")

required_non_claims = {
    "does not define IntendedClosedState",
    "does not prove IntendedUnrestrictedStateClosure",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := intended closed-state non-claim")

print("INTENDED_CLOSED_STATE_TARGET_SURFACE_OK")
