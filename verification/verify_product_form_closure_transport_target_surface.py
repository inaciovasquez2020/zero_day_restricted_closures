#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/product_form_closure_transport_target_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "ProductFormClosureTransportTargetSurface",
    "scope": "transport_target_only",
    "source_theorem": "ProductFormRestrictedLiftClosure",
    "target_theorem": "IntendedUnrestrictedStateClosure",
    "transport_statement": "ProductFormRestrictedLiftClosure -> IntendedUnrestrictedStateClosure",
    "status": "TRANSPORT_TARGET_NOT_PROVED",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside transported intended-state model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

required_deps = {
    "IntendedUnrestrictedState ≃ Fin 256 × Payload",
    "ProductFormRestrictedLiftClosure",
}
depends_on = payload.get("depends_on")
if not isinstance(depends_on, list):
    raise SystemExit("MISSING_OBJECT := depends_on list")
if required_deps - set(depends_on):
    raise SystemExit("MISSING_OBJECT := closure transport dependency")

required_non_claims = {
    "does not prove IntendedUnrestrictedStateClosure",
    "does not prove ProductFormRestrictedLiftClosure -> IntendedUnrestrictedStateClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not erase product-form boundary",
}
non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
if required_non_claims - set(non_claims):
    raise SystemExit("MISSING_OBJECT := closure transport non-claim")

print("PRODUCT_FORM_CLOSURE_TRANSPORT_TARGET_SURFACE_OK")
