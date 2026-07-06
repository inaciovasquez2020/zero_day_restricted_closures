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

    desi_bao_path = ROOT / "artifacts/tests/desi_dr2_bao_dfm_mkc_test_2026_07_06.json"
    if desi_bao_path.exists():
        desi_bao_text = desi_bao_path.read_text(encoding="utf-8")
        required_desi_bao_tokens = [
            "DESI_DR2_BAO_DFM_MKC_Test",
            "falsification_surface_only",
            "DFM_MKC_formula_to_observable_map",
            "first expansion-history falsification surface",
            "H(z)",
            "D_M(z)",
            "D_H(z)",
            "D_V(z)",
            "r_d",
            "DESI_DR2_BAO_FALSIFICATION_TEST_DEFINED_BUT_NOT_EXECUTED",
            "DFM_MKC_FORMULA_SURFACE_FOUND_BUT_NO_ZD_CLOSURE_DERIVED",
            "does not prove unrestricted ZeroDayClosure",
            "does not validate cosmology empirically",
            "does not reject Lambda-CDM",
            "does not independently reproduce DESI DR2 likelihoods",
            "does not claim DESI DR2 falsifies DFM-MKC",
            "does not claim DESI DR2 supports DFM-MKC",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_desi_bao_token in required_desi_bao_tokens:
            if required_desi_bao_token not in desi_bao_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL desi dr2 bao dfm mkc test missing token: {required_desi_bao_token}")
                return 1

    dfm_map_path = ROOT / "core/dfm_mkc_formula_to_observable_map.json"
    if dfm_map_path.exists():
        dfm_map_text = dfm_map_path.read_text(encoding="utf-8")
        required_dfm_map_tokens = [
            "DFM_MKC_formula_to_observable_map",
            "conditional_interface_only",
            "DFM_MKC_FormulaSurface -> ObservablePredictionSurface",
            "DESI_DR2_BAO_DFM_MKC_Test",
            "PantheonPlus_DFM_MKC_HubbleDiagram_Test",
            "Planck_ACT_DFM_MKC_CMB_Consistency_Test",
            "DFM_MKC_FORMULA_SURFACE_FOUND_BUT_NO_ZD_CLOSURE_DERIVED",
            "does not prove unrestricted ZeroDayClosure",
            "does not validate cosmology empirically",
            "does not reject Lambda-CDM",
            "does not independently reproduce DESI DR2 likelihoods",
            "does not independently reproduce PantheonPlus likelihoods",
            "does not independently reproduce Planck or ACT likelihoods",
            "does not discharge LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_dfm_map_token in required_dfm_map_tokens:
            if required_dfm_map_token not in dfm_map_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL dfm mkc formula observable map missing token: {required_dfm_map_token}")
                return 1

    dfm_zd_interface_path = ROOT / "artifacts/tests/dfm_mkc_cosmology_zd_interface_test_2026_07_06.json"
    if dfm_zd_interface_path.exists():
        dfm_zd_interface_text = dfm_zd_interface_path.read_text(encoding="utf-8")
        required_dfm_zd_interface_tokens = [
            "DfmMkcCosmologyZeroDayInterfaceTest",
            "interface_test_only",
            "dfm-mkc-cosmology",
            "DFM_MKC_FORMULA_SURFACE_FOUND_BUT_NO_ZD_CLOSURE_DERIVED",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainCompositionGap",
            "does not prove unrestricted ZeroDayClosure",
            "does not validate cosmology empirically",
            "does not prove a DFM-MKC cosmology theorem",
            "does not discharge LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_dfm_zd_interface_token in required_dfm_zd_interface_tokens:
            if required_dfm_zd_interface_token not in dfm_zd_interface_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL dfm mkc zd interface receipt missing token: {required_dfm_zd_interface_token}")
                return 1

    composition_gap_path = ROOT / "core/lift_source_chain_composition_gap.json"
    if composition_gap_path.exists():
        composition_gap_text = composition_gap_path.read_text(encoding="utf-8")
        required_composition_gap_tokens = [
            "LiftSourceChainCompositionGap",
            "boundary_only",
            "no_composition_theorem_for_lift_source_chain",
            "RestrictedCoverageSource -> DomainErasureSource -> LiftAdmissibilitySource -> ZeroDayClosure",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainStatusReceipt",
            "does not prove unrestricted ZeroDayClosure",
            "does not compose the lift-source chain",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_composition_gap_token in required_composition_gap_tokens:
            if required_composition_gap_token not in composition_gap_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL lift source chain composition gap missing token: {required_composition_gap_token}")
                return 1

    lift_receipt_path = ROOT / "artifacts/status/lift_source_chain_status_receipt_2026_07_06.json"
    if lift_receipt_path.exists():
        lift_receipt_text = lift_receipt_path.read_text(encoding="utf-8")
        required_lift_receipt_tokens = [
            "LiftSourceChainStatusReceipt",
            "conditional_only",
            "RestrictedToUnrestrictedLiftBoundarySurface",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "ANTI_UNCONDITIONAL_RULE_OK",
            "does not prove unrestricted ZeroDayClosure",
            "does not convert conditional lift sources into an unconditional theorem",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_lift_receipt_token in required_lift_receipt_tokens:
            if required_lift_receipt_token not in lift_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL lift source chain receipt missing token: {required_lift_receipt_token}")
                return 1

    no_escape_path = ROOT / "core/no_escape_boundary.json"
    if no_escape_path.exists():
        no_escape_text = no_escape_path.read_text(encoding="utf-8")
        required_no_escape_tokens = [
            "NoEscapeBoundary",
            "no_zeroday_closure_without_lift_sources",
            "ZeroDayClosure may appear only with RestrictedCoverageSource, DomainErasureSource, and LiftAdmissibilitySource",
            "RestrictedCoverageSource",
            "coverage_source : UnrestrictedZeroDayInstance -> RestrictedClosureSurface",
            "DomainErasureSource",
            "domain_erasure_source : RestrictedClosureSurface -> ZeroDayClosure",
            "LiftAdmissibilitySource",
            "lift_admissibility_source : UnrestrictedZeroDayInstance -> RestrictedClosureSurface -> ZeroDayClosure",
            "unconditional ZeroDayClosure",
            "ZeroDayClosure without RestrictedCoverageSource",
            "ZeroDayClosure without DomainErasureSource",
            "ZeroDayClosure without LiftAdmissibilitySource",
            "does not prove unrestricted ZeroDayClosure",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_no_escape_token in required_no_escape_tokens:
            if required_no_escape_token not in no_escape_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL no escape boundary missing token: {required_no_escape_token}")
                return 1

    lift_admissibility_path = ROOT / "core/lift_admissibility_source.json"
    if lift_admissibility_path.exists():
        lift_admissibility_text = lift_admissibility_path.read_text(encoding="utf-8")
        required_lift_admissibility_tokens = [
            "LiftAdmissibilitySource",
            "lift_admissibility_source",
            "UnrestrictedZeroDayInstance -> RestrictedClosureSurface -> ZeroDayClosure",
            "RestrictedCoverageSource",
            "coverage_source : UnrestrictedZeroDayInstance -> RestrictedClosureSurface",
            "DomainErasureSource",
            "domain_erasure_source : RestrictedClosureSurface -> ZeroDayClosure",
            "assumption_surface_only",
            "does not prove unrestricted ZeroDayClosure",
            "does not supply NoEscapeBoundary",
            "does not make lift admissibility unconditional",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_lift_admissibility_token in required_lift_admissibility_tokens:
            if required_lift_admissibility_token not in lift_admissibility_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL lift admissibility missing token: {required_lift_admissibility_token}")
                return 1

    domain_erasure_path = ROOT / "core/domain_erasure_source.json"
    if domain_erasure_path.exists():
        domain_erasure_text = domain_erasure_path.read_text(encoding="utf-8")
        required_domain_erasure_tokens = [
            "DomainErasureSource",
            "domain_erasure_source",
            "RestrictedClosureSurface -> ZeroDayClosure",
            "RestrictedCoverageSource",
            "coverage_source : UnrestrictedZeroDayInstance -> RestrictedClosureSurface",
            "assumption_surface_only",
            "does not prove unrestricted ZeroDayClosure",
            "does not supply LiftAdmissibilitySource",
            "does not erase hypotheses unconditionally",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_domain_erasure_token in required_domain_erasure_tokens:
            if required_domain_erasure_token not in domain_erasure_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL domain erasure missing token: {required_domain_erasure_token}")
                return 1

    coverage_source_path = ROOT / "core/restricted_coverage_source.json"
    if coverage_source_path.exists():
        coverage_source_text = coverage_source_path.read_text(encoding="utf-8")
        required_coverage_source_tokens = [
            "RestrictedCoverageSource",
            "coverage_source",
            "UnrestrictedZeroDayInstance -> RestrictedClosureSurface",
            "does not prove unrestricted ZeroDayClosure",
            "does not supply DomainErasureSource",
            "does not supply LiftAdmissibilitySource",
            "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        ]
        for required_coverage_source_token in required_coverage_source_tokens:
            if required_coverage_source_token not in coverage_source_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL coverage source missing token: {required_coverage_source_token}")
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
