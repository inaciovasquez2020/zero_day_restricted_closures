#!/usr/bin/env python3

from __future__ import annotations

import re
import sys
from pathlib import Path


SOURCE = Path(
    "core/intended_hidden_sector_reduced_joint_action_coupling.lean"
)

REQUIRED_TOKENS = (
    "noncomputable def hiddenSectorReducedJointLagrangian",
    "def hiddenSectorReducedJointSourceResidual",
    "def hiddenSectorReducedJointHiddenMomentum",
    "theorem hiddenSectorReducedJointLagrangian_source_hasDerivAt",
    "(hasDerivAt_id sourceAmplitude).sub_const",
    "theorem hiddenSectorReducedJointLagrangian_sourceDerivative_exact",
    "theorem hiddenSectorReducedJointLagrangian_velocity_hasDerivAt",
    "theorem hiddenSectorReducedJointLagrangian_velocityDerivative_exact",
    "def hiddenSectorReducedJointStationaryAmplitude",
    "theorem hiddenSectorReducedJoint_sourceStationary",
    "theorem hiddenSectorReducedJoint_affine_sourceStationary",
    "noncomputable def hiddenSectorReducedJointHiddenEulerLagrangeResidual",
    "theorem hiddenSectorReducedJoint_affine_hiddenEulerLagrange",
    "noncomputable def hiddenSectorReducedJointAction",
    "theorem hiddenSectorReducedJointAction_affine_eq_freeAction",
    "theorem hiddenSectorReducedJointAction_affine_value",
    "noncomputable def hiddenSectorReducedJointStaticCurlField",
    "theorem hiddenSectorReducedJointStaticCurlField_current_exact",
    "theorem hiddenSectorReducedJointStaticCurl_evolution",
    "theorem hiddenSectorReducedJointStaticCurl_gaussContinuity_global",
    "theorem hiddenSectorReducedJoint_affine_staticCurl_simultaneous_solution",
    "theorem hiddenSectorReducedJointStaticCurl_boundaryFlux_eq_twice_action",
    "theorem hiddenSectorReducedJointStaticCurl_centered_faces_each_eq_action",
    "theorem darkMatterUnitCoupling_reducedJoint_stationaryAmplitude_exact",
    "theorem darkMatterUnitCoupling_reducedJoint_action_exact",
    "theorem darkMatterUnitCoupling_reducedJoint_field_eq_staticCurlField",
    "theorem darkMatterUnitCoupling_reducedJoint_simultaneous_solution",
    "theorem darkMatterUnitCoupling_reducedJoint_boundaryFlux_exact",
)

FORBIDDEN_TOKENS = (
    "source_stationarity_assumption :",
    "hidden_euler_lagrange_assumption :",
    "constitutive_map_assumption :",
    "maxwell_solution_assumption :",
    "joint_solution_assumption :",
    "set_option maxRecDepth",
)

FORBIDDEN_DECLARATION = re.compile(
    r"(?m)(^|[^A-Za-z0-9_])"
    r"(axiom|opaque|sorry|admit)"
    r"([^A-Za-z0-9_]|$)"
)

# Match the obsolete `.sub` method only when it is not `.sub_const`.
LEGACY_SOURCE_SUB = re.compile(
    r"\(hasDerivAt_id\s+sourceAmplitude\)"
    r"\.sub(?!_const)(?=\s|\()"
)


def fail(message: str) -> None:
    raise SystemExit(f"MISSING_OBJECT := {message}")


def verify_regex_boundary() -> None:
    legacy_example = (
        "(hasDerivAt_id sourceAmplitude).sub "
        "(hasDerivAt_const sourceAmplitude (velocity ^ 2))"
    )
    corrected_example = (
        "(hasDerivAt_id sourceAmplitude).sub_const "
        "(velocity ^ 2)"
    )

    if LEGACY_SOURCE_SUB.search(legacy_example) is None:
        fail("legacy source-derivative regex self-test")

    if LEGACY_SOURCE_SUB.search(corrected_example) is not None:
        fail("sub_const false-positive exclusion")


def main() -> None:
    verify_regex_boundary()

    if not SOURCE.is_file():
        fail(str(SOURCE))

    text = SOURCE.read_text(encoding="utf-8")

    for token in REQUIRED_TOKENS:
        if token not in text:
            fail(token)

    for token in FORBIDDEN_TOKENS:
        if token in text:
            fail(f"reduced joint-action package without {token}")

    if FORBIDDEN_DECLARATION.search(text):
        fail("assumption-free reduced joint-action declarations")

    if LEGACY_SOURCE_SUB.search(text):
        fail("legacy source-amplitude derivative using .sub")

    source_residual_body = (
        "sourceAmplitude - velocity ^ 2"
    )
    if source_residual_body not in text:
        fail("explicit source residual A minus velocity squared")

    stationary_relation = (
        "hiddenSectorReducedJointStationaryAmplitude momentum =\n"
        "      momentum ^ 2"
    )
    if stationary_relation not in text:
        fail("stationary amplitude equals momentum squared")

    print("REDUCED_JOINT_ACTION_REQUIRED_DECLARATIONS_OK")
    print("REDUCED_JOINT_ACTION_SUB_CONST_FALSE_POSITIVE_GUARD_OK")
    print("REDUCED_JOINT_ACTION_ASSUMPTION_FREE_GUARD_OK")
    print("HIDDEN_SECTOR_REDUCED_JOINT_ACTION_PERSISTENT_VERIFIER_OK")


if __name__ == "__main__":
    try:
        main()
    except UnicodeError as error:
        print(
            f"MISSING_OBJECT := UTF-8 verifier input: {error}",
            file=sys.stderr,
        )
        raise SystemExit(1) from error
