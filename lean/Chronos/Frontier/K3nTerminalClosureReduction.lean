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
A machine-checkable terminal reduction surface for the K3^[n] restricted
closure argument.

All geometric, monodromy, quotient-classification, and scalar-vanishing
content enters through explicit hypotheses below.  Inventory nonemptiness is
not imposed here: when an independently actual required class exists, the
coverage bridge above derives nonemptiness from that class.  This file proves
only the logical composition of supplied inputs; it does not construct any of
them for a concrete K3^[n]-type manifold.
-/
structure K3nTerminalClosureHypotheses
    (RequiredIndex : Type u)
    (DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop)
    (ZeroDayClosure : Prop) where
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
  closureFromRequiredSubsetSH :
    (∀ i, InSH i) → ZeroDayClosure

theorem k3n_terminal_hypotheses_imply_required_subset_SH
    {RequiredIndex : Type u}
    {DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop}
    {ZeroDayClosure : Prop}
    (h : K3nTerminalClosureHypotheses
      RequiredIndex
      DegreeFour
      InSH
      FiniteOrbitQuotient
      ScalarObstructionVanishes
      ZeroDayClosure) :
    ∀ i, InSH i := by
  intro i
  by_cases hDegreeFour : DegreeFour i
  · exact h.finiteOrbitScalarCriterion
      i
      hDegreeFour
      (h.degreeFourFiniteOrbit i hDegreeFour)
      (h.degreeFourScalarVanishes i hDegreeFour)
  · exact h.nonDegreeFourInSH i hDegreeFour

theorem k3n_terminal_hypotheses_imply_zero_day_closure
    {RequiredIndex : Type u}
    {DegreeFour InSH FiniteOrbitQuotient ScalarObstructionVanishes : RequiredIndex → Prop}
    {ZeroDayClosure : Prop}
    (h : K3nTerminalClosureHypotheses
      RequiredIndex
      DegreeFour
      InSH
      FiniteOrbitQuotient
      ScalarObstructionVanishes
      ZeroDayClosure) :
    ZeroDayClosure := by
  apply h.closureFromRequiredSubsetSH
  exact k3n_terminal_hypotheses_imply_required_subset_SH h

/-
BOUNDARY:
This module proves no unconditional `ZeroDayClosure` theorem.  In particular,
it does not define an independent K3^[n] actual-requirement predicate, prove
that actual required classes are covered by the finite inventory, construct
any concrete required-class inventory element, prove monodromy stability,
classify concrete quotient orbits, prove that a degree-four required-class
index exists, or prove vanishing of a concrete c2/2 scalar obstruction.  Those
remain explicit inputs.
-/

end Frontier
end Chronos
