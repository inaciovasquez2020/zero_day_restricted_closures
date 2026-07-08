#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_unrestricted_state_from_product_form_map_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedUnrestrictedStateFromProductFormMapSurface",
    "scope": "map_target_only",
    "source_surface": "IntendedUnrestrictedStateProductFormEquivalenceSurface",
    "map": "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
    "status": "MAP_TARGET_NOT_CONSTRUCTED",
    "downstream_law": "toProductForm(fromProductForm(y)) = y",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_inputs = {
    "encoded_coordinate : Fin 256",
    "payload_coordinate : Payload",
}
inputs = payload.get("required_inputs")
if not isinstance(inputs, list):
    raise SystemExit("MISSING_OBJECT := required_inputs list")
if required_inputs - set(inputs):
    raise SystemExit("MISSING_OBJECT := fromProductForm required input")

required_non_claims = {
    "does not construct fromProductForm",
    "does not construct toProductForm",
    "does not prove IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := fromProductForm non-claim")

print("INTENDED_UNRESTRICTED_STATE_FROM_PRODUCT_FORM_MAP_SURFACE_OK")
