import intended_hidden_sector_energy_budget_test
import Chronos.Frontier.DirectionalFlowFractionBConditionalIntegralBound

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set

/--
A conditional measurable realization of the conserved hidden-sector model.

The closure amplitude is identified with the norm of an integrated
directional-flow observable. Every analytic assumption needed by the existing
integral theorem remains explicit.

This contract does not derive a dark-matter field or interaction law.
-/
structure HiddenSectorDirectionalFlowRealization
    {Payload : Type u}
    (χDM initialAmplitude totalBudget : Nat)
    (state : IntendedUnrestrictedState Payload)
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    (μ : Measure α)
    (B : Set α)
    (c : ℝ)
    (energyDensity : α → ℝ)
    (directionalFlow : α → E) where
  conservedTrajectory :
    ConservedHiddenSectorThroughClosure
      χDM
      initialAmplitude
      totalBudget
      state

  region_measurable :
    MeasurableSet B

  region_bounded :
    Bornology.IsBounded B

  speed_positive :
    0 < c

  energy_integrable :
    IntegrableOn energyDensity B μ

  energy_nonnegative :
    0 ≤ᵐ[μ.restrict B] energyDensity

  flow_integrable :
    IntegrableOn directionalFlow B μ

  pointwise_flux_bound :
    ∀ᵐ x ∂μ.restrict B,
      ‖directionalFlow x‖ ≤
        c * energyDensity x

  bounded_energy_positive :
    0 < ∫ x in B, energyDensity x ∂μ

  closure_amplitude_is_measured_flow :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
      ‖∫ x in B, directionalFlow x ∂μ‖

/--
The measurable closure response cannot exceed the conserved discrete budget.
-/
theorem hiddenSectorDirectionalFlow_amplitude_le_discrete_budget
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    (realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        directionalFlow) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) ≤
      (totalBudget : ℝ) := by
  have hNatural :
      darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state ≤
        totalBudget :=
    conservedHiddenSector_closureAmplitude_le_budget
      realization.conservedTrajectory

  exact_mod_cast hNatural

/--
The measurable closure response obeys the integrated directional-flow
capacity bound.
-/
theorem hiddenSectorDirectionalFlow_amplitude_le_energy_capacity
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    (realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        directionalFlow) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) ≤
      c * ∫ x in B, energyDensity x ∂μ := by
  have hIntegral :=
    Chronos.Frontier.directionalFlowFractionB_conditionalIntegralBound
      μ
      B
      c
      energyDensity
      directionalFlow
      realization.region_measurable
      realization.region_bounded
      realization.speed_positive
      realization.energy_integrable
      realization.energy_nonnegative
      realization.flow_integrable
      realization.pointwise_flux_bound
      realization.bounded_energy_positive

  have hMeasuredFlow :
      ‖∫ x in B, directionalFlow x ∂μ‖ ≤
        c * ∫ x in B, energyDensity x ∂μ :=
    le_trans hIntegral.1 hIntegral.2

  rw [realization.closure_amplitude_is_measured_flow]
  exact hMeasuredFlow

/--
The response is constrained simultaneously by the finite hidden reserve and by
the measurable energy-flow capacity.
-/
theorem hiddenSectorDirectionalFlow_combined_capacity_bound
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    (realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        directionalFlow) :
    (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) ≤
        (totalBudget : ℝ) ∧
      (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) ≤
        c * ∫ x in B, energyDensity x ∂μ := by
  exact
    ⟨hiddenSectorDirectionalFlow_amplitude_le_discrete_budget
        realization,
      hiddenSectorDirectionalFlow_amplitude_le_energy_capacity
        realization⟩

/--
The normalized directional-flow response uses the finite capacity `c E_B`.
-/
noncomputable def hiddenSectorDirectionalFlowFraction
    {Payload : Type u}
    {χDM initialAmplitude : Nat}
    (state : IntendedUnrestrictedState Payload)
    {α : Type*}
    [MeasurableSpace α]
    (μ : Measure α)
    (B : Set α)
    (c : ℝ)
    (energyDensity : α → ℝ) :
    ℝ :=
  (darkMatterClosureAmplitude
      χDM
      initialAmplitude
      state : ℝ) /
    (c * ∫ x in B, energyDensity x ∂μ)

/--
Every realized normalized response lies in the closed unit interval.
-/
theorem hiddenSectorDirectionalFlowFraction_unit_interval
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    (realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        directionalFlow) :
    0 ≤
        hiddenSectorDirectionalFlowFraction
          (χDM := χDM)
          (initialAmplitude := initialAmplitude)
          state
          μ
          B
          c
          energyDensity ∧
      hiddenSectorDirectionalFlowFraction
          (χDM := χDM)
          (initialAmplitude := initialAmplitude)
          state
          μ
          B
          c
          energyDensity ≤
        1 := by
  have hDenominator :
      0 <
        c * ∫ x in B, energyDensity x ∂μ :=
    mul_pos
      realization.speed_positive
      realization.bounded_energy_positive

  have hCapacity :=
    hiddenSectorDirectionalFlow_amplitude_le_energy_capacity
      realization

  have hNumerator :
      0 ≤
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) := by
    positivity

  constructor
  · unfold hiddenSectorDirectionalFlowFraction
    exact
      div_nonneg
        hNumerator
        (le_of_lt hDenominator)

  · unfold hiddenSectorDirectionalFlowFraction
    apply (div_le_iff₀ hDenominator).2
    simpa using hCapacity

/--
A rank-255 unit-coupling realization requires directional-flow energy capacity
of at least `2^255`.
-/
theorem darkMatterUnitCoupling_directional_energy_requirement
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    {totalBudget : Nat}
    (realization :
      HiddenSectorDirectionalFlowRealization
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        μ
        B
        c
        energyDensity
        directionalFlow) :
    ((2 ^ 255 : Nat) : ℝ) ≤
      c * ∫ x in B, energyDensity x ∂μ := by
  have hCapacity :=
    hiddenSectorDirectionalFlow_amplitude_le_energy_capacity
      realization

  rw [darkMatterUnitCoupling_exact_explosion] at hCapacity
  exact hCapacity

/--
Capacity below `10^70` rules out every conserved measurable realization of the
rank-255 unit-coupling response.
-/
theorem darkMatterUnitCoupling_no_subthreshold_directional_realization
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    {μ : Measure α}
    {B : Set α}
    {c : ℝ}
    {energyDensity : α → ℝ}
    {directionalFlow : α → E}
    {totalBudget : Nat}
    (hCapacity :
      c * ∫ x in B, energyDensity x ∂μ <
        ((10 ^ 70 : Nat) : ℝ)) :
    ¬ Nonempty
        (HiddenSectorDirectionalFlowRealization
          1
          1
          totalBudget
          darkMatterExplosionInitialState
          μ
          B
          c
          energyDensity
          directionalFlow) := by
  rintro ⟨realization⟩

  have hRequired :=
    darkMatterUnitCoupling_directional_energy_requirement
      realization

  have hThresholdNatural :
      10 ^ 70 ≤ 2 ^ 255 := by
    native_decide

  have hThresholdReal :
      ((10 ^ 70 : Nat) : ℝ) ≤
        ((2 ^ 255 : Nat) : ℝ) := by
    exact_mod_cast hThresholdNatural

  linarith

end ZeroDayRestrictedClosures
