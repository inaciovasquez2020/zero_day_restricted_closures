#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_unrestricted_state_product_form_equivalence_assembly_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedUnrestrictedStateProductFormEquivalenceAssemblySurface",
    "scope": "equivalence_assembly_target_only",
    "target_theorem": "IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "status": "EQUIVALENCE_ASSEMBLY_TARGET_NOT_PROVED",
    "downstream_use": "transport ProductFormRestrictedLiftClosure across equivalence",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_deps = {
    "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
    "fromProductForm(toProductForm(x)) = x",
    "toProductForm(fromProductForm(y)) = y",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_deps - set(depends_on):
    raise SystemExit("MISSING_OBJECT := equivalence assembly dependency")

required_non_claims = {
    "does not prove IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not erase product-form boundary",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := equivalence assembly non-claim")

print("INTENDED_UNRESTRICTED_STATE_PRODUCT_FORM_EQUIVALENCE_ASSEMBLY_SURFACE_OK")
