import intended_hidden_sector_free_action_coupling

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
A reduced joint hidden–Maxwell Lagrangian.

Variation in `sourceAmplitude` forces
`sourceAmplitude = velocity²`.
-/
noncomputable def hiddenSectorReducedJointLagrangian
    (velocity sourceAmplitude : ℝ) :
    ℝ :=
  hiddenSectorFreeLagrangian velocity +
    (1 / 2 : ℝ) *
      (sourceAmplitude - velocity ^ 2) ^ 2

/--
The source-amplitude Euler–Lagrange residual.
-/
def hiddenSectorReducedJointSourceResidual
    (velocity sourceAmplitude : ℝ) :
    ℝ :=
  sourceAmplitude - velocity ^ 2

/--
The hidden canonical momentum derived from the reduced joint Lagrangian.
-/
def hiddenSectorReducedJointHiddenMomentum
    (velocity sourceAmplitude : ℝ) :
    ℝ :=
  velocity -
    2 * velocity *
      (sourceAmplitude - velocity ^ 2)

/--
The derivative with respect to the auxiliary source amplitude is the source
residual.
-/
theorem hiddenSectorReducedJointLagrangian_source_hasDerivAt
    (velocity sourceAmplitude : ℝ) :
    HasDerivAt
        (fun amplitude : ℝ =>
          hiddenSectorReducedJointLagrangian
            velocity
            amplitude)
        (hiddenSectorReducedJointSourceResidual
          velocity
          sourceAmplitude)
        sourceAmplitude := by
  have hFree :
      HasDerivAt
        (fun _amplitude : ℝ =>
          hiddenSectorFreeLagrangian velocity)
        0
        sourceAmplitude :=
    hasDerivAt_const
      (x := sourceAmplitude)
      (hiddenSectorFreeLagrangian velocity)

  have hInner :
      HasDerivAt
        (fun amplitude : ℝ =>
          amplitude - velocity ^ 2)
        1
        sourceAmplitude := by
    exact
      (hasDerivAt_id sourceAmplitude).sub_const
        (velocity ^ 2)

  have hPenalty :
      HasDerivAt
        (fun amplitude : ℝ =>
          (1 / 2 : ℝ) *
            (amplitude - velocity ^ 2) ^ 2)
        (sourceAmplitude - velocity ^ 2)
        sourceAmplitude := by
    convert
      (hInner.pow 2).const_mul
        (1 / 2 : ℝ)
      using 1 <;>
      norm_num <;>
      ring

  convert hFree.add hPenalty using 1 <;>
    norm_num [
      hiddenSectorReducedJointLagrangian,
      hiddenSectorReducedJointSourceResidual
    ] <;>
    ring

/--
The source derivative is exactly the source residual.
-/
theorem hiddenSectorReducedJointLagrangian_sourceDerivative_exact
    (velocity sourceAmplitude : ℝ) :
    deriv
        (fun amplitude : ℝ =>
          hiddenSectorReducedJointLagrangian
            velocity
            amplitude)
        sourceAmplitude =
      hiddenSectorReducedJointSourceResidual
        velocity
        sourceAmplitude :=
  (hiddenSectorReducedJointLagrangian_source_hasDerivAt
    velocity
    sourceAmplitude).deriv

/--
The derivative with respect to hidden velocity is the declared reduced
canonical momentum.
-/
theorem hiddenSectorReducedJointLagrangian_velocity_hasDerivAt
    (velocity sourceAmplitude : ℝ) :
    HasDerivAt
        (fun currentVelocity : ℝ =>
          hiddenSectorReducedJointLagrangian
            currentVelocity
            sourceAmplitude)
        (hiddenSectorReducedJointHiddenMomentum
          velocity
          sourceAmplitude)
        velocity := by
  have hFree :=
    hiddenSectorFreeLagrangian_hasDerivAt
      velocity

  have hSquare :
      HasDerivAt
        (fun currentVelocity : ℝ =>
          currentVelocity ^ 2)
        (2 * velocity)
        velocity := by
    convert
      (hasDerivAt_id velocity).pow 2
      using 1 <;>
      norm_num <;>
      ring

  have hInner :
      HasDerivAt
        (fun currentVelocity : ℝ =>
          sourceAmplitude -
            currentVelocity ^ 2)
        (-(2 * velocity))
        velocity := by
    convert
      (hasDerivAt_const
        (x := velocity)
        sourceAmplitude).sub hSquare
      using 1 <;>
      ring

  have hPenalty :
      HasDerivAt
        (fun currentVelocity : ℝ =>
          (1 / 2 : ℝ) *
            (sourceAmplitude -
              currentVelocity ^ 2) ^ 2)
        (-2 * velocity *
          (sourceAmplitude - velocity ^ 2))
        velocity := by
    convert
      (hInner.pow 2).const_mul
        (1 / 2 : ℝ)
      using 1 <;>
      norm_num <;>
      ring

  convert hFree.add hPenalty using 1 <;>
    norm_num [
      hiddenSectorReducedJointLagrangian,
      hiddenSectorReducedJointHiddenMomentum
    ] <;>
    ring

/--
The velocity derivative is exactly the hidden canonical momentum.
-/
theorem hiddenSectorReducedJointLagrangian_velocityDerivative_exact
    (velocity sourceAmplitude : ℝ) :
    deriv
        (fun currentVelocity : ℝ =>
          hiddenSectorReducedJointLagrangian
            currentVelocity
            sourceAmplitude)
        velocity =
      hiddenSectorReducedJointHiddenMomentum
        velocity
        sourceAmplitude :=
  (hiddenSectorReducedJointLagrangian_velocity_hasDerivAt
    velocity
    sourceAmplitude).deriv

/--
The source amplitude selected by hidden momentum.
-/
def hiddenSectorReducedJointStationaryAmplitude
    (momentum : ℝ) :
    ℝ :=
  hiddenSectorFreeActionAmplitude momentum

/--
The stationary source amplitude is `momentum²`.
-/
theorem hiddenSectorReducedJointStationaryAmplitude_exact
    (momentum : ℝ) :
    hiddenSectorReducedJointStationaryAmplitude momentum =
      momentum ^ 2 := by
  rfl

/--
The source Euler–Lagrange residual vanishes at the stationary amplitude.
-/
theorem hiddenSectorReducedJoint_sourceStationary
    (momentum : ℝ) :
    hiddenSectorReducedJointSourceResidual
        momentum
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      0 := by
  simp [
    hiddenSectorReducedJointSourceResidual,
    hiddenSectorReducedJointStationaryAmplitude,
    hiddenSectorFreeActionAmplitude
  ]

/--
The hidden canonical momentum reduces to the free momentum on the stationary
branch.
-/
theorem hiddenSectorReducedJoint_hiddenMomentum_stationary_exact
    (momentum : ℝ) :
    hiddenSectorReducedJointHiddenMomentum
        momentum
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      momentum := by
  simp [
    hiddenSectorReducedJointHiddenMomentum,
    hiddenSectorReducedJointStationaryAmplitude,
    hiddenSectorFreeActionAmplitude
  ]

/--
The source Euler–Lagrange equation holds along the affine hidden trajectory.
-/
theorem hiddenSectorReducedJoint_affine_sourceStationary
    (q₀ momentum time : ℝ) :
    hiddenSectorReducedJointSourceResidual
        (deriv
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          time)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      0 := by
  rw [
    hiddenSectorFreeTrajectory_velocity_exact
  ]

  exact
    hiddenSectorReducedJoint_sourceStationary
      momentum

/--
The reduced hidden canonical momentum along a trajectory.
-/
noncomputable def hiddenSectorReducedJointTrajectoryMomentum
    (trajectory : ℝ → ℝ)
    (sourceAmplitude : ℝ) :
    ℝ → ℝ :=
  fun time =>
    hiddenSectorReducedJointHiddenMomentum
      (deriv trajectory time)
      sourceAmplitude

/--
The reduced hidden Euler–Lagrange residual.
-/
noncomputable def hiddenSectorReducedJointHiddenEulerLagrangeResidual
    (trajectory : ℝ → ℝ)
    (sourceAmplitude time : ℝ) :
    ℝ :=
  deriv
    (hiddenSectorReducedJointTrajectoryMomentum
      trajectory
      sourceAmplitude)
    time

/--
The reduced hidden canonical momentum is constant along the affine
stationary trajectory.
-/
theorem hiddenSectorReducedJoint_affineTrajectoryMomentum_exact
    (q₀ momentum time : ℝ) :
    hiddenSectorReducedJointTrajectoryMomentum
        (hiddenSectorFreeTrajectory
          q₀
          momentum)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum)
        time =
      momentum := by
  unfold hiddenSectorReducedJointTrajectoryMomentum

  rw [
    hiddenSectorFreeTrajectory_velocity_exact
  ]

  exact
    hiddenSectorReducedJoint_hiddenMomentum_stationary_exact
      momentum

/--
The affine hidden trajectory satisfies the reduced hidden Euler–Lagrange
equation globally.
-/
theorem hiddenSectorReducedJoint_affine_hiddenEulerLagrange
    (q₀ momentum time : ℝ) :
    hiddenSectorReducedJointHiddenEulerLagrangeResidual
        (hiddenSectorFreeTrajectory
          q₀
          momentum)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum)
        time =
      0 := by
  have hMomentum :
      hiddenSectorReducedJointTrajectoryMomentum
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) =
        fun _time : ℝ => momentum := by
    funext currentTime

    exact
      hiddenSectorReducedJoint_affineTrajectoryMomentum_exact
        q₀
        momentum
        currentTime

  unfold hiddenSectorReducedJointHiddenEulerLagrangeResidual
  rw [hMomentum]

  simpa using
    (hasDerivAt_const
      (x := time)
      momentum).deriv

/--
The unit-interval reduced joint action.
-/
noncomputable def hiddenSectorReducedJointAction
    (trajectory : ℝ → ℝ)
    (sourceAmplitude : ℝ) :
    ℝ :=
  ∫ time in (0 : ℝ)..1,
    hiddenSectorReducedJointLagrangian
      (deriv trajectory time)
      sourceAmplitude

/--
On the stationary branch, the joint Lagrangian reduces to the free hidden
Lagrangian.
-/
theorem hiddenSectorReducedJointLagrangian_stationary_exact
    (momentum : ℝ) :
    hiddenSectorReducedJointLagrangian
        momentum
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      hiddenSectorFreeLagrangian momentum := by
  simp [
    hiddenSectorReducedJointLagrangian,
    hiddenSectorReducedJointStationaryAmplitude,
    hiddenSectorFreeActionAmplitude
  ]

/--
For an affine trajectory and stationary amplitude, the reduced joint action
equals the free hidden action.
-/
theorem hiddenSectorReducedJointAction_affine_eq_freeAction
    (q₀ momentum : ℝ) :
    hiddenSectorReducedJointAction
        (hiddenSectorFreeTrajectory
          q₀
          momentum)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      hiddenSectorFreeAction
        (hiddenSectorFreeTrajectory
          q₀
          momentum) := by
  unfold hiddenSectorReducedJointAction
  unfold hiddenSectorFreeAction

  apply intervalIntegral.integral_congr
  intro time _

  change
    hiddenSectorReducedJointLagrangian
        (deriv
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          time)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      hiddenSectorFreeLagrangian
        (deriv
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          time)

  rw [
    hiddenSectorFreeTrajectory_velocity_exact
  ]

  exact
    hiddenSectorReducedJointLagrangian_stationary_exact
      momentum

/--
The stationary affine reduced joint action is `momentum²/2`.
-/
theorem hiddenSectorReducedJointAction_affine_value
    (q₀ momentum : ℝ) :
    hiddenSectorReducedJointAction
        (hiddenSectorFreeTrajectory
          q₀
          momentum)
        (hiddenSectorReducedJointStationaryAmplitude
          momentum) =
      momentum ^ 2 / 2 := by
  calc
    hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) =
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum) :=
      hiddenSectorReducedJointAction_affine_eq_freeAction
        q₀
        momentum

    _ =
      momentum ^ 2 / 2 :=
      hiddenSectorFreeAction_affine_value
        q₀
        momentum

/--
The static-curl Maxwell field on the stationary branch.
-/
noncomputable def hiddenSectorReducedJointStaticCurlField
    (momentum μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    SmoothMaxwellField3 :=
  hiddenSectorStaticCurlField
    (hiddenSectorReducedJointStationaryAmplitude
      momentum)
    μ₀
    domain

/--
The reduced-joint field carries the normalized current with the
variationally selected amplitude.
-/
theorem hiddenSectorReducedJointStaticCurlField_current_exact
    (momentum μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    (hiddenSectorReducedJointStaticCurlField
        momentum
        μ₀
        domain).current =
      hiddenSectorStaticCurrent
        (hiddenSectorReducedJointStationaryAmplitude
          momentum)
        domain := by
  rfl

/--
The reduced-joint field satisfies Faraday and Ampère–Maxwell globally.
-/
theorem hiddenSectorReducedJointStaticCurl_evolution
    (momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (point : MaxwellSpacetime3) :
    UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        (hiddenSectorReducedJointStaticCurlField
          momentum
          μ₀
          domain)
        point := by
  simpa [
    hiddenSectorReducedJointStaticCurlField
  ] using
    hiddenSectorStaticCurl_evolution
      (hiddenSectorReducedJointStationaryAmplitude
        momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      point.1
      point.2

/--
The reduced-joint field satisfies both Gauss laws and local continuity.
-/
theorem hiddenSectorReducedJointStaticCurl_gaussContinuity_global
    (momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    ∀ point : MaxwellSpacetime3,
      maxwellDivergence3
            (hiddenSectorReducedJointStaticCurlField
              momentum
              μ₀
              domain).electric
            point =
          hiddenSectorStaticChargeDensity point / ε₀ ∧
        maxwellDivergence3
            (hiddenSectorReducedJointStaticCurlField
              momentum
              μ₀
              domain).magnetic
            point =
          0 ∧
        maxwellTimeDerivative3
              hiddenSectorStaticChargeDensity
              point +
            maxwellDivergence3
              (hiddenSectorReducedJointStaticCurlField
                momentum
                μ₀
                domain).current
              point =
          0 := by
  simpa [
    hiddenSectorReducedJointStaticCurlField
  ] using
    hiddenSectorStaticCurl_gaussContinuity_global
      (hiddenSectorReducedJointStationaryAmplitude
        momentum)
      ε₀
      μ₀
      domain

/--
The affine hidden trajectory, stationary source, and static-curl field solve
the reduced coupled equations simultaneously.
-/
theorem hiddenSectorReducedJoint_affine_staticCurl_simultaneous_solution
    (q₀ momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    (∀ time : ℝ,
      hiddenSectorReducedJointSourceResidual
          (deriv
            (hiddenSectorFreeTrajectory
              q₀
              momentum)
            time)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) =
        0) ∧
      (∀ time : ℝ,
        hiddenSectorReducedJointHiddenEulerLagrangeResidual
            (hiddenSectorFreeTrajectory
              q₀
              momentum)
            (hiddenSectorReducedJointStationaryAmplitude
              momentum)
            time =
          0) ∧
      (∀ point : MaxwellSpacetime3,
        UncontractedMaxwellEvolutionAt3
          ε₀
          μ₀
          (hiddenSectorReducedJointStaticCurlField
            momentum
            μ₀
            domain)
          point) := by
  refine
    ⟨?_,
      ?_,
      ?_⟩

  · intro time

    exact
      hiddenSectorReducedJoint_affine_sourceStationary
        q₀
        momentum
        time

  · intro time

    exact
      hiddenSectorReducedJoint_affine_hiddenEulerLagrange
        q₀
        momentum
        time

  · intro point

    exact
      hiddenSectorReducedJointStaticCurl_evolution
        momentum
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        point

/--
The total outward Maxwell flux equals the stationary source amplitude.
-/
theorem hiddenSectorReducedJointStaticCurl_boundaryFlux_exact
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
          (hiddenSectorReducedJointStaticCurlField
            momentum
            μ₀
            domain)
          time) =
      hiddenSectorReducedJointStationaryAmplitude
        momentum := by
  simpa [
    hiddenSectorReducedJointStaticCurlField
  ] using
    hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
      (hiddenSectorReducedJointStationaryAmplitude
        momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

/--
The total outward flux is twice the stationary reduced joint action.
-/
theorem hiddenSectorReducedJointStaticCurl_boundaryFlux_eq_twice_action
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
          (hiddenSectorReducedJointStaticCurlField
            momentum
            μ₀
            domain)
          time) =
      2 *
        hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) := by
  calc
    maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorReducedJointStaticCurlField
              momentum
              μ₀
              domain)
            time) =
        hiddenSectorReducedJointStationaryAmplitude
          momentum :=
      hiddenSectorReducedJointStaticCurl_boundaryFlux_exact
        momentum
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time

    _ =
      2 *
        hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) := by
      rw [
        hiddenSectorReducedJointAction_affine_value
      ]

      simp [
        hiddenSectorReducedJointStationaryAmplitude,
        hiddenSectorFreeActionAmplitude
      ]

      ring

/--
For a centered domain, each active face carries one reduced-joint action
unit.
-/
theorem hiddenSectorReducedJointStaticCurl_centered_faces_each_eq_action
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
          (hiddenSectorReducedJointStationaryAmplitude
            momentum)
          μ₀
          domain
          time
          (1 : Fin 3) =
        hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) ∧
      hiddenSectorStaticCurlLowerFaceFlux
          (hiddenSectorReducedJointStationaryAmplitude
            momentum)
          μ₀
          domain
          time
          (1 : Fin 3) =
        hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) := by
  have hFaces :=
    hiddenSectorStaticCurl_centered_axisOneFaces_each_eq_half
      (hiddenSectorReducedJointStationaryAmplitude
        momentum)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      hCentered
      time

  have hHalf :
      hiddenSectorReducedJointStationaryAmplitude
            momentum /
          2 =
        hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            momentum)
          (hiddenSectorReducedJointStationaryAmplitude
            momentum) := by
    rw [
      hiddenSectorReducedJointAction_affine_value
    ]

    simp [
      hiddenSectorReducedJointStationaryAmplitude,
      hiddenSectorFreeActionAmplitude
    ]

  exact
    ⟨hFaces.1.trans hHalf,
      hFaces.2.trans hHalf⟩

/--
The reduced-joint rank-255 stationary amplitude is exactly `2^255`.
-/
theorem darkMatterUnitCoupling_reducedJoint_stationaryAmplitude_exact :
    hiddenSectorReducedJointStationaryAmplitude
        darkMatterUnitCouplingFreeActionMomentum =
      ((2 ^ 255 : Nat) : ℝ) := by
  exact
    darkMatterUnitCoupling_freeActionAmplitude_exact

/--
The reduced-joint rank-255 action is exactly `2^254`.
-/
theorem darkMatterUnitCoupling_reducedJoint_action_exact
    (q₀ : ℝ) :
    hiddenSectorReducedJointAction
        (hiddenSectorFreeTrajectory
          q₀
          darkMatterUnitCouplingFreeActionMomentum)
        (hiddenSectorReducedJointStationaryAmplitude
          darkMatterUnitCouplingFreeActionMomentum) =
      ((2 ^ 254 : Nat) : ℝ) := by
  calc
    hiddenSectorReducedJointAction
          (hiddenSectorFreeTrajectory
            q₀
            darkMatterUnitCouplingFreeActionMomentum)
          (hiddenSectorReducedJointStationaryAmplitude
            darkMatterUnitCouplingFreeActionMomentum) =
        hiddenSectorFreeAction
          (hiddenSectorFreeTrajectory
            q₀
            darkMatterUnitCouplingFreeActionMomentum) :=
      hiddenSectorReducedJointAction_affine_eq_freeAction
        q₀
        darkMatterUnitCouplingFreeActionMomentum

    _ =
      ((2 ^ 254 : Nat) : ℝ) :=
      darkMatterUnitCoupling_freeAction_exact
        q₀

/--
The reduced-joint rank-255 field equals the prior rank-255 field.
-/
theorem darkMatterUnitCoupling_reducedJoint_field_eq_staticCurlField
    (μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3) :
    hiddenSectorReducedJointStaticCurlField
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
  unfold hiddenSectorReducedJointStaticCurlField

  exact
    congrArg
      (fun amplitude : ℝ =>
        hiddenSectorStaticCurlField
          amplitude
          μ₀
          domain)
      darkMatterUnitCoupling_freeActionAmplitude_eq_closureAmplitude

/--
The rank-255 trajectory and field solve the reduced coupled equations.
-/
theorem darkMatterUnitCoupling_reducedJoint_simultaneous_solution
    (q₀ ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    (∀ time : ℝ,
      hiddenSectorReducedJointSourceResidual
          (deriv
            (hiddenSectorFreeTrajectory
              q₀
              darkMatterUnitCouplingFreeActionMomentum)
            time)
          (hiddenSectorReducedJointStationaryAmplitude
            darkMatterUnitCouplingFreeActionMomentum) =
        0) ∧
      (∀ time : ℝ,
        hiddenSectorReducedJointHiddenEulerLagrangeResidual
            (hiddenSectorFreeTrajectory
              q₀
              darkMatterUnitCouplingFreeActionMomentum)
            (hiddenSectorReducedJointStationaryAmplitude
              darkMatterUnitCouplingFreeActionMomentum)
            time =
          0) ∧
      (∀ point : MaxwellSpacetime3,
        UncontractedMaxwellEvolutionAt3
          ε₀
          μ₀
          (hiddenSectorReducedJointStaticCurlField
            darkMatterUnitCouplingFreeActionMomentum
            μ₀
            domain)
          point) :=
  hiddenSectorReducedJoint_affine_staticCurl_simultaneous_solution
    q₀
    darkMatterUnitCouplingFreeActionMomentum
    ε₀
    μ₀
    domain
    hμ₀
    hVolume

/--
The rank-255 reduced-joint field has total outward flux `2^255`.
-/
theorem darkMatterUnitCoupling_reducedJoint_boundaryFlux_exact
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
          (hiddenSectorReducedJointStaticCurlField
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
            (hiddenSectorReducedJointStaticCurlField
              darkMatterUnitCouplingFreeActionMomentum
              μ₀
              domain)
            time) =
        hiddenSectorReducedJointStationaryAmplitude
          darkMatterUnitCouplingFreeActionMomentum :=
      hiddenSectorReducedJointStaticCurl_boundaryFlux_exact
        darkMatterUnitCouplingFreeActionMomentum
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time

    _ =
      ((2 ^ 255 : Nat) : ℝ) :=
      darkMatterUnitCoupling_reducedJoint_stationaryAmplitude_exact

end ZeroDayRestrictedClosures
