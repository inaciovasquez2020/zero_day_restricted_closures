#!/usr/bin/env python3
import json
from pathlib import Path

p = Path("core/general_finite_rank_termination_schema.json")
data = json.loads(p.read_text())

required = [
    "finite_state_space",
    "initial_state",
    "terminal_state",
    "admissible_step_relation",
    "rank_function_State_to_Nat",
    "rank_decreases_on_every_admissible_step",
    "terminal_iff_no_outgoing_admissible_step"
]

assert data["classification"] == "GENERAL_TERMINATION_SCHEMA_ONLY"
assert data["schema_status"] == "THEOREM_SCHEMA_NOT_PROVED"
assert data["boundary"] == "BOUNDARY := ¬ unrestricted ZeroDayClosure"

for item in required:
    assert item in data["required_inputs"], f"missing required input: {item}"

for forbidden in [
    "proves unrestricted ZeroDayClosure",
    "proves universal creation",
    "proves universal finality"
]:
    assert forbidden not in json.dumps(data)

print("GENERAL_FINITE_RANK_TERMINATION_SCHEMA_OK")
