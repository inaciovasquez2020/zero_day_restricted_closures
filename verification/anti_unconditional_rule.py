#!/usr/bin/env python3
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]

CONTROLLED_FILES = [
    ROOT / "README.md",
    ROOT / "STATUS.md",
    ROOT / "core" / "zero_day_boundary_surface.json",
    ROOT / "core" / "restricted_closure_surface.json",
    ROOT / "core" / "reachability_surface.json",
    ROOT / "core" / "terminal_closure_surface.json",
    ROOT / "core" / "initial_minimality_surface.json",
    ROOT / "core" / "conditional_restricted_closure_theorem_surface.json",
    ROOT / "specializations" / "k3n_hodge" / "schema" / "required_classes.json",
    ROOT / "specializations" / "k3n_hodge" / "schema" / "subalgebra_sh.json",
    ROOT / "specializations" / "k3n_hodge" / "proofs" / "conditional_closure.v",
    ROOT / "specializations" / "k3n_hodge" / "receipts" / "llv_insufficiency_report.md",
    ROOT / ".github" / "workflows" / "anti-unconditional-rule.yml",
    ROOT / "artifacts" / "status" / "zero_day_reachability_bootstrap_receipt_2026_07_06.json",
]

FORBIDDEN = [
    "UniversalCreationTheorem",
    "UniversalFinalityTheorem",
    "UnrestrictedZeroDayClosure",
    "zero_day_universal_creation",
    "zero_day_universal_finality",
    "zero_day_unrestricted_closure",
    "UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses",
    "zero_day_required_k3n_hodge_classes_subset_SH_unconditional",
    "general_hodge_origin_tate_algebraicity_X_k",
    "GeneralHodgeOriginTateAlgebraicity_X_k",
    "forall_required_k3n_hodge_classes_in_SH",
    "zero_day_unconditional_closure",
]

REQUIRED = [
    "ZeroDayBoundarySurface",
    "RestrictedClosureSurface",
    "ReachabilitySurface",
    "TerminalClosureSurface",
    "InitialMinimalitySurface",
    "ConditionalRestrictedClosureTheoremSurface",
    "ReachabilitySurface + TerminalClosureSurface + InitialMinimalitySurface -> RestrictedClosureSurface",
    "terminal_exists_source",
    "ZeroDayBoundarySurface -> RestrictedClosureSurface",
    "ReachableBy AdmissibleStep Initial Terminal",
    "no universal creation theorem",
    "no universal finality theorem",
    "no unrestricted closure theorem",
    "RequiredClassesSubsetSH",
    "not ProvenFrom LLVMarkmanNearbyInputSurface",
    "core/terminal_exists_source_surface.json",
    "TerminalExistsSource",
    "terminal_exists_source : ExistsAt Terminal",
    "core/local_closure_invariant_source_surface.json",
    "LocalClosureInvariantSource",
    "base_invariant_source : local_closure_predicate Initial",
    "inductive_step_source : forall s1 s2, local_closure_predicate s1 -> AdmissibleStep s1 s2 -> local_closure_predicate s2",
    "TerminalExistsSource + LocalClosureInvariantSource",
    "RestrictedClosureDerivationReceipt",
    "restricted_closure_from_supplied_sources : RestrictedClosureSurface",
    "BOUNDARY := ¬ unrestricted ZeroDayClosure",
]

ALLOWED_BOUNDARY_MENTIONS = {
    "UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses",
}

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
        if token in joined and token not in ALLOWED_BOUNDARY_MENTIONS:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL forbidden token: {token}")
            return 1


    for path, text in read_all():
        if "ReachableBy" in text and "AdmissibleStep" not in text:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL ReachableBy without supplied AdmissibleStep relation: {path.relative_to(ROOT)}")
            return 1


    for path, text in read_all():
        if "TerminalClosed -> ExistsAt" in text and "terminal_exists_source" not in text:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL TerminalClosed implies ExistsAt without explicit supplied terminal_exists_source: {path.relative_to(ROOT)}")
            return 1
        if "TerminalClosed Terminal -> ExistsAt Terminal" in text and "terminal_exists_source" not in text:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL TerminalClosed Terminal implies ExistsAt Terminal without explicit supplied terminal_exists_source: {path.relative_to(ROOT)}")
            return 1

    for path, text in read_all():
        if path.name == "conditional_restricted_closure_theorem_surface.json":
            if "RestrictedClosureSurface" in text and (
                "TerminalExistsSource + LocalClosureInvariantSource" not in text
                or "base_invariant_source : local_closure_predicate Initial" not in text
                or "inductive_step_source : forall s1 s2, local_closure_predicate s1 -> AdmissibleStep s1 s2 -> local_closure_predicate s2" not in text
            ):
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL conditional restricted closure missing explicit TerminalExistsSource + LocalClosureInvariantSource: {path.relative_to(ROOT)}")
                return 1

    for path, text in read_all():
        if path.name == "restricted_closure_derivation_receipt_surface.json":
            required_receipt_sources = [
                "core/restricted_closure_derivation_receipt_surface.json",
                "TerminalExistsSource",
                "LocalClosureInvariantSource",
                "ReachabilitySurface",
                "TerminalClosureSurface",
                "InitialMinimalitySurface",
                "restricted_closure_from_supplied_sources : RestrictedClosureSurface",
                "BOUNDARY := ¬ unrestricted ZeroDayClosure",
            ]
            for required_receipt_source in required_receipt_sources:
                if required_receipt_source not in text:
                    print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted closure receipt missing source: {required_receipt_source}")
                    return 1
            if "RestrictedClosureSurface from TerminalExistsSource alone" not in text:
                print("ANTI_UNCONDITIONAL_RULE_FAIL restricted closure receipt missing TerminalExistsSource-alone boundary")
                return 1

    lift_boundary_path = ROOT / "core/restricted_to_unrestricted_lift_boundary_surface.json"
    if lift_boundary_path.exists():
        lift_boundary_text = lift_boundary_path.read_text(encoding="utf-8")
        required_lift_boundary_tokens = [
            "RestrictedToUnrestrictedLiftBoundarySurface",
            "restricted_to_unrestricted_lift_source : RestrictedClosureSurface -> ZeroDayClosure",
            "zeroday_closure_from_lift_source : ZeroDayClosure",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
            "unconditional ZeroDayClosure",
        ]
        for required_lift_boundary_token in required_lift_boundary_tokens:
            if required_lift_boundary_token not in lift_boundary_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL lift boundary missing token: {required_lift_boundary_token}")
                return 1

    for token in REQUIRED:
        if token not in joined:
            print(f"ANTI_UNCONDITIONAL_RULE_FAIL missing required token: {token}")
            return 1

    if "BOUNDARY :=" not in joined and "Boundary:" not in joined:
        print("ANTI_UNCONDITIONAL_RULE_FAIL missing boundary marker")
        return 1

    print("ANTI_UNCONDITIONAL_RULE_OK")
    return 0

if __name__ == "__main__":
    sys.exit(main())
