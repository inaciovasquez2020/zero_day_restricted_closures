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
        raise SystemExit(f"NON_TOY_LAW_DEPENDENCY_CONTRACT_BOUNDARY_FAIL: {message}")


def text_contains(payload: Any, needle: str) -> bool:
    return needle in json.dumps(payload, sort_keys=True)


def unavailable_required_inputs(contract: dict[str, Any]) -> list[str]:
    missing: list[str] = []
    for item in contract.get("required_inputs", []):
        if item.get("name") == "toy_physics_boundary_proof":
            continue
        if item.get("available") is not True:
            missing.append(str(item.get("name")))
    return missing


def main() -> None:
    target = load_json("core/non_toy_relative_time_law_target_surface.json")
    matrix = load_json("core/non_toy_relative_time_law_dependency_matrix_receipt_2026_07_07.json")
    contract = load_json("core/non_toy_relative_time_law_constructor_input_contract_surface.json")
    boundary = load_json("core/affine_toy_bijection_physics_boundary_receipt_2026_07_07.json")

    for rel, payload in {
        "target": target,
        "matrix": matrix,
        "contract": contract,
        "boundary": boundary
    }.items():
        require(
            text_contains(payload, "does_not_prove_physical_time_dilation")
            or text_contains(payload, "not(physical_time_dilation)"),
            f"{rel} must preserve no-physical-dilation boundary"
        )
        require(
            payload.get("missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
            f"{rel} must preserve missing non-toy law object"
        )

    require(target.get("status") == "target_surface_uninhabited", "non-toy law target must remain uninhabited")
    require(target.get("inhabited") is False, "non-toy law target must not be inhabited")
    require(target.get("constructor_present") is False, "non-toy law target must not expose a constructor")
    require(target.get("theorem_present") is False, "non-toy law target must not expose a theorem")

    require(matrix.get("status") == "dependency_matrix_receipt_only", "dependency matrix must be receipt-only")
    require(
        matrix.get("base_target") == "core/non_toy_relative_time_law_target_surface.json",
        "dependency matrix must bind to the non-toy target"
    )
    require(len(matrix.get("dependency_matrix", [])) >= 6, "dependency matrix must record the required missing edges")
    require(
        any(row.get("status") == "forbidden_boundary" for row in matrix.get("dependency_matrix", [])),
        "dependency matrix must include a forbidden physical-dilation bridge boundary"
    )

    require(
        contract.get("status") == "constructor_input_contract_surface_only",
        "constructor input contract must remain surface-only"
    )
    require(contract.get("inhabited") is False, "constructor input contract must not inhabit F_physical")
    require(contract.get("constructor_present") is False, "constructor input contract must not provide a constructor")
    require(contract.get("theorem_present") is False, "constructor input contract must not provide a theorem")
    missing_inputs = unavailable_required_inputs(contract)
    require(
        len(missing_inputs) >= 4,
        "constructor input contract must keep derivation inputs unavailable"
    )

    if target.get("inhabited") is True and missing_inputs:
        raise SystemExit(
            "NON_TOY_LAW_DEPENDENCY_CONTRACT_BOUNDARY_FAIL: inhabited F_physical without derivation inputs"
        )

    require(boundary.get("status") == "boundary_receipt_only", "physics boundary must be receipt-only")
    require(
        text_contains(boundary, "empirical time dilation"),
        "boundary receipt must separate empirical time dilation claims"
    )
    require(
        text_contains(boundary, "relativistic time dilation"),
        "boundary receipt must separate relativistic time dilation claims"
    )
    require(
        boundary.get("boundary") == "not(physical_time_dilation)",
        "boundary receipt must preserve physical_time_dilation negation"
    )

    print("NON_TOY_LAW_DEPENDENCY_CONTRACT_BOUNDARY_OK")


if __name__ == "__main__":
    main()
