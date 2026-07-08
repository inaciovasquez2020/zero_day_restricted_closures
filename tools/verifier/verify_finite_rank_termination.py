#!/usr/bin/env python3
import json
from pathlib import Path

p = Path("core/finite_rank_termination_fixture.json")
data = json.loads(p.read_text())

states = set(data["state_space"])
initial = data["initial"]
terminal = data["terminal"]
steps = [tuple(x) for x in data["admissible_steps"]]
rank = data["rank"]

assert initial in states
assert terminal in states
assert set(rank) == states

for s in states:
    assert isinstance(rank[s], int)
    assert rank[s] >= 0

for a, b in steps:
    assert a in states
    assert b in states
    assert rank[b] < rank[a], f"rank does not decrease: {a}->{b}"

assert all(a != terminal for a, _ in steps), "Terminal has outgoing step"

seen = set()
frontier = [initial]
while frontier:
    s = frontier.pop()
    if s in seen:
        continue
    seen.add(s)
    frontier.extend(b for a, b in steps if a == s)

assert terminal in seen, "Terminal not reachable from Initial"

print("FINITE_RANK_TERMINATION_OK")
