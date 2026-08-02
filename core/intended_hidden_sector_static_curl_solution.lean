import intended_hidden_sector_ampere_compatibility

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

def hiddenSectorAxis0 :
    MaxwellVector3 :=
  fun component =>
    if component = (0 : Fin 3) then
      1
    else
      0

noncomputable def hiddenSectorRectangularVolume
    (domain : MaxwellRectangularDomain3) :
    ℝ :=
  ∫ _position in Set.Icc domain.lower domain.upper,
    (1 : ℝ)

noncomputable def hiddenSectorSpatialCoordinateCLM
    (i : Fin 3) :
    MaxwellSpacetime3 →L[ℝ] ℝ :=
  (ContinuousLinearMap.proj i :
      MaxwellVector3 →L[ℝ] ℝ).comp
    (ContinuousLinearMap.snd
      ℝ
      ℝ
      MaxwellVector3)

def hiddenSectorStaticElectric :
    MaxwellVectorField3 :=
  fun _point =>
    hiddenSectorAxis0

noncomputable def hiddenSectorStaticCurrent
    (A : ℝ)
    (domain : MaxwellRectangularDomain3) :
    MaxwellVectorField3 :=
  fun _point component =>
    if component = (0 : Fin 3) then
      -(A / hiddenSectorRectangularVolume domain)
    else
      0

noncomputable def hiddenSectorStaticCurlMagneticComponentCLM
    (k : ℝ)
    (component : Fin 3) :
    MaxwellSpacetime3 →L[ℝ] ℝ :=
  if component = (2 : Fin 3) then
    (-k) •
      hiddenSectorSpatialCoordinateCLM
        (1 : Fin 3)
  else
    0

noncomputable def hiddenSectorStaticCurlMagneticCLM
    (k : ℝ) :
    MaxwellSpacetime3 →L[ℝ] MaxwellVector3 :=
  ContinuousLinearMap.pi
    (fun component =>
      hiddenSectorStaticCurlMagneticComponentCLM
        k
        component)

noncomputable def hiddenSectorStaticCurlMagnetic
    (k : ℝ) :
    MaxwellVectorField3 :=
  hiddenSectorStaticCurlMagneticCLM k

noncomputable def hiddenSectorStaticCurlField
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    SmoothMaxwellField3 where
  electric :=
    hiddenSectorStaticElectric

  magnetic :=
    hiddenSectorStaticCurlMagnetic
      (μ₀ * A /
        hiddenSectorRectangularVolume domain)

  current :=
    hiddenSectorStaticCurrent
      A
      domain

  electric_contDiff := by
    exact contDiff_const

  magnetic_contDiff := by
    simpa [hiddenSectorStaticCurlMagnetic] using
      (hiddenSectorStaticCurlMagneticCLM
        (μ₀ * A /
          hiddenSectorRectangularVolume domain)).contDiff

  current_contDiff := by
    exact contDiff_const

theorem hiddenSectorStaticElectric_timeDerivative
    (point : MaxwellSpacetime3) :
    maxwellTimeDerivative3
        hiddenSectorStaticElectric
        point =
      0 := by
  have hDerivative :
      HasFDerivAt
        (fun _ : MaxwellSpacetime3 =>
          hiddenSectorAxis0)
        (0 :
          MaxwellSpacetime3 →L[ℝ] MaxwellVector3)
        point := by
    exact
      hasFDerivAt_const
        hiddenSectorAxis0
        point

  unfold maxwellTimeDerivative3
  change
    (fderiv ℝ
      (fun _ : MaxwellSpacetime3 =>
        hiddenSectorAxis0)
      point)
      maxwellTimeDirection3 =
    0

  rw [hDerivative.fderiv]
  rfl

theorem hiddenSectorStaticElectric_curl
    (point : MaxwellSpacetime3) :
    maxwellCurl3
        hiddenSectorStaticElectric
        point =
      0 := by
  funext component
  fin_cases component <;>
    simp [
      maxwellCurl3,
      maxwellSpatialDerivative3,
      hiddenSectorStaticElectric
    ]

theorem hiddenSectorStaticCurlMagnetic_timeDerivative
    (k : ℝ)
    (point : MaxwellSpacetime3) :
    maxwellTimeDerivative3
        (hiddenSectorStaticCurlMagnetic k)
        point =
      0 := by
  unfold maxwellTimeDerivative3

  change
    (fderiv ℝ
      (⇑(hiddenSectorStaticCurlMagneticCLM k))
      point)
      maxwellTimeDirection3 =
    0

  rw [ContinuousLinearMap.fderiv]

  funext component
  fin_cases component <;>
    simp [
      hiddenSectorStaticCurlMagneticCLM,
      hiddenSectorStaticCurlMagneticComponentCLM,
      hiddenSectorSpatialCoordinateCLM,
      maxwellTimeDirection3
    ]

theorem hiddenSectorStaticCurlMagnetic_spatialDerivative
    (k : ℝ)
    (component coordinate : Fin 3)
    (point : MaxwellSpacetime3) :
    maxwellSpatialDerivative3
        (fun q =>
          hiddenSectorStaticCurlMagnetic
            k
            q
            component)
        coordinate
        point =
      if component = (2 : Fin 3) ∧
          coordinate = (1 : Fin 3) then
        -k
      else
        0 := by
  unfold maxwellSpatialDerivative3

  change
    (fderiv ℝ
      (⇑(hiddenSectorStaticCurlMagneticComponentCLM
        k
        component))
      point)
      (maxwellSpatialDirection3 coordinate) =
    _

  rw [ContinuousLinearMap.fderiv]

  fin_cases component <;>
    fin_cases coordinate <;>
      simp [
        hiddenSectorStaticCurlMagneticComponentCLM,
        hiddenSectorSpatialCoordinateCLM,
        maxwellSpatialDirection3
      ]

theorem hiddenSectorStaticCurlMagnetic_curl
    (k : ℝ)
    (point : MaxwellSpacetime3) :
    maxwellCurl3
        (hiddenSectorStaticCurlMagnetic k)
        point =
      fun component =>
        if component = (0 : Fin 3) then
          -k
        else
          0 := by
  funext component
  fin_cases component <;>
    simp [
      maxwellCurl3,
      hiddenSectorStaticCurlMagnetic_spatialDerivative
    ]

theorem hiddenSectorStaticCurl_evolution
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ)
    (position : MaxwellVector3) :
    UncontractedMaxwellEvolutionAt3
      ε₀
      μ₀
      (hiddenSectorStaticCurlField
        A
        μ₀
        domain)
      (time, position) := by
  constructor

  · change
      maxwellTimeDerivative3
          (hiddenSectorStaticCurlMagnetic
            (μ₀ * A /
              hiddenSectorRectangularVolume domain))
          (time, position) =
        fun component =>
          -maxwellCurl3
            hiddenSectorStaticElectric
            (time, position)
            component

    rw [
      hiddenSectorStaticCurlMagnetic_timeDerivative,
      hiddenSectorStaticElectric_curl
    ]

    funext component
    simp

  · change
      (fun component =>
        ε₀ *
          maxwellTimeDerivative3
            hiddenSectorStaticElectric
            (time, position)
            component) =
      fun component =>
        (1 / μ₀) *
            maxwellCurl3
              (hiddenSectorStaticCurlMagnetic
                (μ₀ * A /
                  hiddenSectorRectangularVolume domain))
              (time, position)
              component -
          hiddenSectorStaticCurrent
            A
            domain
            (time, position)
            component

    rw [
      hiddenSectorStaticElectric_timeDerivative,
      hiddenSectorStaticCurlMagnetic_curl
    ]

    funext component
    fin_cases component

    · simp [hiddenSectorStaticCurrent]
      field_simp [ne_of_gt hμ₀, hVolume] <;>
        ring

    · simp [hiddenSectorStaticCurrent]

    · simp [hiddenSectorStaticCurrent]

theorem hiddenSectorStaticCurl_electricQuadraticIntegral
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorElectricQuadraticIntegral
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        domain
        time =
      hiddenSectorRectangularVolume domain := by
  unfold hiddenSectorElectricQuadraticIntegral
  unfold hiddenSectorRectangularVolume

  apply integral_congr_ae
  filter_upwards with position

  simp [
    hiddenSectorStaticCurlField,
    hiddenSectorStaticElectric,
    hiddenSectorAxis0,
    maxwellDot3
  ]

theorem hiddenSectorStaticCurl_current_is_normalized
    {Payload : Type u}
    (χDM initialAmplitude : Nat)
    (state : IntendedUnrestrictedState Payload)
    (μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (position : MaxwellVector3) :
    (hiddenSectorStaticCurlField
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ)
        μ₀
        domain).current
        (time, position) =
      hiddenSectorNormalizedCurrent
        χDM
        initialAmplitude
        state
        (hiddenSectorStaticCurlField
          (darkMatterClosureAmplitude
            χDM
            initialAmplitude
            state : ℝ)
          μ₀
          domain)
        domain
        (time, position) := by
  funext component

  unfold hiddenSectorNormalizedCurrent
  unfold hiddenSectorNormalizedCurrentCoefficient

  rw [
    hiddenSectorStaticCurl_electricQuadraticIntegral
  ]

  fin_cases component <;>
    simp [
      hiddenSectorStaticCurlField,
      hiddenSectorStaticCurrent,
      hiddenSectorStaticElectric,
      hiddenSectorAxis0
    ]

theorem hiddenSectorStaticCurl_power
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    hiddenSectorMaxwellPower
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        domain
        time =
      -A := by
  unfold hiddenSectorMaxwellPower

  calc
    (∫ position in Set.Icc domain.lower domain.upper,
      maxwellDot3
        ((hiddenSectorStaticCurlField
          A
          μ₀
          domain).current
          (time, position))
        ((hiddenSectorStaticCurlField
          A
          μ₀
          domain).electric
          (time, position))) =
      ∫ _position in Set.Icc domain.lower domain.upper,
        -(A / hiddenSectorRectangularVolume domain) := by
          apply integral_congr_ae
          filter_upwards with position

          simp [
            hiddenSectorStaticCurlField,
            hiddenSectorStaticCurrent,
            hiddenSectorStaticElectric,
            hiddenSectorAxis0,
            maxwellDot3
          ]

    _ =
      -(A / hiddenSectorRectangularVolume domain) *
        (∫ _position in Set.Icc domain.lower domain.upper,
          (1 : ℝ)) := by
            rw [← integral_const_mul]
            simp

    _ =
      -(A / hiddenSectorRectangularVolume domain) *
        hiddenSectorRectangularVolume domain := by
          rfl

    _ = -A := by
      field_simp [hVolume]

theorem hiddenSectorStaticCurl_power_intervalIntegrable
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    IntervalIntegrable
      (hiddenSectorMaxwellPower
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        domain)
      volume
      0
      1 := by
  have hPowerFunction :
      hiddenSectorMaxwellPower
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          domain =
        fun _time : ℝ => -A := by
    funext time

    exact
      hiddenSectorStaticCurl_power
        A
        μ₀
        domain
        hVolume
        time

  rw [hPowerFunction]

  exact
    intervalIntegrable_const
      (μ := (volume : Measure ℝ))
      (a := (0 : ℝ))
      (b := (1 : ℝ))
      (c := (-A : ℝ))

noncomputable def hiddenSectorStaticCurlExplicitCurrentCoupling
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (trajectory :
      ConservedHiddenSectorThroughClosure
        χDM
        initialAmplitude
        totalBudget
        state)
    (hε₀ : 0 ≤ ε₀)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    HiddenSectorExplicitCurrentCoupling
      χDM
      initialAmplitude
      totalBudget
      state
      ε₀
      μ₀
      domain where
  conservedTrajectory :=
    trajectory

  maxwellField :=
    hiddenSectorStaticCurlField
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ)
      μ₀
      domain

  electricCoefficientNonnegative :=
    hε₀

  magneticPermeabilityPositive :=
    hμ₀

  evolution := by
    intro time position

    exact
      hiddenSectorStaticCurl_evolution
        (darkMatterClosureAmplitude
          χDM
          initialAmplitude
          state : ℝ)
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time
        position

  current_is_normalized_hidden_source := by
    intro time position

    exact
      hiddenSectorStaticCurl_current_is_normalized
        χDM
        initialAmplitude
        state
        μ₀
        domain
        time
        position

  electric_quadratic_nonzero := by
    intro time

    rw [
      hiddenSectorStaticCurl_electricQuadraticIntegral
    ]

    exact hVolume

  power_interval_integrable :=
    hiddenSectorStaticCurl_power_intervalIntegrable
      (darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state : ℝ)
      μ₀
      domain
      hVolume

theorem hiddenSectorStaticCurl_smoothSolution_exists
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (trajectory :
      ConservedHiddenSectorThroughClosure
        χDM
        initialAmplitude
        totalBudget
        state)
    (hε₀ : 0 ≤ ε₀)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    Nonempty
      (HiddenSectorExplicitCurrentCoupling
        χDM
        initialAmplitude
        totalBudget
        state
        ε₀
        μ₀
        domain) := by
  exact
    ⟨hiddenSectorStaticCurlExplicitCurrentCoupling
      trajectory
      hε₀
      hμ₀
      hVolume⟩

theorem hiddenSectorStaticCurl_nonlinearAmpere_solution
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    {ε₀ μ₀ : ℝ}
    {domain : MaxwellRectangularDomain3}
    (trajectory :
      ConservedHiddenSectorThroughClosure
        χDM
        initialAmplitude
        totalBudget
        state)
    (hε₀ : 0 ≤ ε₀)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ)
    (position : MaxwellVector3)
    (component : Fin 3) :
    ε₀ *
        maxwellTimeDerivative3
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              χDM
              initialAmplitude
              state : ℝ)
            μ₀
            domain).electric
          (time, position)
          component =
      (1 / μ₀) *
          maxwellCurl3
            (hiddenSectorStaticCurlField
              (darkMatterClosureAmplitude
                χDM
                initialAmplitude
                state : ℝ)
              μ₀
              domain).magnetic
            (time, position)
            component -
        hiddenSectorNormalizedCurrentCoefficient
            χDM
            initialAmplitude
            state
            (hiddenSectorStaticCurlField
              (darkMatterClosureAmplitude
                χDM
                initialAmplitude
                state : ℝ)
              μ₀
              domain)
            domain
            time *
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              χDM
              initialAmplitude
              state : ℝ)
            μ₀
            domain).electric
            (time, position)
            component := by
  let coupling :=
    hiddenSectorStaticCurlExplicitCurrentCoupling
      trajectory
      hε₀
      hμ₀
      hVolume

  exact
    hiddenSectorExplicitCurrent_nonlinear_ampere_equation
      coupling
      time
      position
      component

end ZeroDayRestrictedClosures
