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
        raise SystemExit(f"VARIABLE_DOMAIN_AND_GUARDS_WITNESS_TARGET_FAIL: {message}")


def text(payload: Any) -> str:
    return json.dumps(payload, sort_keys=True)


def contains(payload: Any, token: str) -> bool:
    return token in text(payload)


def main() -> None:
    physical_target = load_json("core/physical_system_context_witness_target_surface.json")
    physical_receipt = load_json("core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json")
    obligation = load_json("core/f_physical_derivation_input_witness_obligation_surface.json")
    ranking = load_json("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    fixture = load_json("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")
    target = load_json("core/variable_domain_and_guards_witness_target_surface.json")
    receipt = load_json("core/variable_domain_and_guards_witness_next_dependency_receipt_2026_07_07.json")

    for label, payload in {
        "physical_target": physical_target,
        "physical_receipt": physical_receipt,
        "obligation": obligation,
        "ranking": ranking,
        "fixture": fixture,
        "target": target,
        "receipt": receipt,
    }.items():
        require(contains(payload, "physical_time_dilation"), f"{label} must preserve physical-time-dilation boundary")
        require(
            contains(payload, "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"),
            f"{label} must preserve upstream missing non-toy law object",
        )

    require(physical_target.get("target") == "physical_system_context_witness", "prior target must remain present")
    require(physical_target.get("available") is False, "prior witness must remain unavailable")
    require(physical_target.get("inhabited") is False, "prior witness must remain non-inhabited")
    require(physical_target.get("witness_present") is False, "prior witness must not be present")
    require(physical_receipt.get("weakest_missing_input") == "physical_system_context_witness", "prior weakest input changed")
    require(physical_receipt.get("rank") == 1, "prior rank must remain 1")

    obligation_inputs = {item.get("name"): item for item in obligation.get("required_witness_inputs", [])}
    require("physical_system_context_witness" in obligation_inputs, "base obligation must require physical_system_context_witness")
    require("variable_domain_and_guards_witness" in obligation_inputs, "base obligation must require variable_domain_and_guards_witness")
    require(
        obligation_inputs["physical_system_context_witness"].get("available") is not True,
        "physical_system_context_witness must remain unavailable",
    )
    require(
        obligation_inputs["variable_domain_and_guards_witness"].get("available") is not True,
        "variable_domain_and_guards_witness must remain unavailable",
    )

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    require(len(ranked) >= 2, "base ranking must contain at least two ranked gaps")
    require(
        ranked[0].get("rank") == 1 and ranked[0].get("gap") == "physical_system_context_witness",
        "rank 1 must remain physical_system_context_witness",
    )
    require(
        ranked[1].get("rank") == 2 and ranked[1].get("gap") == "variable_domain_and_guards_witness",
        "rank 2 must remain variable_domain_and_guards_witness",
    )

    require(target.get("status") == "witness_target_surface_uninhabited", "target must remain uninhabited surface")
    require(target.get("target") == "variable_domain_and_guards_witness", "target name changed")
    require(target.get("rank") == 2, "target rank changed")
    require(
        target.get("depends_on_prior_missing_input") == "physical_system_context_witness",
        "prior dependency changed",
    )
    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:
        require(target.get(field) is False, f"target field {field} must remain false")

    require(target.get("missing_object") == "variable_domain_and_guards_witness", "local missing object changed")
    require(target.get("prior_missing_object") == "physical_system_context_witness", "prior missing object changed")
    require(
        target.get("upstream_missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
        "upstream missing object changed",
    )
    require(contains(target, "does_not_identify_F_toy_with_F_physical"), "target must preserve no-identification")
    require(contains(target, "F_physical := F_toy"), "target must preserve shortcut rejection")

    require(receipt.get("status") == "next_dependency_receipt_only", "receipt must remain receipt-only")
    prior = receipt.get("prior_ranked_missing_input", {})
    nxt = receipt.get("next_ranked_missing_input", {})
    require(
        prior.get("rank") == 1 and prior.get("name") == "physical_system_context_witness" and prior.get("available") is False,
        "receipt prior input changed",
    )
    require(
        nxt.get("rank") == 2 and nxt.get("name") == "variable_domain_and_guards_witness" and nxt.get("available") is False,
        "receipt next input changed",
    )
    require(
        receipt.get("target_surface") == "core/variable_domain_and_guards_witness_target_surface.json",
        "receipt target surface changed",
    )
    require(contains(receipt, "F_physical := F_toy"), "receipt must preserve shortcut rejection")

    require(fixture.get("candidate_shortcut") == "F_physical := F_toy", "fixture shortcut target changed")
    require(fixture.get("expected_verdict") == "rejected", "fixture verdict changed")
    require(contains(fixture, "does_not_identify_F_toy_with_F_physical"), "fixture no-identification guard missing")
    require(
        contains(fixture, "toy affine bijection does not prove physical time dilation"),
        "fixture physical boundary rejection missing",
    )

    print("VARIABLE_DOMAIN_AND_GUARDS_WITNESS_TARGET_OK")


if __name__ == "__main__":
    main()
