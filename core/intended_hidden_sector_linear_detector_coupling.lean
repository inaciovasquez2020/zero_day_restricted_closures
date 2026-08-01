import intended_hidden_sector_directional_flow_observable

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set

/--
The local linear detector equation.

The hidden-sector closure amplitude multiplies a detector response profile.
-/
noncomputable def hiddenSectorLinearDetectorFlow
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    {α E : Type*}
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    (detectorProfile : α → E) :
    α → E :=
  fun x =>
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) •
      detectorProfile x

/--
A concrete linear detector coupling.

The carrier types `α` and `E` are explicit parameters so Lean can resolve the
Banach-space structure without unresolved metavariables.

The measured-flow norm identity is deliberately absent from this structure.
-/
structure HiddenSectorLinearDetectorCoupling
    {Payload : Type u}
    (χDM initialAmplitude totalBudget : Nat)
    (state : IntendedUnrestrictedState Payload)
    (α E : Type*)
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    (μ : Measure α)
    (B : Set α)
    (c : ℝ)
    (energyDensity : α → ℝ) where
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

  bounded_energy_positive :
    0 < ∫ x in B, energyDensity x ∂μ

  detectorProfile :
    α → E

  detectorDirection :
    E

  detector_direction_unit :
    ‖detectorDirection‖ = 1

  detector_profile_integrable :
    IntegrableOn detectorProfile B μ

  detector_profile_integral :
    (∫ x in B, detectorProfile x ∂μ) =
      detectorDirection

  coupled_flow_integrable :
    IntegrableOn
      (hiddenSectorLinearDetectorFlow
        χDM
        initialAmplitude
        state
        detectorProfile)
      B
      μ

  coupled_flux_bound :
    ∀ᵐ x ∂μ.restrict B,
      ‖hiddenSectorLinearDetectorFlow
          χDM
          initialAmplitude
          state
          detectorProfile
          x‖ ≤
        c * energyDensity x

/--
Integrating the local linear detector equation produces the closure amplitude
times the integrated detector response.
-/
theorem hiddenSectorLinearDetector_integrated_flow_equation
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
    (∫ x in B,
        hiddenSectorLinearDetectorFlow
          (α := α)
          (E := E)
          χDM
          initialAmplitude
          state
          coupling.detectorProfile
          x ∂μ) =
      (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) •
        coupling.detectorDirection := by
  change
    (∫ x in B,
        (darkMatterClosureAmplitude
            χDM
            initialAmplitude
            state : ℝ) •
          coupling.detectorProfile x ∂μ) =
      (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) •
        coupling.detectorDirection

  rw [
    integral_smul,
    coupling.detector_profile_integral
  ]

/--
The measured integrated-flow identity follows from the linear equation and the
unit-normalized detector direction.

It is proved rather than stored as a coupling assumption.
-/
theorem hiddenSectorLinearDetector_measured_flow_identity
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) =
      ‖∫ x in B,
          hiddenSectorLinearDetectorFlow
            (α := α)
            (E := E)
            χDM
            initialAmplitude
            state
            coupling.detectorProfile
            x ∂μ‖ := by
  rw [
    hiddenSectorLinearDetector_integrated_flow_equation
      coupling,
    norm_smul,
    coupling.detector_direction_unit,
    mul_one
  ]

  simpa using
    (Real.norm_natCast
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state)).symm

/--
The concrete coupling constructs the earlier directional-flow realization.

The required measured-flow identity is supplied by the theorem above.
-/
noncomputable def
    hiddenSectorLinearDetector_toDirectionalFlowRealization
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
    HiddenSectorDirectionalFlowRealization
      χDM
      initialAmplitude
      totalBudget
      state
      μ
      B
      c
      energyDensity
      (hiddenSectorLinearDetectorFlow
        (α := α)
        (E := E)
        χDM
        initialAmplitude
        state
        coupling.detectorProfile) where
  conservedTrajectory :=
    coupling.conservedTrajectory

  region_measurable :=
    coupling.region_measurable

  region_bounded :=
    coupling.region_bounded

  speed_positive :=
    coupling.speed_positive

  energy_integrable :=
    coupling.energy_integrable

  energy_nonnegative :=
    coupling.energy_nonnegative

  flow_integrable :=
    coupling.coupled_flow_integrable

  pointwise_flux_bound :=
    coupling.coupled_flux_bound

  bounded_energy_positive :=
    coupling.bounded_energy_positive

  closure_amplitude_is_measured_flow :=
    hiddenSectorLinearDetector_measured_flow_identity
      coupling

/--
The measurable energy-capacity bound follows from the concrete detector
coupling without assuming the measured-flow identity.
-/
theorem hiddenSectorLinearDetector_amplitude_le_energy_capacity
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
    (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) ≤
      c * ∫ x in B, energyDensity x ∂μ := by
  let realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        (hiddenSectorLinearDetectorFlow
          (α := α)
          (E := E)
          χDM
          initialAmplitude
          state
          coupling.detectorProfile) :=
    hiddenSectorLinearDetector_toDirectionalFlowRealization
      coupling

  exact
    hiddenSectorDirectionalFlow_amplitude_le_energy_capacity
      realization

/--
The concrete coupling is bounded simultaneously by the conserved hidden
reserve and the measurable directional-flow capacity.
-/
theorem hiddenSectorLinearDetector_combined_capacity_bound
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
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
  let realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        (hiddenSectorLinearDetectorFlow
          (α := α)
          (E := E)
          χDM
          initialAmplitude
          state
          coupling.detectorProfile) :=
    hiddenSectorLinearDetector_toDirectionalFlowRealization
      coupling

  exact
    hiddenSectorDirectionalFlow_combined_capacity_bound
      realization

/--
The normalized measurable response of the concrete detector coupling lies in
the closed unit interval.
-/
theorem hiddenSectorLinearDetector_fraction_unit_interval
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
    (coupling :
      HiddenSectorLinearDetectorCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        α
        E
        μ
        B
        c
        energyDensity) :
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
  let realization :
      HiddenSectorDirectionalFlowRealization
        χDM
        initialAmplitude
        totalBudget
        state
        μ
        B
        c
        energyDensity
        (hiddenSectorLinearDetectorFlow
          (α := α)
          (E := E)
          χDM
          initialAmplitude
          state
          coupling.detectorProfile) :=
    hiddenSectorLinearDetector_toDirectionalFlowRealization
      coupling

  exact
    hiddenSectorDirectionalFlowFraction_unit_interval
      realization

/--
Any rank-255 unit-coupling linear detector model requires directional-flow
capacity of at least `2^255`.
-/
theorem darkMatterUnitCoupling_linearDetector_energy_requirement
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
    {totalBudget : Nat}
    (coupling :
      HiddenSectorLinearDetectorCoupling
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        α
        E
        μ
        B
        c
        energyDensity) :
    ((2 ^ 255 : Nat) : ℝ) ≤
      c * ∫ x in B, energyDensity x ∂μ := by
  let realization :
      HiddenSectorDirectionalFlowRealization
        1
        1
        totalBudget
        darkMatterExplosionInitialState
        μ
        B
        c
        energyDensity
        (hiddenSectorLinearDetectorFlow
          (α := α)
          (E := E)
          1
          1
          darkMatterExplosionInitialState
          coupling.detectorProfile) :=
    hiddenSectorLinearDetector_toDirectionalFlowRealization
      coupling

  exact
    darkMatterUnitCoupling_directional_energy_requirement
      realization

/--
Directional-flow capacity below `10^70` rules out every rank-255
unit-coupling linear detector model.
-/
theorem darkMatterUnitCoupling_no_subthreshold_linearDetectorCoupling
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
    {totalBudget : Nat}
    (hCapacity :
      c * ∫ x in B, energyDensity x ∂μ <
        ((10 ^ 70 : Nat) : ℝ)) :
    ¬ Nonempty
        (HiddenSectorLinearDetectorCoupling
          1
          1
          totalBudget
          darkMatterExplosionInitialState
          α
          E
          μ
          B
          c
          energyDensity) := by
  rintro ⟨coupling⟩

  have hRequired :
      ((2 ^ 255 : Nat) : ℝ) ≤
        c * ∫ x in B, energyDensity x ∂μ :=
    darkMatterUnitCoupling_linearDetector_energy_requirement
      coupling

  have hThresholdNatural :
      10 ^ 70 ≤ 2 ^ 255 := by
    native_decide

  have hThresholdReal :
      ((10 ^ 70 : Nat) : ℝ) ≤
        ((2 ^ 255 : Nat) : ℝ) := by
    exact_mod_cast hThresholdNatural

  linarith

end ZeroDayRestrictedClosures
