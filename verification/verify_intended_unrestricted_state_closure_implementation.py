#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import (
    IntendedUnrestrictedState,
    intended_closed_state,
    intended_step,
)


def iterate_step(state: IntendedUnrestrictedState, n: int) -> IntendedUnrestrictedState:
    current = state
    for _ in range(n):
        current = intended_step(current)
    return current


def main() -> None:
    states = [
        IntendedUnrestrictedState(
            encoded=encoded,
            payload=("exhaustive-encoded-state", encoded),
        )
        for encoded in range(256)
    ]

    assert len(states) == 256
    assert {state.encoded for state in states} == set(range(256))

    for state in states:
        n = 255 - state.encoded
        assert 0 <= n <= 255
        assert iterate_step(state, n) == intended_closed_state(state)

    print("INTENDED_UNRESTRICTED_STATE_CLOSURE_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
