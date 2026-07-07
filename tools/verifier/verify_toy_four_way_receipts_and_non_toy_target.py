#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]


def load_json(rel: str) -> dict[str, Any]:
    path = ROOT / rel
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {rel}")
    with path.open("r", encoding="utf-8") as fh:
        return json.load(fh)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"TOY_FOUR_WAY_RECEIPT_TARGET_FAIL: {message}")


def contains(items: list[Any], token: str) -> bool:
    return any(token in str(item) for item in items)


def main() -> None:
    closure = load_json("core/toy_four_way_bijection_closure_surface.json")
    monotone = load_json("core/toy_four_way_bijection_strict_monotonicity_receipt_2026_07_07.json")
    inverse = load_json("core/toy_four_way_bijection_inverse_recovery_receipt_2026_07_07.json")
    target = load_json("core/non_toy_relative_time_law_target_surface.json")

    require(
        closure.get("missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "closure surface must preserve the derived non-toy law missing object",
    )
    require(
        "physical_time_dilation" in str(closure.get("boundary", "")),
        "closure surface must preserve a physical time dilation boundary",
    )
    require(
        contains(closure.get("non_claims", []), "does_not_prove_physical_time_dilation"),
        "closure surface must explicitly deny physical time dilation",
    )

    require(monotone.get("status") == "receipt_only", "monotonicity object must be receipt-only")
    require(
        monotone.get("base_surface") == "core/toy_four_way_bijection_closure_surface.json",
        "monotonicity receipt must bind to the merged closure surface",
    )
    require(len(monotone.get("monotone_maps", [])) == 4, "monotonicity receipt must list four monotone maps")
    require(
        contains(monotone.get("non_claims", []), "does_not_prove_physical_time_dilation"),
        "monotonicity receipt must preserve the no-physical-dilation non-claim",
    )
    require(
        monotone.get("boundary") == "not(physical_time_dilation)",
        "monotonicity receipt must preserve the physical time dilation boundary",
    )

    require(inverse.get("status") == "receipt_only", "inverse recovery object must be receipt-only")
    require(
        inverse.get("base_surface") == "core/toy_four_way_bijection_closure_surface.json",
        "inverse receipt must bind to the merged closure surface",
    )
    require(len(inverse.get("inverse_chain", [])) == 4, "inverse receipt must list four inverse maps")
    require(
        contains(inverse.get("non_claims", []), "does_not_prove_physical_time_dilation"),
        "inverse receipt must preserve the no-physical-dilation non-claim",
    )
    require(
        inverse.get("boundary") == "not(physical_time_dilation)",
        "inverse receipt must preserve the physical time dilation boundary",
    )

    require(target.get("status") == "target_surface_uninhabited", "non-toy law target must remain uninhabited")
    require(target.get("inhabited") is False, "non-toy law target must not be inhabited")
    require(target.get("constructor_present") is False, "non-toy law target must not expose a constructor")
    require(target.get("theorem_present") is False, "non-toy law target must not expose a theorem")
    require(
        target.get("missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "non-toy law target must preserve the missing object",
    )
    require(
        contains(target.get("forbidden_claims", []), "does_not_prove_physical_time_dilation"),
        "non-toy law target must explicitly forbid physical time dilation",
    )
    require(
        target.get("boundary") == "not(physical_time_dilation)",
        "non-toy law target must preserve the physical time dilation boundary",
    )

    print("TOY_FOUR_WAY_RECEIPTS_AND_NON_TOY_TARGET_OK")


if __name__ == "__main__":
    main()
