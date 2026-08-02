import intended_hidden_sector_explicit_current_coupling

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
The current dictated pointwise by the Ampère–Maxwell evolution equation:

`J = (1 / μ₀) curl B - ε₀ ∂ₜE`.
-/
noncomputable def hiddenSectorAmpereDrive
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 :=
  fun component =>
    (1 / μ₀) *
        maxwellCurl3 field.magnetic point component -
      ε₀ *
        maxwellTimeDerivative3
          field.electric
          point
          component

/--
Every uncontracted Maxwell evolution identifies its current with the
Ampère-derived drive.
-/
theorem maxwellCurrent_eq_ampereDrive
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3)
    (hEvolution :
      UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        field
        point) :
    field.current point =
      hiddenSectorAmpereDrive
        ε₀
        μ₀
        field
        point := by
  funext component

  have hComponent :=
    congrFun hEvolution.ampereMaxwell component

  unfold hiddenSectorAmpereDrive
  linarith

/--
The explicit normalized hidden current must equal the Ampère-derived drive.

This is the exact pointwise compatibility equation between the proposed
source and Maxwell evolution.
-/
theorem hiddenSectorExplicitCurrent_ampere_compatibility
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
    (time : ℝ)
    (position : MaxwellVector3) :
    hiddenSectorNormalizedCurrent
        χDM
        initialAmplitude
        state
        coupling.maxwellField
        domain
        (time, position) =
      hiddenSectorAmpereDrive
        ε₀
        μ₀
        coupling.maxwellField
        (time, position) := by
  calc
    hiddenSectorNormalizedCurrent
          χDM
          initialAmplitude
          state
          coupling.maxwellField
          domain
          (time, position) =
        coupling.maxwellField.current
          (time, position) :=
      (coupling.current_is_normalized_hidden_source
        time
        position).symm

    _ =
        hiddenSectorAmpereDrive
          ε₀
          μ₀
          coupling.maxwellField
          (time, position) :=
      maxwellCurrent_eq_ampereDrive
        ε₀
        μ₀
        coupling.maxwellField
        (time, position)
        (coupling.evolution time position)

/--
Componentwise, the normalized nonlocal source is forced to equal the magnetic
curl minus the electric time response.
-/
theorem hiddenSectorExplicitCurrent_ampere_component
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
    (time : ℝ)
    (position : MaxwellVector3)
    (component : Fin 3) :
    hiddenSectorNormalizedCurrentCoefficient
          χDM
          initialAmplitude
          state
          coupling.maxwellField
          domain
          time *
        coupling.maxwellField.electric
          (time, position)
          component =
      (1 / μ₀) *
          maxwellCurl3
            coupling.maxwellField.magnetic
            (time, position)
            component -
        ε₀ *
          maxwellTimeDerivative3
            coupling.maxwellField.electric
            (time, position)
            component := by
  have hCompatibility :=
    congrFun
      (hiddenSectorExplicitCurrent_ampere_compatibility
        coupling
        time
        position)
      component

  simpa [
    hiddenSectorNormalizedCurrent,
    hiddenSectorAmpereDrive
  ] using hCompatibility

/--
Equivalently, the electric field must solve a nonlinear, spatially nonlocal
Ampère–Maxwell equation driven by its own quadratic integral.
-/
theorem hiddenSectorExplicitCurrent_nonlinear_ampere_equation
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
    (time : ℝ)
    (position : MaxwellVector3)
    (component : Fin 3) :
    ε₀ *
        maxwellTimeDerivative3
          coupling.maxwellField.electric
          (time, position)
          component =
      (1 / μ₀) *
          maxwellCurl3
            coupling.maxwellField.magnetic
            (time, position)
            component -
        hiddenSectorNormalizedCurrentCoefficient
            χDM
            initialAmplitude
            state
            coupling.maxwellField
            domain
            time *
          coupling.maxwellField.electric
            (time, position)
            component := by
  have hComponent :=
    congrFun
      (coupling.evolution time position).ampereMaxwell
      component

  rw [
    coupling.current_is_normalized_hidden_source
      time
      position
  ] at hComponent

  simpa [hiddenSectorNormalizedCurrent] using hComponent

/--
The Ampère-derived drive performs exactly the required negative closure work
at every time.
-/
theorem hiddenSectorExplicitCurrent_ampereDrive_power
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
    (∫ position in Set.Icc domain.lower domain.upper,
      maxwellDot3
        (hiddenSectorAmpereDrive
          ε₀
          μ₀
          coupling.maxwellField
          (time, position))
        (coupling.maxwellField.electric
          (time, position))) =
      -(darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ) := by
  calc
    (∫ position in Set.Icc domain.lower domain.upper,
      maxwellDot3
        (hiddenSectorAmpereDrive
          ε₀
          μ₀
          coupling.maxwellField
          (time, position))
        (coupling.maxwellField.electric
          (time, position))) =
      ∫ position in Set.Icc domain.lower domain.upper,
        maxwellDot3
          (coupling.maxwellField.current
            (time, position))
          (coupling.maxwellField.electric
            (time, position)) := by
        apply integral_congr_ae
        filter_upwards with position

        rw [
          ← maxwellCurrent_eq_ampereDrive
            ε₀
            μ₀
            coupling.maxwellField
            (time, position)
            (coupling.evolution time position)
        ]

    _ =
        hiddenSectorMaxwellPower
          coupling.maxwellField
          domain
          time := by
      rfl

    _ =
        -(darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ) :=
      hiddenSectorExplicitCurrent_power_law
        coupling
        time

/--
For rank-255 unit coupling, the normalization coefficient is nonzero at every
time.
-/
theorem darkMatterUnitCoupling_normalizedCurrentCoefficient_ne_zero
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
    (time : ℝ) :
    hiddenSectorNormalizedCurrentCoefficient
        1
        1
        darkMatterExplosionInitialState
        coupling.maxwellField
        domain
        time ≠
      0 := by
  have hAmplitude :
      (darkMatterClosureAmplitude
        1
        1
        darkMatterExplosionInitialState : ℝ) ≠
      0 := by
    rw [darkMatterUnitCoupling_exact_explosion]
    positivity

  unfold hiddenSectorNormalizedCurrentCoefficient

  exact
    neg_ne_zero.mpr
      (div_ne_zero
        hAmplitude
        (coupling.electric_quadratic_nonzero time))

/--
A rank-255 unit-coupling realization cannot have zero Ampère drive at every
spacetime point.
-/
theorem darkMatterUnitCoupling_ampereDrive_not_identically_zero
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
        hiddenSectorAmpereDrive
            ε₀
            μ₀
            coupling.maxwellField
            point =
          0) := by
  intro hDriveZero

  have hCurrentZero :
      ∀ point : MaxwellSpacetime3,
        coupling.maxwellField.current point =
          0 := by
    intro point

    rw [
      maxwellCurrent_eq_ampereDrive
        ε₀
        μ₀
        coupling.maxwellField
        point
        (coupling.evolution point.1 point.2)
    ]

    exact hDriveZero point

  exact
    darkMatterUnitCoupling_explicitCurrent_not_identically_zero
      coupling
      hCurrentZero

/--
Consequently there exists a spacetime point with nonzero Ampère drive.
-/
theorem darkMatterUnitCoupling_exists_nonzero_ampereDrive
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
    ∃ point : MaxwellSpacetime3,
      hiddenSectorAmpereDrive
          ε₀
          μ₀
          coupling.maxwellField
          point ≠
        0 := by
  by_contra hNoWitness
  push_neg at hNoWitness

  exact
    darkMatterUnitCoupling_ampereDrive_not_identically_zero
      coupling
      hNoWitness

/--
No rank-255 unit-coupling realization can be both globally time-static in its
electric field and globally curl-free in its magnetic field.

Thus a genuine Maxwell dynamical response is necessary.
-/
theorem darkMatterUnitCoupling_not_staticElectric_and_curlFreeMagnetic
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
      ((∀ point : MaxwellSpacetime3,
          maxwellTimeDerivative3
              coupling.maxwellField.electric
              point =
            0) ∧
        (∀ point : MaxwellSpacetime3,
          maxwellCurl3
              coupling.maxwellField.magnetic
              point =
            0)) := by
  rintro ⟨hElectricStatic, hMagneticCurlFree⟩

  apply
    darkMatterUnitCoupling_ampereDrive_not_identically_zero
      coupling

  intro point
  funext component

  simp [
    hiddenSectorAmpereDrive,
    hElectricStatic point,
    hMagneticCurlFree point
  ]

end ZeroDayRestrictedClosures
