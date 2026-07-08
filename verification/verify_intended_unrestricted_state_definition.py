#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import IntendedUnrestrictedState


def main() -> None:
    s = IntendedUnrestrictedState(encoded=0, payload=None)
    assert s.encoded == 0
    assert s.payload is None

    for bad in (-1, 256):
        try:
            IntendedUnrestrictedState(encoded=bad, payload=None)
        except ValueError:
            pass
        else:
            raise AssertionError(f"expected encoded bound failure for {bad}")

    try:
        IntendedUnrestrictedState(encoded="0", payload=None)
    except TypeError:
        pass
    else:
        raise AssertionError("expected encoded type failure")

    print("INTENDED_UNRESTRICTED_STATE_DEFINITION_OK")


if __name__ == "__main__":
    main()
