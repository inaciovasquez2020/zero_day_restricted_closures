#!/usr/bin/env python3

import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "restricted_target_extraction_field_inventory_surface.json"

EXPECTED_FIELDS = {
    "TerminalComposite(C,T)",
    "RestrictedBoundaryInvariant(T)",
    "TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
    "restricted_zero_day_instance_only",
}

ALLOWED_FIELD_STATUSES = {
    "FIELD_NEEDED_NOT_EXTRACTED",
    "FIELD_NEEDED_NOT_APPLIED",
    "FIELD_NEEDED_NOT_USED",
    "FIELD_NEEDED_NOT_PROVED",
    "FIELD_NEEDED_NOT_CONSTRUCTED",
}

REQUIRED_NON_CLAIMS = {
    "does not extract terminal composition closure content",
    "does not prove ZeroDayClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not discharge LiftSourceChainCompositionGap",
    "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
    "does not construct an unrestricted zero-day closure",
    "does not erase the restricted boundary",
    "does not prove the restricted-to-unrestricted lift",
}


def require(condition: bool, missing: str) -> None:
    if not condition:
        raise SystemExit(f"MISSING_OBJECT := {missing}")


def reject_unrestricted_promotion(value: Any, path: tuple[str, ...] = ()) -> None:
    if isinstance(value, dict):
        for key, child in value.items():
            reject_unrestricted_promotion(child, path + (str(key),))
        return

    if isinstance(value, list):
        for index, child in enumerate(value):
            reject_unrestricted_promotion(child, path + (str(index),))
        return

    if not isinstance(value, str):
        return

    allowed_roots = {"boundary", "non_claims", "next_weakest_point"}
    if path and path[0] in allowed_roots:
        return

    require(
        "unrestricted ZeroDayClosure" not in value,
        "absence of unrestricted ZeroDayClosure promotion outside boundary fields",
    )


def main() -> None:
    require(SURFACE.is_file(), str(SURFACE.relative_to(ROOT)))

    data = json.loads(SURFACE.read_text(encoding="utf-8"))

    require(
        data.get("surface") == "RestrictedTargetExtractionFieldInventorySurface",
        "RestrictedTargetExtractionFieldInventorySurface identity",
    )
    require(
        data.get("boundary") == "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "restricted extraction-field inventory boundary",
    )
    require(
        data.get("classification") == "DOWNSTREAM_EDGE_FIELD_INVENTORY_ONLY",
        "field-inventory-only classification",
    )
    require(
        data.get("parent_obligation_refinement")
        == "RestrictedTargetTerminalCompositionExtractionObligationSurface",
        "terminal-composition extraction parent",
    )
    require(
        data.get("target_edge")
        == "RestrictedCompositionTarget -> ZeroDayClosure",
        "restricted target edge shape",
    )
    require(
        data.get("inventory_status") == "FIELDS_IDENTIFIED_NOT_USED",
        "unapplied field inventory status",
    )
    require(
        data.get("missing_object")
        == "actual extraction witness using the listed RestrictedCompositionTarget fields",
        "explicit extraction-witness gap",
    )

    rows = data.get("required_fields")
    require(isinstance(rows, list), "required_fields list")

    fields: dict[str, dict[str, Any]] = {}
    for row in rows:
        require(isinstance(row, dict), "required_fields row object")
        field = row.get("field")
        require(isinstance(field, str), "required_fields row name")
        require(field not in fields, f"unique required field {field}")
        fields[field] = row

    require(
        set(fields) == EXPECTED_FIELDS,
        "exact RestrictedCompositionTarget extraction-field inventory",
    )

    for field, row in fields.items():
        require(
            row.get("status") in ALLOWED_FIELD_STATUSES,
            f"unconstructed status for {field}",
        )
        require(
            isinstance(row.get("role"), str) and bool(row["role"].strip()),
            f"bounded role for {field}",
        )

    non_claims = data.get("non_claims")
    require(isinstance(non_claims, list), "non_claims list")
    require(
        REQUIRED_NON_CLAIMS.issubset(set(non_claims)),
        "complete restricted extraction non-claims",
    )

    reject_unrestricted_promotion(data)

    print("RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_OK")


if __name__ == "__main__":
    main()
