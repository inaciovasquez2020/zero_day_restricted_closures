#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/product_form_right_inverse_law_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "ProductFormRightInverseLawSurface",
    "scope": "inverse_law_target_only",
    "source_surface": "IntendedUnrestrictedStateProductFormEquivalenceSurface",
    "law": "toProductForm(fromProductForm(y)) = y",
    "status": "LAW_TARGET_NOT_PROVED",
    "downstream_use": "right inverse law for IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_dependencies = {
    "toProductForm : IntendedUnrestrictedState -> Fin 256 × Payload",
    "fromProductForm : Fin 256 × Payload -> IntendedUnrestrictedState",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_dependencies - set(depends_on):
    raise SystemExit("MISSING_OBJECT := product-form right inverse dependency")

required_non_claims = {
    "does not prove toProductForm(fromProductForm(y)) = y",
    "does not prove fromProductForm(toProductForm(x)) = x",
    "does not prove IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "does not transport ProductFormRestrictedLiftClosure",
    "does not prove unrestricted ZeroDayClosure",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := product-form right inverse non-claim")

print("PRODUCT_FORM_RIGHT_INVERSE_LAW_SURFACE_OK")
