namespace Chronos
namespace Frontier

universe u

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
A machine-checkable terminal reduction surface for the K3^[n] restricted
closure argument.

All geometric, monodromy, quotient-classification, and scalar-vanishing
content enters through explicit hypotheses below.  This file proves only the
logical composition of those inputs; it does not assert that any input is
inhabited for a concrete K3^[n]-type manifold.
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
it does not construct the required-class inventory, prove monodromy stability,
classify concrete quotient orbits, prove that the defect-witness type is
inhabited, or prove vanishing of a concrete c2/2 scalar obstruction.  Those
remain explicit inputs.
-/

end Frontier
end Chronos
