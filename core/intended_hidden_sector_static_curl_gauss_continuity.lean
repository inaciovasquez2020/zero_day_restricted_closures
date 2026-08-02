import intended_hidden_sector_static_curl_individual_face_flux

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
The charge density associated with the explicit static-curl construction is
identically zero.
-/
def hiddenSectorStaticChargeDensity :
    MaxwellSpacetime3 → ℝ :=
  fun _point => 0

/--
Every spatial derivative of every component of the constant electric field
vanishes.
-/
theorem hiddenSectorStaticElectric_componentSpatialDerivative_zero
    (component direction : Fin 3)
    (point : MaxwellSpacetime3) :
    maxwellSpatialDerivative3
        (fun q =>
          hiddenSectorStaticElectric q component)
        direction
        point =
      0 := by
  let c : ℝ :=
    hiddenSectorStaticElectric point component

  have hConstant :
      (fun q : MaxwellSpacetime3 =>
        hiddenSectorStaticElectric q component) =
        fun _q : MaxwellSpacetime3 => c := by
    funext q
    simp [
      c,
      hiddenSectorStaticElectric
    ]

  unfold maxwellSpatialDerivative3
  rw [hConstant]

  have hDerivative :
      HasFDerivAt
        (fun _q : MaxwellSpacetime3 => c)
        (0 : MaxwellSpacetime3 →L[ℝ] ℝ)
        point := by
    exact
      hasFDerivAt_const
        c
        point

  rw [hDerivative.fderiv]
  rfl

/--
The explicit constant electric field has zero spatial divergence.
-/
theorem hiddenSectorStaticElectric_divergence_zero
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        hiddenSectorStaticElectric
        point =
      0 := by
  unfold maxwellDivergence3

  apply Finset.sum_eq_zero
  intro component _

  exact
    hiddenSectorStaticElectric_componentSpatialDerivative_zero
      component
      component
      point

/--
Every spatial derivative of every component of the constant static current
vanishes.
-/
theorem hiddenSectorStaticCurrent_componentSpatialDerivative_zero
    (A : ℝ)
    (domain : MaxwellRectangularDomain3)
    (component direction : Fin 3)
    (point : MaxwellSpacetime3) :
    maxwellSpatialDerivative3
        (fun q =>
          hiddenSectorStaticCurrent
            A
            domain
            q
            component)
        direction
        point =
      0 := by
  let c : ℝ :=
    hiddenSectorStaticCurrent
      A
      domain
      point
      component

  have hConstant :
      (fun q : MaxwellSpacetime3 =>
        hiddenSectorStaticCurrent
          A
          domain
          q
          component) =
        fun _q : MaxwellSpacetime3 => c := by
    funext q
    simp [
      c,
      hiddenSectorStaticCurrent
    ]

  unfold maxwellSpatialDerivative3
  rw [hConstant]

  have hDerivative :
      HasFDerivAt
        (fun _q : MaxwellSpacetime3 => c)
        (0 : MaxwellSpacetime3 →L[ℝ] ℝ)
        point := by
    exact
      hasFDerivAt_const
        c
        point

  rw [hDerivative.fderiv]
  rfl

/--
The explicit normalized static current is divergence-free.
-/
theorem hiddenSectorStaticCurrent_divergence_zero
    (A : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurrent
          A
          domain)
        point =
      0 := by
  unfold maxwellDivergence3

  apply Finset.sum_eq_zero
  intro component _

  exact
    hiddenSectorStaticCurrent_componentSpatialDerivative_zero
      A
      domain
      component
      component
      point

/--
The diagonal spatial derivative of each affine magnetic component vanishes.

The only nonzero derivative of this magnetic field is the off-diagonal
derivative `∂₁B₂`, which produces the required curl but contributes nothing
to the divergence.
-/
theorem hiddenSectorStaticCurlMagnetic_diagonalSpatialDerivative_zero
    (k : ℝ)
    (component : Fin 3)
    (point : MaxwellSpacetime3) :
    maxwellSpatialDerivative3
        (fun q =>
          hiddenSectorStaticCurlMagnetic
            k
            q
            component)
        component
        point =
      0 := by
  unfold maxwellSpatialDerivative3

  have hDerivative :
      HasFDerivAt
        (fun q : MaxwellSpacetime3 =>
          hiddenSectorStaticCurlMagnetic
            k
            q
            component)
        (hiddenSectorStaticCurlMagneticComponentCLM
          k
          component)
        point := by
    simpa [
      hiddenSectorStaticCurlMagnetic,
      hiddenSectorStaticCurlMagneticCLM
    ] using
      (hiddenSectorStaticCurlMagneticComponentCLM
        k
        component).hasFDerivAt

  rw [hDerivative.fderiv]

  fin_cases component <;>
    simp [
      hiddenSectorStaticCurlMagneticComponentCLM,
      hiddenSectorSpatialCoordinateCLM,
      maxwellSpatialDirection3
    ]

/--
The explicit affine magnetic field has zero spatial divergence for every
coupling scale.
-/
theorem hiddenSectorStaticCurlMagnetic_divergence_zero
    (k : ℝ)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlMagnetic k)
        point =
      0 := by
  unfold maxwellDivergence3

  apply Finset.sum_eq_zero
  intro component _

  exact
    hiddenSectorStaticCurlMagnetic_diagonalSpatialDerivative_zero
      k
      component
      point

/--
The electric field in the complete explicit static-curl field is
divergence-free.
-/
theorem hiddenSectorStaticCurlField_electric_divergence_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain).electric
        point =
      0 := by
  change
    maxwellDivergence3
        hiddenSectorStaticElectric
        point =
      0

  exact
    hiddenSectorStaticElectric_divergence_zero
      point

/--
The magnetic field in the complete explicit static-curl field is
divergence-free.
-/
theorem hiddenSectorStaticCurlField_magnetic_divergence_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain).magnetic
        point =
      0 := by
  change
    maxwellDivergence3
        (hiddenSectorStaticCurlMagnetic
          (μ₀ * A /
            hiddenSectorRectangularVolume domain))
        point =
      0

  exact
    hiddenSectorStaticCurlMagnetic_divergence_zero
      (μ₀ * A /
        hiddenSectorRectangularVolume domain)
      point

/--
The current in the complete explicit static-curl field is divergence-free.
-/
theorem hiddenSectorStaticCurlField_current_divergence_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain).current
        point =
      0 := by
  change
    maxwellDivergence3
        (hiddenSectorStaticCurrent
          A
          domain)
        point =
      0

  exact
    hiddenSectorStaticCurrent_divergence_zero
      A
      domain
      point

/--
The zero charge density has zero time derivative.
-/
theorem hiddenSectorStaticChargeDensity_timeDerivative_zero
    (point : MaxwellSpacetime3) :
    maxwellTimeDerivative3
        hiddenSectorStaticChargeDensity
        point =
      0 := by
  have hDerivative :
      HasFDerivAt
        hiddenSectorStaticChargeDensity
        (0 : MaxwellSpacetime3 →L[ℝ] ℝ)
        point := by
    simpa [
      hiddenSectorStaticChargeDensity
    ] using
      (hasFDerivAt_const
        (0 : ℝ)
        point)

  unfold maxwellTimeDerivative3
  rw [hDerivative.fderiv]
  rfl

/--
Gauss's electric law holds with zero charge density.
-/
theorem hiddenSectorStaticCurl_electricGaussLaw
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain).electric
        point =
      hiddenSectorStaticChargeDensity point / ε₀ := by
  rw [
    hiddenSectorStaticCurlField_electric_divergence_zero
  ]

  simp [hiddenSectorStaticChargeDensity]

/--
Gauss's magnetic law holds pointwise: the constructed magnetic field has no
magnetic charge.
-/
theorem hiddenSectorStaticCurl_magneticGaussLaw
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellDivergence3
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain).magnetic
        point =
      0 :=
  hiddenSectorStaticCurlField_magnetic_divergence_zero
    A
    μ₀
    domain
    point

/--
The explicit charge and current satisfy the local continuity equation.
-/
theorem hiddenSectorStaticCurl_chargeContinuity
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3) :
    maxwellTimeDerivative3
          hiddenSectorStaticChargeDensity
          point +
        maxwellDivergence3
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain).current
          point =
      0 := by
  rw [
    hiddenSectorStaticChargeDensity_timeDerivative_zero,
    hiddenSectorStaticCurlField_current_divergence_zero
  ]

  ring

/--
For nonzero electric permittivity, Gauss's electric law forces any compatible
pointwise charge density to be zero.
-/
theorem hiddenSectorStaticCurl_gaussCharge_unique_zero
    (A ε₀ μ₀ ρ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (point : MaxwellSpacetime3)
    (hε₀ : ε₀ ≠ 0)
    (hGauss :
      maxwellDivergence3
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain).electric
          point =
        ρ / ε₀) :
    ρ = 0 := by
  have hDivergence :=
    hiddenSectorStaticCurlField_electric_divergence_zero
      A
      μ₀
      domain
      point

  have hZeroDivision :
      (0 : ℝ) =
        ρ / ε₀ := by
    calc
      (0 : ℝ) =
          maxwellDivergence3
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain).electric
            point :=
        hDivergence.symm

      _ = ρ / ε₀ :=
        hGauss

  calc
    ρ =
        (ρ / ε₀) * ε₀ := by
          field_simp [hε₀]

    _ =
        0 * ε₀ := by
          rw [← hZeroDivision]

    _ = 0 := by
          ring

/--
The complete Gauss-and-continuity constraint package holds globally for the
explicit static-curl field.
-/
theorem hiddenSectorStaticCurl_gaussContinuity_global
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    ∀ point : MaxwellSpacetime3,
      maxwellDivergence3
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain).electric
            point =
          hiddenSectorStaticChargeDensity point / ε₀ ∧
        maxwellDivergence3
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain).magnetic
            point =
          0 ∧
        maxwellTimeDerivative3
              hiddenSectorStaticChargeDensity
              point +
            maxwellDivergence3
              (hiddenSectorStaticCurlField
                A
                μ₀
                domain).current
              point =
          0 := by
  intro point

  exact
    ⟨hiddenSectorStaticCurl_electricGaussLaw
        A
        ε₀
        μ₀
        domain
        point,
      hiddenSectorStaticCurl_magneticGaussLaw
        A
        μ₀
        domain
        point,
      hiddenSectorStaticCurl_chargeContinuity
        A
        μ₀
        domain
        point⟩

/--
The rank-255 unit-coupling static-curl field satisfies the same global
Gauss-and-continuity constraint package.
-/
theorem darkMatterUnitCoupling_staticCurl_gaussContinuity_global
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    ∀ point : MaxwellSpacetime3,
      maxwellDivergence3
            (hiddenSectorStaticCurlField
              (darkMatterClosureAmplitude
                1
                1
                darkMatterExplosionInitialState : ℝ)
              μ₀
              domain).electric
            point =
          hiddenSectorStaticChargeDensity point / ε₀ ∧
        maxwellDivergence3
            (hiddenSectorStaticCurlField
              (darkMatterClosureAmplitude
                1
                1
                darkMatterExplosionInitialState : ℝ)
              μ₀
              domain).magnetic
            point =
          0 ∧
        maxwellTimeDerivative3
              hiddenSectorStaticChargeDensity
              point +
            maxwellDivergence3
              (hiddenSectorStaticCurlField
                (darkMatterClosureAmplitude
                  1
                  1
                  darkMatterExplosionInitialState : ℝ)
                μ₀
                domain).current
              point =
          0 :=
  hiddenSectorStaticCurl_gaussContinuity_global
    (darkMatterClosureAmplitude
      1
      1
      darkMatterExplosionInitialState : ℝ)
    ε₀
    μ₀
    domain

end ZeroDayRestrictedClosures
