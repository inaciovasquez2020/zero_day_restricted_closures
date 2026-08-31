import core.intended_unrestricted_state_closure

namespace Chronos
namespace Frontier

universe u

/--
The repository's pseudo-formal K3^[n] defect-witness construction contains
exactly one substantive datum: a selected required-class index.  This wrapper
machine-checks that shape without asserting that the index type is inhabited.
-/
structure K3nDefectWitnessConstruction (RequiredIndex : Type u) where
  requiredIndex : RequiredIndex

theorem k3n_defect_witness_construction_nonempty_iff_required_index_nonempty
    {RequiredIndex : Type u} :
    Nonempty (K3nDefectWitnessConstruction RequiredIndex) ↔ Nonempty RequiredIndex := by
  constructor
  · rintro ⟨w⟩
    exact ⟨w.requiredIndex⟩
  · rintro ⟨i⟩
    exact ⟨⟨i⟩⟩

/--
A machine-checkable defect-extraction surface matching the repository's
pseudo-formal K3^[n] interface.  It does not assert that `Witness` is inhabited.
-/
structure K3nDegreeFourDefectExtraction
    (Witness RequiredIndex : Type u)
    (DegreeFour : RequiredIndex → Prop) where
  extractIndex : Witness → RequiredIndex
  extractDegreeFour : ∀ w, DegreeFour (extractIndex w)

theorem k3n_inhabited_defect_extraction_gives_degree_four_required_index
    {Witness RequiredIndex : Type u}
    {DegreeFour : RequiredIndex → Prop}
    (e : K3nDegreeFourDefectExtraction Witness RequiredIndex DegreeFour)
    (hWitness : Nonempty Witness) :
    ∃ i, DegreeFour i := by
  cases hWitness with
  | intro w =>
      exact ⟨e.extractIndex w, e.extractDegreeFour w⟩

def k3n_defect_witness_extracts_degree_four_required_subtype
    {Witness RequiredIndex : Type u}
    {DegreeFour : RequiredIndex → Prop}
    (e : K3nDegreeFourDefectExtraction Witness RequiredIndex DegreeFour)
    (w : Witness) :
    { i : RequiredIndex // DegreeFour i } :=
  ⟨e.extractIndex w, e.extractDegreeFour w⟩

/--
An independent actual-requirement predicate is deliberately kept separate
from the declared finite inventory.  Coverage is the missing bridge: every
actually required class must be represented by some inventory index.

This structure does not define which classes are actually required and does
not assert coverage for the repository's K3^[n] specialization.
-/
structure K3nActualRequiredCoverage
    (ActualClass RequiredIndex : Type u)
    (ActuallyRequired : ActualClass → Prop) where
  classOf : RequiredIndex → ActualClass
  cover : ∀ c, ActuallyRequired c → ∃ i, classOf i = c

theorem k3n_actual_requirement_and_coverage_give_nonempty_inventory
    {ActualClass RequiredIndex : Type u}
    {ActuallyRequired : ActualClass → Prop}
    (coverage : K3nActualRequiredCoverage ActualClass RequiredIndex ActuallyRequired)
    {c : ActualClass}
    (hc : ActuallyRequired c) :
    Nonempty RequiredIndex := by
  obtain ⟨i, _⟩ := coverage.cover c hc
  exact ⟨i⟩

theorem k3n_inventory_SH_plus_coverage_implies_actual_required_SH
    {ActualClass RequiredIndex : Type u}
    {ActuallyRequired InSH : ActualClass → Prop}
    (coverage : K3nActualRequiredCoverage ActualClass RequiredIndex ActuallyRequired)
    (hInventory : ∀ i, InSH (coverage.classOf i)) :
    ∀ c, ActuallyRequired c → InSH c := by
  intro c hc
  obtain ⟨i, hi⟩ := coverage.cover c hc
  rw [← hi]
  exact hInventory i

/--
The repository's concrete intended-state closure saturates only the encoded
`Fin 256` coordinate and preserves an arbitrary payload.  Consequently that
closure theorem cannot, by itself, force a semantic predicate on the payload:
whenever the predicate fails for one payload value, the implication from
intended-state closure to universal payload validity is false.

This blocks a vacuous K3^[n] specialization that would merely store Hodge data
as the payload of the generic intended state.
-/
theorem generic_intended_closure_does_not_force_payload_property
    {Payload : Type u}
    (P : Payload → Prop)
    (p : Payload)
    (hp : ¬ P p) :
    ¬ (ZeroDayRestrictedClosures.IntendedUnrestrictedStateClosure
          (Payload := Payload) →
        ∀ x, P x) := by
  intro h
  have hAll := h ZeroDayRestrictedClosures.intendedUnrestrictedStateClosure
  exact hp (hAll p)

/--
Machine-checkable geometric reduction hypotheses for the K3^[n] required-class
surface.  This structure stops exactly at `forall i, InSH i`; it deliberately
contains no `ZeroDayClosure` proposition and no closure implication.
-/
structure K3nRequiredSubsetSHHypotheses
    (RequiredIndex : Type u)
    (DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop) where
  nonDegreeFourInSH :
    ∀ i, ¬ DegreeFour i → InSH i
  degreeFourFiniteOrbit :
    ∀ i, DegreeFour i → FiniteOrbitQuotient i
  finiteOrbitScalarCriterion :
    ∀ i,
      DegreeFour i →
      FiniteOrbitQuotient i →
      ScalarObstructionVanishes i →
      InSH i
  degreeFourScalarVanishes :
    ∀ i, DegreeFour i → ScalarObstructionVanishes i

/--
The semantic bridge is intentionally separate from the geometric SH reduction.
For the current K3^[n] specialization this bridge remains an input: the
repository does not independently define the mathematical meaning of
`ZeroDayClosure` or derive this implication from that meaning.
-/
structure K3nSemanticClosureBridge
    (RequiredIndex : Type u)
    (InSH : RequiredIndex → Prop)
    (ZeroDayClosure : Prop) where
  closureFromRequiredSubsetSH :
    (∀ i, InSH i) → ZeroDayClosure

theorem k3n_required_subset_hypotheses_imply_required_subset_SH
    {RequiredIndex : Type u}
    {DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop}
    (h : K3nRequiredSubsetSHHypotheses
      RequiredIndex
      DegreeFour
      InSH
      FiniteOrbitQuotient
      ScalarObstructionVanishes) :
    ∀ i, InSH i := by
  intro i
  by_cases hDegreeFour : DegreeFour i
  · exact h.finiteOrbitScalarCriterion
      i
      hDegreeFour
      (h.degreeFourFiniteOrbit i hDegreeFour)
      (h.degreeFourScalarVanishes i hDegreeFour)
  · exact h.nonDegreeFourInSH i hDegreeFour

theorem k3n_required_subset_plus_semantic_bridge_imply_zero_day_closure
    {RequiredIndex : Type u}
    {DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop}
    {ZeroDayClosure : Prop}
    (hReduction : K3nRequiredSubsetSHHypotheses
      RequiredIndex
      DegreeFour
      InSH
      FiniteOrbitQuotient
      ScalarObstructionVanishes)
    (hBridge : K3nSemanticClosureBridge RequiredIndex InSH ZeroDayClosure) :
    ZeroDayClosure := by
  apply hBridge.closureFromRequiredSubsetSH
  exact k3n_required_subset_hypotheses_imply_required_subset_SH hReduction

/-
BOUNDARY:
This module proves no unconditional `ZeroDayClosure` theorem.  In particular,
it does not define an independent K3^[n] actual-requirement predicate, prove
that actual required classes are covered by the finite inventory, construct
any concrete required-class inventory element, prove monodromy stability,
classify concrete quotient orbits, prove that a degree-four required-class
index exists, prove vanishing of a concrete c2/2 scalar obstruction, define a
K3^[n]-specific semantic `ZeroDayClosure`, prove the separate semantic closure
bridge, or derive K3^[n] semantics from the generic payload-blind intended-state
closure.  Those remain explicit boundaries.
-/

end Frontier
end Chronos
