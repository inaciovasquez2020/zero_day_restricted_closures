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
        raise SystemExit(f"F_PHYSICAL_DERIVATION_OBLIGATION_FAIL: {message}")


def body(payload: Any) -> str:
    return json.dumps(payload, sort_keys=True)


def text_contains(payload: Any, token: str) -> bool:
    return token in body(payload)


def unavailable_obligation_inputs(obligation: dict[str, Any]) -> list[str]:
    return [
        str(item.get("name"))
        for item in obligation.get("required_witness_inputs", [])
        if item.get("available") is not True
    ]


def main() -> None:
    target = load_json("core/non_toy_relative_time_law_target_surface.json")
    contract = load_json("core/non_toy_relative_time_law_constructor_input_contract_surface.json")
    matrix = load_json("core/non_toy_relative_time_law_dependency_matrix_receipt_2026_07_07.json")
    boundary = load_json("core/affine_toy_bijection_physics_boundary_receipt_2026_07_07.json")
    obligation = load_json("core/f_physical_derivation_input_witness_obligation_surface.json")
    ranking = load_json("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    fixture = load_json("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    for label, payload in {
        "target": target,
        "contract": contract,
        "matrix": matrix,
        "boundary": boundary,
        "obligation": obligation,
        "ranking": ranking,
        "fixture": fixture,
    }.items():
        require(
            payload.get("missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
            f"{label} must preserve missing non-toy law object",
        )
        require(
            text_contains(payload, "does_not_prove_physical_time_dilation")
            or text_contains(payload, "not(physical_time_dilation)"),
            f"{label} must preserve no-physical-dilation boundary",
        )

    require(target.get("inhabited") is False, "non-toy target must remain uninhabited")
    require(target.get("constructor_present") is False, "non-toy target must not expose constructor")
    require(target.get("theorem_present") is False, "non-toy target must not expose theorem")

    require(
        contract.get("status") == "constructor_input_contract_surface_only",
        "constructor input contract must remain surface-only",
    )
    require(contract.get("inhabited") is False, "constructor input contract must remain uninhabited")
    require(contract.get("constructor_present") is False, "constructor input contract must not expose constructor")
    require(contract.get("theorem_present") is False, "constructor input contract must not expose theorem")

    require(
        matrix.get("status") == "dependency_matrix_receipt_only",
        "dependency matrix must remain receipt-only",
    )
    require(
        boundary.get("status") == "boundary_receipt_only",
        "affine toy physics boundary must remain receipt-only",
    )

    require(
        obligation.get("status") == "witness_obligation_surface_uninhabited",
        "F_physical derivation obligation must remain an uninhabited witness-obligation surface",
    )
    require(obligation.get("inhabited") is False, "F_physical derivation obligation must not be inhabited")
    require(obligation.get("witness_present") is False, "F_physical derivation witness must not be present")
    require(obligation.get("constructor_present") is False, "F_physical derivation obligation must not expose constructor")
    require(obligation.get("theorem_present") is False, "F_physical derivation obligation must not expose theorem")

    missing_inputs = unavailable_obligation_inputs(obligation)
    require(len(missing_inputs) == 5, "all five F_physical derivation witness inputs must remain unavailable")

    if obligation.get("inhabited") is True and missing_inputs:
        raise SystemExit(
            "F_PHYSICAL_DERIVATION_OBLIGATION_FAIL: inhabited F_physical derivation obligation without inputs"
        )

    require(
        ranking.get("status") == "gap_ranking_receipt_only",
        "gap ranking must remain receipt-only",
    )
    ranks = [item.get("rank") for item in ranking.get("ranked_gaps_weakest_first", [])]
    require(ranks == [1, 2, 3, 4, 5], "gap ranking must contain ranks 1 through 5 in order")
    require(
        all(item.get("gap") in missing_inputs for item in ranking.get("ranked_gaps_weakest_first", [])),
        "gap ranking must rank only missing obligation inputs",
    )

    require(
        fixture.get("status") == "forbidden_shortcut_regression_fixture",
        "F_physical := F_toy fixture must be a forbidden shortcut regression fixture",
    )
    require(fixture.get("candidate_shortcut") == "F_physical := F_toy", "fixture must target F_physical := F_toy")
    require(fixture.get("expected_verdict") == "rejected", "F_physical := F_toy fixture must remain rejected")
    require(
        text_contains(fixture, "no derivation_evidence_for_F_physical_witness"),
        "fixture must reject shortcut for missing derivation evidence",
    )
    require(
        text_contains(fixture, "toy affine bijection does not prove physical time dilation"),
        "fixture must reject shortcut by physical boundary",
    )
    require(
        text_contains(fixture, "does_not_identify_F_toy_with_F_physical"),
        "fixture must preserve no F_toy/F_physical identification",
    )

    print("F_PHYSICAL_DERIVATION_OBLIGATION_UNINHABITED_OK")


if __name__ == "__main__":
    main()
