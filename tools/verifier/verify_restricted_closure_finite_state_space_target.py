#!/usr/bin/env python3
import json
from pathlib import Path

p = Path("core/restricted_closure_finite_state_space_target.json")
data = json.loads(p.read_text())

assert data["classification"] == "FINITE_STATE_SPACE_TARGET_ONLY"
assert data["boundary"] == "BOUNDARY := ¬ unrestricted ZeroDayClosure"
assert data["target"] == "finite_state_space"
assert data["state_field"] == "ZeroDayBoundarySurface.State"
assert data["target_shape"] == "Finite ZeroDayBoundarySurface.State"
assert data["target_status"] == "FINITE_STATE_SPACE_TARGET_NOT_PROVED"

for item in [
    "rank_function_State_to_Nat",
    "rank_decreases_on_every_admissible_step",
    "terminal_iff_no_outgoing_admissible_step"
]:
    assert item in data["preserved_unsupplied_schema_inputs"]

text = json.dumps(data)
for forbidden in [
    "does prove finite_state_space",
    "rank_function_State_to_Nat supplied",
    "proves unrestricted ZeroDayClosure"
]:
    assert forbidden not in text

print("RESTRICTED_CLOSURE_FINITE_STATE_SPACE_TARGET_OK")
