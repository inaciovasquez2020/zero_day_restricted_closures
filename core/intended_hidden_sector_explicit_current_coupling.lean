import intended_hidden_sector_unit_interval_source_coupling

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
The spatial integral of the squared electric-field magnitude, expressed using
the repository's coordinate dot product.
-/
noncomputable def hiddenSectorElectricQuadraticIntegral
    (field : SmoothMaxwellField3)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    ℝ :=
  ∫ position in Set.Icc domain.lower domain.upper,
    maxwellDot3
      (field.electric (time, position))
      (field.electric (time, position))

/--
The scalar coefficient used to normalize the explicit hidden-sector current.

Multiplying this coefficient by the electric quadratic integral produces the
negative closure amplitude.
-/
noncomputable def hiddenSectorNormalizedCurrentCoefficient
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (field : SmoothMaxwellField3)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    ℝ :=
  -(
    (darkMatterClosureAmplitude
      χDM
      initialAmplitude
      state : ℝ) /
    hiddenSectorElectricQuadraticIntegral
      field
      domain
      time
  )

/--
An explicit current parallel to the electric field.

Its normalization is chosen so that spatially integrated current work equals
the negative closure amplitude whenever the electric quadratic integral is
nonzero.
-/
noncomputable def hiddenSectorNormalizedCurrent
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (field : SmoothMaxwellField3)
    (domain : MaxwellRectangularDomain3) :
    MaxwellVectorField3 :=
  fun point component =>
    hiddenSectorNormalizedCurrentCoefficient
        χDM
        initialAmplitude
        state
        field
        domain
        point.1 *
      field.electric point component

/--
The explicit normalized current has the expected pointwise work density.
-/
theorem hiddenSectorNormalizedCurrent_dot_electric
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (field : SmoothMaxwellField3)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (position : MaxwellVector3) :
    maxwellDot3
        (hiddenSectorNormalizedCurrent
          χDM
          initialAmplitude
          state
          field
          domain
          (time, position))
        (field.electric (time, position)) =
      hiddenSectorNormalizedCurrentCoefficient
          χDM
          initialAmplitude
          state
          field
          domain
          time *
        maxwellDot3
          (field.electric (time, position))
          (field.electric (time, position)) := by
  unfold hiddenSectorNormalizedCurrent
  unfold maxwellDot3

  rw [Finset.mul_sum]

  apply Finset.sum_congr rfl

  intro component _
  ring

/--
A Maxwell evolution whose current is the explicit normalized hidden source.

The constant integrated-power law is absent. It will be derived from:

* the exact current construction;
* nonvanishing electric quadratic integral;
* interval integrability of the resulting work rate.
-/
structure HiddenSectorExplicitCurrentCoupling
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

  current_is_normalized_hidden_source :
    ∀ (time : ℝ) (position : MaxwellVector3),
      maxwellField.current (time, position) =
        hiddenSectorNormalizedCurrent
          χDM
          initialAmplitude
          state
          maxwellField
          domain
          (time, position)

  electric_quadratic_nonzero :
    ∀ time : ℝ,
      hiddenSectorElectricQuadraticIntegral
          maxwellField
          domain
          time ≠
        0

  power_interval_integrable :
    IntervalIntegrable
      (hiddenSectorMaxwellPower maxwellField domain)
      volume
      0
      1

/--
The explicit normalized current produces the exact constant integrated
Maxwell-power law.

This law is now a theorem rather than a field of the coupling structure.
-/
theorem hiddenSectorExplicitCurrent_power_law
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain)
    (time : ℝ) :
    hiddenSectorMaxwellPower
        coupling.maxwellField
        domain
        time =
      -(darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
  have hQuadraticNonzero :
      hiddenSectorElectricQuadraticIntegral
          coupling.maxwellField
          domain
          time ≠
        0 :=
    coupling.electric_quadratic_nonzero time

  unfold hiddenSectorMaxwellPower

  calc
    (∫ position in Set.Icc domain.lower domain.upper,
        maxwellDot3
          (coupling.maxwellField.current
            (time, position))
          (coupling.maxwellField.electric
            (time, position))) =
      ∫ position in Set.Icc domain.lower domain.upper,
        hiddenSectorNormalizedCurrentCoefficient
            χDM
            initialAmplitude
            state
            coupling.maxwellField
            domain
            time *
          maxwellDot3
            (coupling.maxwellField.electric
              (time, position))
            (coupling.maxwellField.electric
              (time, position)) := by
        apply integral_congr_ae
        filter_upwards with position

        rw [
          coupling.current_is_normalized_hidden_source
            time
            position
        ]

        exact
          hiddenSectorNormalizedCurrent_dot_electric
            χDM
            initialAmplitude
            state
            coupling.maxwellField
            domain
            time
            position
    _ =
      hiddenSectorNormalizedCurrentCoefficient
          χDM
          initialAmplitude
          state
          coupling.maxwellField
          domain
          time *
        hiddenSectorElectricQuadraticIntegral
          coupling.maxwellField
          domain
          time := by
        rw [integral_const_mul]
        rfl
    _ =
      -(darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
        unfold hiddenSectorNormalizedCurrentCoefficient
        field_simp [hQuadraticNonzero]

/--
The explicit-current coupling constructs the previous normalized source
coupling.

Its `unit_interval_power_law` field is filled by the theorem above.
-/
noncomputable def
    HiddenSectorExplicitCurrentCoupling.toUnitIntervalSourceCoupling
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) :
    HiddenSectorUnitIntervalSourceCoupling
      χDM
      initialAmplitude
      totalBudget
      state
      ε₀
      μ₀
      domain where
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

  power_interval_integrable :=
    coupling.power_interval_integrable

  unit_interval_power_law := by
    intro time _
    exact
      hiddenSectorExplicitCurrent_power_law
        coupling
        time

/--
The explicit current therefore implies the integrated Maxwell-work identity.
-/
theorem hiddenSectorExplicitCurrent_integrated_work
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
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
    hiddenSectorUnitIntervalSource_integrated_work
      coupling.toUnitIntervalSourceCoupling

/--
The explicit current inherits the exact electromagnetic energy-and-flux
identity.
-/
theorem hiddenSectorExplicitCurrent_energy_flux_identity
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
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
    hiddenSectorUnitIntervalSource_energy_flux_identity
      coupling.toUnitIntervalSourceCoupling

/--
For rank-255 unit coupling, the explicit current transfers exactly `2^255`
hidden-energy units over the normalized interval.
-/
theorem darkMatterUnitCoupling_explicitCurrent_hiddenEnergy_drop_exact
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
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
    darkMatterUnitCoupling_unitInterval_hiddenEnergy_drop_exact
      coupling.toUnitIntervalSourceCoupling

/--
An isolated rank-255 explicit-current realization requires final
electromagnetic energy of at least `2^255`.
-/
theorem darkMatterUnitCoupling_explicitCurrent_finalEnergy_requirement
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
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
    darkMatterUnitCoupling_unitInterval_finalEnergy_requirement
      coupling.toUnitIntervalSourceCoupling
      hIntegratedBoundaryFluxZero

/--
The rank-255 explicit-current realization cannot have identically zero
electromagnetic current.
-/
theorem darkMatterUnitCoupling_explicitCurrent_not_identically_zero
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    {totalBudget : Nat}
    (coupling :
      HiddenSectorExplicitCurrentCoupling
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
    darkMatterUnitCoupling_unitInterval_current_not_identically_zero
      coupling.toUnitIntervalSourceCoupling

end ZeroDayRestrictedClosures
