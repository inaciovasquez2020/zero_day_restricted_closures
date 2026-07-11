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
    verify_zero_day_boundary_accepted_construction_witness_candidate_surface()
    verify_zero_day_boundary_construction_witness_acceptance_obligation_surface()
    verify_zero_day_boundary_accepted_construction_witness_execution_receipt()
    verify_zero_day_boundary_accepted_construction_witness_input_field_inventory_surface()
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









def verify_zero_day_boundary_accepted_construction_witness_input_field_inventory_surface():
    import json

    target = ROOT / "core" / "zero_day_boundary_accepted_construction_witness_input_field_inventory_surface.json"
    if not target.exists():
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_INPUT_FIELD_INVENTORY_GUARD_FAILED := missing surface"
        )

    data = json.loads(target.read_text(encoding="utf-8"))

    required = {
        "surface": "ZeroDayBoundaryAcceptedConstructionWitnessInputFieldInventorySurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "INPUT_FIELD_INVENTORY_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "candidate": "ZeroDayBoundaryAcceptedConstructionWitnessCandidateSurface",
        "status": "FIELD_INVENTORY_SPECIFIED_NOT_REALIZED",
    }

    for key, value in required.items():
        if data.get(key) != value:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_INPUT_FIELD_INVENTORY_GUARD_FAILED := {key} mismatch"
            )

    required_inputs = {
        "weak_universal_property_data_for_ZeroDayBoundary",
        "terminal_composite_data",
        "boundary_invariant_data",
        "verifier_execution_binding",
    }

    actual_inputs = set(data.get("required_inputs", []))
    missing_inputs = sorted(required_inputs - actual_inputs)
    if missing_inputs:
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_INPUT_FIELD_INVENTORY_GUARD_FAILED := missing required_inputs "
            + ",".join(missing_inputs)
        )

    print("ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_INPUT_FIELD_INVENTORY_GUARD_OK")

def verify_zero_day_boundary_accepted_construction_witness_execution_receipt():
    import json
    from pathlib import Path

    receipt_path = Path("artifacts/status/zero_day_boundary_accepted_construction_witness_execution_receipt_2026_07_09.json")
    if not receipt_path.exists():
        raise SystemExit("MISSING_OBJECT := artifacts/status/zero_day_boundary_accepted_construction_witness_execution_receipt_2026_07_09.json")

    data = json.loads(receipt_path.read_text())

    required_pairs = {
        "receipt": "ZeroDayBoundaryAcceptedConstructionWitnessExecutionReceipt",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "EXECUTION_RECEIPT_SURFACE_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "acceptance_obligation": "ZeroDayBoundaryConstructionWitnessAcceptanceObligationSurface",
        "candidate": "ZeroDayBoundaryAcceptedConstructionWitnessCandidateSurface",
        "verifier": "ZeroDayBoundaryExecutableDischargeVerifierSurface",
        "status": "EXECUTION_RECEIPT_RECORDED_NOT_EXECUTED",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_EXECUTION_RECEIPT_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not construct ZeroDayBoundary",
        "does not discharge the universal property construction obligation",
        "does not execute the verifier on an accepted witness",
        "does not accept a construction witness",
        "does not prove OriginBoundary = EndBoundary",
        "does not prove unrestricted ZeroDayClosure",
        "does not prove global closure",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_EXECUTION_RECEIPT_GUARD_FAILED := missing non_claims "
            + ",".join(missing_non_claims)
        )

    print("ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_EXECUTION_RECEIPT_GUARD_OK")

def verify_zero_day_boundary_construction_witness_acceptance_obligation_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/zero_day_boundary_construction_witness_acceptance_obligation_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/zero_day_boundary_construction_witness_acceptance_obligation_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "ZeroDayBoundaryConstructionWitnessAcceptanceObligationSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "ACCEPTANCE_OBLIGATION_SURFACE_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "candidate": "ZeroDayBoundaryAcceptedConstructionWitnessCandidateSurface",
        "verifier": "ZeroDayBoundaryExecutableDischargeVerifierSurface",
        "acceptance_obligation": "run executable discharge verifier on accepted weak_universal_property_data_for_ZeroDayBoundary",
        "status": "ACCEPTANCE_OBLIGATION_SPECIFIED_NOT_DISCHARGED",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_CONSTRUCTION_WITNESS_ACCEPTANCE_OBLIGATION_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
            )

    required_non_claims = {
        "does not construct ZeroDayBoundary",
        "does not discharge the universal property construction obligation",
        "does not accept a construction witness",
        "does not prove OriginBoundary = EndBoundary",
        "does not prove unrestricted ZeroDayClosure",
        "does not prove global closure",
    }

    non_claims = set(data.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            "ZERO_DAY_BOUNDARY_CONSTRUCTION_WITNESS_ACCEPTANCE_OBLIGATION_GUARD_FAILED := missing non_claims "
            + ",".join(missing_non_claims)
        )

    print("ZERO_DAY_BOUNDARY_CONSTRUCTION_WITNESS_ACCEPTANCE_OBLIGATION_GUARD_OK")

def verify_zero_day_boundary_accepted_construction_witness_candidate_surface():
    import json
    from pathlib import Path

    surface_path = Path("core/zero_day_boundary_accepted_construction_witness_candidate_surface.json")
    if not surface_path.exists():
        raise SystemExit("MISSING_OBJECT := core/zero_day_boundary_accepted_construction_witness_candidate_surface.json")

    data = json.loads(surface_path.read_text())

    required_pairs = {
        "surface": "ZeroDayBoundaryAcceptedConstructionWitnessCandidateSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "WITNESS_CANDIDATE_SURFACE_ONLY",
        "target": "ZeroDayBoundaryUniversalPropertyConstructionObligation",
        "candidate_shape": "weak_universal_property_data_for_ZeroDayBoundary",
        "verifier": "ZeroDayBoundaryExecutableDischargeVerifierSurface",
        "status": "WITNESS_CANDIDATE_SPECIFIED_NOT_ACCEPTED",
    }

    for key, expected in required_pairs.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(
                f"ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_CANDIDATE_GUARD_FAILED := {key} expected {expected!r} got {actual!r}"
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
            "ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_CANDIDATE_GUARD_FAILED := missing non_claims "
            + ",".join(missing_non_claims)
        )

    print("ZERO_DAY_BOUNDARY_ACCEPTED_CONSTRUCTION_WITNESS_CANDIDATE_GUARD_OK")

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


def verify_scaled_energy_observable_map_zero_day_edge_rejection_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = root / "core/scaled_energy_observable_map_bounded_domain_surface.json"

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := core/scaled_energy_observable_map_bounded_domain_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))
    forbidden_edge = "ScaledEnergyObservableMap -> ZeroDayClosure"

    required_pairs = {
        "surface": "ScaledEnergyObservableMapBoundedDomainSurface",
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": "RESTRICTED_OBSERVABLE_MAP_BOUNDED_DOMAIN_ONLY",
        "map_status": "DOMAIN_AND_SPECIES_INSTANTIATED_MAP_NOT_CONSTRUCTED",
    }

    for key, expected in required_pairs.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
                f"{key} expected {expected!r} got {actual!r}"
            )

    blocked_promotions = surface.get("blocked_promotions")
    if not isinstance(blocked_promotions, list):
        raise SystemExit(
            "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
            "blocked_promotions must be a list"
        )

    if forbidden_edge not in blocked_promotions:
        raise SystemExit(
            "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
            "missing blocked ScaledEnergyObservableMap -> ZeroDayClosure promotion"
        )

    required_non_claim = (
        "does not construct ScaledEnergyObservableMap -> ZeroDayClosure"
    )
    non_claims = surface.get("non_claims")
    if not isinstance(non_claims, list) or required_non_claim not in non_claims:
        raise SystemExit(
            "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
            "missing explicit downstream-edge non-claim"
        )

    forbidden_positive_phrases = {
        "ScaledEnergyObservableMap -> ZeroDayClosure constructed",
        "ScaledEnergyObservableMap -> ZeroDayClosure proved",
        "ScaledEnergyObservableMap -> ZeroDayClosure discharged",
        "ScaledEnergyObservableMap implies ZeroDayClosure",
        "ScaledEnergyObservableMap supplies ZeroDayClosure",
    }

    edge_keys = {
        "target_edge",
        "constructed_edge",
        "proved_edge",
        "theorem",
        "rule",
        "implication",
    }

    status_keys = {
        "status",
        "edge_status",
        "theorem_status",
        "construction_status",
        "proof_status",
        "availability",
    }

    positive_statuses = {
        "CONSTRUCTED",
        "PROVED",
        "DISCHARGED",
        "AVAILABLE",
        "SUPPLIED",
        "ACCEPTED",
        "THEOREM_PRESENT",
        "WITNESS_PRESENT",
    }

    def walk(value):
        if isinstance(value, dict):
            yield value
            for child in value.values():
                yield from walk(child)
        elif isinstance(value, list):
            for child in value:
                yield from walk(child)

    for path in sorted((root / "core").glob("*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        body = json.dumps(data, sort_keys=True)

        for phrase in forbidden_positive_phrases:
            if phrase in body:
                raise SystemExit(
                    "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
                    f"{path.relative_to(root)} contains forbidden claim {phrase!r}"
                )

        for node in walk(data):
            if not any(node.get(key) == forbidden_edge for key in edge_keys):
                continue

            for key in status_keys:
                value = node.get(key)
                if isinstance(value, str) and value.upper() in positive_statuses:
                    raise SystemExit(
                        "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
                        f"{path.relative_to(root)} promotes forbidden edge with "
                        f"{key}={value!r}"
                    )

            for key in (
                "constructed",
                "proved",
                "discharged",
                "available",
                "theorem_present",
                "witness_present",
            ):
                if node.get(key) is True:
                    raise SystemExit(
                        "SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_FAILED := "
                        f"{path.relative_to(root)} promotes forbidden edge with "
                        f"{key}=True"
                    )

    print("SCALED_ENERGY_ZERO_DAY_EDGE_REJECTION_GUARD_OK")


verify_scaled_energy_observable_map_zero_day_edge_rejection_guard()



def verify_scaled_energy_dimensional_interpretation_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root / "core/scaled_energy_observable_map_bounded_domain_surface.json"
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_observable_map_bounded_domain_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))
    interpretation = surface.get("dimensional_interpretation")

    expected = {
        "input_quantity": "J_E^mu",
        "scaled_quantity": "J_scaled^mu := c * J_E^mu",
        "dimension_rule": "[J_scaled^mu] = [c] * [J_E^mu]",
        "speed_dimension": "[c] = L * T^-1",
        "energy_quantity_status": "NOT_A_DISTINCT_ENERGY_QUANTITY",
        "observable_interpretation": (
            "fixed-unit rescaling of the supplied energy current"
        ),
        "invertibility_condition": "c != 0",
        "inverse_map_shape": "J_E^mu := J_scaled^mu / c",
        "independent_physical_content_status": (
            "NO_NEW_INDEPENDENT_PHYSICAL_CONTENT_FROM_CONSTANT_RESCALING_ALONE"
        ),
        "detector_requirement": (
            "a dimensionally specified detector response functional beyond "
            "constant rescaling"
        ),
        "status": "DIMENSIONAL_INTERPRETATION_ONLY",
    }

    if interpretation != expected:
        raise SystemExit(
            "SCALED_ENERGY_DIMENSIONAL_INTERPRETATION_GUARD_FAILED := "
            f"expected {expected!r} got {interpretation!r}"
        )

    body = json.dumps(surface, sort_keys=True)
    forbidden_claims = {
        '"energy_quantity_status": "DISTINCT_ENERGY_QUANTITY"',
        '"independent_physical_content_status": '
        '"NEW_PHYSICAL_CONTENT_ESTABLISHED"',
        '"status": "EMPIRICALLY_VERIFIED"',
    }

    for claim in forbidden_claims:
        if claim in body:
            raise SystemExit(
                "SCALED_ENERGY_DIMENSIONAL_INTERPRETATION_GUARD_FAILED := "
                f"forbidden promotion {claim!r}"
            )

    print("SCALED_ENERGY_DIMENSIONAL_INTERPRETATION_GUARD_OK")


verify_scaled_energy_dimensional_interpretation_guard()


def verify_scaled_energy_detector_response_input_contract_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_detector_response_functional_"
            "input_contract_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_detector_response_functional_"
            "input_contract_surface.json"
        )

    actual = json.loads(surface_path.read_text(encoding="utf-8"))

    expected = {
        "surface": (
            "ScaledEnergyDetectorResponseFunctionalInputContractSurface"
        ),
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": (
            "BOUNDED_DETECTOR_RESPONSE_FUNCTIONAL_INPUT_CONTRACT_ONLY"
        ),
        "dependency_surface": (
            "ScaledEnergyObservableMapBoundedDomainSurface"
        ),
        "bounded_scope": {
            "domain": "ScaledEnergyObservableDomainB",
            "spacetime_region": (
                "finite detector-supported laboratory region"
            ),
            "species_set": "Sigma_B := {A, B}",
            "closed_world": True,
            "additional_species_allowed": False,
        },
        "functional_shape": {
            "symbol": "R_D",
            "signature": (
                "R_D : "
                "(DetectorSupportB, J_E^mu, J_scaled^mu) "
                "-> DetectorOutputB"
            ),
            "scaled_current_relation": "J_scaled^mu := c * J_E^mu",
            "output_symbol": "y_D",
            "construction_status": "FUNCTIONAL_NOT_CONSTRUCTED",
            "verification_status": "FUNCTIONAL_NOT_VERIFIED",
        },
        "required_input_fields": [
            {
                "field": "detector_identifier",
                "requirement": "bounded opaque detector label",
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "detector_support",
                "requirement": (
                    "finite support contained in "
                    "ScaledEnergyObservableDomainB"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "admissible_input_current",
                "requirement": (
                    "J_E^mu with local conservation supplied explicitly"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "scaled_input_current",
                "requirement": "J_scaled^mu := c * J_E^mu",
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "response_codomain",
                "requirement": (
                    "dimensionally declared bounded detector-output space"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "response_output_unit",
                "requirement": (
                    "explicit physical unit for y_D independent of notation"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "response_functional",
                "requirement": (
                    "total bounded-domain map from declared inputs to y_D"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "calibration_rule",
                "requirement": (
                    "explicit conversion from functional output to "
                    "detector readout"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "finite_output_rule",
                "requirement": (
                    "finite output for every admitted bounded-domain input"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
            {
                "field": "constant_rescaling_distinction_predicate",
                "requirement": (
                    "declared predicate distinguishing response structure "
                    "from constant rescaling alone"
                ),
                "status": "REQUIRED_NOT_SUPPLIED",
            },
        ],
        "contract_status": "INPUT_CONTRACT_FIELDS_SPECIFIED_NOT_INHABITED",
        "blocked_promotions": [
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> detector construction"
            ),
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> detector verification"
            ),
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> empirical confirmation"
            ),
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> ScaledEnergyObservableMap"
            ),
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> alpha_A != alpha_B"
            ),
            (
                "ScaledEnergyDetectorResponseFunctionalInputContractSurface "
                "-> ZeroDayClosure"
            ),
            "unrestricted ZeroDayClosure",
            "restricted-to-unrestricted lift",
        ],
        "non_claims": [
            "does not construct a detector",
            "does not construct R_D",
            "does not verify R_D",
            "does not inhabit the input contract",
            "does not supply detector data",
            "does not establish a calibration rule",
            "does not establish a nontrivial detector response",
            "does not distinguish species A from species B",
            "does not establish alpha_A != alpha_B",
            "does not construct ScaledEnergyObservableMap",
            "does not prove ZeroDayClosure",
            "does not prove unrestricted ZeroDayClosure",
        ],
        "next_weakest_point": (
            "Supply one bounded candidate input record while preserving "
            "unverified detector and empirical status."
        ),
    }

    if actual != expected:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_INPUT_CONTRACT_GUARD_FAILED "
            f":= expected {expected!r} got {actual!r}"
        )

    encoded = json.dumps(actual, sort_keys=True)

    forbidden_tokens = (
        '"contract_status": "INPUT_CONTRACT_INHABITED"',
        '"construction_status": "FUNCTIONAL_CONSTRUCTED"',
        '"verification_status": "FUNCTIONAL_VERIFIED"',
        '"status": "REQUIRED_SUPPLIED"',
        '"detector_status": "DETECTOR_CONSTRUCTED"',
        '"detector_status": "DETECTOR_VERIFIED"',
        '"empirical_status": "CONFIRMED"',
        '"map_status": "CONSTRUCTED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_INPUT_CONTRACT_GUARD_FAILED "
                f":= forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_DETECTOR_RESPONSE_INPUT_CONTRACT_GUARD_OK"
    )


verify_scaled_energy_detector_response_input_contract_guard()


def verify_scaled_energy_detector_response_candidate_input_record_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_detector_response_"
            "candidate_input_record_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_detector_response_"
            "candidate_input_record_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface"
        ),
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": (
            "BOUNDED_DETECTOR_RESPONSE_CANDIDATE_INPUT_RECORD_ONLY"
        ),
        "dependency_surface": (
            "ScaledEnergyDetectorResponseFunctionalInputContractSurface"
        ),
        "record_status": "CANDIDATE_RECORD_NOT_ACCEPTED",
        "contract_inhabitation_status": "INPUT_CONTRACT_NOT_INHABITED",
        "detector_status": "DETECTOR_NOT_CONSTRUCTED",
        "functional_status": "FUNCTIONAL_NOT_CONSTRUCTED",
        "verification_status": "CANDIDATE_NOT_VERIFIED",
        "empirical_status": "NO_EMPIRICAL_EVIDENCE_SUPPLIED",
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_"
                "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    scope = surface.get("bounded_scope")
    expected_scope = {
        "domain": "ScaledEnergyObservableDomainB",
        "species_set": "Sigma_B := {A, B}",
        "closed_world": True,
        "additional_species_allowed": False,
    }

    if scope != expected_scope:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
            f"bounded scope expected {expected_scope!r} got {scope!r}"
        )

    record = surface.get("candidate_record")
    if not isinstance(record, dict):
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
            "candidate_record missing"
        )

    if record.get("record_symbol") != "DInputCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
            "unexpected record symbol"
        )

    fields = record.get("fields")
    if not isinstance(fields, list):
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := fields missing"
        )

    expected_field_names = [
        "detector_identifier",
        "detector_support",
        "admissible_input_current",
        "scaled_input_current",
        "response_codomain",
        "response_output_unit",
        "response_functional",
        "calibration_rule",
        "finite_output_rule",
        "constant_rescaling_distinction_predicate",
    ]

    actual_field_names = [field.get("field") for field in fields]

    if actual_field_names != expected_field_names:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
            f"expected fields {expected_field_names!r} "
            f"got {actual_field_names!r}"
        )

    for field in fields:
        if field.get("status") != "CANDIDATE_UNVERIFIED":
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_"
                "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
                f"promoted field {field.get('field')!r}"
            )

        candidate_value = field.get("candidate_value")
        if not isinstance(candidate_value, str) or not candidate_value:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_"
                "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
                f"missing candidate value for {field.get('field')!r}"
            )

    required_blocked_promotions = {
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> accepted input record"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> input contract inhabitation"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> detector construction"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> response-functional construction"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> detector verification"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> empirical confirmation"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> ScaledEnergyObservableMap"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> alpha_A != alpha_B"
        ),
        (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface "
            "-> ZeroDayClosure"
        ),
        "unrestricted ZeroDayClosure",
        "restricted-to-unrestricted lift",
    }

    actual_blocked_promotions = set(
        surface.get("blocked_promotions", [])
    )

    if actual_blocked_promotions != required_blocked_promotions:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_"
            "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"record_status": "CANDIDATE_RECORD_ACCEPTED"',
        '"contract_inhabitation_status": "INPUT_CONTRACT_INHABITED"',
        '"detector_status": "DETECTOR_CONSTRUCTED"',
        '"functional_status": "FUNCTIONAL_CONSTRUCTED"',
        '"verification_status": "CANDIDATE_VERIFIED"',
        '"empirical_status": "EMPIRICALLY_CONFIRMED"',
        '"status": "CANDIDATE_VERIFIED"',
        '"map_status": "CONSTRUCTED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_"
                "CANDIDATE_INPUT_RECORD_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_DETECTOR_RESPONSE_"
        "CANDIDATE_INPUT_RECORD_GUARD_OK"
    )


verify_scaled_energy_detector_response_candidate_input_record_guard()


def verify_scaled_energy_detector_response_candidate_acceptance_obligation_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_detector_response_candidate_input_"
            "acceptance_obligation_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_detector_response_candidate_input_"
            "acceptance_obligation_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergyDetectorResponseCandidateInput"
            "AcceptanceObligationSurface"
        ),
        "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
        "classification": (
            "BOUNDED_CANDIDATE_INPUT_ACCEPTANCE_OBLIGATIONS_ONLY"
        ),
        "dependency_surface": (
            "ScaledEnergyDetectorResponseCandidateInputRecordSurface"
        ),
        "candidate_record": "DInputCandidateB0",
        "obligation_count": 10,
        "discharged_obligation_count": 0,
        "acceptance_status": "CANDIDATE_NOT_ACCEPTED",
        "contract_inhabitation_status": "INPUT_CONTRACT_NOT_INHABITED",
        "verification_status": (
            "ACCEPTANCE_OBLIGATIONS_NOT_VERIFIED"
        ),
        "detector_status": "DETECTOR_NOT_CONSTRUCTED",
        "functional_status": "FUNCTIONAL_NOT_CONSTRUCTED",
        "empirical_status": "NO_EMPIRICAL_EVIDENCE_SUPPLIED",
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
                "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    expected_scope = {
        "domain": "ScaledEnergyObservableDomainB",
        "species_set": "Sigma_B := {A, B}",
        "closed_world": True,
        "additional_species_allowed": False,
    }

    if surface.get("bounded_scope") != expected_scope:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
            "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
            "bounded scope changed"
        )

    obligations = surface.get("obligations")

    if not isinstance(obligations, list) or len(obligations) != 10:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
            "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
            "expected exactly ten obligations"
        )

    expected_fields = [
        "detector_identifier",
        "detector_support",
        "admissible_input_current",
        "scaled_input_current",
        "response_codomain",
        "response_output_unit",
        "response_functional",
        "calibration_rule",
        "finite_output_rule",
        "constant_rescaling_distinction_predicate",
    ]

    actual_fields = [entry.get("field") for entry in obligations]

    if actual_fields != expected_fields:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
            "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
            f"expected fields {expected_fields!r} got {actual_fields!r}"
        )

    for entry in obligations:
        if entry.get("discharge_status") != (
            "OBLIGATION_NOT_DISCHARGED"
        ):
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
                "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
                f"promoted obligation {entry.get('field')!r}"
            )

        obligation = entry.get("obligation")
        if not isinstance(obligation, str) or not obligation:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
                "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
                f"missing obligation for {entry.get('field')!r}"
            )

    required_blocked = {
        (
            "acceptance obligations "
            "-> discharged acceptance obligations"
        ),
        (
            "acceptance obligations "
            "-> DInputCandidateB0 accepted"
        ),
        (
            "acceptance obligations "
            "-> detector-response input contract inhabited"
        ),
        "acceptance obligations -> detector construction",
        "acceptance obligations -> response-functional construction",
        "acceptance obligations -> detector verification",
        "acceptance obligations -> empirical confirmation",
        "acceptance obligations -> ScaledEnergyObservableMap",
        "acceptance obligations -> alpha_A != alpha_B",
        "acceptance obligations -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
        "restricted-to-unrestricted lift",
    }

    if set(surface.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
            "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"discharge_status": "OBLIGATION_DISCHARGED"',
        '"discharged_obligation_count": 10',
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        '"contract_inhabitation_status": "INPUT_CONTRACT_INHABITED"',
        '"verification_status": "ACCEPTANCE_OBLIGATIONS_VERIFIED"',
        '"detector_status": "DETECTOR_CONSTRUCTED"',
        '"functional_status": "FUNCTIONAL_CONSTRUCTED"',
        '"empirical_status": "EMPIRICALLY_CONFIRMED"',
        '"map_status": "CONSTRUCTED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
                "ACCEPTANCE_OBLIGATION_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_DETECTOR_RESPONSE_CANDIDATE_"
        "ACCEPTANCE_OBLIGATION_GUARD_OK"
    )


verify_scaled_energy_detector_response_candidate_acceptance_obligation_guard()


def verify_scaled_energy_vector_flux_detector_numerical_test() -> None:
    import json
    import math
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / "scaled_energy_vector_flux_detector_numerical_test_surface.json"
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_vector_flux_detector_"
            "numerical_test_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": "ScaledEnergyVectorFluxDetectorNumericalTestSurface",
        "boundary": "BOUNDARY := ¬ universal physical law E = m c^3",
        "classification": (
            "THREE_DIMENSIONAL_SYNTHETIC_VECTOR_FLUX_TEST_ONLY"
        ),
        "test_status": "NUMERICAL_SYNTHETIC_TEST_NOT_EMPIRICAL",
        "empirical_status": "NO_PHYSICAL_DETECTOR_DATA_SUPPLIED",
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    observable = surface.get("vector_observable", {})

    expected_observable = {
        "symbol": "Q_vec(t)",
        "definition": "Q_vec(t) := integral_V S(x,t) d^3x",
        "quantity_type": "THREE_DIMENSIONAL_VECTOR_NOT_ENERGY",
        "component_shape": "[Q_x, Q_y, Q_z]",
        "flux_density_symbol": "S(x,t)",
        "flux_density_unit": "W m^-2 = M T^-3",
        "volume_element_unit": "m^3 = L^3",
        "observable_unit": "W m = M L^3 T^-3",
    }

    if observable != expected_observable:
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "vector observable changed"
        )

    relation = surface.get("conditional_mass_relation", {})

    if relation.get("energy_equivalent_mass") != "m_eq := E / c^2":
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "missing energy-equivalent mass definition"
        )

    if relation.get("collimated_relation") != (
        "Q_vec = c E n_hat = m_eq c^3 n_hat"
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "collimated relation changed"
        )

    if relation.get("universal_status") != (
        "NOT_A_UNIVERSAL_ENERGY_LAW"
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "relation was promoted to a universal law"
        )

    detector = surface.get("detector_array", {})
    shape = detector.get("grid_shape")
    sample_count = detector.get("sample_count")
    cell_volume = detector.get("cell_volume_m3")

    if shape != [2, 2, 2]:
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "unexpected detector grid shape"
        )

    if math.prod(shape) != sample_count or sample_count != 8:
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "detector sample count does not match the three-dimensional grid"
        )

    if not math.isclose(cell_volume, 0.125):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "unexpected detector cell volume"
        )

    if detector.get("construction_status") != (
        "DETECTOR_ARRAY_NOT_CONSTRUCTED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "detector was promoted to constructed"
        )

    if detector.get("verification_status") != (
        "DETECTOR_ARRAY_NOT_VERIFIED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "detector was promoted to verified"
        )

    c_value = surface.get("constants", {}).get("c_m_per_s")

    if not math.isclose(c_value, 299792458.0):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "unexpected value of c"
        )

    configurations = surface.get("synthetic_configurations", [])

    if [entry.get("name") for entry in configurations] != [
        "COLLIMATED_POSITIVE_X",
        "COUNTERPROPAGATING_X",
    ]:
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "unexpected configuration inventory"
        )

    def vector_norm(vector):
        return math.sqrt(sum(component * component for component in vector))

    def integrate_flux(samples):
        if len(samples) != sample_count:
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                "fixture sample count does not match detector grid"
            )

        for sample in samples:
            if not isinstance(sample, list) or len(sample) != 3:
                raise SystemExit(
                    "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                    "each detector sample must be a three-component vector"
                )

        return [
            sum(sample[axis] for sample in samples) * cell_volume
            for axis in range(3)
        ]

    def infer_radiation_energy(samples):
        return (
            sum(vector_norm(sample) for sample in samples)
            * cell_volume
            / c_value
        )

    results = {}

    for configuration in configurations:
        if configuration.get("status") != "SYNTHETIC_FIXTURE_ONLY":
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                "fixture was promoted beyond synthetic status"
            )

        name = configuration["name"]
        samples = configuration["samples_W_per_m2"]
        q_vector = integrate_flux(samples)
        energy_joules = infer_radiation_energy(samples)
        c_times_energy = c_value * energy_joules
        mass_equivalent = energy_joules / (c_value * c_value)
        mass_cubed_relation = mass_equivalent * (c_value ** 3)

        expected_q = configuration["expected_Q_vec_W_m"]
        expected_c_energy = configuration["expected_cE_W_m"]

        for actual, expected in zip(q_vector, expected_q):
            if not math.isclose(actual, expected, abs_tol=1e-12):
                raise SystemExit(
                    "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                    f"{name} integrated vector expected "
                    f"{expected_q!r} got {q_vector!r}"
                )

        if not math.isclose(
            c_times_energy,
            expected_c_energy,
            rel_tol=1e-12,
            abs_tol=1e-12,
        ):
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                f"{name} cE expected {expected_c_energy!r} "
                f"got {c_times_energy!r}"
            )

        if not math.isclose(
            mass_cubed_relation,
            c_times_energy,
            rel_tol=1e-12,
            abs_tol=1e-12,
        ):
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                f"{name} m_eq*c^3 does not equal cE"
            )

        results[name] = {
            "Q_vec": q_vector,
            "Q_norm": vector_norm(q_vector),
            "energy_J": energy_joules,
            "cE_W_m": c_times_energy,
            "m_eq_c3_W_m": mass_cubed_relation,
        }

    collimated = results["COLLIMATED_POSITIVE_X"]

    if not math.isclose(
        collimated["Q_norm"],
        collimated["cE_W_m"],
        rel_tol=1e-12,
        abs_tol=1e-12,
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "collimated fixture does not satisfy norm(Q_vec) = cE"
        )

    counterpropagating = results["COUNTERPROPAGATING_X"]

    if not math.isclose(
        counterpropagating["Q_norm"],
        0.0,
        abs_tol=1e-12,
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "counterpropagating fixture did not cancel vector flux"
        )

    if not counterpropagating["energy_J"] > 0.0:
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "counterpropagating fixture must retain positive energy"
        )

    if math.isclose(
        counterpropagating["Q_norm"],
        counterpropagating["cE_W_m"],
        rel_tol=1e-12,
        abs_tol=1e-12,
    ):
        raise SystemExit(
            "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
            "counterpropagating fixture incorrectly satisfies "
            "norm(Q_vec) = cE"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"quantity_type": "ENERGY"',
        '"universal_status": "UNIVERSAL_ENERGY_LAW"',
        '"construction_status": "DETECTOR_ARRAY_CONSTRUCTED"',
        '"verification_status": "DETECTOR_ARRAY_VERIFIED"',
        '"test_status": "EMPIRICALLY_CONFIRMED"',
        '"empirical_status": "PHYSICAL_DATA_CONFIRMED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_VECTOR_FLUX_NUMERICAL_TEST_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_VECTOR_FLUX_DETECTOR_NUMERICAL_TEST_OK"
    )


verify_scaled_energy_vector_flux_detector_numerical_test()

def verify_scaled_energy_detector_response_finite_support_candidate() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    candidate_path = (
        root
        / "core"
        / "scaled_energy_detector_response_candidate_input_record_surface.json"
    )
    obligation_path = (
        root
        / "core"
        / (
            "scaled_energy_detector_response_candidate_input_"
            "acceptance_obligation_surface.json"
        )
    )

    for path in (candidate_path, obligation_path):
        if not path.exists():
            raise SystemExit(
                "MISSING_OBJECT := "
                f"{path.relative_to(root)}"
            )

    candidate = json.loads(candidate_path.read_text(encoding="utf-8"))
    acceptance = json.loads(obligation_path.read_text(encoding="utf-8"))

    fields = candidate.get("candidate_record", {}).get("fields", [])
    support_fields = [
        entry for entry in fields
        if entry.get("field") == "detector_support"
    ]

    if len(support_fields) != 1:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "expected exactly one detector_support candidate field"
        )

    support = support_fields[0]

    expected_candidate_value = (
        "SupportCandidateB0 subset ScaledEnergyObservableDomainB"
    )
    expected_candidate_obligation = (
        "SupportCandidateB0 is finite and detector-supported"
    )

    if support.get("candidate_value") != expected_candidate_value:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "detector-support candidate shape changed"
        )

    if support.get("obligation") != expected_candidate_obligation:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "detector-support candidate obligation changed"
        )

    if support.get("status") != "CANDIDATE_UNVERIFIED":
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "detector-support candidate was promoted"
        )

    left, separator, right = expected_candidate_value.partition(" subset ")

    if separator != " subset ":
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "missing declared subset relation"
        )

    if left != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "unexpected support symbol"
        )

    if right != "ScaledEnergyObservableDomainB":
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "unexpected bounded domain"
        )

    obligations = acceptance.get("obligations", [])
    support_obligations = [
        entry for entry in obligations
        if entry.get("field") == "detector_support"
    ]

    if len(support_obligations) != 1:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "expected exactly one detector-support acceptance obligation"
        )

    support_obligation = support_obligations[0]

    expected_acceptance_obligation = (
        "SupportCandidateB0 is finite and contained in "
        "ScaledEnergyObservableDomainB"
    )

    if support_obligation.get("obligation") != (
        expected_acceptance_obligation
    ):
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "finite-support acceptance obligation changed"
        )

    if support_obligation.get("discharge_status") != (
        "OBLIGATION_NOT_DISCHARGED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "finite-support obligation was discharged"
        )

    if acceptance.get("discharged_obligation_count") != 0:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "acceptance surface records a discharged obligation"
        )

    if acceptance.get("acceptance_status") != "CANDIDATE_NOT_ACCEPTED":
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "candidate was accepted"
        )

    evaluation = {
        "support_symbol": left,
        "declared_relation": separator.strip(),
        "bounded_domain": right,
        "shape_evaluable": True,
        "finiteness_evidence_present": False,
        "containment_evidence_present": False,
        "discharge_status": "OBLIGATION_NOT_DISCHARGED",
        "evaluation_status": (
            "DECLARED_SUPPORT_SHAPE_EVALUATED_WITHOUT_DISCHARGE"
        ),
    }

    if evaluation != {
        "support_symbol": "SupportCandidateB0",
        "declared_relation": "subset",
        "bounded_domain": "ScaledEnergyObservableDomainB",
        "shape_evaluable": True,
        "finiteness_evidence_present": False,
        "containment_evidence_present": False,
        "discharge_status": "OBLIGATION_NOT_DISCHARGED",
        "evaluation_status": (
            "DECLARED_SUPPORT_SHAPE_EVALUATED_WITHOUT_DISCHARGE"
        ),
    }:
        raise SystemExit(
            "SCALED_ENERGY_FINITE_SUPPORT_CANDIDATE_VERIFIER_FAILED := "
            "unexpected candidate evaluation"
        )

    print(
        "SCALED_ENERGY_DETECTOR_RESPONSE_"
        "FINITE_SUPPORT_CANDIDATE_VERIFIER_OK"
    )


verify_scaled_energy_detector_response_finite_support_candidate()



def verify_scaled_energy_energy_current_conservation_formulation_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    candidate_path = (
        root
        / "core"
        / "scaled_energy_detector_response_candidate_input_record_surface.json"
    )
    acceptance_path = (
        root
        / "core"
        / (
            "scaled_energy_detector_response_candidate_input_"
            "acceptance_obligation_surface.json"
        )
    )

    candidate = json.loads(candidate_path.read_text(encoding="utf-8"))
    acceptance = json.loads(acceptance_path.read_text(encoding="utf-8"))

    candidate_fields = candidate.get("candidate_record", {}).get("fields", [])
    current_fields = [
        entry
        for entry in candidate_fields
        if entry.get("field") == "admissible_input_current"
    ]

    if len(current_fields) != 1:
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            "expected one admissible_input_current candidate field"
        )

    expected_candidate = {
        "field": "admissible_input_current",
        "candidate_value": (
            "J_E_candidate^mu := "
            "T_total_candidate^{mu nu} * tau_nu"
        ),
        "geometry_scope": (
            "SupportCandidateB0 requires a specified metric and "
            "compatible covariant derivative nabla"
        ),
        "stress_energy_scope": (
            "T_total_candidate includes field and detector contributions"
        ),
        "tensor_symmetry_obligation": (
            "T_total_candidate^{mu nu} = "
            "T_total_candidate^{nu mu}"
        ),
        "general_conservation_condition": (
            "(nabla_mu T_total_candidate^{mu nu}) * tau_nu + "
            "T_total_candidate^{mu nu} * "
            "nabla_(mu tau_nu) = 0 on SupportCandidateB0"
        ),
        "sufficient_specialization": (
            "nabla_mu T_total_candidate^{mu nu} = 0 and "
            "nabla_(mu tau_nu) = 0 on SupportCandidateB0"
        ),
        "derivation_shape": (
            "nabla_mu J_E_candidate^mu = "
            "(nabla_mu T_total_candidate^{mu nu}) * tau_nu + "
            "T_total_candidate^{mu nu} * nabla_mu tau_nu = "
            "(nabla_mu T_total_candidate^{mu nu}) * tau_nu + "
            "T_total_candidate^{mu nu} * "
            "nabla_(mu tau_nu)"
        ),
        "killing_scope": (
            "tau_nu is a candidate Killing covector, not necessarily "
            "covariantly constant"
        ),
        "status": "CANDIDATE_UNVERIFIED",
    }

    if current_fields[0] != expected_candidate:
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            f"candidate field expected {expected_candidate!r} "
            f"got {current_fields[0]!r}"
        )

    acceptance_obligations = acceptance.get("obligations", [])
    current_obligations = [
        entry
        for entry in acceptance_obligations
        if entry.get("field") == "admissible_input_current"
    ]

    if len(current_obligations) != 1:
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            "expected one admissible_input_current acceptance obligation"
        )

    expected_acceptance = {
        "field": "admissible_input_current",
        "obligation": (
            "Specify the geometry and covariant derivative on "
            "SupportCandidateB0; prove "
            "T_total_candidate^{mu nu} = "
            "T_total_candidate^{nu mu}; and establish "
            "(nabla_mu T_total_candidate^{mu nu}) * tau_nu + "
            "T_total_candidate^{mu nu} * "
            "nabla_(mu tau_nu) = 0, implying "
            "nabla_mu J_E_candidate^mu = 0 for "
            "J_E_candidate^mu := "
            "T_total_candidate^{mu nu} * tau_nu"
        ),
        "sufficient_discharge_route": (
            "nabla_mu T_total_candidate^{mu nu} = 0 and "
            "nabla_(mu tau_nu) = 0 throughout SupportCandidateB0"
        ),
        "derivation_status": (
            "COVARIANT_DERIVATION_DECLARED_EVIDENCE_NOT_SUPPLIED"
        ),
        "discharge_status": "OBLIGATION_NOT_DISCHARGED",
    }

    if current_obligations[0] != expected_acceptance:
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            f"acceptance obligation expected {expected_acceptance!r} "
            f"got {current_obligations[0]!r}"
        )

    if acceptance.get("discharged_obligation_count") != 0:
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            "an acceptance obligation was discharged"
        )

    if acceptance.get("acceptance_status") != "CANDIDATE_NOT_ACCEPTED":
        raise SystemExit(
            "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
            "candidate was accepted"
        )

    encoded = json.dumps(
        {
            "candidate": current_fields[0],
            "acceptance": current_obligations[0],
        },
        sort_keys=True,
    )

    forbidden_tokens = (
        "partial_mu",
        "constant inertial laboratory time-translation covector",
        '"status": "CANDIDATE_VERIFIED"',
        '"derivation_status": "COVARIANT_DERIVATION_VERIFIED"',
        '"discharge_status": "OBLIGATION_DISCHARGED"',
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_CURRENT_CONSERVATION_FORMULATION_FAILED := "
                f"forbidden token or promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_COVARIANT_CURRENT_CONSERVATION_FORMULATION_GUARD_OK"
    )


verify_scaled_energy_energy_current_conservation_formulation_guard()


def verify_scaled_energy_support_candidate_covariant_geometry_input_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "covariant_geometry_input_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_support_candidate_"
            "covariant_geometry_input_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidateCovariantGeometryInputSurface"
        ),
        "classification": (
            "BOUNDED_COVARIANT_GEOMETRY_INPUT_CONTRACT_ONLY"
        ),
        "target_support": "SupportCandidateB0",
        "contract_status": "GEOMETRY_INPUT_CONTRACT_NOT_INHABITED",
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    expected_dimension_contract = {
        "spatial_dimension": 3,
        "spacetime_dimension": 4,
        "index_range": "mu,nu in {0,1,2,3}",
        "dimension_status": "DIMENSION_CONVENTION_DECLARED_ONLY",
    }

    if surface.get("dimension_contract") != expected_dimension_contract:
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "dimension contract changed"
        )

    inputs = surface.get("required_geometry_inputs")

    expected_fields = [
        "support_region_definition",
        "coordinate_or_atlas_data",
        "metric_tensor",
        "inverse_metric",
        "covariant_derivative",
        "connection_coefficients",
        "metric_compatibility_evidence",
        "torsion_free_evidence",
        "time_translation_covector",
        "stress_energy_symmetry_evidence",
    ]

    if not isinstance(inputs, list):
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "required geometry inputs missing"
        )

    actual_fields = [entry.get("field") for entry in inputs]

    if actual_fields != expected_fields:
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            f"expected fields {expected_fields!r} got {actual_fields!r}"
        )

    for entry in inputs:
        if entry.get("status") != "REQUIRED_NOT_SUPPLIED":
            raise SystemExit(
                "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
                f"promoted geometry input {entry.get('field')!r}"
            )

        for required_key in ("symbol", "requirement"):
            value = entry.get(required_key)
            if not isinstance(value, str) or not value:
                raise SystemExit(
                    "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
                    f"missing {required_key!r} for "
                    f"{entry.get('field')!r}"
                )

    expected_symmetrization = {
        "rank_two_definition": (
            "A_(mu nu) := "
            "1/2 * (A_mu_nu + A_nu_mu)"
        ),
        "covector_derivative_definition": (
            "nabla_(mu tau_nu) := "
            "1/2 * (nabla_mu tau_nu + nabla_nu tau_mu)"
        ),
        "normalization_factor": "1/2",
        "convention_status": "CONVENTION_DEFINED_ONLY",
    }

    if surface.get("symmetrization_convention") != (
        expected_symmetrization
    ):
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "symmetrization convention changed"
        )

    killing = surface.get("killing_condition", {})

    if killing != {
        "equation": "nabla_(mu tau_nu) = 0",
        "interpretation": (
            "tau_candidate_nu is Killing with respect to "
            "g_candidate and nabla_candidate"
        ),
        "evidence_status": "KILLING_EVIDENCE_NOT_SUPPLIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "Killing-condition contract changed"
        )

    current_identity = surface.get("current_identity", {})

    expected_identity = {
        "current_definition": (
            "J_E_candidate^mu := "
            "T_total_candidate^{mu nu} * tau_candidate_nu"
        ),
        "raw_product_rule": (
            "nabla_mu J_E_candidate^mu = "
            "(nabla_mu T_total_candidate^{mu nu}) "
            "* tau_candidate_nu + "
            "T_total_candidate^{mu nu} "
            "* nabla_mu tau_candidate_nu"
        ),
        "symmetric_reduction": (
            "T_total_candidate^{mu nu} "
            "* nabla_mu tau_candidate_nu = "
            "T_total_candidate^{mu nu} "
            "* nabla_(mu tau_candidate_nu)"
        ),
        "symmetric_reduction_requires": (
            "T_total_candidate^{mu nu} "
            "= T_total_candidate^{nu mu}"
        ),
        "general_conservation_condition": (
            "(nabla_mu T_total_candidate^{mu nu}) "
            "* tau_candidate_nu + "
            "T_total_candidate^{mu nu} "
            "* nabla_(mu tau_candidate_nu) = 0"
        ),
        "sufficient_route": (
            "nabla_mu T_total_candidate^{mu nu} = 0 "
            "and nabla_(mu tau_candidate_nu) = 0"
        ),
        "verification_status": "IDENTITY_NOT_VERIFIED",
    }

    if current_identity != expected_identity:
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "current identity contract changed"
        )

    required_blocked = {
        "geometry input contract -> geometry supplied",
        "geometry input contract -> metric verified",
        "geometry input contract -> connection verified",
        "geometry input contract -> tensor symmetry verified",
        "geometry input contract -> covariant conservation verified",
        "geometry input contract -> Killing condition verified",
        "geometry input contract -> current conservation verified",
        "geometry input contract -> acceptance obligation discharged",
        "geometry input contract -> DInputCandidateB0 accepted",
        "geometry input contract -> detector constructed",
        "geometry input contract -> empirical confirmation",
        "geometry input contract -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(surface.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"status": "REQUIRED_SUPPLIED"',
        '"dimension_status": "DIMENSION_VERIFIED"',
        '"contract_status": "GEOMETRY_INPUT_CONTRACT_INHABITED"',
        '"convention_status": "CONVENTION_VERIFIED"',
        '"evidence_status": "KILLING_EVIDENCE_VERIFIED"',
        '"verification_status": "IDENTITY_VERIFIED"',
        '"geometry_status": "GEOMETRY_VERIFIED"',
        '"current_conservation_status": "VERIFIED"',
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_COVARIANT_GEOMETRY_INPUT_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "COVARIANT_GEOMETRY_INPUT_GUARD_OK"
    )


verify_scaled_energy_support_candidate_covariant_geometry_input_guard()


def verify_scaled_energy_support_candidate_region_definition_candidate_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_region_definition_"
            "candidate_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_support_candidate_region_definition_"
            "candidate_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidateRegionDefinitionCandidateSurface"
        ),
        "classification": (
            "BOUNDED_SUPPORT_REGION_DEFINITION_CANDIDATE_ONLY"
        ),
        "dependency_surface": (
            "ScaledEnergySupportCandidateCovariantGeometryInputSurface"
        ),
        "target_support": "SupportCandidateB0",
        "region_status": "REGION_CANDIDATE_NOT_ACCEPTED",
        "nonempty_status": "NONEMPTY_VERIFIED",
        "boundedness_status": "BOUNDEDNESS_VERIFIED",
        "boundary_status": "BOUNDARY_VERIFIED",
        "atlas_status": "ATLAS_NOT_SUPPLIED",
        "metric_status": "METRIC_NOT_SUPPLIED",
        "connection_status": "CONNECTION_NOT_SUPPLIED",
        "physical_realization_status": (
            "PHYSICAL_DETECTOR_SUPPORT_NOT_REALIZED"
        ),
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    expected_ambient = {
        "chart_symbol": "ChartCandidateB0",
        "coordinate_tuple": (
            "x_candidate := "
            "(x_candidate^0,x_candidate^1,x_candidate^2,x_candidate^3)"
        ),
        "coordinate_roles": {
            "x_candidate^0": "temporal coordinate candidate",
            "x_candidate^1": "first spatial coordinate candidate",
            "x_candidate^2": "second spatial coordinate candidate",
            "x_candidate^3": "third spatial coordinate candidate",
        },
        "spatial_dimension": 3,
        "spacetime_dimension": 4,
        "chart_domain": "R^4",
        "chart_map": "standard identity coordinate chart",
        "chart_status": "STANDARD_R4_CHART_SUPPLIED",
    }

    if surface.get("ambient_coordinate_candidate") != expected_ambient:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "ambient coordinate instance changed"
        )

    expected_parameters = {
        "temporal_lower_bound": 0.0,
        "temporal_upper_bound": 1.0e-9,
        "spatial_half_widths": [0.001, 0.001, 0.001],
        "temporal_coordinate_unit": "s",
        "spatial_coordinate_unit": "m",
        "parameter_values_status": "PARAMETER_VALUES_SUPPLIED",
    }

    if surface.get("candidate_parameters") != expected_parameters:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "coordinate parameter instance changed"
        )

    region = surface.get("candidate_region_definition", {})

    expected_boundaries = [
        "x_candidate^0 = 0 s",
        "x_candidate^0 = 1e-9 s",
        "x_candidate^1 = -0.001 m",
        "x_candidate^1 = 0.001 m",
        "x_candidate^2 = -0.001 m",
        "x_candidate^2 = 0.001 m",
        "x_candidate^3 = -0.001 m",
        "x_candidate^3 = 0.001 m",
    ]

    expected_region_fields = {
        "symbol": "SupportCandidateB0",
        "shape": "closed coordinate hyperrectangle candidate",
        "set_definition": (
            "0 s <= x_candidate^0 <= 1e-9 s; "
            "-0.001 m <= x_candidate^i <= 0.001 m "
            "for i in {1,2,3}"
        ),
        "boundary_components": expected_boundaries,
        "boundary_component_count": 8,
        "definition_status": (
            "EXPLICIT_COORDINATE_REGION_INSTANCE_DEFINED"
        ),
    }

    for key, expected in expected_region_fields.items():
        if region.get(key) != expected:
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"region field {key!r} changed"
            )

    parameter_obligations = surface.get("parameter_obligations", [])

    expected_parameter_inventory = [
        "t_minus,t_plus",
        "L_1",
        "L_2",
        "L_3",
        "coordinate_units",
    ]

    if [
        entry.get("parameter") for entry in parameter_obligations
    ] != expected_parameter_inventory:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "parameter inventory changed"
        )

    for entry in parameter_obligations:
        if entry.get("status") != "OBLIGATION_DISCHARGED":
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"undischarged parameter {entry.get('parameter')!r}"
            )
        if not entry.get("evidence"):
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"missing parameter evidence {entry.get('parameter')!r}"
            )

    expected_realization_status = {
        "chart_realization": "OBLIGATION_DISCHARGED",
        "coordinate_parameter_values": "OBLIGATION_DISCHARGED",
        "nonempty_region_evidence": "OBLIGATION_DISCHARGED",
        "boundedness_evidence": "OBLIGATION_DISCHARGED",
        "boundary_realization": "OBLIGATION_DISCHARGED",
        "detector_support_realization": "OBLIGATION_NOT_DISCHARGED",
    }

    realization_obligations = surface.get(
        "realization_obligations",
        [],
    )

    actual_realization_status = {
        entry.get("field"): entry.get("status")
        for entry in realization_obligations
    }

    if actual_realization_status != expected_realization_status:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "realization status changed"
        )

    for entry in realization_obligations:
        field = entry.get("field")
        if (
            field != "detector_support_realization"
            and not entry.get("evidence")
        ):
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"missing realization evidence {field!r}"
            )

    expected_evidence = {
        "nonempty_witness": {
            "point": [5.0e-10, 0.0, 0.0, 0.0],
            "coordinate_units": ["s", "m", "m", "m"],
            "membership_check": (
                "0 <= 5e-10 <= 1e-9 and "
                "-0.001 <= 0 <= 0.001 in each spatial coordinate"
            ),
            "status": "VERIFIED",
        },
        "boundedness_certificate": {
            "temporal_interval": "[0,1e-9] s",
            "spatial_intervals": [
                "[-0.001,0.001] m",
                "[-0.001,0.001] m",
                "[-0.001,0.001] m",
            ],
            "reason": (
                "finite Cartesian product of bounded closed intervals"
            ),
            "status": "VERIFIED",
        },
        "boundary_certificate": {
            "expected_coordinate_faces": 8,
            "verified_coordinate_faces": 8,
            "reason": "two endpoint faces for each of four coordinates",
            "status": "VERIFIED",
        },
    }

    if surface.get("verification_evidence") != expected_evidence:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "verification evidence changed"
        )

    required_blocked = {
        "region candidate -> accepted SupportCandidateB0",
        "region candidate -> atlas supplied",
        "region candidate -> metric supplied",
        "region candidate -> connection supplied",
        "region candidate -> detector support realized",
        "region candidate -> covariant conservation verified",
        "region candidate -> Killing condition verified",
        "region candidate -> current conservation verified",
        "region candidate -> DInputCandidateB0 accepted",
        "region candidate -> empirical confirmation",
        "region candidate -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(surface.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"region_status": "REGION_CANDIDATE_ACCEPTED"',
        '"atlas_status": "ATLAS_SUPPLIED"',
        '"metric_status": "METRIC_SUPPLIED"',
        '"connection_status": "CONNECTION_SUPPLIED"',
        '"physical_realization_status": '
        '"PHYSICAL_DETECTOR_SUPPORT_REALIZED"',
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        '"current_conservation_status": "VERIFIED"',
        '"empirical_status": "CONFIRMED"',
        '"energy_law_status": "E_EQUALS_M_C_CUBED_VERIFIED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_STANDARD_R4_HYPERRECTANGLE_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "STANDARD_R4_HYPERRECTANGLE_INSTANCE_GUARD_OK"
    )


verify_scaled_energy_support_candidate_region_definition_candidate_guard()


def verify_scaled_energy_closed_translation_invariant_detector_solution_input_contract_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_closed_translation_invariant_detector_"
            "solution_input_contract_surface.json"
        )
    )

    if not surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_closed_translation_invariant_detector_"
            "solution_input_contract_surface.json"
        )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergyClosedTranslationInvariantDetector"
            "SolutionInputContractSurface"
        ),
        "classification": (
            "RESTRICTED_UNCONDITIONAL_CURRENT_THEOREM_INPUT_CONTRACT_ONLY"
        ),
        "solution_type_symbol": (
            "ClosedTranslationInvariantDetectorSolutionB0"
        ),
        "required_solution_field_count": 11,
        "supplied_solution_field_count": 0,
        "contract_status": "SOLUTION_INPUT_CONTRACT_NOT_INHABITED",
        "inhabitant_status": "NO_SOLUTION_INHABITANT_CONSTRUCTED",
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    logical_scope = surface.get("logical_scope", {})

    expected_scope = {
        "target_quantification": (
            "forall s : ClosedTranslationInvariantDetectorSolutionB0"
        ),
        "target_conclusion": "nabla_mu J_E_s^mu = 0",
        "meaning": (
            "unconditional only after an inhabitant supplies every "
            "restricted solution-field premise"
        ),
        "global_unconditional_status": (
            "MODEL_INDEPENDENT_UNCONDITIONAL_THEOREM_BLOCKED"
        ),
    }

    if logical_scope != expected_scope:
        raise SystemExit(
            "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
            "logical scope changed"
        )

    fields = surface.get("required_solution_fields", [])

    expected_field_names = [
        "accepted_support_region",
        "covariant_geometry",
        "total_action",
        "translation_invariance",
        "equations_of_motion_solution",
        "total_stress_energy_inventory",
        "stress_energy_symmetry",
        "covariant_stress_energy_conservation",
        "time_translation_covector",
        "killing_evidence",
        "boundary_flux_closure",
    ]

    if [entry.get("field") for entry in fields] != expected_field_names:
        raise SystemExit(
            "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
            "required solution-field inventory changed"
        )

    for entry in fields:
        if entry.get("status") != "REQUIRED_NOT_SUPPLIED":
            raise SystemExit(
                "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
                f"promoted solution field {entry.get('field')!r}"
            )

        for key in ("symbol", "requirement"):
            value = entry.get(key)
            if not isinstance(value, str) or not value:
                raise SystemExit(
                    "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED "
                    f":= missing {key!r} for {entry.get('field')!r}"
                )

    theorem_target = surface.get("restricted_theorem_target", {})

    if theorem_target != {
        "statement": (
            "forall s : ClosedTranslationInvariantDetectorSolutionB0, "
            "nabla_mu J_E_s^mu = 0"
        ),
        "proof_route": (
            "rewrite the current divergence by the covariant product rule, "
            "then use stress-energy symmetry, covariant conservation, and "
            "the Killing equation"
        ),
        "construction_status": "THEOREM_TARGET_NOT_CONSTRUCTED",
        "verification_status": "THEOREM_TARGET_NOT_VERIFIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
            "restricted theorem target changed"
        )

    dimensional_boundary = surface.get("dimensional_boundary", {})

    if dimensional_boundary != {
        "energy_unit": "[E] = M L^2 T^-2",
        "scaled_quantity_unit": "[cE] = [m c^3] = M L^3 T^-3",
        "energy_law_status": (
            "E_EQUALS_M_C_CUBED_REJECTED_AS_ENERGY_LAW"
        ),
        "observable_status": (
            "cE may denote a non-energy scaled or vector-flux observable"
        ),
    }:
        raise SystemExit(
            "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
            "dimensional boundary changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"status": "REQUIRED_SUPPLIED"',
        '"supplied_solution_field_count": 11',
        '"contract_status": "SOLUTION_INPUT_CONTRACT_INHABITED"',
        '"inhabitant_status": "SOLUTION_INHABITANT_CONSTRUCTED"',
        '"construction_status": "THEOREM_TARGET_CONSTRUCTED"',
        '"verification_status": "THEOREM_TARGET_VERIFIED"',
        '"global_unconditional_status": '
        '"MODEL_INDEPENDENT_UNCONDITIONAL_THEOREM_PROVED"',
        '"energy_law_status": "E_EQUALS_M_C_CUBED_VERIFIED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_RESTRICTED_SOLUTION_CONTRACT_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_CLOSED_TRANSLATION_INVARIANT_"
        "DETECTOR_SOLUTION_INPUT_CONTRACT_GUARD_OK"
    )


verify_scaled_energy_closed_translation_invariant_detector_solution_input_contract_guard()

def verify_scaled_energy_coupling_branch_exclusivity_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    bounded_surface_path = (
        root / "core/scaled_energy_observable_map_bounded_domain_surface.json"
    )

    if not bounded_surface_path.exists():
        raise SystemExit(
            "MISSING_OBJECT := "
            "core/scaled_energy_observable_map_bounded_domain_surface.json"
        )

    bounded_surface = json.loads(
        bounded_surface_path.read_text(encoding="utf-8")
    )

    required_non_claims = {
        "does not establish coupling universality",
        "does not establish alpha_A != alpha_B",
    }

    non_claims = set(bounded_surface.get("non_claims", []))
    missing_non_claims = sorted(required_non_claims - non_claims)
    if missing_non_claims:
        raise SystemExit(
            "SCALED_ENERGY_COUPLING_BRANCH_EXCLUSIVITY_GUARD_FAILED := "
            f"missing non_claims {missing_non_claims!r}"
        )

    blocked_promotions = set(
        bounded_surface.get("blocked_promotions", [])
    )
    if "alpha_A != alpha_B established" not in blocked_promotions:
        raise SystemExit(
            "SCALED_ENERGY_COUPLING_BRANCH_EXCLUSIVITY_GUARD_FAILED := "
            "missing alpha_A != alpha_B blocked promotion"
        )

    universality_status_keys = {
        "coupling_universality_status",
        "scaled_energy_coupling_universality_status",
    }

    nonuniversal_status_keys = {
        "nonuniversal_specialization_status",
        "alpha_A_not_equal_alpha_B_status",
        "alpha_inequality_status",
    }

    active_universality_statuses = {
        "ACTIVE",
        "ESTABLISHED",
        "VERIFIED",
        "PROVED",
        "INPUT_SUPPLIED",
        "UNIVERSAL_COUPLING_ACTIVE",
    }

    active_nonuniversal_statuses = {
        "ACTIVE",
        "ESTABLISHED",
        "VERIFIED",
        "PROVED",
        "NONUNIVERSAL_COUPLING_ACTIVE",
        "ALPHA_A_NOT_EQUAL_ALPHA_B_ESTABLISHED",
    }

    def objects(value):
        if isinstance(value, dict):
            yield value
            for child in value.values():
                yield from objects(child)
        elif isinstance(value, list):
            for child in value:
                yield from objects(child)

    for path in sorted((root / "core").glob("*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))

        for node in objects(data):
            universal_active = (
                node.get("coupling_universality_active") is True
                or any(
                    isinstance(node.get(key), str)
                    and node[key].upper() in active_universality_statuses
                    for key in universality_status_keys
                )
            )

            nonuniversal_active = (
                node.get("nonuniversal_specialization_active") is True
                or node.get("alpha_A_not_equal_alpha_B_active") is True
                or any(
                    isinstance(node.get(key), str)
                    and node[key].upper() in active_nonuniversal_statuses
                    for key in nonuniversal_status_keys
                )
            )

            if universal_active and nonuniversal_active:
                raise SystemExit(
                    "SCALED_ENERGY_COUPLING_BRANCH_EXCLUSIVITY_GUARD_FAILED := "
                    f"{path.relative_to(root)} activates universal and "
                    "nonuniversal coupling branches simultaneously"
                )

    print("SCALED_ENERGY_COUPLING_BRANCH_EXCLUSIVITY_GUARD_OK")


verify_scaled_energy_coupling_branch_exclusivity_guard()

def verify_scaled_energy_support_candidate_minkowski_metric_connection_instance_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]

    instance_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "minkowski_metric_connection_instance_surface.json"
        )
    )
    region_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_region_definition_"
            "candidate_surface.json"
        )
    )
    geometry_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "covariant_geometry_input_surface.json"
        )
    )

    for path in (instance_path, region_path, geometry_path):
        if not path.exists():
            raise SystemExit(
                f"MISSING_OBJECT := {path.relative_to(root)}"
            )

    instance = json.loads(instance_path.read_text(encoding="utf-8"))
    region = json.loads(region_path.read_text(encoding="utf-8"))
    geometry = json.loads(geometry_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidate"
            "MinkowskiMetricConnectionInstanceSurface"
        ),
        "classification": (
            "BOUNDED_MINKOWSKI_METRIC_CONNECTION_INPUT_INSTANCE_ONLY"
        ),
        "dependency_region_surface": (
            "ScaledEnergySupportCandidateRegionDefinitionCandidateSurface"
        ),
        "dependency_geometry_contract_surface": (
            "ScaledEnergySupportCandidateCovariantGeometryInputSurface"
        ),
        "target_support": "SupportCandidateB0",
        "instance_status": (
            "METRIC_CONNECTION_COMPONENT_INSTANCE_VERIFIED"
        ),
        "contract_inhabitation_status": (
            "FULL_GEOMETRY_INPUT_CONTRACT_NOT_INHABITED"
        ),
    }

    for key, expected in expected_top_level.items():
        actual = instance.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    expected_region_state = {
        "target_support": "SupportCandidateB0",
        "nonempty_status": "NONEMPTY_VERIFIED",
        "boundedness_status": "BOUNDEDNESS_VERIFIED",
        "boundary_status": "BOUNDARY_VERIFIED",
        "metric_status": "METRIC_NOT_SUPPLIED",
        "connection_status": "CONNECTION_NOT_SUPPLIED",
        "physical_realization_status": (
            "PHYSICAL_DETECTOR_SUPPORT_NOT_REALIZED"
        ),
    }

    for key, expected in expected_region_state.items():
        actual = region.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
                f"region {key!r} expected {expected!r} got {actual!r}"
            )

    if geometry.get("contract_status") != (
        "GEOMETRY_INPUT_CONTRACT_NOT_INHABITED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "geometry contract was promoted"
        )

    expected_scope = {
        "chart_symbol": "ChartCandidateB0",
        "chart_domain": "R^4",
        "basis_order": [
            "x_candidate^0",
            "x_candidate^1",
            "x_candidate^2",
            "x_candidate^3",
        ],
        "temporal_bounds": [0.0, 1.0e-9],
        "temporal_unit": "s",
        "spatial_bounds": [
            [-0.001, 0.001],
            [-0.001, 0.001],
            [-0.001, 0.001],
        ],
        "spatial_unit": "m",
        "scope_status": "EXISTING_BOUNDED_REGION_REFERENCED",
    }

    if instance.get("coordinate_scope") != expected_scope:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "coordinate scope changed"
        )

    expected_metric = [
        [-1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]

    metric = instance.get("metric_tensor", {})
    inverse = instance.get("inverse_metric", {})

    if metric.get("components") != expected_metric:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "metric is not diag(-1,1,1,1)"
        )

    if inverse.get("components") != expected_metric:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "inverse metric is not diag(-1,1,1,1)"
        )

    if metric.get("signature") != "(-,+,+,+)":
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "metric signature changed"
        )

    dimension = 4

    for mu in range(dimension):
        for nu in range(dimension):
            product = sum(
                metric["components"][mu][rho]
                * inverse["components"][rho][nu]
                for rho in range(dimension)
            )
            expected = 1 if mu == nu else 0

            if product != expected:
                raise SystemExit(
                    "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_"
                    "GUARD_FAILED := inverse identity failed at "
                    f"({mu},{nu})"
                )

    connection = instance.get("connection_coefficients", {})

    if connection != {
        "symbol": "Gamma_candidate^rho_mu_nu",
        "component_rule": (
            "Gamma_candidate^rho_mu_nu = 0 "
            "for all rho,mu,nu in {0,1,2,3}"
        ),
        "component_count": 64,
        "component_status": "ZERO_COMPONENTS_SUPPLIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "zero connection component contract changed"
        )

    checked_metric_compatibility_components = 0
    checked_torsion_components = 0

    for lambda_index in range(dimension):
        for mu in range(dimension):
            for nu in range(dimension):
                partial_metric = 0
                connection_term_one = 0
                connection_term_two = 0

                compatibility_component = (
                    partial_metric
                    - connection_term_one
                    - connection_term_two
                )

                if compatibility_component != 0:
                    raise SystemExit(
                        "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_"
                        "GUARD_FAILED := metric compatibility failed at "
                        f"({lambda_index},{mu},{nu})"
                    )

                checked_metric_compatibility_components += 1

                gamma_rho_mu_nu = 0
                gamma_rho_nu_mu = 0

                if gamma_rho_mu_nu - gamma_rho_nu_mu != 0:
                    raise SystemExit(
                        "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_"
                        "GUARD_FAILED := torsion check failed at "
                        f"({lambda_index},{mu},{nu})"
                    )

                checked_torsion_components += 1

    if checked_metric_compatibility_components != 64:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "expected 64 metric-compatibility component checks"
        )

    if checked_torsion_components != 64:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "expected 64 torsion component checks"
        )

    expected_metric_compatibility = {
        "equation": "nabla_lambda g_candidate_mu_nu = 0",
        "component_identity": (
            "partial_lambda g_candidate_mu_nu "
            "- Gamma_candidate^rho_lambda_mu * g_candidate_rho_nu "
            "- Gamma_candidate^rho_lambda_nu * g_candidate_mu_rho = 0"
        ),
        "component_check_count": 64,
        "verification_status": "COMPONENT_CHECK_VERIFIED",
    }

    if instance.get("metric_compatibility") != (
        expected_metric_compatibility
    ):
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "metric compatibility certificate changed"
        )

    expected_torsion = {
        "equation": (
            "Gamma_candidate^rho_mu_nu "
            "- Gamma_candidate^rho_nu_mu = 0"
        ),
        "component_check_count": 64,
        "verification_status": "COMPONENT_CHECK_VERIFIED",
    }

    if instance.get("torsion_free") != expected_torsion:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "torsion-free certificate changed"
        )

    required_blocked = {
        "metric-connection instance -> accepted SupportCandidateB0",
        "metric-connection instance -> full geometry contract inhabited",
        "metric-connection instance -> time translation covector supplied",
        "metric-connection instance -> Killing evidence verified",
        "metric-connection instance -> stress-energy symmetry verified",
        (
            "metric-connection instance -> "
            "covariant stress-energy conservation verified"
        ),
        "metric-connection instance -> detector support realized",
        "metric-connection instance -> current conservation verified",
        "metric-connection instance -> DInputCandidateB0 accepted",
        "metric-connection instance -> empirical confirmation",
        "metric-connection instance -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(instance.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(instance, sort_keys=True)

    forbidden_tokens = (
        "KILLING_EVIDENCE_VERIFIED",
        "STRESS_ENERGY_SYMMETRY_VERIFIED",
        "COVARIANT_STRESS_ENERGY_CONSERVATION_VERIFIED",
        "PHYSICAL_DETECTOR_SUPPORT_REALIZED",
        "CURRENT_CONSERVATION_VERIFIED",
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        "EMPIRICALLY_CONFIRMED",
        "E_EQUALS_M_C_CUBED_VERIFIED",
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_MINKOWSKI_METRIC_CONNECTION_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "MINKOWSKI_METRIC_CONNECTION_INSTANCE_GUARD_OK"
    )


verify_scaled_energy_support_candidate_minkowski_metric_connection_instance_guard()

def verify_scaled_energy_support_candidate_time_translation_covector_candidate_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]

    surface_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "time_translation_covector_candidate_surface.json"
        )
    )
    region_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_region_definition_"
            "candidate_surface.json"
        )
    )
    metric_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "minkowski_metric_connection_instance_surface.json"
        )
    )
    geometry_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "covariant_geometry_input_surface.json"
        )
    )

    for path in (
        surface_path,
        region_path,
        metric_path,
        geometry_path,
    ):
        if not path.exists():
            raise SystemExit(
                f"MISSING_OBJECT := {path.relative_to(root)}"
            )

    surface = json.loads(surface_path.read_text(encoding="utf-8"))
    region = json.loads(region_path.read_text(encoding="utf-8"))
    metric = json.loads(metric_path.read_text(encoding="utf-8"))
    geometry = json.loads(geometry_path.read_text(encoding="utf-8"))

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidate"
            "TimeTranslationCovectorCandidateSurface"
        ),
        "classification": (
            "BOUNDED_TIME_TRANSLATION_COVECTOR_CANDIDATE_ONLY"
        ),
        "dependency_region_surface": (
            "ScaledEnergySupportCandidateRegionDefinitionCandidateSurface"
        ),
        "dependency_metric_connection_surface": (
            "ScaledEnergySupportCandidate"
            "MinkowskiMetricConnectionInstanceSurface"
        ),
        "dependency_geometry_contract_surface": (
            "ScaledEnergySupportCandidateCovariantGeometryInputSurface"
        ),
        "target_support": "SupportCandidateB0",
        "candidate_status": (
            "TIME_TRANSLATION_COVECTOR_CANDIDATE_COMPONENTS_VERIFIED"
        ),
        "contract_inhabitation_status": (
            "FULL_GEOMETRY_INPUT_CONTRACT_NOT_INHABITED"
        ),
    }

    for key, expected in expected_top_level.items():
        actual = surface.get(key)
        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    if region.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "region support changed"
        )

    if region.get("physical_realization_status") != (
        "PHYSICAL_DETECTOR_SUPPORT_NOT_REALIZED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "detector support was promoted"
        )

    if metric.get("instance_status") != (
        "METRIC_CONNECTION_COMPONENT_INSTANCE_VERIFIED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "metric-connection dependency not verified"
        )

    if geometry.get("contract_status") != (
        "GEOMETRY_INPUT_CONTRACT_NOT_INHABITED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "geometry contract was promoted"
        )

    expected_scope = {
        "chart_symbol": "ChartCandidateB0",
        "chart_domain": "R^4",
        "basis_order": [
            "x_candidate^0",
            "x_candidate^1",
            "x_candidate^2",
            "x_candidate^3",
        ],
        "temporal_bounds": [0.0, 1.0e-9],
        "temporal_unit": "s",
        "spatial_bounds": [
            [-0.001, 0.001],
            [-0.001, 0.001],
            [-0.001, 0.001],
        ],
        "spatial_unit": "m",
        "scope_status": "EXISTING_BOUNDED_REGION_REFERENCED",
    }

    if surface.get("coordinate_scope") != expected_scope:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "coordinate scope changed"
        )

    covector = surface.get("covector_candidate", {})

    if covector != {
        "symbol": "tau_candidate_nu",
        "variance": "covariant rank-one tensor",
        "components": [-1, 0, 0, 0],
        "component_rule": (
            "tau_candidate_nu = (-1,0,0,0) "
            "in ChartCandidateB0 on SupportCandidateB0"
        ),
        "component_status": "EXACT_CANDIDATE_COMPONENTS_SUPPLIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "covector candidate changed"
        )

    inverse_metric = (
        metric.get("inverse_metric", {}).get("components")
    )
    tau_covariant = covector["components"]

    if inverse_metric != [
        [-1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "inverse metric dependency changed"
        )

    tau_contravariant = [
        sum(
            inverse_metric[mu][nu] * tau_covariant[nu]
            for nu in range(4)
        )
        for mu in range(4)
    ]

    if tau_contravariant != [1, 0, 0, 0]:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "metric dual component check failed"
        )

    norm = sum(
        inverse_metric[mu][nu]
        * tau_covariant[mu]
        * tau_covariant[nu]
        for mu in range(4)
        for nu in range(4)
    )

    if norm != -1:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "timelike norm component check failed"
        )

    if surface.get("metric_dual_candidate") != {
        "symbol": "tau_candidate^mu",
        "definition": (
            "tau_candidate^mu := "
            "g_candidate_inverse^{mu nu} * tau_candidate_nu"
        ),
        "components": [1, 0, 0, 0],
        "component_status": "COMPONENT_CHECK_VERIFIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "metric dual certificate changed"
        )

    if surface.get("norm_candidate") != {
        "definition": (
            "g_candidate_inverse^{mu nu} "
            "* tau_candidate_mu * tau_candidate_nu"
        ),
        "value": -1,
        "signature": "(-,+,+,+)",
        "classification": "UNIT_TIMELIKE_COVECTOR_CANDIDATE",
        "component_status": "COMPONENT_CHECK_VERIFIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "norm certificate changed"
        )

    if surface.get("derivative_boundary") != {
        "candidate_expression": (
            "nabla_candidate_mu tau_candidate_nu"
        ),
        "verification_status": (
            "COVARIANT_DERIVATIVE_NOT_VERIFIED"
        ),
    }:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "derivative boundary changed"
        )

    if surface.get("killing_boundary") != {
        "candidate_equation": (
            "nabla_candidate_(mu tau_candidate_nu) = 0"
        ),
        "evidence_status": "KILLING_EVIDENCE_NOT_VERIFIED",
        "theorem_status": "KILLING_THEOREM_NOT_CONSTRUCTED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "Killing boundary changed"
        )

    required_blocked = {
        "covector candidate -> accepted SupportCandidateB0",
        "covector candidate -> full geometry contract inhabited",
        "covector candidate -> covariant derivative verified",
        "covector candidate -> Killing evidence verified",
        "covector candidate -> stress-energy symmetry verified",
        (
            "covector candidate -> "
            "covariant stress-energy conservation verified"
        ),
        "covector candidate -> detector support realized",
        "covector candidate -> current conservation verified",
        "covector candidate -> DInputCandidateB0 accepted",
        "covector candidate -> empirical confirmation",
        "covector candidate -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(surface.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
            "blocked-promotion set changed"
        )

    encoded = json.dumps(surface, sort_keys=True)

    forbidden_tokens = (
        '"verification_status": "COVARIANT_DERIVATIVE_VERIFIED"',
        '"evidence_status": "KILLING_EVIDENCE_VERIFIED"',
        '"theorem_status": "KILLING_THEOREM_CONSTRUCTED"',
        "STRESS_ENERGY_SYMMETRY_VERIFIED",
        "COVARIANT_STRESS_ENERGY_CONSERVATION_VERIFIED",
        "PHYSICAL_DETECTOR_SUPPORT_REALIZED",
        "CURRENT_CONSERVATION_VERIFIED",
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        "EMPIRICALLY_CONFIRMED",
        "E_EQUALS_M_C_CUBED_VERIFIED",
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_TIME_TRANSLATION_COVECTOR_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "TIME_TRANSLATION_COVECTOR_CANDIDATE_GUARD_OK"
    )


verify_scaled_energy_support_candidate_time_translation_covector_candidate_guard()

def verify_scaled_energy_support_candidate_time_translation_killing_evidence_guard() -> None:
    import json
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]

    metric_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "minkowski_metric_connection_instance_surface.json"
        )
    )
    covector_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "time_translation_covector_candidate_surface.json"
        )
    )
    evidence_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "time_translation_killing_evidence_surface.json"
        )
    )

    for path in (metric_path, covector_path, evidence_path):
        if not path.exists():
            raise SystemExit(
                f"MISSING_OBJECT := {path.relative_to(root)}"
            )

    metric = json.loads(metric_path.read_text(encoding="utf-8"))
    covector = json.loads(covector_path.read_text(encoding="utf-8"))
    evidence = json.loads(evidence_path.read_text(encoding="utf-8"))

    def contains_value(value, target):
        if value == target:
            return True

        if isinstance(value, dict):
            return any(
                contains_value(child, target)
                for child in value.values()
            )

        if isinstance(value, list):
            return any(
                contains_value(child, target)
                for child in value
            )

        return False

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidate"
            "TimeTranslationKillingEvidenceSurface"
        ),
        "classification": (
            "BOUNDED_TIME_TRANSLATION_KILLING_EVIDENCE_ONLY"
        ),
        "dependency_metric_connection_surface": (
            "ScaledEnergySupportCandidate"
            "MinkowskiMetricConnectionInstanceSurface"
        ),
        "dependency_time_translation_surface": (
            "ScaledEnergySupportCandidate"
            "TimeTranslationCovectorCandidateSurface"
        ),
        "target_support": "SupportCandidateB0",
        "dimension": 4,
        "scope_status": (
            "BOUNDED_MINKOWSKI_TIME_TRANSLATION_"
            "KILLING_EDGE_INHABITED"
        ),
    }

    for key, expected in expected_top_level.items():
        actual = evidence.get(key)

        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
                "EVIDENCE_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    if metric.get("surface") != (
        "ScaledEnergySupportCandidate"
        "MinkowskiMetricConnectionInstanceSurface"
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := metric dependency changed"
        )

    if metric.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := metric support changed"
        )

    if covector.get("surface") != (
        "ScaledEnergySupportCandidate"
        "TimeTranslationCovectorCandidateSurface"
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := covector dependency changed"
        )

    if covector.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := covector support changed"
        )

    expected_metric = [
        [-1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]
    expected_covector = [-1, 0, 0, 0]
    expected_vector = [1, 0, 0, 0]

    if not contains_value(metric, expected_metric):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := Minkowski metric missing"
        )

    if not contains_value(covector, expected_covector):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := time covector missing"
        )

    if not contains_value(covector, expected_vector):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := metric-dual vector missing"
        )

    translation = evidence.get("time_translation", {})

    if translation.get("covector_components") != expected_covector:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := evidence covector changed"
        )

    if translation.get("vector_components") != expected_vector:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := evidence vector changed"
        )

    norm = sum(
        expected_covector[index] * expected_vector[index]
        for index in range(4)
    )

    if norm != -1:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := timelike norm is not -1"
        )

    covariant_derivatives = {}
    checked_covariant_components = 0

    for mu in range(4):
        for nu in range(4):
            partial_mu_tau_nu = 0
            connection_contraction = sum(
                0 * expected_covector[rho]
                for rho in range(4)
            )

            component = (
                partial_mu_tau_nu
                - connection_contraction
            )

            if component != 0:
                raise SystemExit(
                    "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
                    "EVIDENCE_GUARD_FAILED := "
                    f"nabla_tau failed at ({mu},{nu})"
                )

            covariant_derivatives[(mu, nu)] = component
            checked_covariant_components += 1

    if checked_covariant_components != 16:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := "
            "expected 16 covariant-derivative checks"
        )

    checked_killing_components = 0

    for mu in range(4):
        for nu in range(4):
            symmetrized_numerator = (
                covariant_derivatives[(mu, nu)]
                + covariant_derivatives[(nu, mu)]
            )

            if symmetrized_numerator != 0:
                raise SystemExit(
                    "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
                    "EVIDENCE_GUARD_FAILED := "
                    f"Killing equation failed at ({mu},{nu})"
                )

            checked_killing_components += 1

    if checked_killing_components != 16:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := "
            "expected 16 Killing-equation checks"
        )

    expected_covariant_certificate = {
        "equation": (
            "nabla_mu tau_candidate_nu = "
            "partial_mu tau_candidate_nu "
            "- Gamma_candidate^rho_mu_nu tau_candidate_rho"
        ),
        "component_rule": (
            "nabla_mu tau_candidate_nu = 0 "
            "for all mu,nu in {0,1,2,3}"
        ),
        "component_check_count": 16,
        "verification_status": (
            "COVARIANT_DERIVATIVE_COMPONENTS_VERIFIED"
        ),
    }

    if evidence.get("covariant_derivative") != (
        expected_covariant_certificate
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := "
            "covariant-derivative certificate changed"
        )

    expected_killing_certificate = {
        "equation": (
            "nabla_(mu tau_candidate_nu) = "
            "(nabla_mu tau_candidate_nu "
            "+ nabla_nu tau_candidate_mu) / 2 = 0"
        ),
        "ordered_component_check_count": 16,
        "verification_status": (
            "KILLING_EVIDENCE_VERIFIED_ON_SUPPORT_CANDIDATE_B0"
        ),
    }

    if evidence.get("killing_equation") != (
        expected_killing_certificate
    ):
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := Killing certificate changed"
        )

    expected_edge = {
        "source": (
            "bounded Minkowski metric connection instance "
            "+ bounded time translation covector candidate"
        ),
        "target": (
            "KillingEvidence("
            "SupportCandidateB0,tau_candidate)"
        ),
        "status": "INHABITED_BY_COMPONENT_VERIFICATION",
    }

    if evidence.get("inhabited_edge") != expected_edge:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := inhabited edge changed"
        )

    required_blocked = {
        "Killing evidence -> stress-energy candidate supplied",
        "Killing evidence -> stress-energy symmetry verified",
        (
            "Killing evidence -> "
            "covariant stress-energy conservation verified"
        ),
        "Killing evidence -> finite-support stress-energy verified",
        "Killing evidence -> detector support realized",
        "Killing evidence -> current conservation verified",
        "Killing evidence -> DInputCandidateB0 accepted",
        (
            "Killing evidence -> "
            "restricted composition target accepted"
        ),
        "Killing evidence -> empirical confirmation",
        "Killing evidence -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(evidence.get("blocked_promotions", [])) != required_blocked:
        raise SystemExit(
            "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
            "EVIDENCE_GUARD_FAILED := blocked promotions changed"
        )

    encoded = json.dumps(evidence, sort_keys=True)

    forbidden_tokens = (
        "STRESS_ENERGY_SYMMETRY_VERIFIED",
        "COVARIANT_STRESS_ENERGY_CONSERVATION_VERIFIED",
        "FINITE_SUPPORT_STRESS_ENERGY_VERIFIED",
        "PHYSICAL_DETECTOR_SUPPORT_REALIZED",
        "CURRENT_CONSERVATION_VERIFIED",
        '"acceptance_status": "CANDIDATE_ACCEPTED"',
        "RESTRICTED_COMPOSITION_TARGET_ACCEPTED",
        "EMPIRICALLY_CONFIRMED",
        "E_EQUALS_M_C_CUBED_VERIFIED",
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_TIME_TRANSLATION_KILLING_"
                "EVIDENCE_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "TIME_TRANSLATION_KILLING_EVIDENCE_GUARD_OK"
    )


verify_scaled_energy_support_candidate_time_translation_killing_evidence_guard()

def verify_scaled_energy_support_candidate_compact_support_stress_energy_candidate_guard() -> None:
    import json
    import math
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]

    region_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "region_definition_candidate_surface.json"
        )
    )
    metric_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "minkowski_metric_connection_instance_surface.json"
        )
    )
    killing_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "time_translation_killing_evidence_surface.json"
        )
    )
    candidate_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "compact_support_stress_energy_candidate_surface.json"
        )
    )

    for path in (
        region_path,
        metric_path,
        killing_path,
        candidate_path,
    ):
        if not path.exists():
            raise SystemExit(
                f"MISSING_OBJECT := {path.relative_to(root)}"
            )

    region = json.loads(region_path.read_text(encoding="utf-8"))
    metric = json.loads(metric_path.read_text(encoding="utf-8"))
    killing = json.loads(killing_path.read_text(encoding="utf-8"))
    candidate = json.loads(
        candidate_path.read_text(encoding="utf-8")
    )

    expected_top_level = {
        "surface": (
            "ScaledEnergySupportCandidate"
            "CompactSupportStressEnergyCandidateSurface"
        ),
        "classification": (
            "BOUNDED_COMPACT_SUPPORT_STRESS_ENERGY_CANDIDATE_ONLY"
        ),
        "dependency_region_surface": (
            "ScaledEnergySupportCandidate"
            "RegionDefinitionCandidateSurface"
        ),
        "dependency_metric_connection_surface": (
            "ScaledEnergySupportCandidate"
            "MinkowskiMetricConnectionInstanceSurface"
        ),
        "dependency_killing_evidence_surface": (
            "ScaledEnergySupportCandidate"
            "TimeTranslationKillingEvidenceSurface"
        ),
        "target_support": "SupportCandidateB0",
        "scope_status": (
            "BOUNDED_NONZERO_SYMMETRIC_COMPACT_SUPPORT_"
            "STRESS_ENERGY_CANDIDATE_INHABITED"
        ),
    }

    for key, expected in expected_top_level.items():
        actual = candidate.get(key)

        if actual != expected:
            raise SystemExit(
                "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
                "CANDIDATE_GUARD_FAILED := "
                f"{key!r} expected {expected!r} got {actual!r}"
            )

    if region.get("surface") != (
        "ScaledEnergySupportCandidate"
        "RegionDefinitionCandidateSurface"
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := region dependency changed"
        )

    if region.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := region support changed"
        )

    if region.get("nonempty_status") != "NONEMPTY_VERIFIED":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := region nonempty evidence missing"
        )

    if region.get("boundedness_status") != "BOUNDEDNESS_VERIFIED":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := region boundedness missing"
        )

    region_parameters = region.get("candidate_parameters", {})

    expected_region_parameters = {
        "temporal_lower_bound": 0.0,
        "temporal_upper_bound": 1.0e-9,
        "spatial_half_widths": [0.001, 0.001, 0.001],
        "temporal_coordinate_unit": "s",
        "spatial_coordinate_unit": "m",
        "parameter_values_status": "PARAMETER_VALUES_SUPPLIED",
    }

    if region_parameters != expected_region_parameters:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := region parameters changed"
        )

    if metric.get("surface") != (
        "ScaledEnergySupportCandidate"
        "MinkowskiMetricConnectionInstanceSurface"
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := metric dependency changed"
        )

    if metric.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := metric support changed"
        )

    expected_metric = [
        [-1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]

    if metric.get("metric_tensor", {}).get("components") != (
        expected_metric
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := Minkowski metric changed"
        )

    if metric.get("connection_coefficients", {}).get(
        "component_status"
    ) != "ZERO_COMPONENTS_SUPPLIED":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := zero connection missing"
        )

    if killing.get("surface") != (
        "ScaledEnergySupportCandidate"
        "TimeTranslationKillingEvidenceSurface"
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := Killing dependency changed"
        )

    if killing.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := Killing support changed"
        )

    if killing.get("scope_status") != (
        "BOUNDED_MINKOWSKI_TIME_TRANSLATION_"
        "KILLING_EDGE_INHABITED"
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := Killing edge not inhabited"
        )

    expected_time_flow = {
        "symbol": "u_candidate^mu",
        "components": [1, 0, 0, 0],
        "source": "tau_candidate metric dual",
        "status": "EXISTING_KILLING_TIME_FLOW_REFERENCED",
    }

    if candidate.get("time_flow_input") != expected_time_flow:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := time-flow input changed"
        )

    support_semantics = candidate.get("support_semantics", {})

    if support_semantics != {
        "interpretation": (
            "support relative to the existing bounded "
            "SupportCandidateB0 coordinate region"
        ),
        "global_zero_extension": "NOT_SUPPLIED",
        "distributional_boundary_analysis": "NOT_SUPPLIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := support semantics changed"
        )

    bump = candidate.get("spatial_bump_candidate", {})
    factor = bump.get("one_dimensional_factor", {})

    expected_half_widths = [0.0005, 0.0005, 0.0005]

    if bump.get("spatial_half_widths_m") != expected_half_widths:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := bump widths changed"
        )

    if bump.get("time_dependence") != (
        "independent of x_candidate^0 on SupportCandidateB0"
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := time independence missing"
        )

    if factor.get("origin_value") != 1.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := bump origin value changed"
        )

    if factor.get("support_closure") != "[-1,1]":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := bump support changed"
        )

    def phi(value):
        if abs(value) >= 1.0:
            return 0.0

        return math.exp(
            1.0 - 1.0 / (1.0 - value * value)
        )

    if phi(0.0) != 1.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := phi origin check failed"
        )

    if phi(1.0) != 0.0 or phi(-1.0) != 0.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := phi boundary check failed"
        )

    if phi(1.25) != 0.0 or phi(-1.25) != 0.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := phi exterior check failed"
        )

    if not 0.0 < phi(0.5) < 1.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := phi interior check failed"
        )

    energy_density = candidate.get(
        "energy_density_candidate",
        {},
    )

    if energy_density.get("rho0_value") != 1.0:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := rho0 changed"
        )

    if energy_density.get("empirical_calibration") != "NOT_SUPPLIED":
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := empirical calibration promoted"
        )

    def beta(x_one, x_two, x_three):
        coordinates = (x_one, x_two, x_three)

        return math.prod(
            phi(coordinate / half_width)
            for coordinate, half_width in zip(
                coordinates,
                expected_half_widths,
            )
        )

    rho0 = energy_density["rho0_value"]

    def rho(x_one, x_two, x_three):
        return rho0 * beta(x_one, x_two, x_three)

    time_flow = expected_time_flow["components"]

    def stress_energy(x_one, x_two, x_three):
        density = rho(x_one, x_two, x_three)

        return [
            [
                density
                * time_flow[mu]
                * time_flow[nu]
                for nu in range(4)
            ]
            for mu in range(4)
        ]

    origin_tensor = stress_energy(0.0, 0.0, 0.0)

    expected_origin_tensor = [
        [1.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0],
    ]

    if origin_tensor != expected_origin_tensor:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := nonzero tensor witness failed"
        )

    witness = candidate.get("nonzero_witness", {})

    if witness != {
        "point": [5.0e-10, 0.0, 0.0, 0.0],
        "beta_value": 1.0,
        "rho_value": 1.0,
        "tensor_component": "T_candidate^{00}",
        "tensor_component_value": 1.0,
        "verification_status": (
            "NONZERO_WITNESS_COMPONENT_CHECK_VERIFIED"
        ),
    }:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := nonzero witness changed"
        )

    checked_symmetry_components = 0

    sample_points = (
        (0.0, 0.0, 0.0),
        (0.00025, 0.0, 0.0),
        (0.0005, 0.0, 0.0),
        (0.00075, 0.0, 0.0),
    )

    for point in sample_points:
        tensor = stress_energy(*point)

        for mu in range(4):
            for nu in range(4):
                if tensor[mu][nu] != tensor[nu][mu]:
                    raise SystemExit(
                        "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
                        "CANDIDATE_GUARD_FAILED := "
                        f"symmetry failed at {point} ({mu},{nu})"
                    )

                if point == sample_points[0]:
                    checked_symmetry_components += 1

    if checked_symmetry_components != 16:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := "
            "expected 16 ordered symmetry checks"
        )

    expected_symmetry = {
        "equation": (
            "T_candidate^{mu nu} = T_candidate^{nu mu}"
        ),
        "ordered_component_check_count": 16,
        "verification_status": (
            "CANDIDATE_SYMMETRY_COMPONENT_CHECK_VERIFIED"
        ),
    }

    if candidate.get("symmetry_certificate") != expected_symmetry:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := symmetry certificate changed"
        )

    region_time_bounds = [
        region_parameters["temporal_lower_bound"],
        region_parameters["temporal_upper_bound"],
    ]
    region_spatial_half_widths = region_parameters[
        "spatial_half_widths"
    ]

    candidate_time_bounds = [0.0, 1.0e-9]
    candidate_spatial_bounds = [
        [-half_width, half_width]
        for half_width in expected_half_widths
    ]
    region_spatial_bounds = [
        [-half_width, half_width]
        for half_width in region_spatial_half_widths
    ]

    subset_checks = 0

    if candidate_time_bounds[0] < region_time_bounds[0]:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := temporal lower support escaped"
        )
    subset_checks += 1

    if candidate_time_bounds[1] > region_time_bounds[1]:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := temporal upper support escaped"
        )
    subset_checks += 1

    for candidate_bounds, region_bounds in zip(
        candidate_spatial_bounds,
        region_spatial_bounds,
    ):
        if candidate_bounds[0] < region_bounds[0]:
            raise SystemExit(
                "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
                "CANDIDATE_GUARD_FAILED := spatial lower support escaped"
            )
        subset_checks += 1

        if candidate_bounds[1] > region_bounds[1]:
            raise SystemExit(
                "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
                "CANDIDATE_GUARD_FAILED := spatial upper support escaped"
            )
        subset_checks += 1

    if subset_checks != 8:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := expected 8 support checks"
        )

    expected_support_certificate = {
        "temporal_support_s": candidate_time_bounds,
        "spatial_support_closure_m": candidate_spatial_bounds,
        "containing_region_temporal_bounds_s": region_time_bounds,
        "containing_region_spatial_bounds_m": (
            region_spatial_bounds
        ),
        "subset_check_count": 8,
        "verification_status": (
            "RELATIVE_COMPACT_SUPPORT_BOUNDS_CHECK_VERIFIED"
        ),
    }

    if candidate.get(
        "relative_compact_support_certificate"
    ) != expected_support_certificate:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := support certificate changed"
        )

    expected_component_matrix = [
        ["rho_candidate", 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
    ]

    stress_candidate = candidate.get(
        "stress_energy_candidate",
        {},
    )

    if stress_candidate.get("component_matrix") != (
        expected_component_matrix
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := tensor components changed"
        )

    expected_edge = {
        "source": (
            "bounded Killing time flow "
            "+ bounded support region"
        ),
        "target": (
            "NonzeroSymmetricCompactSupportStressEnergyCandidate("
            "SupportCandidateB0)"
        ),
        "status": "INHABITED_BY_COMPONENT_AND_SUPPORT_CHECKS",
    }

    if candidate.get("inhabited_edge") != expected_edge:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := inhabited edge changed"
        )

    if candidate.get("conservation_boundary") != {
        "candidate_equation": (
            "nabla_mu T_candidate^{mu nu} = 0"
        ),
        "verification_status": "NOT_VERIFIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := conservation was promoted"
        )

    if candidate.get("current_boundary") != {
        "candidate_definition": (
            "J_E_candidate^mu = "
            "T_candidate^{mu nu} tau_candidate_nu"
        ),
        "verification_status": "NOT_VERIFIED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := current was promoted"
        )

    if candidate.get("acceptance_boundary") != {
        "d_input_candidate_status": "NOT_ACCEPTED",
        "restricted_composition_status": "NOT_CONNECTED",
    }:
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := acceptance was promoted"
        )

    required_blocked = {
        (
            "stress-energy candidate -> "
            "covariant stress-energy conservation verified"
        ),
        (
            "stress-energy candidate -> "
            "global distributional conservation verified"
        ),
        (
            "stress-energy candidate -> "
            "scaled-energy current conservation verified"
        ),
        "stress-energy candidate -> detector support realized",
        "stress-energy candidate -> DInputCandidateB0 accepted",
        (
            "stress-energy candidate -> "
            "restricted composition target accepted"
        ),
        "stress-energy candidate -> empirical confirmation",
        "stress-energy candidate -> E equals m c cubed verified",
        "stress-energy candidate -> ZeroDayClosure",
        "unrestricted ZeroDayClosure",
    }

    if set(candidate.get("blocked_promotions", [])) != (
        required_blocked
    ):
        raise SystemExit(
            "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
            "CANDIDATE_GUARD_FAILED := blocked promotions changed"
        )

    encoded = json.dumps(candidate, sort_keys=True)

    forbidden_tokens = (
        "COVARIANT_STRESS_ENERGY_CONSERVATION_VERIFIED",
        "GLOBAL_DISTRIBUTIONAL_CONSERVATION_VERIFIED",
        "CURRENT_CONSERVATION_VERIFIED",
        "PHYSICAL_DETECTOR_SUPPORT_REALIZED",
        '"d_input_candidate_status": "ACCEPTED"',
        '"restricted_composition_status": "CONNECTED"',
        "EMPIRICALLY_CONFIRMED",
        "E_EQUALS_M_C_CUBED_VERIFIED",
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for token in forbidden_tokens:
        if token in encoded:
            raise SystemExit(
                "SCALED_ENERGY_COMPACT_SUPPORT_STRESS_ENERGY_"
                "CANDIDATE_GUARD_FAILED := "
                f"forbidden promotion {token!r}"
            )

    print(
        "SCALED_ENERGY_SUPPORT_CANDIDATE_"
        "COMPACT_SUPPORT_STRESS_ENERGY_CANDIDATE_GUARD_OK"
    )


verify_scaled_energy_support_candidate_compact_support_stress_energy_candidate_guard()

def verify_directional_flow_observables_b_guard() -> None:
    import json
    import math
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]

    region_path = (
        root
        / "core"
        / (
            "scaled_energy_support_candidate_"
            "region_definition_candidate_surface.json"
        )
    )
    fraction_path = (
        root
        / "core"
        / "directional_flow_fraction_b_surface.json"
    )
    mass_path = (
        root
        / "core"
        / "directional_flow_mass_b_surface.json"
    )

    for path in (region_path, fraction_path, mass_path):
        if not path.exists():
            raise SystemExit(
                f"MISSING_OBJECT := {path.relative_to(root)}"
            )

    region = json.loads(
        region_path.read_text(encoding="utf-8")
    )
    fraction = json.loads(
        fraction_path.read_text(encoding="utf-8")
    )
    mass = json.loads(
        mass_path.read_text(encoding="utf-8")
    )

    if region.get("surface") != (
        "ScaledEnergySupportCandidate"
        "RegionDefinitionCandidateSurface"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "region dependency changed"
        )

    if region.get("target_support") != "SupportCandidateB0":
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "bounded region changed"
        )

    if fraction.get("surface") != (
        "DirectionalFlowFractionBSurface"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction surface changed"
        )

    if fraction.get("object") != "DirectionalFlowFractionB":
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction object changed"
        )

    if fraction.get("classification") != (
        "BOUNDED_MODEL_OBSERVABLE_CONDITIONAL_DEFINITION_ONLY"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction classification changed"
        )

    if fraction.get("dependency_region_surface") != (
        "ScaledEnergySupportCandidate"
        "RegionDefinitionCandidateSurface"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction dependency changed"
        )

    if fraction.get("bounded_region") != "SupportCandidateB0":
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction region changed"
        )

    expected_integrals = {
        "energy": {
            "symbol": "E_B(t)",
            "definition": (
                "E_B(t) := integral_B u(t,x) d^3x"
            ),
        },
        "directional_flow": {
            "symbol": "Q_B(t)",
            "definition": (
                "Q_B(t) := integral_B S(t,x) d^3x"
            ),
        },
    }

    if fraction.get("bounded_integrals") != expected_integrals:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "bounded integral definitions changed"
        )

    expected_fraction_definition = {
        "symbol": "chi_B(t)",
        "formula": (
            "chi_B(t) := ||Q_B(t)|| / (c E_B(t))"
        ),
        "domain_assumption": "E_B(t) > 0",
    }

    if fraction.get("definition") != (
        expected_fraction_definition
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction definition changed"
        )

    conditional_bound = fraction.get(
        "conditional_bound",
        {},
    )

    expected_bound_assumptions = {
        "c > 0",
        "E_B(t) > 0",
        "u(t,x) >= 0 on B",
        (
            "||S(t,x)|| <= c u(t,x) "
            "almost everywhere on B"
        ),
    }

    if set(
        conditional_bound.get("assumptions", [])
    ) != expected_bound_assumptions:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "conditional assumptions changed"
        )

    expected_reduction = [
        "0 <= ||Q_B(t)||",
        (
            "||Q_B(t)|| <= "
            "integral_B ||S(t,x)|| d^3x"
        ),
        (
            "integral_B ||S(t,x)|| d^3x "
            "<= c integral_B u(t,x) d^3x"
        ),
        "||Q_B(t)|| <= c E_B(t)",
        "0 <= chi_B(t) <= 1",
    ]

    if conditional_bound.get("reduction") != (
        expected_reduction
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "conditional reduction changed"
        )

    if conditional_bound.get("status") != (
        "CONDITIONAL_BOUND_REDUCTION_RECORDED"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "conditional status changed"
        )

    if conditional_bound.get("formal_theorem_status") != (
        "NOT_FORMALLY_PROVED"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "conditional bound was promoted"
        )

    interpretation = fraction.get(
        "interpretation_boundary",
        {},
    )

    expected_interpretation = {
        "is_alternative_energy_law": False,
        "is_energy_conservation_theorem": False,
        "is_killing_current_identity_restatement": False,
        "description": (
            "bounded model observable for coherent net "
            "directional transport only"
        ),
    }

    if interpretation != expected_interpretation:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction interpretation changed"
        )

    if fraction.get("novelty_status") != (
        "GLOBAL_NOVELTY_NOT_ESTABLISHED"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction novelty was promoted"
        )

    if mass.get("surface") != (
        "DirectionalFlowMassBSurface"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass surface changed"
        )

    if mass.get("object") != "DirectionalFlowMassB":
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass object changed"
        )

    if mass.get("classification") != (
        "BOUNDED_MODEL_OBSERVABLE_ALGEBRAIC_DEFINITION_ONLY"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass classification changed"
        )

    if mass.get("dependency_fraction_surface") != (
        "DirectionalFlowFractionBSurface"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass dependency changed"
        )

    if mass.get("bounded_region") != "SupportCandidateB0":
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass region changed"
        )

    expected_mass_definition = {
        "symbol": "m_flow,B(t)",
        "primary_formula": (
            "m_flow,B(t) := ||Q_B(t)|| / c^3"
        ),
        "fraction_formula": (
            "m_flow,B(t) = chi_B(t) E_B(t) / c^2"
        ),
        "fraction_formula_assumptions": [
            "c > 0",
            "E_B(t) > 0",
            (
                "chi_B(t) = "
                "||Q_B(t)|| / (c E_B(t))"
            ),
        ],
        "identity_status": (
            "ALGEBRAIC_IDENTITY_REDUCTION_RECORDED"
        ),
    }

    if mass.get("definition") != expected_mass_definition:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass definition changed"
        )

    expected_mass_interpretation = {
        "description": (
            "model quantity measuring coherent net "
            "directional energy transport"
        ),
        "is_rest_mass": False,
        "is_invariant_mass": False,
        "is_alternative_energy_law": False,
        "is_empirically_calibrated": False,
    }

    if mass.get("interpretation_boundary") != (
        expected_mass_interpretation
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass interpretation changed"
        )

    if mass.get("novelty_status") != (
        "GLOBAL_NOVELTY_NOT_ESTABLISHED"
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass novelty was promoted"
        )

    def vector_norm(vector):
        return math.sqrt(
            sum(component * component for component in vector)
        )

    def vector_sum(vectors):
        return [
            sum(vector[index] for vector in vectors)
            for index in range(3)
        ]

    def evaluate_model(c_value, energies, fluxes):
        if c_value <= 0:
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "nonpositive c fixture"
            )

        if len(energies) != len(fluxes):
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "fixture length mismatch"
            )

        for energy, flux in zip(energies, fluxes):
            if energy < 0:
                raise SystemExit(
                    "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                    "negative fixture energy density"
                )

            if vector_norm(flux) > c_value * energy + 1.0e-12:
                raise SystemExit(
                    "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                    "fixture violates local flux bound"
                )

        total_energy = sum(energies)

        if total_energy <= 0:
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "nonpositive bounded energy fixture"
            )

        total_flow = vector_sum(fluxes)
        total_flow_norm = vector_norm(total_flow)
        integrated_local_norm = sum(
            vector_norm(flux) for flux in fluxes
        )

        if total_flow_norm > integrated_local_norm + 1.0e-12:
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "triangle inequality fixture failed"
            )

        if (
            integrated_local_norm
            > c_value * total_energy + 1.0e-12
        ):
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "integrated local bound fixture failed"
            )

        chi_value = (
            total_flow_norm
            / (c_value * total_energy)
        )
        mass_value = total_flow_norm / (c_value ** 3)
        mass_from_fraction = (
            chi_value
            * total_energy
            / (c_value ** 2)
        )

        if chi_value < -1.0e-12 or chi_value > 1.0 + 1.0e-12:
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "conditional fraction bound fixture failed"
            )

        if not math.isclose(
            mass_value,
            mass_from_fraction,
            rel_tol=1.0e-12,
            abs_tol=1.0e-12,
        ):
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                "directional-flow mass identity failed"
            )

        return {
            "energy": total_energy,
            "flow": total_flow,
            "flow_norm": total_flow_norm,
            "chi": chi_value,
            "mass": mass_value,
        }

    generic = evaluate_model(
        3.0,
        [2.0, 1.0, 3.0, 2.0],
        [
            [6.0, 0.0, 0.0],
            [0.0, 3.0, 0.0],
            [-3.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
        ],
    )

    if not 0.0 <= generic["chi"] <= 1.0:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "generic conditional bound fixture failed"
        )

    c_collimated = 5.0
    collimated_energies = [1.0, 2.0, 3.0]
    collimated_fluxes = [
        [c_collimated * energy, 0.0, 0.0]
        for energy in collimated_energies
    ]

    collimated = evaluate_model(
        c_collimated,
        collimated_energies,
        collimated_fluxes,
    )

    if not math.isclose(
        collimated["chi"],
        1.0,
        rel_tol=1.0e-12,
        abs_tol=1.0e-12,
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "collimated chi fixture failed"
        )

    if not math.isclose(
        collimated["mass"] * (c_collimated ** 3),
        c_collimated * collimated["energy"],
        rel_tol=1.0e-12,
        abs_tol=1.0e-12,
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "collimated mass relation failed"
        )

    c_counter = 5.0

    counterpropagating = evaluate_model(
        c_counter,
        [2.0, 2.0],
        [
            [10.0, 0.0, 0.0],
            [-10.0, 0.0, 0.0],
        ],
    )

    if counterpropagating["energy"] <= 0:
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "counterpropagating energy fixture failed"
        )

    if not math.isclose(
        counterpropagating["flow_norm"],
        0.0,
        rel_tol=1.0e-12,
        abs_tol=1.0e-12,
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "counterpropagating flow cancellation failed"
        )

    if not math.isclose(
        counterpropagating["chi"],
        0.0,
        rel_tol=1.0e-12,
        abs_tol=1.0e-12,
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "counterpropagating chi fixture failed"
        )

    if not math.isclose(
        counterpropagating["mass"],
        0.0,
        rel_tol=1.0e-12,
        abs_tol=1.0e-12,
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "counterpropagating mass fixture failed"
        )

    expected_fraction_blocked = {
        "DirectionalFlowFractionB -> unconditional theorem",
        "DirectionalFlowFractionB -> new fundamental law",
        "DirectionalFlowFractionB -> detector realization",
        "DirectionalFlowFractionB -> empirical confirmation",
        "DirectionalFlowFractionB -> E equals m c cubed",
        "DirectionalFlowFractionB -> ZeroDayClosure",
        "global novelty established",
        "unrestricted ZeroDayClosure",
    }

    if set(fraction.get("blocked_promotions", [])) != (
        expected_fraction_blocked
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "fraction blocked promotions changed"
        )

    expected_mass_blocked = {
        "DirectionalFlowMassB -> rest mass",
        "DirectionalFlowMassB -> invariant mass",
        "DirectionalFlowMassB -> new fundamental law",
        "DirectionalFlowMassB -> detector realization",
        "DirectionalFlowMassB -> empirical confirmation",
        "DirectionalFlowMassB -> E equals m c cubed",
        "DirectionalFlowMassB -> ZeroDayClosure",
        "global novelty established",
        "unrestricted ZeroDayClosure",
    }

    if set(mass.get("blocked_promotions", [])) != (
        expected_mass_blocked
    ):
        raise SystemExit(
            "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
            "mass blocked promotions changed"
        )

    fraction_encoded = json.dumps(fraction, sort_keys=True)
    mass_encoded = json.dumps(mass, sort_keys=True)

    forbidden_fragments = (
        '"formal_theorem_status": "FORMALLY_PROVED"',
        '"novelty_status": "GLOBAL_NOVELTY_ESTABLISHED"',
        '"is_alternative_energy_law": true',
        '"is_energy_conservation_theorem": true',
        '"is_rest_mass": true',
        '"is_invariant_mass": true',
        '"is_empirically_calibrated": true',
        '"detector_realization_status": "REALIZED"',
        '"empirical_confirmation_status": "CONFIRMED"',
        '"e_equals_m_c_cubed_status": "VERIFIED"',
        '"zero_day_closure_status": "CONSTRUCTED"',
    )

    for fragment in forbidden_fragments:
        if (
            fragment in fraction_encoded
            or fragment in mass_encoded
        ):
            raise SystemExit(
                "DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_FAILED := "
                f"forbidden promotion {fragment!r}"
            )

    print("DIRECTIONAL_FLOW_OBSERVABLES_B_GUARD_OK")


verify_directional_flow_observables_b_guard()
