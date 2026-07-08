#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import (
    IntendedUnrestrictedState,
    from_product_form,
    to_product_form,
)


def main() -> None:
    products = [
        (0, None),
        (7, {"x": 1}),
        (255, ("payload", 3)),
    ]

    states = [
        IntendedUnrestrictedState(encoded=0, payload=None),
        IntendedUnrestrictedState(encoded=7, payload={"x": 1}),
        IntendedUnrestrictedState(encoded=255, payload=("payload", 3)),
    ]

    for product in products:
        assert to_product_form(from_product_form(product)) == product

    for state in states:
        assert from_product_form(to_product_form(state)) == state

    print("PRODUCT_FORM_EQUIVALENCE_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
