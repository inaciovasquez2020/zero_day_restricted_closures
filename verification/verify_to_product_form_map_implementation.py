#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import IntendedUnrestrictedState, to_product_form


def main() -> None:
    payload = {"x": 1}
    s = IntendedUnrestrictedState(encoded=7, payload=payload)

    assert to_product_form(s) == (7, payload)

    try:
        to_product_form((7, payload))
    except TypeError:
        pass
    else:
        raise AssertionError("expected state type failure")

    print("TO_PRODUCT_FORM_MAP_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
