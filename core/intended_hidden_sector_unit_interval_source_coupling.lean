import intended_hidden_sector_differential_energy_exchange

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
An explicit hidden-energy trajectory over normalized time `[0,1]`.

It starts at the closure amplitude and decreases linearly to zero.
-/
noncomputable def hiddenSectorUnitIntervalEnergy
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (time : ℝ) :
    ℝ :=
  (darkMatterClosureAmplitude
      χDM
      initialAmplitude
      state : ℝ) *
    (1 - time)

/--
The explicit unit-interval hidden energy has constant derivative equal to the
negative closure amplitude.
-/
theorem hiddenSectorUnitIntervalEnergy_hasDerivAt
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (time : ℝ) :
    HasDerivAt
      (hiddenSectorUnitIntervalEnergy
        χDM
        initialAmplitude
        state)
      (-(darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ))
      time := by
  unfold hiddenSectorUnitIntervalEnergy

  convert
    (hasDerivAt_const
        time
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ)).mul
      ((hasDerivAt_const time (1 : ℝ)).sub
        (hasDerivAt_id time))
    using 1 <;>
      ring

/--
The explicit trajectory loses exactly the closure amplitude between normalized
times zero and one.
-/
theorem hiddenSectorUnitIntervalEnergy_endpoint_drop
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload) :
    hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          0 -
        hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          1 =
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
  simp [hiddenSectorUnitIntervalEnergy]

/--
A coupled normalized-time Maxwell source law.

The hidden-energy trajectory is no longer supplied as data. Its derivative and
endpoint loss are both derived from the explicit affine trajectory.

The remaining physical coupling input is local: throughout `[0,1]`, the
spatially integrated Maxwell current work rate equals the negative closure
amplitude.
-/
structure HiddenSectorUnitIntervalSourceCoupling
    {Payload : Type u}
    (χDM initialAmplitude totalBudget : Nat)
    (state : IntendedUnrestrictedState Payload)
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) where
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

  power_interval_integrable :
    IntervalIntegrable
      (hiddenSectorMaxwellPower maxwellField domain)
      volume
      0
      1

  unit_interval_power_law :
    ∀ time ∈ Set.uIcc (0 : ℝ) 1,
      hiddenSectorMaxwellPower
          maxwellField
          domain
          time =
        -(darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ)

/--
The normalized source coupling constructs the differential hidden-energy
exchange coupling.

Neither a hidden-energy function, a derivative law, nor an endpoint-drop law
is taken as a field of the normalized source coupling.
-/
noncomputable def
    HiddenSectorUnitIntervalSourceCoupling.toDifferentialEnergyExchange
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) :
    HiddenSectorDifferentialEnergyExchangeCoupling
      χDM
      initialAmplitude
      totalBudget
      state
      ε₀
      μ₀
      domain
      0
      1 where
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

  hiddenEnergy :=
    hiddenSectorUnitIntervalEnergy
      χDM
      initialAmplitude
      state

  hidden_power_interval_integrable :=
    coupling.power_interval_integrable

  hidden_energy_derivative := by
    intro time hTime

    rw [coupling.unit_interval_power_law time hTime]

    exact
      hiddenSectorUnitIntervalEnergy_hasDerivAt
        χDM
        initialAmplitude
        state
        time

  hidden_energy_endpoint_drop :=
    hiddenSectorUnitIntervalEnergy_endpoint_drop
      χDM
      initialAmplitude
      state

/--
The local normalized source law implies the integrated Maxwell-work identity
through the differential exchange theorem.
-/
theorem hiddenSectorUnitIntervalSource_integrated_work
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) :
    -(∫ time in (0 : ℝ)..1,
        hiddenSectorMaxwellPower
          coupling.maxwellField
          domain
          time) =
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
  exact
    hiddenSectorDifferentialEnergyExchange_integrated_work
      coupling.toDifferentialEnergyExchange

/--
The local normalized source law inherits the exact Maxwell energy-and-flux
identity.
-/
theorem hiddenSectorUnitIntervalSource_energy_flux_identity
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
      maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          1 -
        maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          0 +
        (∫ time in (0 : ℝ)..1,
          maxwellRectangularBoundaryFlux3
            domain
            (maxwellPoyntingSpatialSlice3
              μ₀
              coupling.maxwellField
              time)) := by
  exact
    hiddenSectorDifferentialEnergyExchange_energy_flux_identity
      coupling.toDifferentialEnergyExchange

/--
With zero integrated boundary flux, the explicit hidden-energy loss equals the
increase in stored electromagnetic energy.
-/
theorem hiddenSectorUnitIntervalSource_isolated_transfer
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain)
    (hIntegratedBoundaryFluxZero :
      (∫ time in (0 : ℝ)..1,
        maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            coupling.maxwellField
            time)) =
        0) :
    hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          0 -
        hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          1 =
      maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          1 -
        maxwellTotalElectromagneticEnergy3
          ε₀
          μ₀
          coupling.maxwellField
          domain
          0 := by
  exact
    hiddenSectorDifferentialEnergyExchange_isolated_transfer
      coupling.toDifferentialEnergyExchange
      hIntegratedBoundaryFluxZero

/--
The explicit normalized hidden-energy loss is bounded by the finite conserved
budget.
-/
theorem hiddenSectorUnitIntervalSource_energyDrop_le_budget
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) :
    hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          0 -
        hiddenSectorUnitIntervalEnergy
          χDM
          initialAmplitude
          state
          1 ≤
      (totalBudget : ℝ) := by
  exact
    hiddenSectorDifferentialEnergyExchange_endpointDrop_le_budget
      coupling.toDifferentialEnergyExchange

/--
For rank-255 unit coupling, the explicit hidden-energy trajectory loses exactly
`2^255` over normalized time `[0,1]`.
-/
theorem darkMatterUnitCoupling_unitInterval_hiddenEnergy_drop_exact
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain) :
    hiddenSectorUnitIntervalEnergy
          1
          1
          darkMatterExplosionInitialState
          0 -
        hiddenSectorUnitIntervalEnergy
          1
          1
          darkMatterExplosionInitialState
          1 =
      ((2 ^ 255 : Nat) : ℝ) := by
  exact
    darkMatterUnitCoupling_hiddenEnergy_drop_exact
      coupling.toDifferentialEnergyExchange

/--
An isolated rank-255 unit-coupling normalized source requires final
electromagnetic energy of at least `2^255`.
-/
theorem
    darkMatterUnitCoupling_unitInterval_finalEnergy_requirement
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain)
    (hIntegratedBoundaryFluxZero :
      (∫ time in (0 : ℝ)..1,
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
        1 := by
  exact
    darkMatterUnitCoupling_differentialExchange_finalEnergy_requirement
      coupling.toDifferentialEnergyExchange
      hIntegratedBoundaryFluxZero

/--
The rank-255 unit-coupling normalized source cannot have identically zero
electromagnetic current.
-/
theorem
    darkMatterUnitCoupling_unitInterval_current_not_identically_zero
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorUnitIntervalSourceCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        ε₀
        μ₀
        domain) :
    ¬
      (∀ point : MaxwellSpacetime3,
        coupling.maxwellField.current point = 0) := by
  exact
    darkMatterUnitCoupling_differentialExchange_current_not_identically_zero
      coupling.toDifferentialEnergyExchange

end ZeroDayRestrictedClosures
