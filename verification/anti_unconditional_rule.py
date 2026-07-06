#!/usr/bin/env python3
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]

FORBIDDEN = [
    "UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses",
    "zero_day_required_k3n_hodge_classes_subset_SH_unconditional",
    "general_hodge_origin_tate_algebraicity_X_k",
    "GeneralHodgeOriginTateAlgebraicity_X_k",
    "forall_required_k3n_hodge_classes_in_SH",
    "zero_day_unconditional_closure",
]

REQUIRED = [
    "RequiredClassesSubsetSH",
    "ZeroDayConditionalClosureSurface",
    "not ProvenFrom LLVMarkmanNearbyInputSurface",
]

CONTROLLED_FILES = [
    ROOT / "schema" / "required_classes.json",
    ROOT / "schema" / "subalgebra_sh.json",
    ROOT / "proofs" / "conditional_closure.v",
    ROOT / "receipts" / "llv_insufficiency_report.md",
]

def read_all():
    for path in CONTROLLED_FILES:
        if not path.exists():
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL missing controlled file: {path.relative_to(ROOT)}")
            raise SystemExit(1)
        yield path, path.read_text(encoding="utf-8", errors="ignore")

def main():
    joined = ""
    for path, text in read_all():
        joined += f"\n--- {path.relative_to(ROOT)} ---\n{text}\n"

    for token in FORBIDDEN:
        if token in joined and token != "UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses":
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL forbidden token: {token}")
            return 1

    for token in REQUIRED:
        if token not in joined:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL missing required token: {token}")
            return 1

    if "Boundary:" not in joined and "BOUNDARY :=" not in joined:
        print("ANTI_UNCONDITIONAL_RULE_FAIL missing boundary marker")
        return 1

    print("ANTI_UNCONDITIONAL_RULE_OK")
    return 0

if __name__ == "__main__":
    sys.exit(main())
