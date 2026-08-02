import intended_hidden_sector_static_curl_gauss_continuity

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
An affine hidden-sector trajectory with initial coordinate `q₀` and constant
momentum parameter `p`.
-/
def hiddenSectorFreeTrajectory
    (q₀ p : ℝ) :
    ℝ → ℝ :=
  fun time =>
    q₀ + p * time

/--
The minimal free hidden-sector Lagrangian.
-/
noncomputable def hiddenSectorFreeLagrangian
    (velocity : ℝ) :
    ℝ :=
  (1 / 2 : ℝ) * velocity ^ 2

/--
The unit-interval action of a hidden-sector trajectory.
-/
noncomputable def hiddenSectorFreeAction
    (trajectory : ℝ → ℝ) :
    ℝ :=
  ∫ time in (0 : ℝ)..1,
    hiddenSectorFreeLagrangian
      (deriv trajectory time)

/--
For the free Lagrangian, canonical momentum is the velocity.
-/
def hiddenSectorFreeCanonicalMomentumAt
    (velocity : ℝ) :
    ℝ :=
  velocity

/--
Canonical momentum along a trajectory.
-/
noncomputable def hiddenSectorFreeTrajectoryMomentum
    (trajectory : ℝ → ℝ) :
    ℝ → ℝ :=
  fun time =>
    hiddenSectorFreeCanonicalMomentumAt
      (deriv trajectory time)

/--
The free Euler–Lagrange residual is the time derivative of canonical
momentum.
-/
noncomputable def hiddenSectorFreeEulerLagrangeResidual
    (trajectory : ℝ → ℝ)
    (time : ℝ) :
    ℝ :=
  deriv
    (hiddenSectorFreeTrajectoryMomentum trajectory)
    time

/--
The affine hidden trajectory has constant derivative `p`.
-/
theorem hiddenSectorFreeTrajectory_hasDerivAt
    (q₀ p time : ℝ) :
    HasDerivAt
        (hiddenSectorFreeTrajectory q₀ p)
        p
        time := by
  simpa [hiddenSectorFreeTrajectory] using
    (hasDerivAt_const (x := time) q₀).add
      ((hasDerivAt_id time).const_mul p)

/--
The affine trajectory's velocity is exactly its momentum parameter.
-/
theorem hiddenSectorFreeTrajectory_velocity_exact
    (q₀ p time : ℝ) :
    deriv
        (hiddenSectorFreeTrajectory q₀ p)
        time =
      p :=
  (hiddenSectorFreeTrajectory_hasDerivAt
    q₀
    p
    time).deriv

/--
The derivative of the free Lagrangian with respect to velocity is the
canonical momentum.
-/
theorem hiddenSectorFreeLagrangian_hasDerivAt
    (velocity : ℝ) :
    HasDerivAt
        hiddenSectorFreeLagrangian
        velocity
        velocity := by
  convert
    (((hasDerivAt_id velocity).pow 2).const_mul
      (1 / 2 : ℝ))
      using 1 <;>
    norm_num [hiddenSectorFreeLagrangian] <;>
    ring

/--
Canonical momentum agrees with the velocity derivative of the Lagrangian.
-/
theorem hiddenSectorFreeCanonicalMomentum_eq_lagrangianDerivative
    (velocity : ℝ) :
    hiddenSectorFreeCanonicalMomentumAt velocity =
      deriv hiddenSectorFreeLagrangian velocity := by
  rw [
    (hiddenSectorFreeLagrangian_hasDerivAt
      velocity).deriv
  ]

  rfl

/--
Canonical momentum along the affine trajectory is constant.
-/
theorem hiddenSectorFreeTrajectoryMomentum_exact
    (q₀ p time : ℝ) :
    hiddenSectorFreeTrajectoryMomentum
        (hiddenSectorFreeTrajectory q₀ p)
        time =
      p := by
  unfold hiddenSectorFreeTrajectoryMomentum
  unfold hiddenSectorFreeCanonicalMomentumAt

  exact
    hiddenSectorFreeTrajectory_velocity_exact
      q₀
      p
      time

/--
The affine trajectory satisfies the free Euler–Lagrange equation globally.
-/
theorem hiddenSectorFreeTrajectory_eulerLagrange
    (q₀ p time : ℝ) :
    hiddenSectorFreeEulerLagrangeResidual
        (hiddenSectorFreeTrajectory q₀ p)
        time =
      0 := by
  have hMomentum :
      hiddenSectorFreeTrajectoryMomentum
          (hiddenSectorFreeTrajectory q₀ p) =
        fun _time : ℝ => p := by
    funext currentTime

    exact
      hiddenSectorFreeTrajectoryMomentum_exact
        q₀
        p
        currentTime

  unfold hiddenSectorFreeEulerLagrangeResidual
  rw [hMomentum]

  simpa using
    (hasDerivAt_const
      (x := time)
      p).deriv

/--
The affine trajectory's unit-interval action equals its constant
Lagrangian value.
-/
theorem hiddenSectorFreeAction_affine_exact
    (q₀ p : ℝ) :
    hiddenSectorFreeAction
        (hiddenSectorFreeTrajectory q₀ p) =
      hiddenSectorFreeLagrangian p := by
  unfold hiddenSectorFreeAction

  calc
    (∫ time in (0 : ℝ)..1,
      hiddenSectorFreeLagrangian
        (deriv
          (hiddenSectorFreeTrajectory q₀ p)
          time)) =
      ∫ _time in (0 : ℝ)..1,
        hiddenSectorFreeLagrangian p := by
          apply intervalIntegral.integral_congr
          intro time _

          change
            hiddenSectorFreeLagrangian
                (deriv
                  (hiddenSectorFreeTrajectory q₀ p)
                  time) =
              hiddenSectorFreeLagrangian p

          rw [
            hiddenSectorFreeTrajectory_velocity_exact
          ]

    _ =
      hiddenSectorFreeLagrangian p := by
        simp

/--
The explicit unit-interval action value is `p²/2`.
-/
theorem hiddenSectorFreeAction_affine_value
    (q₀ p : ℝ) :
    hiddenSectorFreeAction
        (hiddenSectorFreeTrajectory q₀ p) =
      p ^ 2 / 2 := by
  rw [
    hiddenSectorFreeAction_affine_exact
  ]

  unfold hiddenSectorFreeLagrangian
  ring

/--
The Maxwell source amplitude selected from the free hidden trajectory is the
square of its conserved canonical momentum.
-/
def hiddenSectorFreeActionAmplitude
    (momentum : ℝ) :
    ℝ :=
  momentum ^ 2

/--
The action-selected amplitude is nonnegative.
-/
theorem hiddenSectorFreeActionAmplitude_nonnegative
    (momentum : ℝ) :
    0 ≤ hiddenSectorFreeActionAmplitude momentum := by
  exact
    sq_nonneg momentum

/--
The selected source amplitude equals twice the unit-interval free action.
-/
theorem hiddenSectorFreeActionAmplitude_eq_twice_action
    (q₀ momentum : ℝ) :
    hiddenSectorFreeActionAmplitude momentum =
      2 *
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) := by
  rw [
    hiddenSectorFreeAction_affine_value
  ]

  unfold hiddenSectorFreeActionAmplitude
  ring

/--
Every nonnegative amplitude is realized by the conserved momentum
`sqrt A`.
-/
theorem hiddenSectorFreeActionAmplitude_sqrt_exact
    (amplitude : ℝ)
    (hAmplitude : 0 ≤ amplitude) :
    hiddenSectorFreeActionAmplitude
        (Real.sqrt amplitude) =
      amplitude := by
  simpa [hiddenSectorFreeActionAmplitude] using
    Real.sq_sqrt hAmplitude

/--
The explicit static-curl Maxwell field selected by the conserved free-action
momentum.
-/
noncomputable def hiddenSectorFreeActionStaticCurlField
    (momentum μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    SmoothMaxwellField3 :=
  hiddenSectorStaticCurlField
    (hiddenSectorFreeActionAmplitude momentum)
    μ₀
    domain

/--
The action-selected field satisfies the uncontracted Faraday and
Ampère–Maxwell evolution equations globally.
-/
theorem hiddenSectorFreeActionStaticCurl_evolution
    (momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (point : MaxwellSpacetime3) :
    UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        (hiddenSectorFreeActionStaticCurlField
          momentum
          μ₀
          domain)
        point := by
  simpa [
    hiddenSectorFreeActionStaticCurlField
  ] using
    hiddenSectorStaticCurl_evolution
      (hiddenSectorFreeActionAmplitude momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      point.1
      point.2

/--
The action-selected field satisfies electric Gauss, magnetic Gauss, and
local charge continuity at every spacetime point.
-/
theorem hiddenSectorFreeActionStaticCurl_gaussContinuity_global
    (momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    ∀ point : MaxwellSpacetime3,
      maxwellDivergence3
            (hiddenSectorFreeActionStaticCurlField
              momentum
              μ₀
              domain).electric
            point =
          hiddenSectorStaticChargeDensity point / ε₀ ∧
        maxwellDivergence3
            (hiddenSectorFreeActionStaticCurlField
              momentum
              μ₀
              domain).magnetic
            point =
          0 ∧
        maxwellTimeDerivative3
              hiddenSectorStaticChargeDensity
              point +
            maxwellDivergence3
              (hiddenSectorFreeActionStaticCurlField
                momentum
                μ₀
                domain).current
              point =
          0 := by
  simpa [
    hiddenSectorFreeActionStaticCurlField
  ] using
    hiddenSectorStaticCurl_gaussContinuity_global
      (hiddenSectorFreeActionAmplitude momentum)
      ε₀
      μ₀
      domain

/--
The total outward Poynting flux equals the squared conserved momentum.
-/
theorem hiddenSectorFreeActionStaticCurl_boundaryFlux_exact
    (momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorFreeActionStaticCurlField
            momentum
            μ₀
            domain)
          time) =
      hiddenSectorFreeActionAmplitude momentum := by
  simpa [
    hiddenSectorFreeActionStaticCurlField
  ] using
    hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
      (hiddenSectorFreeActionAmplitude momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

/--
The total outward Maxwell flux is twice the hidden trajectory's
unit-interval free action.
-/
theorem hiddenSectorFreeActionStaticCurl_boundaryFlux_eq_twice_action
    (q₀ momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorFreeActionStaticCurlField
            momentum
            μ₀
            domain)
          time) =
      2 *
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) := by
  calc
    maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorFreeActionStaticCurlField
              momentum
              μ₀
              domain)
            time) =
        hiddenSectorFreeActionAmplitude momentum :=
      hiddenSectorFreeActionStaticCurl_boundaryFlux_exact
        momentum
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time

    _ =
      2 *
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) :=
      hiddenSectorFreeActionAmplitude_eq_twice_action
        q₀
        momentum

/--
For a centered rectangular domain, each active face carries exactly the
unit-interval hidden free action.
-/
theorem hiddenSectorFreeActionStaticCurl_centered_faces_each_eq_action
    (q₀ momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hCentered :
      domain.lower (1 : Fin 3) =
        -domain.upper (1 : Fin 3))
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          (hiddenSectorFreeActionAmplitude momentum)
          μ₀
          domain
          time
          (1 : Fin 3) =
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) ∧
      hiddenSectorStaticCurlLowerFaceFlux
          (hiddenSectorFreeActionAmplitude momentum)
          μ₀
          domain
          time
          (1 : Fin 3) =
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) := by
  have hFaces :=
    hiddenSectorStaticCurl_centered_axisOneFaces_each_eq_half
      (hiddenSectorFreeActionAmplitude momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      hCentered
      time

  have hHalfAction :
      hiddenSectorFreeActionAmplitude momentum / 2 =
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) := by
    rw [
      hiddenSectorFreeAction_affine_value
    ]

    unfold hiddenSectorFreeActionAmplitude
    ring

  exact
    ⟨hFaces.1.trans hHalfAction,
      hFaces.2.trans hHalfAction⟩

/--
The conserved momentum used to realize the rank-255 unit-coupling closure
amplitude.
-/
noncomputable def darkMatterUnitCouplingFreeActionMomentum :
    ℝ :=
  Real.sqrt
    (darkMatterClosureAmplitude
      1
      1
      darkMatterExplosionInitialState : ℝ)

/--
The rank-255 closure amplitude is exactly the square of the selected
conserved momentum.
-/
theorem darkMatterUnitCoupling_freeActionAmplitude_eq_closureAmplitude :
    hiddenSectorFreeActionAmplitude
        darkMatterUnitCouplingFreeActionMomentum =
      (darkMatterClosureAmplitude
        1
        1
        darkMatterExplosionInitialState : ℝ) := by
  unfold darkMatterUnitCouplingFreeActionMomentum

  apply
    hiddenSectorFreeActionAmplitude_sqrt_exact

  rw [
    darkMatterUnitCoupling_closureAmplitude_real_exact
  ]

  positivity

/--
The action-selected rank-255 source amplitude is exactly `2^255`.
-/
theorem darkMatterUnitCoupling_freeActionAmplitude_exact :
    hiddenSectorFreeActionAmplitude
        darkMatterUnitCouplingFreeActionMomentum =
      ((2 ^ 255 : Nat) : ℝ) := by
  calc
    hiddenSectorFreeActionAmplitude
          darkMatterUnitCouplingFreeActionMomentum =
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) :=
      darkMatterUnitCoupling_freeActionAmplitude_eq_closureAmplitude

    _ =
      ((2 ^ 255 : Nat) : ℝ) :=
      darkMatterUnitCoupling_closureAmplitude_real_exact

/--
The rank-255 affine hidden trajectory has unit-interval action exactly
`2^254`.
-/
theorem darkMatterUnitCoupling_freeAction_exact
    (q₀ : ℝ) :
    hiddenSectorFreeAction
        (hiddenSectorFreeTrajectory
          q₀
          darkMatterUnitCouplingFreeActionMomentum) =
      ((2 ^ 254 : Nat) : ℝ) := by
  calc
    hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            darkMatterUnitCouplingFreeActionMomentum) =
        darkMatterUnitCouplingFreeActionMomentum ^ 2 / 2 :=
      hiddenSectorFreeAction_affine_value
        q₀
        darkMatterUnitCouplingFreeActionMomentum

    _ =
        hiddenSectorFreeActionAmplitude
            darkMatterUnitCouplingFreeActionMomentum /
          2 := by
      rfl

    _ =
        ((2 ^ 255 : Nat) : ℝ) / 2 := by
      rw [
        darkMatterUnitCoupling_freeActionAmplitude_exact
      ]

    _ =
      ((2 ^ 254 : Nat) : ℝ) := by
      simpa using
        real_cast_two_pow_succ_div_two 254

/--
The rank-255 action-selected trajectory satisfies the Euler–Lagrange equation
at every time.
-/
theorem darkMatterUnitCoupling_freeTrajectory_eulerLagrange
    (q₀ time : ℝ) :
    hiddenSectorFreeEulerLagrangeResidual
        (hiddenSectorFreeTrajectory
          q₀
          darkMatterUnitCouplingFreeActionMomentum)
        time =
      0 :=
  hiddenSectorFreeTrajectory_eulerLagrange
    q₀
    darkMatterUnitCouplingFreeActionMomentum
    time

/--
The action-selected rank-255 Maxwell field equals the prior rank-255
static-curl field.
-/
theorem darkMatterUnitCoupling_freeActionField_eq_staticCurlField
    (μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    hiddenSectorFreeActionStaticCurlField
        darkMatterUnitCouplingFreeActionMomentum
        μ₀
        domain =
      hiddenSectorStaticCurlField
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ)
        μ₀
        domain := by
  unfold hiddenSectorFreeActionStaticCurlField

  exact
    congrArg
      (fun amplitude : ℝ =>
        hiddenSectorStaticCurlField
          amplitude
          μ₀
          domain)
      darkMatterUnitCoupling_freeActionAmplitude_eq_closureAmplitude

/--
The rank-255 action-selected field satisfies the complete Faraday and
Ampère–Maxwell evolution equations.
-/
theorem darkMatterUnitCoupling_freeActionStaticCurl_evolution
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (point : MaxwellSpacetime3) :
    UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        (hiddenSectorFreeActionStaticCurlField
          darkMatterUnitCouplingFreeActionMomentum
          μ₀
          domain)
        point :=
  hiddenSectorFreeActionStaticCurl_evolution
    darkMatterUnitCouplingFreeActionMomentum
    ε₀
    μ₀
    domain
    hμ₀
    hVolume
    point

/--
The rank-255 action-selected field has exact total outward flux `2^255`.
-/
theorem darkMatterUnitCoupling_freeActionStaticCurl_boundaryFlux_exact
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorFreeActionStaticCurlField
            darkMatterUnitCouplingFreeActionMomentum
            μ₀
            domain)
          time) =
      ((2 ^ 255 : Nat) : ℝ) := by
  calc
    maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorFreeActionStaticCurlField
              darkMatterUnitCouplingFreeActionMomentum
              μ₀
              domain)
            time) =
        hiddenSectorFreeActionAmplitude
          darkMatterUnitCouplingFreeActionMomentum :=
      hiddenSectorFreeActionStaticCurl_boundaryFlux_exact
        darkMatterUnitCouplingFreeActionMomentum
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time

    _ =
      ((2 ^ 255 : Nat) : ℝ) :=
      darkMatterUnitCoupling_freeActionAmplitude_exact

end ZeroDayRestrictedClosures
