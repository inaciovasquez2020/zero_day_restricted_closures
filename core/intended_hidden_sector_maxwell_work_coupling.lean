import intended_hidden_sector_energy_budget_test
import Chronos.Frontier.DirectionalFlowFractionBConditionalIntegralBound

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
A hidden-sector coupling to a smooth Maxwell evolution.

The hidden closure response is electromagnetic work performed by the current
on the electric field over a finite rectangular spacetime region.

No detector response profile, detector direction, or direct measured-flow
identity appears in this structure.
-/
structure HiddenSectorMaxwellWorkCoupling
    {Payload : Type u}
    (χDM initialAmplitude totalBudget : Nat)
    (state : IntendedUnrestrictedState Payload)
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (initialTime finalTime : ℝ) where
  conservedTrajectory :
    ConservedHiddenSectorThroughClosure
      χDM
      initialAmplitude
      totalBudget
      state

  maxwellField :
    SmoothMaxwellField3

  electricCoefficientNonnegative :
    0 ≤ ε₀

  magneticPermeabilityPositive :
    0 < μ₀

  evolution :
    ∀ (time : ℝ) (position : MaxwellVector3),
      UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        maxwellField
        (time, position)

  hidden_sector_work :
    -(∫ time in initialTime..finalTime,
        ∫ position in Set.Icc domain.lower domain.upper,
          maxwellDot3
            (maxwellField.current (time, position))
            (maxwellField.electric (time, position))) =
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ)

/--
The smooth Maxwell evolution converts hidden-sector work into the exact sum
of stored electromagnetic-energy change and outward Poynting flux.
-/
theorem hiddenSectorMaxwellWork_energy_flux_identity
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
      maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          finalTime -
        maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          initialTime +
        (∫ time in initialTime..finalTime,
          maxwellRectangularBoundaryFlux3
            domain
            (maxwellPoyntingSpatialSlice3
              μ₀
              coupling.maxwellField
              time)) := by
  have hBalance :=
    maxwellIntegratedRectangularPoyntingBalance3_of_smooth_evolution
      ε₀
      μ₀
      coupling.maxwellField
      domain
      initialTime
      finalTime
      coupling.evolution

  calc
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
        -(∫ time in initialTime..finalTime,
            ∫ position in Set.Icc domain.lower domain.upper,
              maxwellDot3
                (coupling.maxwellField.current
                  (time, position))
                (coupling.maxwellField.electric
                  (time, position))) :=
      coupling.hidden_sector_work.symm
    _ =
        maxwellTotalElectromagneticEnergy3
            ε₀
            μ₀
            coupling.maxwellField
            domain
            finalTime -
          maxwellTotalElectromagneticEnergy3
            ε₀
            μ₀
            coupling.maxwellField
            domain
            initialTime +
          (∫ time in initialTime..finalTime,
            maxwellRectangularBoundaryFlux3
              domain
              (maxwellPoyntingSpatialSlice3
                μ₀
                coupling.maxwellField
                time)) :=
      hBalance.symm

/--
Initial stored electromagnetic energy is nonnegative.
-/
theorem hiddenSectorMaxwellWork_initial_energy_nonnegative
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    0 ≤
      maxwellTotalElectromagneticEnergy3
        ε₀
        μ₀
        coupling.maxwellField
        domain
        initialTime := by
  exact
    maxwellTotalElectromagneticEnergy3_nonneg
      ε₀
      μ₀
      coupling.maxwellField
      domain
      initialTime
      coupling.electricCoefficientNonnegative
      coupling.magneticPermeabilityPositive

/--
With zero integrated outward boundary flux, the closure response equals the
increase in stored electromagnetic energy.
-/
theorem hiddenSectorMaxwellWork_isolated_energy_increase
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
      maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          finalTime -
        maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          initialTime := by
  have hIdentity :=
    hiddenSectorMaxwellWork_energy_flux_identity
      coupling

  rw [hIntegratedBoundaryFluxZero, add_zero] at hIdentity
  exact hIdentity

/--
For an isolated coupling, final electromagnetic energy is at least the hidden
closure response.
-/
theorem hiddenSectorMaxwellWork_closureAmplitude_le_finalEnergy
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) ≤
      maxwellTotalElectromagneticEnergy3
        ε₀
        μ₀
        coupling.maxwellField
        domain
        finalTime := by
  have hIncrease :=
    hiddenSectorMaxwellWork_isolated_energy_increase
      coupling
      hIntegratedBoundaryFluxZero

  have hInitialNonnegative :=
    hiddenSectorMaxwellWork_initial_energy_nonnegative
      coupling

  linarith

/--
The Maxwell response remains subject to the original finite hidden-sector
budget.
-/
theorem hiddenSectorMaxwellWork_combined_budget_and_energy_bound
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) ≤
        maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          finalTime ∧
      darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state ≤
        totalBudget := by
  exact
    ⟨hiddenSectorMaxwellWork_closureAmplitude_le_finalEnergy
        coupling
        hIntegratedBoundaryFluxZero,
      conservedHiddenSector_closureAmplitude_le_budget
        coupling.conservedTrajectory⟩

/--
An isolated rank-255 unit-coupling Maxwell realization requires final
electromagnetic energy of at least `2^255`.
-/
theorem darkMatterUnitCoupling_maxwell_finalEnergy_requirement
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    ((2 ^ 255 : Nat) : ℝ) ≤
      maxwellTotalElectromagneticEnergy3
        ε₀
        μ₀
        coupling.maxwellField
        domain
        finalTime := by
  have hBound :=
    hiddenSectorMaxwellWork_closureAmplitude_le_finalEnergy
      coupling
      hIntegratedBoundaryFluxZero

  rw [darkMatterUnitCoupling_exact_explosion] at hBound
  exact hBound

/--
The same isolated response requires final electromagnetic energy of at least
`10^70`.
-/
theorem darkMatterUnitCoupling_maxwell_testThreshold_requirement
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    ((10 ^ 70 : Nat) : ℝ) ≤
      maxwellTotalElectromagneticEnergy3
        ε₀
        μ₀
        coupling.maxwellField
        domain
        finalTime := by
  have hPowerRequirement :=
    darkMatterUnitCoupling_maxwell_finalEnergy_requirement
      coupling
      hIntegratedBoundaryFluxZero

  have hThresholdNatural :
      10 ^ 70 ≤ 2 ^ 255 := by
    native_decide

  have hThresholdReal :
      ((10 ^ 70 : Nat) : ℝ) ≤
        ((2 ^ 255 : Nat) : ℝ) := by
    exact_mod_cast hThresholdNatural

  exact
    le_trans
      hThresholdReal
      hPowerRequirement

/--
Final electromagnetic energy below `10^70` contradicts an isolated rank-255
unit-coupling Maxwell response.
-/
theorem darkMatterUnitCoupling_no_subthreshold_isolatedMaxwellResponse
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain
        initialTime
        finalTime)
    (hIntegratedBoundaryFluxZero :
      (∫ time in initialTime..finalTime,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    ¬
      maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          finalTime <
        ((10 ^ 70 : Nat) : ℝ) := by
  intro hSubthreshold

  have hRequired :=
    darkMatterUnitCoupling_maxwell_testThreshold_requirement
      coupling
      hIntegratedBoundaryFluxZero

  linarith

/--
The rank-255 unit-coupling work response cannot be produced by an identically
zero electromagnetic current.

This proof uses the repository's existing source-free integrated Maxwell
balance rather than simplifying nested spacetime integrals.
-/
theorem darkMatterUnitCoupling_maxwell_current_not_identically_zero
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorMaxwellWorkCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    ¬
      (∀ point : MaxwellSpacetime3,
        coupling.maxwellField.current point = 0) := by
  intro hCurrentZero

  have hSourceFreeBalance :
      maxwellTotalElectromagneticEnergy3
            ε₀
            μ₀
            coupling.maxwellField
            domain
            finalTime -
          maxwellTotalElectromagneticEnergy3
            ε₀
            μ₀
            coupling.maxwellField
            domain
            initialTime +
          (∫ time in initialTime..finalTime,
            maxwellRectangularBoundaryFlux3
              domain
              (maxwellPoyntingSpatialSlice3
                μ₀
                coupling.maxwellField
                time)) =
        0 :=
    maxwellIntegratedRectangularPoyntingBalance3_sourceFree_of_smooth_evolution
      ε₀
      μ₀
      coupling.maxwellField
      domain
      initialTime
      finalTime
      coupling.evolution
      hCurrentZero

  have hAmplitudeZero :
      (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) =
        0 :=
    (hiddenSectorMaxwellWork_energy_flux_identity
      coupling).trans hSourceFreeBalance

  have hAmplitudePositive :
      0 <
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) := by
    rw [darkMatterUnitCoupling_exact_explosion]
    positivity

  exact
    (ne_of_gt hAmplitudePositive)
      hAmplitudeZero

end ZeroDayRestrictedClosures
