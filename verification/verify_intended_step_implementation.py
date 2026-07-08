#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import IntendedUnrestrictedState, intended_step


def main() -> None:
    assert intended_step(IntendedUnrestrictedState(0, None)) == IntendedUnrestrictedState(1, None)
    assert intended_step(IntendedUnrestrictedState(7, {"x": 1})) == IntendedUnrestrictedState(8, {"x": 1})
    assert intended_step(IntendedUnrestrictedState(255, "x")) == IntendedUnrestrictedState(0, "x")

    try:
        intended_step((0, None))
    except TypeError:
        pass
    else:
        raise AssertionError("expected state type failure")

    print("INTENDED_STEP_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
