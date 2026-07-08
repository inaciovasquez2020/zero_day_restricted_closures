#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/restricted_bounded_transition_relation_witness.json")

if not path.exists():
    raise SystemExit("MISSING_OBJECT := core/restricted_bounded_transition_relation_witness.json")

payload = json.loads(path.read_text())

if payload.get("surface") != "RestrictedBoundedTransitionRelationWitness":
    raise SystemExit("MISSING_OBJECT := RestrictedBoundedTransitionRelationWitness surface")

if payload.get("state_model") != "Fin 256":
    raise SystemExit("MISSING_OBJECT := state_model Fin 256")

prop = payload.get("restricted_transition_property")
if not isinstance(prop, dict):
    raise SystemExit("MISSING_OBJECT := restricted_transition_property field")
if prop.get("property") != "bounded_successor_semantics_over_StateModel_Fin_256":
    raise SystemExit("MISSING_OBJECT := restricted transition property name")
if prop.get("scope") != "restricted_zero_day_instance_only":
    raise SystemExit("MISSING_OBJECT := restricted transition property scope")
if prop.get("status") != "PROPERTY_WITNESS_SUPPLIED":
    raise SystemExit("MISSING_OBJECT := restricted transition property witness status")

bridges = payload.get("target_field_bridges")
if not isinstance(bridges, list):
    raise SystemExit("MISSING_OBJECT := target_field_bridges")

required_bridges = {
    ("restricted_transition_property", "TargetRealizesRestrictedLiftSourceChainComposition(C,T)"),
    ("scope", "restricted_zero_day_instance_only"),
}

seen_bridges = set()
for bridge in bridges:
    if not isinstance(bridge, dict):
        raise SystemExit("MISSING_OBJECT := target_field_bridge object")
    if bridge.get("bridge_status") != "FIELD_BRIDGE_WITNESS_SUPPLIED":
        raise SystemExit("MISSING_OBJECT := target_field_bridge witness status")
    if bridge.get("scope") != "restricted_zero_day_instance_only":
        raise SystemExit("MISSING_OBJECT := target_field_bridge scope")
    seen_bridges.add((bridge.get("source_field"), bridge.get("target_field")))

missing_bridges = sorted(required_bridges - seen_bridges)
if missing_bridges:
    raise SystemExit("MISSING_OBJECT := required target field bridge")

rows = payload.get("transitions")
if not isinstance(rows, list) or not rows:
    raise SystemExit("MISSING_OBJECT := nonempty bounded transition rows")

seen_sources = set()

for i, row in enumerate(rows):
    if not isinstance(row, dict):
        raise SystemExit(f"MISSING_OBJECT := transition row {i} object")
    src = row.get("from")
    dst = row.get("to")
    if not isinstance(src, int) or not 0 <= src < 256:
        raise SystemExit(f"MISSING_OBJECT := transition row {i} bounded from Fin 256")
    if not isinstance(dst, int) or not 0 <= dst < 256:
        raise SystemExit(f"MISSING_OBJECT := transition row {i} bounded to Fin 256")
    if row.get("kind") != "bounded_successor_row":
        raise SystemExit(f"MISSING_OBJECT := transition row {i} bounded_successor_row kind")
    if dst != min(src + 1, 255):
        raise SystemExit(f"MISSING_OBJECT := transition row {i} bounded successor semantics")
    seen_sources.add(src)

missing_sources = [i for i in range(256) if i not in seen_sources]
if missing_sources:
    raise SystemExit("MISSING_OBJECT := transition rows covering every source in Fin 256")

print("RESTRICTED_BOUNDED_TRANSITION_WITNESS_TEST_OK")
