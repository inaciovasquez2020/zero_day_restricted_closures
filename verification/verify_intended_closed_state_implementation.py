#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import IntendedUnrestrictedState, intended_closed_state


def main() -> None:
    assert intended_closed_state(IntendedUnrestrictedState(0, None)) == IntendedUnrestrictedState(0, None)
    assert intended_closed_state(IntendedUnrestrictedState(7, {"x": 1})) == IntendedUnrestrictedState(0, {"x": 1})
    assert intended_closed_state(IntendedUnrestrictedState(255, "x")) == IntendedUnrestrictedState(0, "x")

    try:
        intended_closed_state((7, None))
    except TypeError:
        pass
    else:
        raise AssertionError("expected state type failure")

    print("INTENDED_CLOSED_STATE_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
