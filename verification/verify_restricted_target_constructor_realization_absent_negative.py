#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_constructor_realization_obligation_surface.json"

def main() -> None:
    data = json.loads(SURFACE.read_text())

    if data["constructor_realization"]["status"] != "ABSENT":
        raise AssertionError("constructor realization must remain absent")

    if data["restricted_composition_target"]["status"] != "UNCONSTRUCTED":
        raise AssertionError("RestrictedCompositionTarget must remain unconstructed")

    print("RESTRICTED_TARGET_CONSTRUCTOR_REALIZATION_ABSENT_NEGATIVE_OK")

if __name__ == "__main__":
    main()
