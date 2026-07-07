#!/usr/bin/env python3
from pathlib import Path
import sys

LEAN = Path("lean/Chronos/Frontier/ToyFourWayBijectionClosure.lean")
FRONTIER = Path("lean/Chronos/Frontier.lean")
WORKFLOW = Path(".github/workflows/external-status-lock.yml")

REQUIRED = [
    "def ToyMotionBand",
    "def ToyUnitCoordinate",
    "def ToyRelativeTimeBand",
    "def ToyElapsedTimeBand",
    "def toyX",
    "def toyV",
    "def toyR",
    "def toyXFromR",
    "def toyE",
    "def toyRFromE",
    "def toyEFromSpeed",
    "def toyVFromElapsed",
    "theorem toyX_mem_unit",
    "theorem toyR_mem_time_band",
    "theorem toyE_mem_elapsed_band",
    "theorem toyV_toyX",
    "theorem toyX_toyV",
    "theorem toyR_toyXFromR",
    "theorem toyXFromR_toyR",
    "theorem toyRFromE_toyE",
    "theorem toyE_toyRFromE",
    "theorem toy_forward_elapsed_from_speed",
    "theorem toy_inverse_speed_from_elapsed",
    "theorem toyX_strict_mono",
    "theorem toyR_strict_mono",
    "theorem toyE_strict_mono",
    "theorem toyVFromElapsed_strict_mono",
    "theorem toy_four_way_forward",
    "BOUNDARY := ¬ toy_four_way_bijection_proves_physical_time_dilation",
    "MISSING_OBJECT := derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x",
    "structure DerivedNonToyRelativeTimeLawTarget where",
]

FORBIDDEN = [
    "axiom ",
    "opaque ",
    "sorry",
    "admit",
    "toy_four_way_bijection_proves_physical_time_dilation : Prop := True",
    "theorem toy_four_way_bijection_proves_physical_time_dilation",
    "def physical_time_dilation : Prop := True",
    "theorem physical_time_dilation",
    "F_physical := F_toy",
    "DerivedNonToyRelativeTimeLawTarget : Prop := True",
]


def fail(message: str) -> None:
    print(f"TOY_FOUR_WAY_BIJECTION_CLOSURE_FAIL: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> None:
    if not LEAN.exists():
        fail(f"missing {LEAN}")
    text = LEAN.read_text(encoding="utf-8")
    for needle in REQUIRED:
        if needle not in text:
            fail(f"missing required token: {needle}")
    for forbidden in FORBIDDEN:
        if forbidden in text:
            fail(f"forbidden overclaim token present: {forbidden}")
    if FRONTIER.exists():
        frontier = FRONTIER.read_text(encoding="utf-8")
        expected_import = "import Chronos.Frontier.ToyFourWayBijectionClosure"
        if expected_import not in frontier:
            fail("toy four-way bijection closure import missing from Chronos.Frontier")
    if WORKFLOW.exists():
        workflow = WORKFLOW.read_text(encoding="utf-8")
        expected_cmd = "python3 tools/verifier/verify_toy_four_way_bijection_closure.py"
        if expected_cmd not in workflow:
            fail("toy four-way bijection closure verifier not wired into external-status-lock workflow")
    print("TOY_FOUR_WAY_BIJECTION_CLOSURE_OK")


if __name__ == "__main__":
    main()
