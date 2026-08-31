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

/--
Once the witness type is inhabited, the current defect-extraction interface
contains exactly the same existence content as a degree-four required index.
Thus the interface is not yet an independent geometric source for such an
index: a degree-four index can manufacture the extractor by a constant map,
and an inhabited extractor yields such an index.
-/
theorem k3n_nonempty_defect_extraction_iff_degree_four_required_index
    {Witness RequiredIndex : Type u}
    {DegreeFour : RequiredIndex → Prop}
    (hWitness : Nonempty Witness) :
    Nonempty (K3nDegreeFourDefectExtraction Witness RequiredIndex DegreeFour) ↔
      ∃ i, DegreeFour i := by
  constructor
  · rintro ⟨e⟩
    exact k3n_inhabited_defect_extraction_gives_degree_four_required_index e hWitness
  · rintro ⟨i, hi⟩
    exact ⟨
      { extractIndex := fun _ => i
        extractDegreeFour := fun _ => hi }
    ⟩

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

/--
Coverage alone does not create an actually required class, even when both the
actual-class type and the inventory-index type are inhabited.  With `Unit` on
both sides and an empty `ActuallyRequired` predicate, a total coverage map
exists vacuously while no actually required class exists.
-/
theorem k3n_coverage_does_not_create_actual_requirement :
    ∃ (ActuallyRequired : Unit → Prop),
      Nonempty (K3nActualRequiredCoverage Unit Unit ActuallyRequired) ∧
      ¬ ∃ c, ActuallyRequired c := by
  refine ⟨(fun _ => False), ?_, ?_⟩
  · exact ⟨
      { classOf := fun i => i
        cover := by
          intro c hc
          exact False.elim hc }
    ⟩
  · rintro ⟨c, hc⟩
    exact hc

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
The semantic bridge is intentionally stated over classes that are actually
required, not merely over entries of the declared inventory.  Therefore a
terminal closure proof must separately establish inventory coverage before the
geometric SH reduction can discharge this bridge.

For the current K3^[n] specialization this remains an input: the repository
does not independently define `ActuallyRequired`, define the mathematical
meaning of `ZeroDayClosure`, or derive this implication from those semantics.
-/
structure K3nActualSemanticClosureBridge
    (ActualClass : Type u)
    (ActuallyRequired InSH : ActualClass → Prop)
    (ZeroDayClosure : Prop) where
  closureFromActualRequiredSubsetSH :
    (∀ c, ActuallyRequired c → InSH c) → ZeroDayClosure

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

/--
Terminal closure now has to traverse the completeness bridge explicitly:
first prove every declared inventory class is in SH, then use coverage to move
that result to every actually required class, and only then invoke the semantic
closure bridge.  An incomplete inventory can no longer discharge this theorem
by itself.
-/
theorem k3n_reduction_plus_coverage_plus_semantic_bridge_imply_zero_day_closure
    {ActualClass RequiredIndex : Type u}
    {ActuallyRequired InSH : ActualClass → Prop}
    {DegreeFour FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop}
    {ZeroDayClosure : Prop}
    (coverage : K3nActualRequiredCoverage ActualClass RequiredIndex ActuallyRequired)
    (hReduction : K3nRequiredSubsetSHHypotheses
      RequiredIndex
      DegreeFour
      (fun i => InSH (coverage.classOf i))
      FiniteOrbitQuotient
      ScalarObstructionVanishes)
    (hBridge : K3nActualSemanticClosureBridge
      ActualClass
      ActuallyRequired
      InSH
      ZeroDayClosure) :
    ZeroDayClosure := by
  apply hBridge.closureFromActualRequiredSubsetSH
  apply k3n_inventory_SH_plus_coverage_implies_actual_required_SH coverage
  exact k3n_required_subset_hypotheses_imply_required_subset_SH hReduction

/--
The geometric SH reduction does not determine an arbitrary semantic closure,
even when the required-class inventory is inhabited.  The concrete index type
`Unit` has one element; all of its required classes satisfy `InSH`; and the
geometric reduction hypotheses hold.  Nevertheless there can be no semantic
bridge to the false proposition.
-/
theorem k3n_nonempty_geometric_reduction_does_not_force_arbitrary_semantic_closure :
    ∃ (DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes
        ActuallyRequired : Unit → Prop),
      K3nRequiredSubsetSHHypotheses
          Unit
          DegreeFour
          InSH
          FiniteOrbitQuotient
          ScalarObstructionVanishes ∧
      ¬ K3nActualSemanticClosureBridge Unit ActuallyRequired InSH False := by
  refine ⟨
    (fun _ => False),
    (fun _ => True),
    (fun _ => True),
    (fun _ => True),
    (fun _ => True),
    ?_,
    ?_
  ⟩
  · refine ⟨?_, ?_, ?_, ?_⟩
    · intro _ _
      exact True.intro
    · intro _ hDegreeFour
      exact False.elim hDegreeFour
    · intro _ _ _ _
      exact True.intro
    · intro _ hDegreeFour
      exact False.elim hDegreeFour
  · intro hBridge
    exact hBridge.closureFromActualRequiredSubsetSH (fun _ _ => True.intro)

/-
BOUNDARY:
This module proves no unconditional `ZeroDayClosure` theorem.  In particular,
it does not define an independent K3^[n] actual-requirement predicate, prove
that an actual required class exists, prove that actual required classes are
covered by the finite inventory, construct any concrete required-class
inventory element, prove monodromy stability, classify concrete quotient
orbits, prove that a degree-four required-class index exists, prove vanishing
of a concrete c2/2 scalar obstruction, define a K3^[n]-specific semantic
`ZeroDayClosure`, prove the actual-required semantic closure bridge, or derive
K3^[n] semantics from the generic payload-blind intended-state closure.  The
terminal theorem above now requires coverage explicitly, so proving SH for an
incomplete declared inventory cannot by itself reach `ZeroDayClosure`.  The
coverage countermodel above machine-checks that coverage itself cannot
manufacture an actual required class, even over inhabited class and index
types.  The inhabited-extractor equivalence machine-checks that the current
defect-extraction interface itself contributes no degree-four existence beyond
`exists i, DegreeFour i`; a genuine geometric source must supply more.  The
nonempty `Unit` model machine-checks that the geometric SH reduction alone does
not determine an arbitrary semantic closure.  Those semantic and geometric
inputs remain explicit boundaries.
-/

end Frontier
end Chronos
