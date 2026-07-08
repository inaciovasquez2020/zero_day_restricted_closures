#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_step_target_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedStepTargetSurface",
    "scope": "step_target_only",
    "target": "IntendedStep : IntendedUnrestrictedState -> IntendedUnrestrictedState",
    "definition_target": "IntendedStep(x) := fromProductForm(UnrestrictedStep(toProductForm(x)))",
    "status": "STEP_TARGET_NOT_DEFINED",
    "downstream_use": "IntendedUnrestrictedStateClosure",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside transported intended-state model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_deps = {
    "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
    "UnrestrictedStep : Fin 256 × Payload -> Fin 256 × Payload",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_deps - set(depends_on):
    raise SystemExit("MISSING_OBJECT := intended step dependency")

required_non_claims = {
    "does not define IntendedStep",
    "does not prove IntendedUnrestrictedStateClosure",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := intended step non-claim")

print("INTENDED_STEP_TARGET_SURFACE_OK")
