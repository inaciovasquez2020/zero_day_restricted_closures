#!/usr/bin/env python3
from __future__ import annotations

import json
import math
import re
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]

SCHEMA_PATH = (
    ROOT
    / "core"
    / "directional_flow_detector_measurement_receipt.schema.json"
)

TEMPLATE_PATH = (
    ROOT
    / "core"
    / "directional_flow_detector_measurement_receipt.template.json"
)

RECEIPT_DIR = ROOT / "artifacts" / "external_validation"

RECEIPT_GLOB = (
    "directional_flow_detector_measurement_receipt_*.json"
)

HEX64 = re.compile(r"^[A-Fa-f0-9]{64}$")
ZERO_HASH = "0" * 64


def fail(message: str) -> None:
    raise SystemExit(
        "DIRECTIONAL_FLOW_DETECTOR_MEASUREMENT_"
        f"RECEIPT_SCHEMA_ERROR := {message}"
    )


def require(condition: bool, message: str) -> None:
    if not condition:
        fail(message)


def load(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"{path}: {exc}")

    require(
        isinstance(value, dict),
        f"{path}: top-level JSON value is not an object",
    )

    return value


def reject_nonfinite(value: Any, location: str = "$") -> None:
    if isinstance(value, float):
        require(
            math.isfinite(value),
            f"{location}: non-finite number",
        )
        return

    if isinstance(value, dict):
        for key, child in value.items():
            reject_nonfinite(child, f"{location}.{key}")
        return

    if isinstance(value, list):
        for index, child in enumerate(value):
            reject_nonfinite(child, f"{location}[{index}]")


def reject_placeholders(
    value: Any,
    location: str = "$",
) -> None:
    if isinstance(value, str):
        upper = value.upper()

        require(
            "MISSING" not in upper,
            f"{location}: placeholder text",
        )

        require(
            "UNINHABITED" not in upper,
            f"{location}: uninhabited marker",
        )

        return

    if isinstance(value, dict):
        for key, child in value.items():
            reject_placeholders(child, f"{location}.{key}")
        return

    if isinstance(value, list):
        for index, child in enumerate(value):
            reject_placeholders(child, f"{location}[{index}]")


def require_hash(value: Any, location: str) -> None:
    require(
        isinstance(value, str),
        f"{location}: hash is not a string",
    )

    require(
        bool(HEX64.fullmatch(value)),
        f"{location}: hash is not 64 hexadecimal characters",
    )

    require(
        value != ZERO_HASH,
        f"{location}: all-zero placeholder hash",
    )


def require_close(
    actual: float,
    expected: float,
    location: str,
) -> None:
    require(
        math.isclose(
            actual,
            expected,
            rel_tol=1e-9,
            abs_tol=1e-18,
        ),
        f"{location}: expected {expected!r}, got {actual!r}",
    )


schema = load(SCHEMA_PATH)
template = load(TEMPLATE_PATH)

reject_nonfinite(schema)
reject_nonfinite(template)

required_top = {
    "schema_version",
    "receipt_status",
    "receipt_id",
    "created_utc",
    "dataset",
    "measurement_context",
    "calibration",
    "uncertainty_budget",
    "systematic_error_subtraction",
    "null_estimators",
    "derived_affine_inputs",
    "admission_boundaries",
}

require(
    schema.get("$schema")
    == "https://json-schema.org/draft/2020-12/schema",
    "wrong JSON Schema draft",
)

require(
    schema.get("additionalProperties") is False,
    "top-level additionalProperties must be false",
)

require(
    set(schema.get("required", [])) == required_top,
    "top-level required-field inventory mismatch",
)

properties = schema.get("properties", {})

require(
    properties
    .get("receipt_status", {})
    .get("const")
    == "external_measurement",
    "receipt_status is not locked",
)

boundary_properties = (
    properties
    .get("admission_boundaries", {})
    .get("properties", {})
)

require(
    boundary_properties
    .get("empirical_promotion_authorized", {})
    .get("const")
    is False,
    "empirical-promotion boundary missing",
)

require(
    boundary_properties
    .get("universal_E_eq_mc3_claimed", {})
    .get("const")
    is False,
    "universal-law boundary missing",
)

require(
    template.get("receipt_status")
    == "template_uninhabited",
    "template must remain uninhabited",
)

require(
    template["dataset"]["sha256"] == ZERO_HASH,
    "template dataset hash must remain a placeholder",
)

require(
    template["calibration"]["independent"] is False,
    "template must not claim independent calibration",
)

require(
    template["null_estimators"][0]["passed"] is False,
    "template must not claim a passing null estimator",
)

require(
    template["derived_affine_inputs"]
    ["signal_above_uncertainty"]
    is False,
    "template must not claim signal significance",
)

require(
    template["admission_boundaries"]
    ["empirical_promotion_authorized"]
    is False,
    "template empirical boundary missing",
)

require(
    template["admission_boundaries"]
    ["universal_E_eq_mc3_claimed"]
    is False,
    "template universal-law boundary missing",
)

if RECEIPT_DIR.is_dir():
    receipt_paths = sorted(
        RECEIPT_DIR.glob(RECEIPT_GLOB)
    )
else:
    receipt_paths = []

for path in receipt_paths:
    receipt = load(path)

    reject_nonfinite(receipt)
    reject_placeholders(receipt)

    require(
        set(receipt) == required_top,
        f"{path}: top-level fields mismatch",
    )

    require(
        receipt["schema_version"] == "1.0.0",
        f"{path}: schema version mismatch",
    )

    require(
        receipt["receipt_status"] == "external_measurement",
        f"{path}: receipt is not external_measurement",
    )

    dataset = receipt["dataset"]

    require(
        dataset["immutable"] is True,
        f"{path}: dataset is not immutable",
    )

    require(
        isinstance(dataset["byte_size"], int)
        and dataset["byte_size"] > 0,
        f"{path}: invalid dataset byte size",
    )

    require_hash(
        dataset["sha256"],
        f"{path}: dataset.sha256",
    )

    calibration = receipt["calibration"]

    require(
        calibration["independent"] is True,
        f"{path}: calibration is not independent",
    )

    require(
        float(calibration["k_D"]) > 0.0,
        f"{path}: k_D is not positive",
    )

    require_hash(
        calibration["artifact_sha256"],
        f"{path}: calibration.artifact_sha256",
    )

    budget = receipt["uncertainty_budget"]

    require(
        float(budget["coverage_factor"]) > 0.0,
        f"{path}: coverage factor is not positive",
    )

    require(
        0.0
        < float(budget["confidence_level"])
        <= 1.0,
        f"{path}: invalid confidence level",
    )

    require(
        float(budget["delta_readout"]) >= 0.0,
        f"{path}: negative delta_readout",
    )

    require(
        float(budget["delta_response"]) >= 0.0,
        f"{path}: negative delta_response",
    )

    require(
        isinstance(budget["components"], list)
        and bool(budget["components"]),
        f"{path}: empty uncertainty components",
    )

    require_hash(
        budget["artifact_sha256"],
        f"{path}: uncertainty_budget.artifact_sha256",
    )

    systematic = receipt["systematic_error_subtraction"]

    require_hash(
        systematic["artifact_sha256"],
        (
            f"{path}: systematic_error_subtraction."
            "artifact_sha256"
        ),
    )

    require_close(
        float(systematic["residual_signal"]),
        (
            float(systematic["raw_signal"])
            - float(
                systematic["total_systematic_correction"]
            )
        ),
        f"{path}: systematic residual",
    )

    nulls = receipt["null_estimators"]

    require(
        isinstance(nulls, list) and bool(nulls),
        f"{path}: no null estimators",
    )

    for index, null in enumerate(nulls):
        require(
            null["passed"] is True,
            (
                f"{path}: null estimator {index} "
                "did not pass"
            ),
        )

        require(
            float(null["acceptance_threshold"]) >= 0.0,
            f"{path}: negative null threshold",
        )

        require_hash(
            null["artifact_sha256"],
            (
                f"{path}: null_estimators[{index}]."
                "artifact_sha256"
            ),
        )

    affine = receipt["derived_affine_inputs"]

    readout = float(affine["readout_D"])
    flow_norm = float(affine["flowNorm_B"])
    c = float(affine["c"])

    k_d = float(calibration["k_D"])
    b_d = float(calibration["b_D"])

    delta_readout = float(budget["delta_readout"])
    delta_response = float(budget["delta_response"])

    require(
        flow_norm >= 0.0,
        f"{path}: negative flowNorm_B",
    )

    require(
        c > 0.0,
        f"{path}: c is not positive",
    )

    residual = abs(
        (readout - b_d)
        - k_d * flow_norm
    )

    combined_uncertainty = (
        delta_readout
        + k_d * delta_response
    )

    signal = readout - b_d

    calibrated_lower_bound = (
        (signal - combined_uncertainty)
        / (k_d * c**3)
    )

    flow_mass = flow_norm / c**3

    require_close(
        float(affine["calibration_residual"]),
        residual,
        f"{path}: calibration_residual",
    )

    require_close(
        float(affine["combined_uncertainty"]),
        combined_uncertainty,
        f"{path}: combined_uncertainty",
    )

    tolerance = max(
        1e-18,
        1e-9
        * max(
            abs(residual),
            abs(combined_uncertainty),
            1.0,
        ),
    )

    require(
        residual <= combined_uncertainty + tolerance,
        (
            f"{path}: calibration residual exceeds "
            "combined uncertainty"
        ),
    )

    require(
        affine["signal_above_uncertainty"] is True,
        f"{path}: signal_above_uncertainty is false",
    )

    require(
        combined_uncertainty < signal,
        (
            f"{path}: signal does not exceed "
            "combined uncertainty"
        ),
    )

    require_close(
        float(affine["calibrated_lower_bound_B"]),
        calibrated_lower_bound,
        f"{path}: calibrated_lower_bound_B",
    )

    require_close(
        float(affine["flow_mass_B"]),
        flow_mass,
        f"{path}: flow_mass_B",
    )

    require(
        calibrated_lower_bound > 0.0,
        f"{path}: lower bound is not positive",
    )

    require(
        calibrated_lower_bound <= flow_mass + tolerance,
        f"{path}: lower bound exceeds flow mass",
    )

    admission = receipt["admission_boundaries"]

    require(
        admission["measurement_receipt_only"] is True,
        (
            f"{path}: measurement-receipt "
            "boundary missing"
        ),
    )

    require(
        admission["empirical_promotion_authorized"]
        is False,
        f"{path}: empirical promotion was asserted",
    )

    require(
        admission["universal_E_eq_mc3_claimed"]
        is False,
        f"{path}: universal E=mc^3 was asserted",
    )

if receipt_paths:
    print(
        "DIRECTIONAL_FLOW_DETECTOR_MEASUREMENT_"
        f"RECEIPTS_VERIFIED := {len(receipt_paths)}"
    )
else:
    print(
        "DIRECTIONAL_FLOW_DETECTOR_MEASUREMENT_"
        "RECEIPT_SCHEMA_OK"
    )
    print(
        "BOUNDARY := "
        "¬ external_measurement_receipt_present"
    )
