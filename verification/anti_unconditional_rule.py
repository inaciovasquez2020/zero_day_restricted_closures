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
    _guard_non_toy_structure_source_witness_target()
    _guard_variable_domain_and_guards_witness_target()
    _guard_physical_system_context_witness_target()
    _guard_f_physical_derivation_obligation_uninhabited()
    _guard_non_toy_law_dependency_contract_boundary()
    _guard_toy_four_way_no_physical_dilation()
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

    planck_act_path = ROOT / "artifacts/tests/planck_act_dfm_mkc_cmb_consistency_test_2026_07_06.json"
    if planck_act_path.exists():
        planck_act_text = planck_act_path.read_text(encoding="utf-8")
        required_planck_act_tokens = [
            "Planck_ACT_DFM_MKC_CMB_Consistency_Test",
            "falsification_surface_only",
            "DFM_MKC_formula_to_observable_map",
            "third CMB consistency falsification surface",
            "theta_star",
            "sound_horizon",
            "angular_diameter_distance_to_last_scattering",
            "linear perturbation transfer consistency",
            "C_ell summary or likelihood-compatible compressed prediction",
            "PLANCK_ACT_CMB_CONSISTENCY_TEST_DEFINED_BUT_NOT_EXECUTED",
            "DFM_MKC_FORMULA_SURFACE_FOUND_BUT_NO_ZD_CLOSURE_DERIVED",
            "does not prove unrestricted ZeroDayClosure",
            "does not validate cosmology empirically",
            "does not reject Lambda-CDM",
            "does not independently reproduce Planck likelihoods",
            "does not independently reproduce ACT likelihoods",
            "does not claim Planck falsifies DFM-MKC",
            "does not claim ACT falsifies DFM-MKC",
            "does not claim Planck supports DFM-MKC",
            "does not claim ACT supports DFM-MKC",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_planck_act_token in required_planck_act_tokens:
            if required_planck_act_token not in planck_act_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL planck act dfm mkc cmb consistency test missing token: {required_planck_act_token}")
                return 1

    pantheon_path = ROOT / "artifacts/tests/pantheonplus_dfm_mkc_hubble_diagram_test_2026_07_06.json"
    if pantheon_path.exists():
        pantheon_text = pantheon_path.read_text(encoding="utf-8")
        required_pantheon_tokens = [
            "PantheonPlus_DFM_MKC_HubbleDiagram_Test",
            "falsification_surface_only",
            "DFM_MKC_formula_to_observable_map",
            "second Hubble-diagram falsification surface",
            "D_L(z)",
            "mu(z)",
            "nuisance-calibrated residual model",
            "PANTHEONPLUS_HUBBLE_DIAGRAM_FALSIFICATION_TEST_DEFINED_BUT_NOT_EXECUTED",
            "DFM_MKC_FORMULA_SURFACE_FOUND_BUT_NO_ZD_CLOSURE_DERIVED",
            "does not prove unrestricted ZeroDayClosure",
            "does not validate cosmology empirically",
            "does not reject Lambda-CDM",
            "does not independently reproduce PantheonPlus likelihoods",
            "does not claim PantheonPlus falsifies DFM-MKC",
            "does not claim PantheonPlus supports DFM-MKC",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_pantheon_token in required_pantheon_tokens:
            if required_pantheon_token not in pantheon_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL pantheonplus dfm mkc hubble diagram test missing token: {required_pantheon_token}")
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

    composition_contract_path = ROOT / "core/restricted_lift_source_chain_composition_input_contract.json"
    if composition_contract_path.exists():
        composition_contract_text = composition_contract_path.read_text(encoding="utf-8")
        required_composition_contract_tokens = [
            "RestrictedLiftSourceChainCompositionInputContract",
            "conditional_input_contract_only",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainCompositionGap",
            "packages the existing restricted lift-source chain inputs without deriving ZeroDayClosure",
            "RestrictedCoverageSource -> DomainErasureSource -> LiftAdmissibilitySource -> NoEscapeBoundary -> ZeroDayClosure",
            "RESTRICTED_LIFT_SOURCE_CHAIN_COMPOSITION_INPUT_CONTRACT_DEFINED_BUT_NOT_DISCHARGED",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_contract_token in required_composition_contract_tokens:
            if required_composition_contract_token not in composition_contract_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL composition input contract missing token: {required_composition_contract_token}")
                return 1

    composition_receipt_path = ROOT / "artifacts/status/restricted_lift_source_chain_composition_input_contract_receipt_2026_07_06.json"
    if composition_receipt_path.exists():
        composition_receipt_text = composition_receipt_path.read_text(encoding="utf-8")
        required_composition_receipt_tokens = [
            "RestrictedLiftSourceChainCompositionInputContractReceipt",
            "guarded_conditional_input_contract_only",
            "RestrictedLiftSourceChainCompositionInputContract",
            "core/restricted_lift_source_chain_composition_input_contract.json",
            "verification/anti_unconditional_rule.py",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainCompositionGap",
            "RESTRICTED_LIFT_SOURCE_CHAIN_COMPOSITION_INPUT_CONTRACT_GUARDED_BUT_NOT_DISCHARGED",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "A conditional theorem surface from the guarded input contract to a restricted composition target is still absent",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_receipt_token in required_composition_receipt_tokens:
            if required_composition_receipt_token not in composition_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted lift composition receipt missing token: {required_composition_receipt_token}")
                return 1

    composition_target_path = ROOT / "core/restricted_lift_source_chain_composition_target_surface.json"
    if composition_target_path.exists():
        composition_target_text = composition_target_path.read_text(encoding="utf-8")
        required_composition_target_tokens = [
            "RestrictedLiftSourceChainCompositionTargetSurface",
            "conditional_theorem_target_surface_only",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainCompositionGap",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "restricted_zero_day_instance_only",
            "RESTRICTED_COMPOSITION_TARGET_SURFACE_DEFINED_BUT_NO_THEOREM_SUPPLIED",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not prove RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_target_token in required_composition_target_tokens:
            if required_composition_target_token not in composition_target_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition target surface missing token: {required_composition_target_token}")
                return 1

    composition_target_receipt_path = ROOT / "artifacts/status/restricted_lift_source_chain_composition_target_surface_receipt_2026_07_06.json"
    if composition_target_receipt_path.exists():
        composition_target_receipt_text = composition_target_receipt_path.read_text(encoding="utf-8")
        required_composition_target_receipt_tokens = [
            "RestrictedLiftSourceChainCompositionTargetSurfaceReceipt",
            "guarded_conditional_theorem_target_surface_only",
            "RestrictedLiftSourceChainCompositionTargetSurface",
            "core/restricted_lift_source_chain_composition_target_surface.json",
            "verification/anti_unconditional_rule.py",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RESTRICTED_COMPOSITION_TARGET_SURFACE_GUARDED_BUT_NO_THEOREM_SUPPLIED",
            "LiftSourceChainCompositionGap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not prove RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "A conditional theorem witness surface from the guarded input contract to RestrictedCompositionTarget is still absent",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_target_receipt_token in required_composition_target_receipt_tokens:
            if required_composition_target_receipt_token not in composition_target_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition target receipt missing token: {required_composition_target_receipt_token}")
                return 1

    composition_witness_path = ROOT / "core/restricted_lift_source_chain_composition_witness_surface.json"
    if composition_witness_path.exists():
        composition_witness_text = composition_witness_path.read_text(encoding="utf-8")
        required_composition_witness_tokens = [
            "RestrictedLiftSourceChainCompositionWitnessSurface",
            "conditional_witness_surface_only",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedLiftSourceChainCompositionTargetSurface",
            "RestrictedCompositionTarget",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "assumption_surface_required_not_constructed",
            "RESTRICTED_COMPOSITION_WITNESS_SURFACE_DEFINED_BUT_WITNESS_NOT_SUPPLIED",
            "LiftSourceChainCompositionGap",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_witness_token in required_composition_witness_tokens:
            if required_composition_witness_token not in composition_witness_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness surface missing token: {required_composition_witness_token}")
                return 1

    composition_witness_receipt_path = ROOT / "artifacts/status/restricted_lift_source_chain_composition_witness_surface_receipt_2026_07_06.json"
    if composition_witness_receipt_path.exists():
        composition_witness_receipt_text = composition_witness_receipt_path.read_text(encoding="utf-8")
        required_composition_witness_receipt_tokens = [
            "RestrictedLiftSourceChainCompositionWitnessSurfaceReceipt",
            "guarded_conditional_witness_surface_only",
            "RestrictedLiftSourceChainCompositionWitnessSurface",
            "core/restricted_lift_source_chain_composition_witness_surface.json",
            "verification/anti_unconditional_rule.py",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedLiftSourceChainCompositionTargetSurface",
            "RestrictedCompositionTarget",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RESTRICTED_COMPOSITION_WITNESS_SURFACE_GUARDED_BUT_WITNESS_NOT_SUPPLIED",
            "LiftSourceChainCompositionGap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "A positive restricted composition witness is still absent",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_witness_receipt_token in required_composition_witness_receipt_tokens:
            if required_composition_witness_receipt_token not in composition_witness_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness receipt missing token: {required_composition_witness_receipt_token}")
                return 1

    composition_assumption_path = ROOT / "core/restricted_composition_witness_assumption_surface.json"
    if composition_assumption_path.exists():
        composition_assumption_text = composition_assumption_path.read_text(encoding="utf-8")
        required_composition_assumption_tokens = [
            "RestrictedCompositionWitnessAssumptionSurface",
            "explicit_assumption_surface_only",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedLiftSourceChainCompositionTargetSurface",
            "RestrictedLiftSourceChainCompositionWitnessSurface",
            "RestrictedCompositionTarget",
            "RESTRICTED_COMPOSITION_WITNESS_ASSUMPTION_SURFACE_DEFINED_BUT_NOT_INHABITED",
            "LiftSourceChainCompositionGap",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_assumption_token in required_composition_assumption_tokens:
            if required_composition_assumption_token not in composition_assumption_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness assumption missing token: {required_composition_assumption_token}")
                return 1

    composition_witness_assumption_receipt_path = ROOT / "artifacts/status/restricted_composition_witness_assumption_surface_receipt_2026_07_06.json"
    if composition_witness_assumption_receipt_path.exists():
        composition_witness_assumption_receipt_text = composition_witness_assumption_receipt_path.read_text(encoding="utf-8")
        required_composition_witness_assumption_receipt_tokens = [
            "RestrictedCompositionWitnessAssumptionSurface",
            "guarded",
            "guarded_explicit_assumption_surface_only",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RestrictedCompositionTarget",
            "LiftSourceChainCompositionGap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_witness_assumption_receipt_token in required_composition_witness_assumption_receipt_tokens:
            if required_composition_witness_assumption_receipt_token not in composition_witness_assumption_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness assumption receipt missing token: {required_composition_witness_assumption_receipt_token}")
                return 1

    composition_witness_inhabitant_gap_receipt_path = ROOT / "artifacts/status/restricted_composition_witness_assumption_positive_inhabitant_gap_receipt_2026_07_06.json"
    if composition_witness_inhabitant_gap_receipt_path.exists():
        composition_witness_inhabitant_gap_receipt_text = composition_witness_inhabitant_gap_receipt_path.read_text(encoding="utf-8")
        required_composition_witness_inhabitant_gap_receipt_tokens = [
            "RestrictedCompositionWitnessAssumptionPositiveInhabitantGapReceipt",
            "negative_shape_receipt_only",
            "RestrictedCompositionWitnessAssumptionSurface",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RestrictedCompositionTarget",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "LiftSourceChainCompositionGap",
            "positive inhabitant of RestrictedCompositionWitnessAssumptionSurface",
            "restricted-to-unrestricted lift",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_composition_witness_inhabitant_gap_receipt_token in required_composition_witness_inhabitant_gap_receipt_tokens:
            if required_composition_witness_inhabitant_gap_receipt_token not in composition_witness_inhabitant_gap_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness inhabitant gap receipt missing token: {required_composition_witness_inhabitant_gap_receipt_token}")
                return 1

    unrestricted_zero_day_closure_blocker_receipt_path = ROOT / "artifacts/status/unrestricted_zero_day_closure_blocker_receipt_2026_07_06.json"
    if unrestricted_zero_day_closure_blocker_receipt_path.exists():
        unrestricted_zero_day_closure_blocker_receipt_text = unrestricted_zero_day_closure_blocker_receipt_path.read_text(encoding="utf-8")
        required_unrestricted_zero_day_closure_blocker_receipt_tokens = [
            "UnrestrictedZeroDayClosureBlockerReceipt",
            "negative_blocker_receipt_only",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "unrestricted ZeroDayClosure",
            "No positive inhabitant of RestrictedCompositionWitnessAssumptionSurface",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "LiftSourceChainCompositionGap remains undischarged",
            "No restricted-to-unrestricted lift is proved",
            "RestrictedCompositionTarget -> ZeroDayClosure",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
        ]
        for required_unrestricted_zero_day_closure_blocker_receipt_token in required_unrestricted_zero_day_closure_blocker_receipt_tokens:
            if required_unrestricted_zero_day_closure_blocker_receipt_token not in unrestricted_zero_day_closure_blocker_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL unrestricted zero day closure blocker receipt missing token: {required_unrestricted_zero_day_closure_blocker_receipt_token}")
                return 1

    restricted_composition_witness_construction_obligation_path = ROOT / "core/restricted_composition_witness_construction_obligation_surface.json"
    if restricted_composition_witness_construction_obligation_path.exists():
        restricted_composition_witness_construction_obligation_text = restricted_composition_witness_construction_obligation_path.read_text(encoding="utf-8")
        required_restricted_composition_witness_construction_obligation_tokens = [
            "RestrictedCompositionWitnessConstructionObligationSurface",
            "construction_obligation_surface_only",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedCompositionTarget",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "restricted_instance",
            "restricted_closure_surface",
            "LiftSourceChainCompositionGap",
            "unrestricted ZeroDayClosure",
            "positive inhabitant of RestrictedCompositionWitnessAssumptionSurface",
            "constructed RestrictedCompositionTarget -> ZeroDayClosure",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
        ]
        for required_restricted_composition_witness_construction_obligation_token in required_restricted_composition_witness_construction_obligation_tokens:
            if required_restricted_composition_witness_construction_obligation_token not in restricted_composition_witness_construction_obligation_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness construction obligation surface missing token: {required_restricted_composition_witness_construction_obligation_token}")
                return 1

    restricted_composition_witness_construction_obligation_receipt_path = ROOT / "artifacts/status/restricted_composition_witness_construction_obligation_receipt_2026_07_06.json"
    if restricted_composition_witness_construction_obligation_receipt_path.exists():
        restricted_composition_witness_construction_obligation_receipt_text = restricted_composition_witness_construction_obligation_receipt_path.read_text(encoding="utf-8")
        required_restricted_composition_witness_construction_obligation_receipt_tokens = [
            "RestrictedCompositionWitnessConstructionObligationReceipt",
            "guarded_construction_obligation_surface_only",
            "RestrictedCompositionWitnessConstructionObligationSurface",
            "core/restricted_composition_witness_construction_obligation_surface.json",
            "verification/anti_unconditional_rule.py",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "unrestricted ZeroDayClosure",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "A real construction of RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget remains absent.",
        ]
        for required_restricted_composition_witness_construction_obligation_receipt_token in required_restricted_composition_witness_construction_obligation_receipt_tokens:
            if required_restricted_composition_witness_construction_obligation_receipt_token not in restricted_composition_witness_construction_obligation_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness construction obligation receipt missing token: {required_restricted_composition_witness_construction_obligation_receipt_token}")
                return 1

    restricted_composition_witness_dependency_matrix_path = ROOT / "core/restricted_composition_witness_dependency_matrix_surface.json"
    if restricted_composition_witness_dependency_matrix_path.exists():
        restricted_composition_witness_dependency_matrix_text = restricted_composition_witness_dependency_matrix_path.read_text(encoding="utf-8")
        required_restricted_composition_witness_dependency_matrix_tokens = [
            "RestrictedCompositionWitnessDependencyMatrixSurface",
            "dependency_matrix_surface_only",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedCompositionTarget",
            "RestrictedCoverageSource",
            "DomainErasureSource",
            "LiftAdmissibilitySource",
            "NoEscapeBoundary",
            "restricted_zero_day_instance_only",
            "RestrictedClosureSurface",
            "available contract inputs -> RestrictedCompositionTarget",
            "RestrictedCompositionTarget -> ZeroDayClosure",
            "restricted-to-unrestricted lift",
            "unrestricted ZeroDayClosure",
            "LiftSourceChainCompositionGap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "The first missing edge is still a real construction from the available contract inputs to RestrictedCompositionTarget.",
        ]
        for required_restricted_composition_witness_dependency_matrix_token in required_restricted_composition_witness_dependency_matrix_tokens:
            if required_restricted_composition_witness_dependency_matrix_token not in restricted_composition_witness_dependency_matrix_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness dependency matrix surface missing token: {required_restricted_composition_witness_dependency_matrix_token}")
                return 1

    restricted_composition_witness_dependency_matrix_receipt_path = ROOT / "artifacts/status/restricted_composition_witness_dependency_matrix_receipt_2026_07_06.json"
    if restricted_composition_witness_dependency_matrix_receipt_path.exists():
        restricted_composition_witness_dependency_matrix_receipt_text = restricted_composition_witness_dependency_matrix_receipt_path.read_text(encoding="utf-8")
        required_restricted_composition_witness_dependency_matrix_receipt_tokens = [
            "RestrictedCompositionWitnessDependencyMatrixReceipt",
            "guarded_dependency_matrix_surface_only",
            "RestrictedCompositionWitnessDependencyMatrixSurface",
            "core/restricted_composition_witness_dependency_matrix_surface.json",
            "verification/anti_unconditional_rule.py",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "available contract inputs -> RestrictedCompositionTarget",
            "LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "unrestricted ZeroDayClosure",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            "The first missing edge remains a real construction from available contract inputs to RestrictedCompositionTarget.",
        ]
        for required_restricted_composition_witness_dependency_matrix_receipt_token in required_restricted_composition_witness_dependency_matrix_receipt_tokens:
            if required_restricted_composition_witness_dependency_matrix_receipt_token not in restricted_composition_witness_dependency_matrix_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition witness dependency matrix receipt missing token: {required_restricted_composition_witness_dependency_matrix_receipt_token}")
                return 1

    restricted_composition_target_constructor_input_receipt_path = ROOT / "artifacts/status/restricted_composition_target_constructor_input_receipt_2026_07_07.json"
    if restricted_composition_target_constructor_input_receipt_path.exists():
        restricted_composition_target_constructor_input_receipt_text = restricted_composition_target_constructor_input_receipt_path.read_text(encoding="utf-8")
        required_restricted_composition_target_constructor_input_receipt_tokens = [
            "RestrictedCompositionTargetConstructorInputReceipt",
            "constructor_input_receipt_only",
            "core/restricted_lift_source_chain_composition_target_surface.json",
            "RestrictedCompositionTarget",
            "restricted_zero_day_instance_only",
            "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "RESTRICTED_COMPOSITION_TARGET_SURFACE_DEFINED_BUT_NO_THEOREM_SUPPLIED",
            "restricted_composition_constructor",
            "restricted_composition_constructor : RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "available inputs are already packaged by RestrictedLiftSourceChainCompositionInputContract",
            "RestrictedCompositionTarget -> ZeroDayClosure",
            "No restricted-to-unrestricted lift is supplied by this receipt.",
            "LiftSourceChainCompositionGap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
            "does not discharge LiftSourceChainCompositionGap",
            "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget",
            "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
            "does not construct an unrestricted zero-day closure",
            "does not erase the restricted boundary",
            "does not prove the restricted-to-unrestricted lift",
            r"BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "Supply a real restricted_composition_constructor field, or keep this as an explicit assumption boundary.",
        ]
        for required_restricted_composition_target_constructor_input_receipt_token in required_restricted_composition_target_constructor_input_receipt_tokens:
            if required_restricted_composition_target_constructor_input_receipt_token not in restricted_composition_target_constructor_input_receipt_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL restricted composition target constructor input receipt missing token: {required_restricted_composition_target_constructor_input_receipt_token}")
                return 1

    family_route_path = ROOT / "artifacts/status/urf_restricted_boundary_family_route_receipt_2026_07_07.json"
    if family_route_path.exists():
        family_route_text = family_route_path.read_text(encoding="utf-8")
        required_family_route_tokens = [
            "classification",
            "same restricted-boundary family, not same theory",
            "does not prove same family implies same theory",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_family_route_token in required_family_route_tokens:
            if required_family_route_token not in family_route_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL family route receipt missing token: {required_family_route_token}")
                raise SystemExit(1)
        forbidden_family_route_tokens = [
            "same_family_implies_same_theory",
            "same family implies same theory theorem",
        ]
        for forbidden_family_route_token in forbidden_family_route_tokens:
            if forbidden_family_route_token in family_route_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL family route receipt theorem claim: {forbidden_family_route_token}")
                raise SystemExit(1)

    cross_repo_rollup_path = ROOT / "artifacts/status/urf_cross_repo_restricted_boundary_status_rollup_2026_07_07.json"
    if cross_repo_rollup_path.exists():
        cross_repo_rollup_text = cross_repo_rollup_path.read_text(encoding="utf-8")
        required_cross_repo_rollup_tokens = [
            "cross_repo_status_rollup_only",
            "zero_day, SIDFH, chronos, and urf-core are synchronized as restricted-boundary status routes only",
            "does not prove same family implies same theory",
            "does not add a constructor surface",
            "does not construct RestrictedCompositionTarget",
            "does not discharge LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_cross_repo_rollup_token in required_cross_repo_rollup_tokens:
            if required_cross_repo_rollup_token not in cross_repo_rollup_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL cross-repo rollup missing token: {required_cross_repo_rollup_token}")
                raise SystemExit(1)
        forbidden_cross_repo_rollup_tokens = [
            "same_family_implies_same_theory",
            "proves physical time dilation",
            "proves SIDFH is physically real",
            "proves unrestricted ZeroDayClosure",
        ]
        for forbidden_cross_repo_rollup_token in forbidden_cross_repo_rollup_tokens:
            if forbidden_cross_repo_rollup_token in cross_repo_rollup_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL cross-repo rollup theorem claim: {forbidden_cross_repo_rollup_token}")
                raise SystemExit(1)

    dfm_mkc_sidfh_external_evidence_pin_path = ROOT / "artifacts/status/dfm_mkc_sidfh_external_evidence_pin_receipt_2026_07_07.json"
    if dfm_mkc_sidfh_external_evidence_pin_path.exists():
        dfm_mkc_sidfh_external_evidence_pin_text = dfm_mkc_sidfh_external_evidence_pin_path.read_text(encoding="utf-8")
        required_dfm_mkc_sidfh_external_evidence_pin_tokens = [
            "external_evidence_pin_receipt_only",
            "\"head\": \"1293134\"",
            "SIDFH_REPOSITORY_ROUTE_RECEIPT_OK",
            "MotionBandShadow(V,c,v) := V < v \\u2227 v < c",
            "supports the prior cross-repo restricted-boundary status rollup as external evidence only",
            "does not prove same-family classification implies same theory",
            "does not add a constructor surface",
            "does not construct RestrictedCompositionTarget",
            "does not discharge LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
        ]
        for required_dfm_mkc_sidfh_external_evidence_pin_token in required_dfm_mkc_sidfh_external_evidence_pin_tokens:
            if required_dfm_mkc_sidfh_external_evidence_pin_token not in dfm_mkc_sidfh_external_evidence_pin_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL dfm-mkc SIDFH external evidence pin missing token: {required_dfm_mkc_sidfh_external_evidence_pin_token}")
                raise SystemExit(1)
        forbidden_dfm_mkc_sidfh_external_evidence_pin_tokens = [
            "same_family_implies_same_theory",
            "\"classification\": \"same theory\"",
            "\"status\": \"theorem\"",
            "constructs RestrictedCompositionTarget",
            "discharges LiftSourceChainCompositionGap",
        ]
        for forbidden_dfm_mkc_sidfh_external_evidence_pin_token in forbidden_dfm_mkc_sidfh_external_evidence_pin_tokens:
            if forbidden_dfm_mkc_sidfh_external_evidence_pin_token in dfm_mkc_sidfh_external_evidence_pin_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL dfm-mkc SIDFH external evidence pin theorem claim: {forbidden_dfm_mkc_sidfh_external_evidence_pin_token}")
                raise SystemExit(1)

    chronos_sidfh_tach_speed_external_evidence_pin_path = ROOT / "artifacts/status/chronos_sidfh_tach_speed_external_evidence_pin_receipt_2026_07_07.json"
    if chronos_sidfh_tach_speed_external_evidence_pin_path.exists():
        chronos_sidfh_tach_speed_external_evidence_pin_text = chronos_sidfh_tach_speed_external_evidence_pin_path.read_text(encoding="utf-8")
        required_chronos_sidfh_tach_speed_external_evidence_pin_tokens = [
            "external_evidence_pin_receipt_only",
            "\"head\": \"b2ff64b1\"",
            "SIDFH_TACH_SPEED_INPUT_SURFACE_OK",
            "SIDFH_TACH_SPEED_EXTERNAL_TIME_REFERENCE_RECEIPT_OK",
            "SIDFHTachSpeedInputSurface",
            "MotionBandShadow(V,c,v) := V < v \\u2227 v < c",
            "RelativeTimeScale(S,t) := elapsed_time(S,t) / natural_cycle_time(S)",
            "supports the prior cross-repo restricted-boundary status rollup as external evidence only",
            "does not prove physical time dilation",
            "does not prove v_min from SIDFHTachSpeedInputSurface",
            "does not prove same-family classification implies same theory",
            "does not add a constructor surface",
            "does not construct RestrictedCompositionTarget",
            "does not discharge LiftSourceChainCompositionGap",
            "BOUNDARY := \\u00ac unrestricted ZeroDayClosure",
            "BOUNDARY := \\u00ac chronos_derives_RelativeTimeScale_physical_time_dilation",
        ]
        for required_chronos_sidfh_tach_speed_external_evidence_pin_token in required_chronos_sidfh_tach_speed_external_evidence_pin_tokens:
            if required_chronos_sidfh_tach_speed_external_evidence_pin_token not in chronos_sidfh_tach_speed_external_evidence_pin_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL Chronos SIDFH tach-speed external evidence pin missing token: {required_chronos_sidfh_tach_speed_external_evidence_pin_token}")
                raise SystemExit(1)
        forbidden_chronos_sidfh_tach_speed_external_evidence_pin_tokens = [
            "same_family_implies_same_theory",
            "\"classification\": \"same theory\"",
            "\"status\": \"theorem\"",
            "constructs RestrictedCompositionTarget",
            "discharges LiftSourceChainCompositionGap",
            "\"chronos_derives_RelativeTimeScale_physical_time_dilation\": true",
        ]
        for forbidden_chronos_sidfh_tach_speed_external_evidence_pin_token in forbidden_chronos_sidfh_tach_speed_external_evidence_pin_tokens:
            if forbidden_chronos_sidfh_tach_speed_external_evidence_pin_token in chronos_sidfh_tach_speed_external_evidence_pin_text:
                print(f"ANTI_UNCONDITIONAL_RULE_FAIL Chronos SIDFH tach-speed external evidence pin theorem claim: {forbidden_chronos_sidfh_tach_speed_external_evidence_pin_token}")
                raise SystemExit(1)

    restricted_composition_constructor_allowed_paths = {
        "artifacts/status/restricted_composition_target_constructor_input_receipt_2026_07_07.json",
        "core/restricted_composition_target_constructor_schema_surface.json",
        "verification/anti_unconditional_rule.py",
    }
    restricted_composition_constructor_hits = []
    for restricted_composition_constructor_root in ("core", "artifacts", "verification"):
        for restricted_composition_constructor_path in (ROOT / restricted_composition_constructor_root).rglob("*"):
            if restricted_composition_constructor_path.is_file():
                restricted_composition_constructor_text = restricted_composition_constructor_path.read_text(encoding="utf-8", errors="ignore")
                if "restricted_composition_constructor" in restricted_composition_constructor_text:
                    restricted_composition_constructor_hits.append(str(restricted_composition_constructor_path.relative_to(ROOT)))
    restricted_composition_constructor_outside_guarded_receipt = sorted(
        set(restricted_composition_constructor_hits) - restricted_composition_constructor_allowed_paths
    )
    if restricted_composition_constructor_outside_guarded_receipt:
        print("ANTI_UNCONDITIONAL_RULE_FAIL restricted_composition_constructor outside guarded receipt:")
        for restricted_composition_constructor_unexpected_path in restricted_composition_constructor_outside_guarded_receipt:
            print(restricted_composition_constructor_unexpected_path)
        return 1

    verify_restricted_target_extraction_field_inventory_guard()
    verify_restricted_edge_terminal_composite_source_field_refinement_surface()
    verify_restricted_edge_terminal_composite_witness_shape_refinement_surface()
    verify_restricted_edge_terminal_composite_witness_candidate_input_contract_surface()
    verify_restricted_edge_terminal_composite_executable_candidate_verifier_surface()
    verify_zero_day_boundary_construction_discharge_verifier_surface()
    verify_zero_day_boundary_executable_discharge_verifier_surface()
    print("ANTI_UNCONDITIONAL_RULE_OK")
    return 0


def _guard_toy_four_way_no_physical_dilation() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    required = [
        "core/toy_four_way_bijection_closure_surface.json",
        "core/toy_four_way_bijection_strict_monotonicity_receipt_2026_07_07.json",
        "core/toy_four_way_bijection_inverse_recovery_receipt_2026_07_07.json",
        "core/non_toy_relative_time_law_target_surface.json",
    ]

    payloads = {}
    for rel in required:
        path = root / rel
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {rel}")
        payloads[rel] = json.loads(path.read_text(encoding="utf-8"))

    closure = payloads["core/toy_four_way_bijection_closure_surface.json"]
    monotone = payloads["core/toy_four_way_bijection_strict_monotonicity_receipt_2026_07_07.json"]
    inverse = payloads["core/toy_four_way_bijection_inverse_recovery_receipt_2026_07_07.json"]
    target = payloads["core/non_toy_relative_time_law_target_surface.json"]

    for rel, payload in payloads.items():
        body = json.dumps(payload, sort_keys=True)
        if "does_not_prove_physical_time_dilation" not in body and "not(physical_time_dilation)" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing no-physical-dilation guard in {rel}")

    if closure.get("missing_object") != "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: toy closure missing object changed")

    if monotone.get("status") != "receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: monotonicity receipt is not receipt-only")

    if inverse.get("status") != "receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: inverse recovery receipt is not receipt-only")

    if target.get("status") != "target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy law target status changed")

    if target.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy law target became inhabited")

    if target.get("constructor_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy law target constructor appeared")

    if target.get("theorem_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy law target theorem appeared")

    if target.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical time dilation boundary changed")


def _guard_non_toy_law_dependency_contract_boundary() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    required = [
        "core/non_toy_relative_time_law_target_surface.json",
        "core/non_toy_relative_time_law_dependency_matrix_receipt_2026_07_07.json",
        "core/non_toy_relative_time_law_constructor_input_contract_surface.json",
        "core/affine_toy_bijection_physics_boundary_receipt_2026_07_07.json",
    ]

    payloads = {}
    for rel in required:
        path = root / rel
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {rel}")
        payloads[rel] = json.loads(path.read_text(encoding="utf-8"))

    target = payloads["core/non_toy_relative_time_law_target_surface.json"]
    matrix = payloads["core/non_toy_relative_time_law_dependency_matrix_receipt_2026_07_07.json"]
    contract = payloads["core/non_toy_relative_time_law_constructor_input_contract_surface.json"]
    boundary = payloads["core/affine_toy_bijection_physics_boundary_receipt_2026_07_07.json"]

    for rel, payload in payloads.items():
        body = json.dumps(payload, sort_keys=True)
        if "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing non-toy missing object in {rel}")
        if "does_not_prove_physical_time_dilation" not in body and "not(physical_time_dilation)" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing physical-time-dilation boundary in {rel}")

    if target.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical target became inhabited")

    if target.get("constructor_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor appeared")

    if target.get("theorem_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical theorem appeared")

    if matrix.get("status") != "dependency_matrix_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy dependency matrix is not receipt-only")

    if contract.get("status") != "constructor_input_contract_surface_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor input contract is not surface-only")

    missing_inputs = [
        item.get("name")
        for item in contract.get("required_inputs", [])
        if item.get("name") != "toy_physics_boundary_proof" and item.get("available") is not True
    ]

    if contract.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor input contract became inhabited")

    if contract.get("constructor_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor input contract exposes constructor")

    if contract.get("theorem_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor input contract exposes theorem")

    if target.get("inhabited") is True and missing_inputs:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: inhabited F_physical without derivation inputs")

    if boundary.get("status") != "boundary_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: affine toy physics boundary is not receipt-only")

    boundary_body = json.dumps(boundary, sort_keys=True)
    if "empirical time dilation" not in boundary_body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: empirical boundary separation missing")

    if "relativistic time dilation" not in boundary_body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: relativistic boundary separation missing")

    if boundary.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_time_dilation boundary changed")


def _guard_f_physical_derivation_obligation_uninhabited() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    required = [
        "core/non_toy_relative_time_law_target_surface.json",
        "core/non_toy_relative_time_law_constructor_input_contract_surface.json",
        "core/f_physical_derivation_input_witness_obligation_surface.json",
        "core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json",
        "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json",
    ]

    payloads = {}
    for rel in required:
        path = root / rel
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {rel}")
        payloads[rel] = json.loads(path.read_text(encoding="utf-8"))

    target = payloads["core/non_toy_relative_time_law_target_surface.json"]
    contract = payloads["core/non_toy_relative_time_law_constructor_input_contract_surface.json"]
    obligation = payloads["core/f_physical_derivation_input_witness_obligation_surface.json"]
    ranking = payloads["core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json"]
    fixture = payloads["core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"]

    for rel, payload in payloads.items():
        body = json.dumps(payload, sort_keys=True)
        if "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing non-toy missing object in {rel}")
        if "does_not_prove_physical_time_dilation" not in body and "not(physical_time_dilation)" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing physical-time-dilation boundary in {rel}")

    for name, payload in {
        "target": target,
        "contract": contract,
        "obligation": obligation,
    }.items():
        if payload.get("inhabited") is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: {name} became inhabited")
        if payload.get("constructor_present") is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: {name} exposes constructor")
        if payload.get("theorem_present") is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: {name} exposes theorem")

    if obligation.get("status") != "witness_obligation_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical derivation obligation status changed")

    if obligation.get("witness_present") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical derivation witness appeared")

    missing_inputs = [
        item.get("name")
        for item in obligation.get("required_witness_inputs", [])
        if item.get("available") is not True
    ]

    if len(missing_inputs) != 5:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical derivation inputs unexpectedly available")

    if obligation.get("inhabited") is True and missing_inputs:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: inhabited F_physical obligation without derivation inputs")

    if ranking.get("status") != "gap_ranking_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical gap ranking is not receipt-only")

    ranks = [item.get("rank") for item in ranking.get("ranked_gaps_weakest_first", [])]
    if ranks != [1, 2, 3, 4, 5]:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical gap ranking changed")

    if fixture.get("status") != "forbidden_shortcut_regression_fixture":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy fixture status changed")

    if fixture.get("candidate_shortcut") != "F_physical := F_toy":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy fixture target changed")

    if fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy shortcut not rejected")

    fixture_body = json.dumps(fixture, sort_keys=True)
    if "does_not_identify_F_toy_with_F_physical" not in fixture_body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: fixture no-identification guard missing")

    if "toy affine bijection does not prove physical time dilation" not in fixture_body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: fixture physical boundary rejection missing")




def _guard_physical_system_context_witness_target() -> None:

    import json

    from pathlib import Path



    root = Path(__file__).resolve().parents[1]

    required = [

        "core/f_physical_derivation_input_witness_obligation_surface.json",

        "core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json",

        "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json",

        "core/physical_system_context_witness_target_surface.json",

        "core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json",

    ]



    payloads = {}

    for rel in required:

        path = root / rel

        if not path.exists():

            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {rel}")

        payloads[rel] = json.loads(path.read_text(encoding="utf-8"))



    obligation = payloads["core/f_physical_derivation_input_witness_obligation_surface.json"]

    ranking = payloads["core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json"]

    fixture = payloads["core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"]

    target = payloads["core/physical_system_context_witness_target_surface.json"]

    receipt = payloads["core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json"]



    for rel, payload in payloads.items():

        body = json.dumps(payload, sort_keys=True)

        if "physical_time_dilation" not in body:

            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing physical_time_dilation boundary in {rel}")

        if "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x" not in body:

            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing upstream non-toy law object in {rel}")



    if target.get("status") != "witness_target_surface_uninhabited":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness target status changed")



    if target.get("target") != "physical_system_context_witness":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness target name changed")



    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:

        if target.get(field) is not False:

            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness {field} became available")



    if target.get("boundary") != "not(physical_time_dilation)":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness boundary changed")



    obligation_inputs = {

        item.get("name"): item

        for item in obligation.get("required_witness_inputs", [])

    }



    if "physical_system_context_witness" not in obligation_inputs:

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: base obligation lost physical_system_context_witness")



    if obligation_inputs["physical_system_context_witness"].get("available") is True:

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness unexpectedly available in obligation")



    ranked = ranking.get("ranked_gaps_weakest_first", [])

    if not ranked or ranked[0].get("rank") != 1 or ranked[0].get("gap") != "physical_system_context_witness":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness no longer weakest ranked gap")



    if receipt.get("status") != "weakest_dependency_receipt_only":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness receipt is not receipt-only")



    if receipt.get("weakest_missing_input") != "physical_system_context_witness":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: weakest dependency receipt target changed")



    if receipt.get("rank") != 1:

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_system_context_witness rank changed")



    if receipt.get("available") is not False:

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: weakest dependency receipt made witness available")



    if fixture.get("candidate_shortcut") != "F_physical := F_toy":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture target changed")



    if fixture.get("expected_verdict") != "rejected":

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy shortcut not rejected")



    fixture_body = json.dumps(fixture, sort_keys=True)

    if "does_not_identify_F_toy_with_F_physical" not in fixture_body:

        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: no-identification guard missing from fixture")



def _guard_variable_domain_and_guards_witness_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    required = [
        "core/physical_system_context_witness_target_surface.json",
        "core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json",
        "core/f_physical_derivation_input_witness_obligation_surface.json",
        "core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json",
        "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json",
        "core/variable_domain_and_guards_witness_target_surface.json",
        "core/variable_domain_and_guards_witness_next_dependency_receipt_2026_07_07.json",
    ]

    payloads = {}
    for rel in required:
        path = root / rel
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {rel}")
        payloads[rel] = json.loads(path.read_text(encoding="utf-8"))

    physical_target = payloads["core/physical_system_context_witness_target_surface.json"]
    physical_receipt = payloads["core/physical_system_context_witness_weakest_dependency_receipt_2026_07_07.json"]
    obligation = payloads["core/f_physical_derivation_input_witness_obligation_surface.json"]
    ranking = payloads["core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json"]
    fixture = payloads["core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"]
    target = payloads["core/variable_domain_and_guards_witness_target_surface.json"]
    receipt = payloads["core/variable_domain_and_guards_witness_next_dependency_receipt_2026_07_07.json"]

    for rel, payload in payloads.items():
        body = json.dumps(payload, sort_keys=True)
        if "physical_time_dilation" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing physical_time_dilation boundary in {rel}")
        if "derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x" not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing upstream non-toy law object in {rel}")

    if physical_target.get("target") != "physical_system_context_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: prior physical_system_context_witness target changed")
    if physical_target.get("available") is not False or physical_target.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: prior physical_system_context_witness became available")
    if physical_receipt.get("weakest_missing_input") != "physical_system_context_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: prior weakest missing input changed")
    if physical_receipt.get("rank") != 1:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: prior physical_system_context_witness rank changed")

    obligation_inputs = {item.get("name"): item for item in obligation.get("required_witness_inputs", [])}
    if "variable_domain_and_guards_witness" not in obligation_inputs:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: base obligation lost variable_domain_and_guards_witness")
    if obligation_inputs["variable_domain_and_guards_witness"].get("available") is True:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness unexpectedly available")

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    if len(ranked) < 2:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: ranked gaps lost rank-2 input")
    if ranked[0].get("rank") != 1 or ranked[0].get("gap") != "physical_system_context_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-1 physical_system_context_witness changed")
    if ranked[1].get("rank") != 2 or ranked[1].get("gap") != "variable_domain_and_guards_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-2 variable_domain_and_guards_witness changed")

    if target.get("status") != "witness_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness target status changed")
    if target.get("target") != "variable_domain_and_guards_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness target name changed")
    if target.get("rank") != 2:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness rank changed")
    if target.get("depends_on_prior_missing_input") != "physical_system_context_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness prior dependency changed")
    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness {field} became available")
    if target.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness boundary changed")

    if receipt.get("status") != "next_dependency_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: variable_domain_and_guards_witness receipt is not receipt-only")
    prior = receipt.get("prior_ranked_missing_input", {})
    nxt = receipt.get("next_ranked_missing_input", {})
    if prior.get("rank") != 1 or prior.get("name") != "physical_system_context_witness" or prior.get("available") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: next-dependency receipt prior input changed")
    if nxt.get("rank") != 2 or nxt.get("name") != "variable_domain_and_guards_witness" or nxt.get("available") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: next-dependency receipt rank-2 input changed")

    if fixture.get("candidate_shortcut") != "F_physical := F_toy":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture target changed")
    if fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy shortcut not rejected")
    fixture_body = json.dumps(fixture, sort_keys=True)
    if "does_not_identify_F_toy_with_F_physical" not in fixture_body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: no-identification guard missing from fixture")

def _guard_non_toy_structure_source_witness_target() -> None:
    import json
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    tp=root/"core/non_toy_structure_source_witness_target_surface.json"; rp=root/"core/non_toy_structure_source_witness_next_dependency_receipt_2026_07_07.json"; fp=root/"core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"
    for p in [tp,rp,fp]:
        if not p.exists(): raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {p.relative_to(root)}")
    t=json.loads(tp.read_text()); r=json.loads(rp.read_text()); f=json.loads(fp.read_text())
    if t.get("status")!="witness_target_surface_uninhabited" or t.get("target")!="non_toy_structure_source_witness" or t.get("rank")!=3: raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non_toy_structure_source_witness target changed")
    for k in ["available","inhabited","witness_present","constructor_present","theorem_present"]:
        if t.get(k) is not False: raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: non_toy_structure_source_witness {k} became available")
    if t.get("boundary")!="not(physical_time_dilation)": raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_time_dilation boundary changed")
    n=r.get("next_ranked_missing_input",{})
    if r.get("status")!="next_dependency_receipt_only" or n.get("rank")!=3 or n.get("name")!="non_toy_structure_source_witness" or n.get("available") is not False: raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-3 receipt changed")
    body=json.dumps(t,sort_keys=True)+json.dumps(r,sort_keys=True)
    if "F_physical := F_toy" not in body or "does_not_identify_F_toy_with_F_physical" not in body: raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: shortcut/no-identification guard missing")
    if f.get("candidate_shortcut")!="F_physical := F_toy" or f.get("expected_verdict")!="rejected": raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")


def verify_restricted_target_extraction_field_inventory_guard():
    import json
    from pathlib import Path

    surface_path = Path("core/restricted_target_extraction_field_inventory_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_target_extraction_field_inventory_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "RestrictedTargetExtractionFieldInventorySurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "DOWNSTREAM_EDGE_FIELD_INVENTORY_ONLY",
        "target_edge": "RestrictedCompositionTarget -> ZeroDayClosure",
        "inventory_status": "FIELDS_IDENTIFIED_NOT_USED",
        "missing_object": "actual extraction witness using the listed RestrictedCompositionTarget fields",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    expected_field_statuses = {
        "TerminalComposite(C,T)": "FIELD_NEEDED_NOT_EXTRACTED",
        "RestrictedBoundaryInvariant(T)": "FIELD_NEEDED_NOT_APPLIED",
        "TargetRealizesRestrictedLiftSourceChainComposition(C,T)": "FIELD_NEEDED_NOT_APPLIED",
        "restricted_zero_day_instance_only": "FIELD_NEEDED_NOT_APPLIED",
    }

    required_fields = data.get("required_fields")
    if not isinstance(required_fields, list):
        raise SystemExit("RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := required_fields must be a list")

    seen = {}
    for row in required_fields:
        if not isinstance(row, dict):
            raise SystemExit("RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := required field row must be an object")
        field = row.get("field")
        status = row.get("status")
        if field in expected_field_statuses:
            seen[field] = status
            if status != expected_field_statuses[field]:
                raise SystemExit(
                    f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := {field} status {status!r}"
                )

    missing_fields = sorted(set(expected_field_statuses) - set(seen))
    if missing_fields:
        raise SystemExit(
            f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := missing fields {missing_fields!r}"
        )

    required_non_claims = {
        "does not extract terminal composition closure content",
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
        "does not construct an unrestricted zero-day closure",
        "does not prove the restricted-to-unrestricted lift",
        "does not add SNOLAB or external empirical evidence",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := missing non_claims {missing_non_claims!r}"
        )

    forbidden_exact_values = {
        "RestrictedCompositionTarget -> ZeroDayClosure constructed",
        "terminal composition closure content extracted",
        "restricted-to-unrestricted lift proved",
        "unrestricted closure constructed",
    }

    forbidden_promotion_substrings = {
        "unrestricted ZeroDayClosure constructed",
        "unrestricted closure constructed",
        "restricted-to-unrestricted lift proved",
        "restricted boundary erased",
        "restricted_zero_day_instance_only erased",
    }

    required_guard_fixture = "guard fixture: unrestricted ZeroDayClosure constructed"
    fixture_hits = [
        value
        for value in data.get("blocked_promotions", [])
        if isinstance(value, str) and required_guard_fixture in value
    ]
    if fixture_hits:
        raise SystemExit(
            "RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := live surface contains forbidden guard fixture"
        )

    def walk(value):
        if isinstance(value, dict):
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)
        elif isinstance(value, str):
            yield value

    for value in walk(data):
        if value in forbidden_exact_values:
            raise SystemExit(
                f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := forbidden promotion value {value!r}"
            )
        for forbidden in forbidden_promotion_substrings:
            if forbidden in value:
                raise SystemExit(
                    f"RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_FAILED := forbidden promotion substring {forbidden!r}"
                )

    print("RESTRICTED_TARGET_EXTRACTION_FIELD_INVENTORY_GUARD_OK")


def verify_restricted_edge_terminal_composite_source_field_refinement_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/restricted_edge_terminal_composite_source_field_refinement_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_edge_terminal_composite_source_field_refinement_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "RestrictedEdgeTerminalCompositeSourceFieldRefinementSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "SOURCE_FIELD_BRIDGE_ROW_REFINEMENT_ONLY",
        "parent_surface": "RestrictedEdgeSourceFieldBridgeTargetSurface",
        "target_edge": "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "missing_object": "actual witness mapping coverage_source or restricted_closure_surface to TerminalComposite(C,T)",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    refined = data.get("refined_bridge_row")
    if not isinstance(refined, dict):
        raise SystemExit("RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_FAILED := refined_bridge_row must be an object")

    required_refined_pairs = {
        "source_field": "coverage_source or restricted_closure_surface",
        "target_field": "TerminalComposite(C,T)",
        "bridge_status": "ROW_REFINED_NOT_SUPPLIED",
    }

    for key, expected in required_refined_pairs.items():
        actual = refined.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_FAILED := refined_bridge_row.{key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not discharge LiftSourceChainCompositionGap",
        "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "does not construct the restricted edge",
        "does not construct the source-field bridge",
        "does not construct RestrictedCompositionTarget",
        "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
        "does not supply TerminalComposite(C,T)",
        "does not prove field-by-field obligation discharge",
        "does not erase the restricted boundary",
        "does not prove the restricted-to-unrestricted lift",
        "does not add SNOLAB or external empirical evidence",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_FAILED := missing non_claims {missing_non_claims!r}"
        )

    forbidden_exact_values = {
        "TerminalComposite(C,T) supplied",
        "source-field bridge constructed",
        "RestrictedCompositionTarget constructed",
        "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget constructed",
        "RestrictedCompositionTarget -> ZeroDayClosure constructed",
        "unrestricted ZeroDayClosure constructed",
        "restricted-to-unrestricted lift proved",
    }

    def walk(value):
        if isinstance(value, dict):
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)
        elif isinstance(value, str):
            yield value

    for value in walk(data):
        if value in forbidden_exact_values:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_FAILED := forbidden value {value!r}"
            )

    print("RESTRICTED_EDGE_TERMINAL_COMPOSITE_SOURCE_FIELD_REFINEMENT_GUARD_OK")


def verify_restricted_edge_terminal_composite_witness_shape_refinement_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/restricted_edge_terminal_composite_witness_shape_refinement_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_edge_terminal_composite_witness_shape_refinement_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "RestrictedEdgeTerminalCompositeWitnessShapeRefinementSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_ONLY",
        "parent_surface": "RestrictedEdgeTerminalCompositeSourceFieldRefinementSurface",
        "target_edge": "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "refined_target_field": "TerminalComposite(C,T)",
        "missing_object": "actual terminal-composite witness from coverage_source or restricted_closure_surface to TerminalComposite(C,T)",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    witness_shape = data.get("witness_shape")
    if not isinstance(witness_shape, dict):
        raise SystemExit("RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_FAILED := witness_shape must be an object")

    required_shape_pairs = {
        "input_source": "coverage_source or restricted_closure_surface",
        "output_target": "TerminalComposite(C,T)",
        "required_scope": "restricted-only terminal composite content",
        "status": "WITNESS_SHAPE_REFINED_NOT_CONSTRUCTED",
    }

    for key, expected in required_shape_pairs.items():
        actual = witness_shape.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_FAILED := witness_shape.{key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not discharge LiftSourceChainCompositionGap",
        "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "does not construct the restricted edge",
        "does not construct the source-field bridge",
        "does not construct RestrictedCompositionTarget",
        "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
        "does not supply TerminalComposite(C,T)",
        "does not construct a terminal-composite witness",
        "does not prove field-by-field obligation discharge",
        "does not erase the restricted boundary",
        "does not prove the restricted-to-unrestricted lift",
        "does not add SNOLAB or external empirical evidence",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_FAILED := missing non_claims {missing_non_claims!r}"
        )

    forbidden_exact_values = {
        "TerminalComposite(C,T) supplied",
        "terminal-composite witness constructed",
        "source-field bridge constructed",
        "RestrictedCompositionTarget constructed",
        "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget constructed",
        "RestrictedCompositionTarget -> ZeroDayClosure constructed",
        "unrestricted ZeroDayClosure constructed",
        "restricted-to-unrestricted lift proved",
    }

    def walk(value):
        if isinstance(value, dict):
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)
        elif isinstance(value, str):
            yield value

    for value in walk(data):
        if value in forbidden_exact_values:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_FAILED := forbidden value {value!r}"
            )

    print("RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_SHAPE_REFINEMENT_GUARD_OK")


def verify_restricted_edge_terminal_composite_witness_candidate_input_contract_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/restricted_edge_terminal_composite_witness_candidate_input_contract_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_edge_terminal_composite_witness_candidate_input_contract_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "RestrictedEdgeTerminalCompositeWitnessCandidateInputContractSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_ONLY",
        "parent_surface": "RestrictedEdgeTerminalCompositeWitnessShapeRefinementSurface",
        "target_edge": "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "refined_target_field": "TerminalComposite(C,T)",
        "preserved_parent_status": "WITNESS_SHAPE_REFINED_NOT_CONSTRUCTED",
        "missing_object": "inhabited executable witness candidate from coverage_source or restricted_closure_surface to TerminalComposite(C,T)",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    contract = data.get("candidate_input_contract")
    if not isinstance(contract, dict):
        raise SystemExit("RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_FAILED := candidate_input_contract must be an object")

    required_contract_pairs = {
        "input_source": "coverage_source or restricted_closure_surface",
        "required_scope": "restricted-only terminal composite content",
        "candidate_output_target": "TerminalComposite(C,T)",
        "contract_status": "INPUT_CONTRACT_RECORDED_NOT_INHABITED",
    }

    for key, expected in required_contract_pairs.items():
        actual = contract.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_FAILED := candidate_input_contract.{key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not discharge LiftSourceChainCompositionGap",
        "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "does not construct the restricted edge",
        "does not construct the source-field bridge",
        "does not construct RestrictedCompositionTarget",
        "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
        "does not supply TerminalComposite(C,T)",
        "does not construct a terminal-composite witness",
        "does not inhabit a terminal-composite witness candidate",
        "does not change WITNESS_SHAPE_REFINED_NOT_CONSTRUCTED",
        "does not prove field-by-field obligation discharge",
        "does not erase the restricted boundary",
        "does not prove the restricted-to-unrestricted lift",
        "does not add SNOLAB or external empirical evidence",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_FAILED := missing non_claims {missing_non_claims!r}"
        )

    forbidden_exact_values = {
        "WITNESS_SHAPE_CONSTRUCTED",
        "INPUT_CONTRACT_INHABITED",
        "TerminalComposite(C,T) supplied",
        "terminal-composite witness constructed",
        "terminal-composite witness candidate inhabited",
        "source-field bridge constructed",
        "RestrictedCompositionTarget constructed",
        "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget constructed",
        "RestrictedCompositionTarget -> ZeroDayClosure constructed",
        "unrestricted ZeroDayClosure constructed",
        "restricted-to-unrestricted lift proved",
    }

    def walk(value):
        if isinstance(value, dict):
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)
        elif isinstance(value, str):
            yield value

    for value in walk(data):
        if value in forbidden_exact_values:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_FAILED := forbidden value {value!r}"
            )

    print("RESTRICTED_EDGE_TERMINAL_COMPOSITE_WITNESS_CANDIDATE_INPUT_CONTRACT_GUARD_OK")




def verify_zero_day_boundary_executable_discharge_verifier_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/zero_day_boundary_executable_discharge_verifier_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/zero_day_boundary_executable_discharge_verifier_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "ZeroDayBoundaryExecutableDischargeVerifierSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "EXECUTABLE_VERIFIER_SURFACE_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "verifies": "ZeroDayBoundaryConstructionDischargeInputContractSurface",
        "parent_surface": "ZeroDayBoundaryConstructionDischargeVerifierSurface",
        "status": "EXECUTABLE_VERIFIER_SPECIFIED_NOT_RUN_ON_ACCEPTED_WITNESS",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_EXECUTABLE_DISCHARGE_VERIFIER_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not construct ZeroDayBoundary",
        "does not discharge the universal property construction obligation",
        "does not provide an accepted construction witness",
        "does not prove OriginBoundary = EndBoundary",
        "does not prove unrestricted ZeroDayClosure",
        "does not prove global closure",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_EXECUTABLE_DISCHARGE_VERIFIER_GUARD_FAILED := missing non_claims "
            + ",".join(missing_non_claims)
        )

    print("ZERO_DAY_BOUNDARY_EXECUTABLE_DISCHARGE_VERIFIER_GUARD_OK")

def verify_zero_day_boundary_construction_discharge_verifier_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/zero_day_boundary_construction_discharge_verifier_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/zero_day_boundary_construction_discharge_verifier_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "ZeroDayBoundaryConstructionDischargeVerifierSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "VERIFIER_SURFACE_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "verifies_input_contract": "ZeroDayBoundaryConstructionDischargeInputContractSurface",
        "status": "VERIFIER_SURFACE_SPECIFIED_NOT_EXECUTABLE",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_CONSTRUCTION_DISCHARGE_VERIFIER_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not construct ZeroDayBoundary",
        "does not discharge the universal property construction obligation",
        "does not prove unrestricted ZeroDayClosure",
        "does not prove global closure",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_CONSTRUCTION_DISCHARGE_VERIFIER_GUARD_FAILED := missing non_claims "
            + ",".join(missing_non_claims)
        )

    print("ZERO_DAY_BOUNDARY_CONSTRUCTION_DISCHARGE_VERIFIER_GUARD_OK")

def verify_restricted_edge_terminal_composite_executable_candidate_verifier_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/restricted_edge_terminal_composite_executable_candidate_verifier_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/restricted_edge_terminal_composite_executable_candidate_verifier_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "RestrictedEdgeTerminalCompositeExecutableCandidateVerifierSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_SURFACE_ONLY",
        "parent_surface": "RestrictedEdgeTerminalCompositeWitnessCandidateInputContractSurface",
        "target_edge": "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "refined_target_field": "TerminalComposite(C,T)",
        "preserved_parent_status": "INPUT_CONTRACT_RECORDED_NOT_INHABITED",
        "missing_object": "accepted executable terminal-composite witness candidate satisfying the input contract",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    verifier = data.get("candidate_verifier")
    if not isinstance(verifier, dict):
        raise SystemExit("RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_FAILED := candidate_verifier must be an object")

    required_verifier_pairs = {
        "input_contract": "coverage_source or restricted_closure_surface -> restricted-only terminal composite content",
        "candidate_output_target": "TerminalComposite(C,T)",
        "verifier_status": "EXECUTABLE_CANDIDATE_VERIFIER_RECORDED_NOT_RUN_ON_INHABITANT",
        "accepted_candidate_status": "NO_ACCEPTED_CANDIDATE",
    }

    for key, expected in required_verifier_pairs.items():
        actual = verifier.get(key)
        if actual != expected:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_FAILED := candidate_verifier.{key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not discharge LiftSourceChainCompositionGap",
        "does not construct RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "does not construct the restricted edge",
        "does not construct the source-field bridge",
        "does not construct RestrictedCompositionTarget",
        "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
        "does not supply TerminalComposite(C,T)",
        "does not construct a terminal-composite witness",
        "does not inhabit a terminal-composite witness candidate",
        "does not accept a terminal-composite witness candidate",
        "does not change INPUT_CONTRACT_RECORDED_NOT_INHABITED",
        "does not prove field-by-field obligation discharge",
        "does not erase the restricted boundary",
        "does not prove the restricted-to-unrestricted lift",
        "does not add SNOLAB or external empirical evidence",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_FAILED := missing non_claims {missing_non_claims!r}"
        )

    forbidden_exact_values = {
        "INPUT_CONTRACT_INHABITED",
        "EXECUTABLE_CANDIDATE_VERIFIER_ACCEPTED",
        "ACCEPTED_CANDIDATE",
        "TerminalComposite(C,T) supplied",
        "terminal-composite witness constructed",
        "terminal-composite witness candidate inhabited",
        "terminal-composite witness candidate accepted",
        "source-field bridge constructed",
        "RestrictedCompositionTarget constructed",
        "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget constructed",
        "RestrictedCompositionTarget -> ZeroDayClosure constructed",
        "unrestricted ZeroDayClosure constructed",
        "restricted-to-unrestricted lift proved",
    }

    def walk(value):
        if isinstance(value, dict):
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)
        elif isinstance(value, str):
            yield value

    for value in walk(data):
        if value in forbidden_exact_values:
            raise SystemExit(
                f"RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_FAILED := forbidden value {value!r}"
            )

    print("RESTRICTED_EDGE_TERMINAL_COMPOSITE_EXECUTABLE_CANDIDATE_VERIFIER_GUARD_OK")

if __name__ == "__main__":
    sys.exit(main())

# URF_CORE_SHADOW_TIME_EXTERNAL_EVIDENCE_PIN_RECEIPT_2026_07_07_GUARD
def _verify_urf_core_shadow_time_external_evidence_pin_receipt_2026_07_07():
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    receipt = root / "artifacts/status/urf_core_shadow_time_external_evidence_pin_receipt_2026_07_07.json"

    if not receipt.exists():
        raise SystemExit(f"MISSING_OBJECT := {receipt.relative_to(root)}")

    raw = receipt.read_text(encoding="utf-8")
    data = json.loads(raw)
    joined = raw + "\n" + json.dumps(data, ensure_ascii=False, sort_keys=True)

    required_tokens = [
        "URF_CORE_SHADOW_TIME_EXTERNAL_EVIDENCE_PIN_RECEIPT_2026_07_07",
        "external_evidence_pin_receipt_only",
        '"head": "2021284c"',
        "SHADOW_OF_INFINITY_MOTION_RELATIVE_TIME_BOUNDARY_OK",
        "tools/verify_shadow_of_infinity_motion_relative_time_boundary.py",
        "MotionBandShadow(V,c,v) := V < v ∧ v < c",
        "RelativeTimeScale(S,t) := elapsed_time(S,t) / natural_cycle_time(S)",
        "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "BOUNDARY := ¬ universal_physical_minimum_nonzero_speed_proved",
        "BOUNDARY := ¬ RelativeTimeScale_proves_physical_time_dilation",
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not prove physical time dilation",
        "does not prove a universal physical minimum nonzero speed",
        "does not prove same-family classification implies same theory",
        "does not add a constructor surface",
        "does not construct RestrictedCompositionTarget",
        "does not discharge LiftSourceChainCompositionGap",
    ]

    for token in required_tokens:
        if token not in joined:
            raise SystemExit(f"MISSING_OBJECT := token {token!r}")

    forbidden_tokens = [
        '"status": "theorem"',
        '"classification": "same theory"',
        "same_family_implies_same_theory := true",
        "physical_time_dilation := true",
        "universal_physical_minimum_nonzero_speed_proved := true",
        "unrestricted_ZeroDayClosure := true",
        "constructs RestrictedCompositionTarget",
        "discharges LiftSourceChainCompositionGap",
        "RestrictedCompositionTargetIntro",
        "restricted-to-unrestricted lift proved",
    ]

    for token in forbidden_tokens:
        if token in joined:
            raise SystemExit(f"BOUNDARY := forbidden promotion present: {token}")


_verify_urf_core_shadow_time_external_evidence_pin_receipt_2026_07_07()

# RESTRICTED_COMPOSITION_TARGET_DEFINITION_SURFACE_GUARD
def _verify_restricted_composition_target_definition_surface():
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface = root / "core/restricted_composition_target_definition_surface.json"

    if not surface.exists():
        raise SystemExit(f"MISSING_OBJECT := {surface.relative_to(root)}")

    raw = surface.read_text(encoding="utf-8")
    data = json.loads(raw)
    joined = raw + "\n" + json.dumps(data, ensure_ascii=False, sort_keys=True)

    required_tokens = [
        "RestrictedCompositionTargetDefinitionSurface",
        "definition_surface_only",
        "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "RestrictedCompositionTarget",
        "restricted_zero_day_instance_only",
        '"not_unrestricted": true',
        "RestrictedLiftSourceChainCompositionInputContract",
        "TerminalComposite(C,T)",
        "RestrictedBoundaryInvariant(T)",
        "TargetRealizesRestrictedLiftSourceChainComposition(C,T)",
        "restricted_scope_guard",
        "not_supplied",
        "not_inhabited",
        "does not prove ZeroDayClosure",
        "does not prove unrestricted ZeroDayClosure",
        "does not discharge LiftSourceChainCompositionGap",
        "does not inhabit the restricted target",
        "does not supply a theorem rule from input contract to restricted target",
        "does not supply a theorem rule from restricted target to ZeroDayClosure",
        "does not erase the restricted boundary",
        "does not prove the restricted-to-unrestricted lift",
    ]

    for token in required_tokens:
        if token not in joined:
            raise SystemExit(f"MISSING_OBJECT := token {token!r}")

    forbidden_tokens = [
        '"status": "theorem"',
        '"rule_status": "supplied"',
        '"target_status": "inhabited"',
        "RestrictedCompositionTargetIntro",
        "RestrictedTargetBridge",
        "RestrictedLiftSourceChainCompositionInputContract -> RestrictedCompositionTarget",
        "RestrictedCompositionTarget -> ZeroDayClosure",
        "restricted-to-unrestricted lift proved",
        "unrestricted ZeroDayClosure proved",
        "same_family_implies_same_theory := true",
        "physical_time_dilation := true",
        "universal physical minimum nonzero speed theorem",
    ]

    for token in forbidden_tokens:
        if token in joined:
            raise SystemExit(f"BOUNDARY := forbidden promotion present: {token}")


_verify_restricted_composition_target_definition_surface()


def _guard_derivation_evidence_for_f_physical_witness_target() -> None:
    import json
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    paths=[root/"core/derivation_evidence_for_F_physical_witness_target_surface.json",root/"core/derivation_evidence_for_F_physical_witness_next_dependency_receipt_2026_07_07.json",root/"core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json",root/"core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"]
    for path in paths:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")
    t=json.loads(paths[0].read_text(encoding="utf-8")); r=json.loads(paths[1].read_text(encoding="utf-8")); g=json.loads(paths[2].read_text(encoding="utf-8")); f=json.loads(paths[3].read_text(encoding="utf-8"))
    ranked=g.get("ranked_gaps_weakest_first",[])
    if len(ranked)<4 or ranked[3].get("rank")!=4 or ranked[3].get("gap")!="derivation_evidence_for_F_physical_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-4 derivation evidence gap changed")
    if t.get("status")!="witness_target_surface_uninhabited" or t.get("target")!="derivation_evidence_for_F_physical_witness" or t.get("rank")!=4:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-4 target changed")
    for field in ["available","inhabited","witness_present","constructor_present","theorem_present"]:
        if t.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: rank-4 {field} became available")
    nxt=r.get("next_ranked_missing_input",{})
    if r.get("status")!="next_dependency_receipt_only" or nxt.get("rank")!=4 or nxt.get("name")!="derivation_evidence_for_F_physical_witness" or nxt.get("available") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-4 receipt changed")
    body=json.dumps(t,sort_keys=True)+json.dumps(r,sort_keys=True)
    if "F_physical := F_toy" not in body or "does_not_identify_F_toy_with_F_physical" not in body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-4 shortcut/no-identification guard missing")
    if f.get("candidate_shortcut")!="F_physical := F_toy" or f.get("expected_verdict")!="rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")
_guard_derivation_evidence_for_f_physical_witness_target()


def _guard_relative_time_scale_bridge_proof_witness_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/relative_time_scale_bridge_proof_witness_target_surface.json"
    receipt_path = root / "core/relative_time_scale_bridge_proof_witness_next_dependency_receipt_2026_07_07.json"
    ranking_path = root / "core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json"
    fixture_path = root / "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"

    for path in [target_path, receipt_path, ranking_path, fixture_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    receipt = json.loads(receipt_path.read_text(encoding="utf-8"))
    ranking = json.loads(ranking_path.read_text(encoding="utf-8"))
    fixture = json.loads(fixture_path.read_text(encoding="utf-8"))

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    if len(ranked) < 5 or ranked[4].get("rank") != 5 or ranked[4].get("gap") != "relative_time_scale_bridge_proof_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 relative_time_scale_bridge_proof_witness changed")

    if target.get("status") != "witness_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 witness target status changed")
    if target.get("target") != "relative_time_scale_bridge_proof_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 witness target name changed")
    if target.get("rank") != 5:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 witness rank changed")
    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 witness {field} became available")
    if target.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_time_dilation boundary changed")

    nxt = receipt.get("next_ranked_missing_input", {})
    if receipt.get("status") != "next_dependency_receipt_only" or nxt.get("rank") != 5 or nxt.get("name") != "relative_time_scale_bridge_proof_witness" or nxt.get("available") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: rank-5 receipt changed")

    body = json.dumps(target, sort_keys=True) + json.dumps(receipt, sort_keys=True)
    if "RelativeTimeScale_x_equals_F_physical_bridge" not in body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: relative time bridge block missing")
    if "F_physical := F_toy" not in body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical := F_toy rejection missing")
    if "does_not_identify_F_toy_with_F_physical" not in body:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_toy/F_physical no-identification missing")
    if fixture.get("candidate_shortcut") != "F_physical := F_toy" or fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")
_guard_relative_time_scale_bridge_proof_witness_target()


def _guard_f_physical_ranked_missing_input_targets_exhaustion() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    receipt_path = root / "core/f_physical_ranked_missing_input_targets_exhaustion_receipt_2026_07_07.json"
    ranking_path = root / "core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json"
    fixture_path = root / "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"

    for path in [receipt_path, ranking_path, fixture_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    receipt = json.loads(receipt_path.read_text(encoding="utf-8"))
    ranking = json.loads(ranking_path.read_text(encoding="utf-8"))
    fixture = json.loads(fixture_path.read_text(encoding="utf-8"))

    ranked = ranking.get("ranked_gaps_weakest_first", [])
    if len(ranked) != 5:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: ranked gap count changed")
    if receipt.get("status") != "ranked_target_chain_exhaustion_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: exhaustion receipt status changed")
    if receipt.get("ranked_gap_count") != 5:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: exhaustion receipt gap count changed")
    if receipt.get("remaining_missing_object") != "F_physical_derivation_input_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: remaining derivation witness changed")
    if receipt.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_time_dilation boundary changed")

    body = json.dumps(receipt, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: exhaustion receipt missing {token}")

    if fixture.get("candidate_shortcut") != "F_physical := F_toy" or fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")
_guard_f_physical_ranked_missing_input_targets_exhaustion()


def _guard_f_physical_derivation_input_witness_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_derivation_input_witness_target_surface.json"
    exhaustion_path = root / "core/f_physical_ranked_missing_input_targets_exhaustion_receipt_2026_07_07.json"
    fixture_path = root / "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"

    for path in [target_path, exhaustion_path, fixture_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    exhaustion = json.loads(exhaustion_path.read_text(encoding="utf-8"))
    fixture = json.loads(fixture_path.read_text(encoding="utf-8"))

    if target.get("status") != "witness_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F physical witness target status changed")
    if target.get("target") != "F_physical_derivation_input_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F physical witness target name changed")
    for field in ["available", "inhabited", "witness_present", "constructor_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: F physical witness {field} became available")
    if target.get("boundary") != "not(physical_time_dilation)":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: physical_time_dilation boundary changed")
    if exhaustion.get("remaining_missing_object") != "F_physical_derivation_input_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: exhaustion remaining object changed")

    body = json.dumps(target, sort_keys=True) + json.dumps(exhaustion, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {token}")

    if fixture.get("candidate_shortcut") != "F_physical := F_toy" or fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")
_guard_f_physical_derivation_input_witness_target()


def _guard_f_physical_constructor_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_constructor_target_surface.json"
    witness_path = root / "core/f_physical_derivation_input_witness_target_surface.json"
    fixture_path = root / "core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"

    for path in [target_path, witness_path, fixture_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    witness = json.loads(witness_path.read_text(encoding="utf-8"))
    fixture = json.loads(fixture_path.read_text(encoding="utf-8"))

    if target.get("status") != "constructor_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor target status changed")
    if target.get("target") != "F_physical_constructor":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor target name changed")
    if target.get("constructs") != "F_physical":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor target construct changed")
    for field in ["available", "inhabited", "constructor_present", "value_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor {field} became available")
    if witness.get("available") is not False or witness.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical derivation witness became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor target missing {token}")

    if fixture.get("candidate_shortcut") != "F_physical := F_toy" or fixture.get("expected_verdict") != "rejected":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: forbidden shortcut fixture changed")
_guard_f_physical_constructor_target()


def _guard_f_physical_derivation_input_witness_constructor_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_derivation_input_witness_constructor_target_surface.json"
    witness_path = root / "core/f_physical_derivation_input_witness_target_surface.json"
    constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, witness_path, constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    witness = json.loads(witness_path.read_text(encoding="utf-8"))
    constructor = json.loads(constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "constructor_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor target status changed")
    if target.get("target") != "F_physical_derivation_input_witness_constructor":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor target name changed")
    if target.get("constructs") != "F_physical_derivation_input_witness":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor construct changed")

    for field in ["available", "inhabited", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor {field} became available")

    if witness.get("available") is not False or witness.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness became available")
    if constructor.get("available") is not False or constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor missing {token}")
_guard_f_physical_derivation_input_witness_constructor_target()


def _guard_f_physical_derivation_input_witness_constructor_contract() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    contract_path = root / "core/f_physical_derivation_input_witness_constructor_input_contract_surface.json"
    constructor_path = root / "core/f_physical_derivation_input_witness_constructor_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [contract_path, constructor_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    constructor = json.loads(constructor_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if contract.get("status") != "input_contract_surface_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: constructor contract status changed")
    if contract.get("target_constructor") != "F_physical_derivation_input_witness_constructor":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: constructor contract target changed")
    for field in ["available", "inhabited", "constructor_present", "witness_present", "theorem_present"]:
        if contract.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: constructor contract {field} became available")
    if constructor.get("available") is not False or constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation witness constructor became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(contract, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness_constructor",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: constructor contract missing {token}")
_guard_f_physical_derivation_input_witness_constructor_contract()


def _guard_f_physical_derivation_input_witness_constructor_contract_realization_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_target_surface.json"
    contract_path = root / "core/f_physical_derivation_input_witness_constructor_input_contract_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, contract_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "realization_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: contract realization target status changed")
    if target.get("would_realize") != "F_physical_derivation_input_witness_constructor_input_contract":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: contract realization target changed")

    for field in ["available", "inhabited", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: contract realization {field} became available")

    if contract.get("available") is not False or contract.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: constructor input contract became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_realize_F_physical_derivation_input_witness_constructor_input_contract",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: contract realization missing {token}")
_guard_f_physical_derivation_input_witness_constructor_contract_realization_target()


def _guard_f_physical_derivation_input_witness_constructor_contract_realization_source_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    realization_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, realization_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    realization = json.loads(realization_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "source_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source target status changed")
    if target.get("would_supply") != "F_physical_derivation_input_witness_constructor_contract_realization":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source would-supply changed")
    for field in ["available", "inhabited", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: realization source {field} became available")
    if realization.get("available") is not False or realization.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: contract realization became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: realization source missing {token}")
_guard_f_physical_derivation_input_witness_constructor_contract_realization_source_target()


def _guard_non_toy_source_law_evidence_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/non_toy_source_law_evidence_target_surface.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "evidence_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy source evidence target status changed")
    if target.get("target") != "non_toy_source_law_evidence":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy source evidence target name changed")

    for field in ["available", "inhabited", "evidence_present", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: non-toy source evidence {field} became available")

    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: non-toy source evidence missing {token}")
_guard_non_toy_source_law_evidence_target()


def _guard_f_physical_not_equal_f_toy_guard_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_not_equal_f_toy_guard_target_surface.json"
    evidence_path = root / "core/non_toy_source_law_evidence_target_surface.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, evidence_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    evidence = json.loads(evidence_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "guard_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical != F_toy guard target status changed")
    if target.get("target") != "F_physical_not_equal_F_toy_guard":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical != F_toy guard target name changed")

    for field in ["available", "inhabited", "guard_present", "evidence_present", "source_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: F_physical != F_toy guard {field} became available")

    if evidence.get("available") is not False or evidence.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: non-toy evidence became available")
    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_not_equal_F_toy_guard",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_F_physical_not_equal_F_toy",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: guard target missing {token}")
_guard_f_physical_not_equal_f_toy_guard_target()


def _guard_f_physical_realization_source_input_targets_exhaustion() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    receipt_path = root / "core/f_physical_realization_source_input_targets_exhaustion_receipt_2026_07_07.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [receipt_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    receipt = json.loads(receipt_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if receipt.get("status") != "source_input_target_exhaustion_receipt_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input exhaustion receipt status changed")
    if receipt.get("source_input_target_count") != 4:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input target count changed")
    if receipt.get("source_input_targets_exhausted") is not True:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input targets exhaustion flag changed")
    if receipt.get("remaining_missing_object") != "F_physical_derivation_input_witness_constructor_contract_realization_source":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input exhaustion remaining object changed")

    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(receipt, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_F_physical_not_equal_F_toy_guard",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source input exhaustion missing {token}")
_guard_f_physical_realization_source_input_targets_exhaustion()


def _guard_f_physical_realization_source_input_contract() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    contract_path = root / "core/f_physical_realization_source_input_contract_surface.json"
    exhaustion_path = root / "core/f_physical_realization_source_input_targets_exhaustion_receipt_2026_07_07.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [contract_path, exhaustion_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    exhaustion = json.loads(exhaustion_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if contract.get("status") != "input_contract_surface_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract status changed")
    if contract.get("target_source") != "F_physical_derivation_input_witness_constructor_contract_realization_source":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract target changed")
    if contract.get("would_supply") != "F_physical_derivation_input_witness_constructor_contract_realization_source":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract would-supply changed")
    for field in ["available", "inhabited", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if contract.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source input contract {field} became available")

    if exhaustion.get("source_input_targets_exhausted") is not True:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input exhaustion flag changed")
    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(contract, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_non_toy_source_law_evidence",
        "does_not_supply_F_physical_not_equal_F_toy_guard",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source input contract missing {token}")
_guard_f_physical_realization_source_input_contract()


def _guard_f_physical_realization_source_input_contract_realization_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_realization_source_input_contract_realization_target_surface.json"
    contract_path = root / "core/f_physical_realization_source_input_contract_surface.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, contract_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "realization_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract realization status changed")
    if target.get("would_realize") != "F_physical_realization_source_input_contract":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract realization target changed")
    if target.get("would_supply") != "F_physical_derivation_input_witness_constructor_contract_realization_source":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract realization would-supply changed")

    for field in ["available", "inhabited", "realization_present", "source_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source input contract realization {field} became available")

    if contract.get("available") is not False or contract.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source input contract became available")
    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_realize_F_physical_realization_source_input_contract",
        "does_not_supply_F_physical_derivation_input_witness_constructor_contract_realization_source",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source input contract realization missing {token}")
_guard_f_physical_realization_source_input_contract_realization_target()


def _guard_f_physical_realization_source_input_contract_realization_source_target() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    target_path = root / "core/f_physical_realization_source_input_contract_realization_source_target_surface.json"
    realization_path = root / "core/f_physical_realization_source_input_contract_realization_target_surface.json"
    source_path = root / "core/f_physical_derivation_input_witness_constructor_contract_realization_source_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [target_path, realization_path, source_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    target = json.loads(target_path.read_text(encoding="utf-8"))
    realization = json.loads(realization_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if target.get("status") != "source_target_surface_uninhabited":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source target status changed")
    if target.get("would_supply") != "F_physical_realization_source_input_contract_realization":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source would-supply changed")

    for field in ["available", "inhabited", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if target.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source {field} became available")

    if realization.get("available") is not False or realization.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization became available")
    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: derivation realization source became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(target, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_realization_source_input_contract_realization_source",
        "does_not_realize_F_physical_realization_source_input_contract",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source missing {token}")
_guard_f_physical_realization_source_input_contract_realization_source_target()


def _guard_f_physical_realization_source_input_contract_realization_source_input_contract() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    contract_path = root / "core/f_physical_realization_source_input_contract_realization_source_input_contract_surface.json"
    source_path = root / "core/f_physical_realization_source_input_contract_realization_source_target_surface.json"
    realization_path = root / "core/f_physical_realization_source_input_contract_realization_target_surface.json"
    f_constructor_path = root / "core/f_physical_constructor_target_surface.json"

    for path in [contract_path, source_path, realization_path, f_constructor_path]:
        if not path.exists():
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: missing {path.relative_to(root)}")

    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    source = json.loads(source_path.read_text(encoding="utf-8"))
    realization = json.loads(realization_path.read_text(encoding="utf-8"))
    f_constructor = json.loads(f_constructor_path.read_text(encoding="utf-8"))

    if contract.get("status") != "input_contract_surface_only":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source contract status changed")
    if contract.get("would_supply") != "F_physical_realization_source_input_contract_realization_source":
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source contract would-supply changed")

    for field in ["available", "inhabited", "source_present", "realization_present", "constructor_present", "witness_present", "theorem_present"]:
        if contract.get(field) is not False:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source contract {field} became available")

    if source.get("available") is not False or source.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source became available")
    if realization.get("available") is not False or realization.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization became available")
    if f_constructor.get("available") is not False or f_constructor.get("inhabited") is not False:
        raise SystemExit("ANTI_UNCONDITIONAL_RULE_FAIL: F_physical constructor became available")

    body = json.dumps(contract, sort_keys=True)
    for token in [
        "F_physical := F_toy",
        "does_not_supply_F_physical_realization_source_input_contract_realization_source",
        "does_not_supply_F_physical",
        "does_not_construct_F_physical",
        "does_not_identify_F_toy_with_F_physical",
        "does_not_prove_physical_time_dilation",
    ]:
        if token not in body:
            raise SystemExit(f"ANTI_UNCONDITIONAL_RULE_FAIL: source-input realization source contract missing {token}")
_guard_f_physical_realization_source_input_contract_realization_source_input_contract()
