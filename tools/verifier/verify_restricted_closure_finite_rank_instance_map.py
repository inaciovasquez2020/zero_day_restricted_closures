#!/usr/bin/env python3
import json
from pathlib import Path

p = Path("core/restricted_closure_finite_rank_instance_map.json")
data = json.loads(p.read_text())

expected = {
    "State": "ZeroDayBoundarySurface.State",
    "Initial": "ZeroDayBoundarySurface.Initial",
    "Terminal": "ZeroDayBoundarySurface.Terminal",
    "AdmissibleStep": "ZeroDayBoundarySurface.AdmissibleStep",
}

assert data["classification"] == "SCHEMA_INSTANCE_MAP_ONLY"
assert data["boundary"] == "BOUNDARY := ¬ unrestricted ZeroDayClosure"
assert data["instance_status"] == "PARTIAL_INSTANCE_MAP_RANK_UNSUPPLIED"
assert data["mapped_fields"] == expected

required_unsupplied = [
    "finite_state_space",
    "rank_function_State_to_Nat",
    "rank_decreases_on_every_admissible_step",
    "terminal_iff_no_outgoing_admissible_step",
]

for item in required_unsupplied:
    assert item in data["unsupplied_schema_inputs"], f"missing unsupplied input marker: {item}"

text = json.dumps(data)
for forbidden in [
    "rank_function_State_to_Nat supplied",
    "rank_decreases_on_every_admissible_step supplied",
    "proves unrestricted ZeroDayClosure"
]:
    assert forbidden not in text

print("RESTRICTED_CLOSURE_FINITE_RANK_INSTANCE_MAP_OK")
