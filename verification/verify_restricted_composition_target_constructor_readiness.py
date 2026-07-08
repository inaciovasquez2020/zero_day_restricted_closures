#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("core/restricted_bounded_transition_relation_witness.json")

if not path.exists():
    raise SystemExit("MISSING_OBJECT := core/restricted_bounded_transition_relation_witness.json")

payload = json.loads(path.read_text())

bridges = payload.get("target_field_bridges")
if not isinstance(bridges, list):
    raise SystemExit("MISSING_OBJECT := target_field_bridges")

required_targets = {
    "TerminalComposite(C,T)",
    "RestrictedBoundaryInvariant(T)",
    "TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
    "restricted_zero_day_instance_only",
}

seen_targets = set()
for bridge in bridges:
    if not isinstance(bridge, dict):
        raise SystemExit("MISSING_OBJECT := target_field_bridge object")
    if bridge.get("bridge_status") != "FIELD_BRIDGE_WITNESS_SUPPLIED":
        raise SystemExit("MISSING_OBJECT := supplied field bridge status")
    if bridge.get("scope") != "restricted_zero_day_instance_only":
        raise SystemExit("MISSING_OBJECT := restricted field bridge scope")
    seen_targets.add(bridge.get("target_field"))

missing_targets = sorted(required_targets - seen_targets)
if missing_targets:
    raise SystemExit("MISSING_OBJECT := complete RestrictedCompositionTarget field bridge coverage")

if payload.get("scope") != "restricted_zero_day_instance_only":
    raise SystemExit("MISSING_OBJECT := restricted witness scope")

print("RESTRICTED_COMPOSITION_TARGET_CONSTRUCTOR_READINESS_OK")
