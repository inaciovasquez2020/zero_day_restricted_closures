#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_unrestricted_state_product_form_equivalence_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedUnrestrictedStateProductFormEquivalenceSurface",
    "scope": "equivalence_target_only",
    "source": "IntendedUnrestrictedState",
    "target": "Fin 256 × Payload",
    "target_theorem": "IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "downstream_use": "transport ProductFormRestrictedLiftClosure across equivalence",
    "status": "EQUIVALENCE_TARGET_NOT_PROVED",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_maps = {
    "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
}
maps = payload.get("required_maps")
if not isinstance(maps, list):
    raise SystemExit("MISSING_OBJECT := required_maps list")
if required_maps - set(maps):
    raise SystemExit("MISSING_OBJECT := product-form equivalence maps")

required_laws = {
    "fromProductForm(toProductForm(x)) = x",
    "toProductForm(fromProductForm(y)) = y",
}
laws = payload.get("required_laws")
if not isinstance(laws, list):
    raise SystemExit("MISSING_OBJECT := required_laws list")
if required_laws - set(laws):
    raise SystemExit("MISSING_OBJECT := product-form equivalence laws")

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
    raise SystemExit("MISSING_OBJECT := product-form equivalence non-claim")

print("INTENDED_UNRESTRICTED_STATE_PRODUCT_FORM_EQUIVALENCE_SURFACE_OK")
