#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/intended_unrestricted_state_to_product_form_map_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "IntendedUnrestrictedStateToProductFormMapSurface",
    "scope": "map_target_only",
    "source_surface": "IntendedUnrestrictedStateProductFormEquivalenceSurface",
    "map": "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "status": "MAP_TARGET_NOT_CONSTRUCTED",
    "downstream_law": "fromProductForm(toProductForm(x)) = x",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_outputs = {
    "encoded_coordinate : Fin 256",
    "payload_coordinate : Payload",
}
outputs = payload.get("required_outputs")
if not isinstance(outputs, list):
    raise SystemExit("MISSING_OBJECT := required_outputs list")
if required_outputs - set(outputs):
    raise SystemExit("MISSING_OBJECT := toProductForm required output")

required_non_claims = {
    "does not construct toProductForm",
    "does not construct fromProductForm",
    "does not prove IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := toProductForm non-claim")

print("INTENDED_UNRESTRICTED_STATE_TO_PRODUCT_FORM_MAP_SURFACE_OK")
