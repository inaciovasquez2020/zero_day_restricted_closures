
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

        raise SystemExit(f"PHYSICAL_SYSTEM_CONTEXT_WITNESS_TARGET_FAIL: {message}")





def text(payload: Any) -> str:

    return json.dumps(payload, sort_keys=True)





def contains(payload: Any, token: str) -> bool:

    return token in text(payload)





def main() -> None:

    obligation = load_json("core/f_physical_derivation_input_witness_obligation_surface.json")

    ranking = load_json("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")

    fixture = load_json("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")

    target = load_json("core/physical_system_context_witness_target_surface.json")

    receipt = load_json("core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json")



    for label, payload in {

        "obligation": obligation,

        "ranking": ranking,

        "fixture": fixture,

        "target": target,

        "receipt": receipt,

    }.items():

        require(

            contains(payload, "does_not_prove_physical_time_dilation")

            or contains(payload, "not(physical_time_dilation)"),

            f"{label} must preserve no-physical-dilation boundary",

        )

        require(

            contains(payload, "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"),

            f"{label} must preserve upstream missing non-toy law object",

        )



    require(

        target.get("status") == "witness_target_surface_uninhabited",

        "physical system context witness must remain an uninhabited target surface",

    )

    require(target.get("target") == "physical_system_context_witness", "target name must be physical_system_context_witness")

    require(target.get("available") is False, "physical system context witness must remain unavailable")

    require(target.get("inhabited") is False, "physical system context witness must remain non-inhabited")

    require(target.get("witness_present") is False, "physical system context witness must not be present")

    require(target.get("constructor_present") is False, "physical system context witness must not expose constructor")

    require(target.get("theorem_present") is False, "physical system context witness must not expose theorem")

    require(

        target.get("missing_object") == "physical_system_context_witness",

        "target must preserve physical_system_context_witness as local missing object",

    )

    require(

        target.get("upstream_missing_object") == "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",

        "target must preserve upstream F_physical missing object",

    )

    require(

        contains(target, "does_not_identify_F_toy_with_F_physical"),

        "target must preserve no F_toy/F_physical identification",

    )



    obligation_inputs = {

        item.get("name"): item

        for item in obligation.get("required_witness_inputs", [])

    }

    require(

        "physical_system_context_witness" in obligation_inputs,

        "base obligation must require physical_system_context_witness",

    )

    require(

        obligation_inputs["physical_system_context_witness"].get("available") is not True,

        "base obligation must keep physical_system_context_witness unavailable",

    )



    ranked = ranking.get("ranked_gaps_weakest_first", [])

    require(len(ranked) >= 1, "base ranking must contain at least one ranked gap")

    require(

        ranked[0].get("rank") == 1 and ranked[0].get("gap") == "physical_system_context_witness",

        "base ranking must rank physical_system_context_witness as weakest missing input",

    )



    require(

        receipt.get("status") == "weakest_dependency_receipt_only",

        "weakest dependency receipt must remain receipt-only",

    )

    require(

        receipt.get("weakest_missing_input") == "physical_system_context_witness",

        "receipt must identify physical_system_context_witness as weakest missing input",

    )

    require(receipt.get("rank") == 1, "receipt must keep physical_system_context_witness at rank 1")

    require(receipt.get("available") is False, "receipt must keep physical_system_context_witness unavailable")

    require(

        receipt.get("target_surface") == "core/physical_system_context_witness_target_surface.json",

        "receipt must bind to the physical system context witness target surface",

    )

    require(

        contains(receipt, "F_physical := F_toy"),

        "receipt must preserve rejection of F_physical := F_toy",

    )



    require(

        fixture.get("candidate_shortcut") == "F_physical := F_toy",

        "forbidden shortcut fixture must still target F_physical := F_toy",

    )

    require(fixture.get("expected_verdict") == "rejected", "F_physical := F_toy must remain rejected")

    require(

        contains(fixture, "does_not_identify_F_toy_with_F_physical"),

        "fixture must preserve no F_toy/F_physical identification",

    )

    require(

        contains(fixture, "toy affine bijection does not prove physical time dilation"),

        "fixture must preserve physical-dilation boundary rejection",

    )



    print("PHYSICAL_SYSTEM_CONTEXT_WITNESS_TARGET_OK")





if __name__ == "__main__":

    main()
