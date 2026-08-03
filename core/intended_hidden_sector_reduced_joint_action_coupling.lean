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
The uncontracted Maxwell equations represented as a vector-valued off-shell
residual rather than as a proposition.
-/
noncomputable def hiddenSectorReducedJointMaxwellResidual
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 × MaxwellVector3 :=
  (maxwellTimeDerivative3
        field.magnetic
        point -
      (fun i : Fin 3 =>
        -maxwellCurl3
          field.electric
          point
          i),
    (fun i : Fin 3 =>
      ε₀ *
        maxwellTimeDerivative3
          field.electric
          point
          i) -
      (fun i : Fin 3 =>
        (1 / μ₀) *
            maxwellCurl3
              field.magnetic
              point
              i -
          field.current point i))

/--
The vector-valued Maxwell residual vanishes exactly when the two
uncontracted Maxwell evolution equations hold.
-/
theorem hiddenSectorReducedJointMaxwellResidual_eq_zero_iff
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellResidual
        ε₀
        μ₀
        field
        point =
      (0, 0) ↔
    UncontractedMaxwellEvolutionAt3
      ε₀
      μ₀
      field
      point := by
  constructor
  · intro hResidual

    have hFaradayResidual :
        maxwellTimeDerivative3
              field.magnetic
              point -
            (fun i : Fin 3 =>
              -maxwellCurl3
                field.electric
                point
                i) =
          0 := by
      simpa [
        hiddenSectorReducedJointMaxwellResidual
      ] using
        congrArg Prod.fst hResidual

    have hAmpereResidual :
        (fun i : Fin 3 =>
            ε₀ *
              maxwellTimeDerivative3
                field.electric
                point
                i) -
            (fun i : Fin 3 =>
              (1 / μ₀) *
                    maxwellCurl3
                      field.magnetic
                      point
                      i -
                field.current point i) =
          0 := by
      simpa [
        hiddenSectorReducedJointMaxwellResidual
      ] using
        congrArg Prod.snd hResidual

    refine
      {
        faraday := ?_
        ampereMaxwell := ?_
      }

    · exact
        sub_eq_zero.mp hFaradayResidual

    · exact
        sub_eq_zero.mp hAmpereResidual

  · intro hEvolution

    apply Prod.ext

    · simpa [
        hiddenSectorReducedJointMaxwellResidual
      ] using
        (sub_eq_zero.mpr hEvolution.faraday)

    · simpa [
        hiddenSectorReducedJointMaxwellResidual
      ] using
        (sub_eq_zero.mpr hEvolution.ampereMaxwell)

/--
The time-principal coefficient of the exact electric/magnetic Maxwell
residual is not skew-symmetric when the permittivity is nonnegative.

For a first-order Euler–Lagrange operator written directly in the declared
`electric` and `magnetic` variables with identity multiplier, formal
self-adjointness requires the time-derivative coefficient matrix to be
skew-symmetric. The displayed residual has temporal coefficient matrix

  [[0, 1],
   [ε₀, 0]],

so its `(0, 1)` Helmholtz condition would require `1 = -ε₀`.
-/
theorem hiddenSectorReducedJointMaxwellTemporalHelmholtz_obstruction
    (ε₀ : ℝ)
    (hε₀ : 0 ≤ ε₀) :
    ¬ ∀ i j : Fin 2,
      (if i = (0 : Fin 2) ∧ j = (1 : Fin 2) then
          (1 : ℝ)
        else if i = (1 : Fin 2) ∧ j = (0 : Fin 2) then
          ε₀
        else
          0) =
        -(if j = (0 : Fin 2) ∧ i = (1 : Fin 2) then
            (1 : ℝ)
          else if j = (1 : Fin 2) ∧ i = (0 : Fin 2) then
            ε₀
          else
            0) := by
  intro hSkew

  have hZeroOne :=
    hSkew
      (0 : Fin 2)
      (1 : Fin 2)

  norm_num at hZeroOne
  linarith

/--
Multiplying the Faraday residual by `ε₀` and the Ampère–Maxwell residual
by `-1` repairs the temporal Helmholtz skew-symmetry condition.

The resulting temporal principal matrix is

  [[0, ε₀],
   [-ε₀, 0]].
-/
theorem hiddenSectorReducedJointMaxwellTemporalHelmholtz_diagonalMultiplier
    (ε₀ : ℝ) :
    ∀ i j : Fin 2,
      (if i = (0 : Fin 2) ∧ j = (1 : Fin 2) then
          ε₀
        else if i = (1 : Fin 2) ∧ j = (0 : Fin 2) then
          -ε₀
        else
          0) =
        -(if j = (0 : Fin 2) ∧ i = (1 : Fin 2) then
            ε₀
          else if j = (1 : Fin 2) ∧ i = (0 : Fin 2) then
            -ε₀
          else
            0) := by
  intro i j
  fin_cases i <;>
    fin_cases j <;>
      norm_num

/--
The exact Maxwell residual after applying the temporal Helmholtz multiplier
`diag(ε₀, -1)`.
-/
noncomputable def hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 × MaxwellVector3 :=
  let residual :=
    hiddenSectorReducedJointMaxwellResidual
      ε₀
      μ₀
      field
      point
  (fun i : Fin 3 =>
      ε₀ * residual.1 i,
    fun i : Fin 3 =>
      -residual.2 i)

/--
For nonzero permittivity, the diagonal Helmholtz multiplier preserves exactly
the zero set of the Maxwell residual.
-/
theorem hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual_eq_zero_iff
    (ε₀ μ₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ε₀
        μ₀
        field
        point =
      (0, 0) ↔
    hiddenSectorReducedJointMaxwellResidual
        ε₀
        μ₀
        field
        point =
      (0, 0) := by
  constructor

  · intro hMultiplied

    apply Prod.ext

    · funext i

      have hFirst :
          ε₀ *
              (hiddenSectorReducedJointMaxwellResidual
                ε₀
                μ₀
                field
                point).1 i =
            0 := by
        simpa [
          hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ] using
          congrArg
            (fun pair => pair.1 i)
            hMultiplied

      exact
        (mul_eq_zero.mp hFirst).resolve_left hε₀

    · funext i

      have hSecond :
          -(hiddenSectorReducedJointMaxwellResidual
              ε₀
              μ₀
              field
              point).2 i =
            0 := by
        simpa [
          hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ] using
          congrArg
            (fun pair => pair.2 i)
            hMultiplied

      exact
        neg_eq_zero.mp hSecond

  · intro hResidual

    apply Prod.ext

    · funext i

      have hFirst :
          (hiddenSectorReducedJointMaxwellResidual
              ε₀
              μ₀
              field
              point).1 i =
            0 := by
        simpa using
          congrArg
            (fun pair => pair.1 i)
            hResidual

      simp [
        hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual,
        hFirst
      ]

    · funext i

      have hSecond :
          (hiddenSectorReducedJointMaxwellResidual
              ε₀
              μ₀
              field
              point).2 i =
            0 := by
        simpa using
          congrArg
            (fun pair => pair.2 i)
            hResidual

      simp [
        hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual,
        hSecond
      ]

/--
For every spatial derivative direction, the component coefficient matrix of
`maxwellCurl3` is skew-symmetric. Multiplication by an arbitrary real scalar
preserves this spatial first-order Helmholtz condition.

This covers both diagonal curl blocks of the multiplied Maxwell residual:
the electric block scaled by `ε₀` and the magnetic block scaled by `1 / μ₀`.
-/
theorem hiddenSectorReducedJointMaxwellSpatialHelmholtz_curlCoefficient
    (scale : ℝ) :
    ∀ direction output input : Fin 3,
      scale *
          (if direction = (0 : Fin 3) then
              if output = (1 : Fin 3) ∧ input = (2 : Fin 3) then
                (-1 : ℝ)
              else if output = (2 : Fin 3) ∧ input = (1 : Fin 3) then
                1
              else
                0
            else if direction = (1 : Fin 3) then
              if output = (0 : Fin 3) ∧ input = (2 : Fin 3) then
                1
              else if output = (2 : Fin 3) ∧ input = (0 : Fin 3) then
                -1
              else
                0
            else
              if output = (0 : Fin 3) ∧ input = (1 : Fin 3) then
                -1
              else if output = (1 : Fin 3) ∧ input = (0 : Fin 3) then
                1
              else
                0) =
        -(scale *
          (if direction = (0 : Fin 3) then
              if input = (1 : Fin 3) ∧ output = (2 : Fin 3) then
                (-1 : ℝ)
              else if input = (2 : Fin 3) ∧ output = (1 : Fin 3) then
                1
              else
                0
            else if direction = (1 : Fin 3) then
              if input = (0 : Fin 3) ∧ output = (2 : Fin 3) then
                1
              else if input = (2 : Fin 3) ∧ output = (0 : Fin 3) then
                -1
              else
                0
            else
              if input = (0 : Fin 3) ∧ output = (1 : Fin 3) then
                -1
              else if input = (1 : Fin 3) ∧ output = (0 : Fin 3) then
                1
              else
                0)) := by
  intro direction output input

  fin_cases direction <;>
    fin_cases output <;>
      fin_cases input <;>
        simp

/--
One coordinate contribution to the candidate local first-jet Maxwell density.

Its terms are, respectively, the antisymmetric electric/magnetic temporal
pairing, the electric curl term, the magnetic curl term, and the current
coupling.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : ℝ) :
    ℝ :=
  (ε₀ / 2) *
      (electric * magneticTime -
        magnetic * electricTime) +
    (ε₀ / 2) *
      electric *
      electricCurl +
    (1 / (2 * μ₀)) *
      magnetic *
      magneticCurl -
    current *
      magnetic

/--
The candidate local density obtained by summing the three coordinate
contributions.

This is a first-jet density. No spacetime integration or boundary-term theorem
is asserted here.
-/
noncomputable def hiddenSectorReducedJointMaxwellCandidateLocalDensity
    (ε₀ μ₀ : ℝ)
    (electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : MaxwellVector3) :
    ℝ :=
  ∑ i : Fin 3,
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
      ε₀
      μ₀
      (electric i)
      (magnetic i)
      (electricTime i)
      (magneticTime i)
      (electricCurl i)
      (magneticCurl i)
      (current i)

/--
The ordinary electric-coordinate derivative of one density component.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_electricDerivative_exact
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : ℝ) :
    deriv
        (fun currentElectric : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            currentElectric
            magnetic
            electricTime
            magneticTime
            electricCurl
            magneticCurl
            current)
        electric =
      (ε₀ / 2) * magneticTime +
        (ε₀ / 2) * electricCurl := by
  let coefficient : ℝ :=
    (ε₀ / 2) * magneticTime +
      (ε₀ / 2) * electricCurl

  let constantTerm : ℝ :=
    -(ε₀ / 2) *
          magnetic *
          electricTime +
      (1 / (2 * μ₀)) *
          magnetic *
          magneticCurl -
      current *
          magnetic

  have hAffine :
      HasDerivAt
          (fun currentElectric : ℝ =>
            coefficient * currentElectric +
              constantTerm)
          coefficient
          electric := by
    convert
      ((hasDerivAt_id electric).const_mul
          coefficient).add
        (hasDerivAt_const
          (x := electric)
          constantTerm)
      using 1 <;>
      simp [id]

  have hFunction :
      (fun currentElectric : ℝ =>
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
          ε₀
          μ₀
          currentElectric
          magnetic
          electricTime
          magneticTime
          electricCurl
          magneticCurl
          current) =
        (fun currentElectric : ℝ =>
          coefficient * currentElectric +
            constantTerm) := by
    funext currentElectric

    dsimp [coefficient, constantTerm]

    unfold
      hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent

    ring

  rw [hFunction]

  simpa [coefficient] using hAffine.deriv

/--
The electric Euler–Lagrange component of the candidate first-jet density.

The second term is minus the time derivative of the electric temporal
momentum `-(ε₀ / 2) B`. The third term is the formal self-adjoint curl
contribution from `(ε₀ / 2) E`.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrangeComponent
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 :=
  fun i : Fin 3 =>
    deriv
        (fun currentElectric : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            currentElectric
            (field.magnetic point i)
            (maxwellTimeDerivative3
              field.electric
              point
              i)
            (maxwellTimeDerivative3
              field.magnetic
              point
              i)
            (maxwellCurl3
              field.electric
              point
              i)
            (maxwellCurl3
              field.magnetic
              point
              i)
            (field.current point i))
        (field.electric point i) -
      (-(ε₀ / 2) *
        maxwellTimeDerivative3
          field.magnetic
          point
          i) +
      (ε₀ / 2) *
        maxwellCurl3
          field.electric
          point
          i

/--
The electric Euler–Lagrange component of the candidate density is exactly the
first component of the diagonal-multiplied Maxwell residual.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrange_exact
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrangeComponent
        ε₀
        μ₀
        field
        point =
      (hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ε₀
        μ₀
        field
        point).1 := by
  funext i

  unfold
    hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrangeComponent

  rw [
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_electricDerivative_exact
  ]

  simp [
    hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual,
    hiddenSectorReducedJointMaxwellResidual
  ] <;>
    ring

/--
The reduced joint equations before substituting either the stationary source
amplitude or the explicit static-curl Maxwell field.
-/
noncomputable def hiddenSectorReducedJointOffShellEquationTuple
    (trajectory : ℝ → ℝ)
    (sourceAmplitude ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (time : ℝ)
    (point : MaxwellSpacetime3) :
    ℝ × ℝ × Prop :=
  (hiddenSectorReducedJointSourceResidual
      (deriv trajectory time)
      sourceAmplitude,
    hiddenSectorReducedJointHiddenEulerLagrangeResidual
      trajectory
      sourceAmplitude
      time,
    UncontractedMaxwellEvolutionAt3
      ε₀
      μ₀
      field
      point)



/--
The first reduced Helmholtz mixed condition: differentiating the source
Euler–Lagrange residual with respect to hidden velocity equals
differentiating the hidden canonical momentum with respect to source
amplitude.
-/
theorem hiddenSectorReducedJoint_firstHelmholtzMixedSymmetry
    (velocity sourceAmplitude : ℝ) :
    deriv
        (fun currentVelocity : ℝ =>
          hiddenSectorReducedJointSourceResidual
            currentVelocity
            sourceAmplitude)
        velocity =
      deriv
        (fun currentAmplitude : ℝ =>
          hiddenSectorReducedJointHiddenMomentum
            velocity
            currentAmplitude)
        sourceAmplitude := by
  have hSourceVelocity :
      HasDerivAt
          (fun currentVelocity : ℝ =>
            hiddenSectorReducedJointSourceResidual
              currentVelocity
              sourceAmplitude)
          (-2 * velocity)
          velocity := by
    unfold hiddenSectorReducedJointSourceResidual
    convert
      (hasDerivAt_const
          (x := velocity)
          sourceAmplitude).sub
        ((hasDerivAt_id velocity).pow 2)
      using 1 <;>
      simp [id]

  have hMomentumSource :
      HasDerivAt
          (fun currentAmplitude : ℝ =>
            hiddenSectorReducedJointHiddenMomentum
              velocity
              currentAmplitude)
          (-2 * velocity)
          sourceAmplitude := by
    have hInner :
        HasDerivAt
            (fun currentAmplitude : ℝ =>
              currentAmplitude - velocity ^ 2)
            1
            sourceAmplitude := by
      exact
        (hasDerivAt_id sourceAmplitude).sub_const
          (velocity ^ 2)

    have hScaled :
        HasDerivAt
            (fun currentAmplitude : ℝ =>
              2 * velocity *
                (currentAmplitude - velocity ^ 2))
            (2 * velocity)
            sourceAmplitude := by
      convert
        hInner.const_mul (2 * velocity)
        using 1 <;>
        ring

    unfold hiddenSectorReducedJointHiddenMomentum
    convert
      (hasDerivAt_const
          (x := sourceAmplitude)
          velocity).sub hScaled
      using 1 <;>
      ring

  exact
    hSourceVelocity.deriv.trans
      hMomentumSource.deriv.symm

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
