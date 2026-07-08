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
    samples = [
        IntendedUnrestrictedState(encoded=0, payload=None),
        IntendedUnrestrictedState(encoded=1, payload={"x": 1}),
        IntendedUnrestrictedState(encoded=255, payload=("payload", 3)),
    ]

    for state in samples:
        n = (256 - state.encoded) % 256
        assert n <= 255
        assert iterate_step(state, n) == intended_closed_state(state)

    print("INTENDED_UNRESTRICTED_STATE_CLOSURE_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
