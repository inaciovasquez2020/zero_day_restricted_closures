#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/product_form_restricted_lift_closure_surface.json")
payload = json.loads(path.read_text())

required = {
    "surface": "ProductFormRestrictedLiftClosure",
    "scope": "product_form_only",
    "state_model": "UnrestrictedStateModel := Fin 256 × Payload",
    "restricted_state_model": "StateModel := Fin 256",
    "closed_state": "ClosedState(x) := (255, x.2)",
    "rank": "255 - x.1",
    "theorem": "forall x : Fin 256 × Payload, ZeroDayClosureState(x)",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure outside product-form model",
}

for key, value in required.items():
    if payload.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := {key}")

transition = payload.get("transition")
if not isinstance(transition, dict):
    raise SystemExit("MISSING_OBJECT := transition object")
if transition.get("restricted") != "tau(s) := min(s + 1, 255)":
    raise SystemExit("MISSING_OBJECT := restricted tau definition")
if transition.get("product_form") != "UnrestrictedStep(x) := (tau(x.1), x.2)":
    raise SystemExit("MISSING_OBJECT := product-form step definition")

required_obligations = {
    "tau(255) = 255",
    "s < 255 -> tau(s) = s + 1",
    "tau^[k](s) = min(s + k, 255)",
    "UnrestrictedStep^[k](x) = (tau^[k](x.1), x.2)",
    "UnrestrictedStep^[255 - x.1](x) = ClosedState(x)",
}

obligations = payload.get("proof_obligations")
if not isinstance(obligations, list):
    raise SystemExit("MISSING_OBJECT := proof_obligations list")
missing_obligations = sorted(required_obligations - set(obligations))
if missing_obligations:
    raise SystemExit("MISSING_OBJECT := product-form restricted lift proof obligation")

required_non_claims = {
    "does not prove unrestricted ZeroDayClosure outside product-form model",
    "does not prove every intended unrestricted state has product form",
    "does not erase restricted boundary",
    "does not prove IntendedUnrestrictedState ≃ Fin 256 × Payload",
}

non_claims = payload.get("non_claims")
if not isinstance(non_claims, list):
    raise SystemExit("MISSING_OBJECT := non_claims list")
missing_non_claims = sorted(required_non_claims - set(non_claims))
if missing_non_claims:
    raise SystemExit("MISSING_OBJECT := product-form restricted lift non-claim")

print("PRODUCT_FORM_RESTRICTED_LIFT_CLOSURE_OK")
