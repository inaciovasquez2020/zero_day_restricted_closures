#!/usr/bin/env python3

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from core.intended_unrestricted_state import from_product_form, to_product_form


def main() -> None:
    samples = [
        (0, None),
        (7, {"x": 1}),
        (255, ("payload", 3)),
    ]

    for product in samples:
        assert to_product_form(from_product_form(product)) == product

    print("PRODUCT_FORM_RIGHT_INVERSE_IMPLEMENTATION_OK")


if __name__ == "__main__":
    main()
