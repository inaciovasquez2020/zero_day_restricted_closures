#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import IntendedUnrestrictedState, from_product_form


def main() -> None:
    payload = {"x": 1}
    s = from_product_form((7, payload))

    assert s == IntendedUnrestrictedState(encoded=7, payload=payload)

    for bad in (-1, 256):
        try:
            from_product_form((bad, None))
        except ValueError:
            pass
        else:
            raise AssertionError(f"expected encoded bound failure for {bad}")

    try:
        from_product_form([7, payload])
    except TypeError:
        pass
    else:
        raise AssertionError("expected product type failure")

    print("FROM_PRODUCT_FORM_MAP_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
