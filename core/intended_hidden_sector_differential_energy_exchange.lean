import intended_hidden_sector_maxwell_work_coupling

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
The instantaneous electromagnetic work rate over the rectangular spatial
domain.
-/
noncomputable def hiddenSectorMaxwellPower
    (field : SmoothMaxwellField3)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    ℝ :=
  ∫ position in Set.Icc domain.lower domain.upper,
    maxwellDot3
      (field.current (time, position))
      (field.electric (time, position))

/--
A local differential hidden-energy exchange law.

The hidden reservoir loses energy through electromagnetic work. Its derivative
is the Maxwell work rate, and its endpoint loss is the discrete closure
response.

The previously assumed integrated field `hidden_sector_work` is absent.
-/
structure HiddenSectorDifferentialEnergyExchangeCoupling
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

  hiddenEnergy :
    ℝ → ℝ

  hidden_power_interval_integrable :
    IntervalIntegrable
      (hiddenSectorMaxwellPower maxwellField domain)
      volume
      initialTime
      finalTime

  hidden_energy_derivative :
    ∀ time ∈ Set.uIcc initialTime finalTime,
      HasDerivAt
        hiddenEnergy
        (hiddenSectorMaxwellPower
          maxwellField
          domain
          time)
        time

  hidden_energy_endpoint_drop :
    hiddenEnergy initialTime -
        hiddenEnergy finalTime =
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ)

/--
The differential exchange law integrates exactly to the former Maxwell-work
identity.
-/
theorem hiddenSectorDifferentialEnergyExchange_integrated_work
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    -(∫ time in initialTime..finalTime,
        hiddenSectorMaxwellPower
          coupling.maxwellField
          domain
          time) =
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
  have hFTC :
      (∫ time in initialTime..finalTime,
        hiddenSectorMaxwellPower
          coupling.maxwellField
          domain
          time) =
        coupling.hiddenEnergy finalTime -
          coupling.hiddenEnergy initialTime :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      coupling.hidden_energy_derivative
      coupling.hidden_power_interval_integrable

  calc
    -(∫ time in initialTime..finalTime,
        hiddenSectorMaxwellPower
          coupling.maxwellField
          domain
          time) =
        -(
          coupling.hiddenEnergy finalTime -
            coupling.hiddenEnergy initialTime
        ) := by
          rw [hFTC]
    _ =
        coupling.hiddenEnergy initialTime -
          coupling.hiddenEnergy finalTime := by
          ring
    _ =
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) :=
      coupling.hidden_energy_endpoint_drop

/--
The local differential exchange coupling constructs the earlier integrated
Maxwell-work coupling.
-/
noncomputable def
    HiddenSectorDifferentialEnergyExchangeCoupling.toMaxwellWorkCoupling
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    HiddenSectorMaxwellWorkCoupling
      χDM
      initialAmplitude
      totalBudget
      state
      ε₀
      μ₀
      domain
      initialTime
      finalTime where
  conservedTrajectory :=
    coupling.conservedTrajectory

  maxwellField :=
    coupling.maxwellField

  electricCoefficientNonnegative :=
    coupling.electricCoefficientNonnegative

  magneticPermeabilityPositive :=
    coupling.magneticPermeabilityPositive

  evolution :=
    coupling.evolution

  hidden_sector_work := by
    simpa [hiddenSectorMaxwellPower] using
      hiddenSectorDifferentialEnergyExchange_integrated_work
        coupling

/--
The endpoint loss of the hidden reservoir is bounded by the finite
hidden-sector budget.
-/
theorem hiddenSectorDifferentialEnergyExchange_endpointDrop_le_budget
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    coupling.hiddenEnergy initialTime -
        coupling.hiddenEnergy finalTime ≤
      (totalBudget : ℝ) := by
  have hNatural :
      darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state ≤
        totalBudget :=
    conservedHiddenSector_closureAmplitude_le_budget
      coupling.conservedTrajectory

  rw [coupling.hidden_energy_endpoint_drop]

  exact_mod_cast hNatural

/--
The local exchange equation inherits the exact Maxwell energy-and-flux
identity without assuming integrated work.
-/
theorem hiddenSectorDifferentialEnergyExchange_energy_flux_identity
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
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
  exact
    hiddenSectorMaxwellWork_energy_flux_identity
      coupling.toMaxwellWorkCoupling

/--
With zero integrated boundary flux, hidden-energy loss equals the increase in
stored electromagnetic energy.
-/
theorem hiddenSectorDifferentialEnergyExchange_isolated_transfer
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
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
    coupling.hiddenEnergy initialTime -
        coupling.hiddenEnergy finalTime =
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
  calc
    coupling.hiddenEnergy initialTime -
          coupling.hiddenEnergy finalTime =
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) :=
      coupling.hidden_energy_endpoint_drop
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
            initialTime :=
      hiddenSectorMaxwellWork_isolated_energy_increase
        coupling.toMaxwellWorkCoupling
        hIntegratedBoundaryFluxZero

/--
For the rank-255 unit-coupling state, the hidden reservoir loses exactly
`2^255`.
-/
theorem darkMatterUnitCoupling_hiddenEnergy_drop_exact
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain
        initialTime
        finalTime) :
    coupling.hiddenEnergy initialTime -
        coupling.hiddenEnergy finalTime =
      ((2 ^ 255 : Nat) : ℝ) := by
  rw [
    coupling.hidden_energy_endpoint_drop,
    darkMatterUnitCoupling_exact_explosion
  ]

/--
An isolated rank-255 unit-coupling differential exchange requires final
electromagnetic energy of at least `2^255`.
-/
theorem
    darkMatterUnitCoupling_differentialExchange_finalEnergy_requirement
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
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
  exact
    darkMatterUnitCoupling_maxwell_finalEnergy_requirement
      coupling.toMaxwellWorkCoupling
      hIntegratedBoundaryFluxZero

/--
The rank-255 unit-coupling differential exchange cannot have identically zero
electromagnetic current.
-/
theorem
    darkMatterUnitCoupling_differentialExchange_current_not_identically_zero
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {initialTime finalTime : ℝ}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorDifferentialEnergyExchangeCoupling
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
  exact
    darkMatterUnitCoupling_maxwell_current_not_identically_zero
      coupling.toMaxwellWorkCoupling

end ZeroDayRestrictedClosures
