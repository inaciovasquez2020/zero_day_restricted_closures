import intended_hidden_sector_free_action_coupling
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv

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
The temporal canonical momenta of one candidate-density component are the
antisymmetric electric/magnetic pair.

They are independent of both temporal jets, exposing the constrained
first-order temporal structure of the candidate Maxwell density.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : ℝ) :
    (deriv
        (fun currentElectricTime : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            electric
            magnetic
            currentElectricTime
            magneticTime
            electricCurl
            magneticCurl
            current)
        electricTime =
      -(ε₀ / 2) * magnetic) ∧
      (deriv
          (fun currentMagneticTime : ℝ =>
            hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
              ε₀
              μ₀
              electric
              magnetic
              electricTime
              currentMagneticTime
              electricCurl
              magneticCurl
              current)
          magneticTime =
        (ε₀ / 2) * electric) := by
  constructor

  · let coefficient : ℝ :=
      -(ε₀ / 2) * magnetic

    let constantTerm : ℝ :=
      (ε₀ / 2) *
          electric *
          magneticTime +
        (ε₀ / 2) *
          electric *
          electricCurl +
        (1 / (2 * μ₀)) *
          magnetic *
          magneticCurl -
        current *
          magnetic

    have hAffine :
        HasDerivAt
            (fun currentElectricTime : ℝ =>
              coefficient * currentElectricTime +
                constantTerm)
            coefficient
            electricTime := by
      convert
        ((hasDerivAt_id electricTime).const_mul
            coefficient).add
          (hasDerivAt_const
            (x := electricTime)
            constantTerm)
        using 1 <;>
        simp [id]

    have hFunction :
        (fun currentElectricTime : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            electric
            magnetic
            currentElectricTime
            magneticTime
            electricCurl
            magneticCurl
            current) =
          (fun currentElectricTime : ℝ =>
            coefficient * currentElectricTime +
              constantTerm) := by
      funext currentElectricTime

      dsimp [coefficient, constantTerm]

      unfold
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent

      ring

    rw [hFunction]

    simpa [coefficient] using hAffine.deriv

  · let coefficient : ℝ :=
      (ε₀ / 2) * electric

    let constantTerm : ℝ :=
      -(ε₀ / 2) *
          magnetic *
          electricTime +
        (ε₀ / 2) *
          electric *
          electricCurl +
        (1 / (2 * μ₀)) *
          magnetic *
          magneticCurl -
        current *
          magnetic

    have hAffine :
        HasDerivAt
            (fun currentMagneticTime : ℝ =>
              coefficient * currentMagneticTime +
                constantTerm)
            coefficient
            magneticTime := by
      convert
        ((hasDerivAt_id magneticTime).const_mul
            coefficient).add
          (hasDerivAt_const
            (x := magneticTime)
            constantTerm)
        using 1 <;>
        simp [id]

    have hFunction :
        (fun currentMagneticTime : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            electric
            magnetic
            electricTime
            currentMagneticTime
            electricCurl
            magneticCurl
            current) =
          (fun currentMagneticTime : ℝ =>
            coefficient * currentMagneticTime +
              constantTerm) := by
      funext currentMagneticTime

      dsimp [coefficient, constantTerm]

      unfold
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent

      ring

    rw [hFunction]

    simpa [coefficient] using hAffine.deriv

/--
Every entry of the temporal-jet Hessian of one candidate Maxwell density
component vanishes.

Thus the temporal Legendre map has rank zero with respect to the two temporal
jets: the candidate density is first order and maximally temporally singular.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalJetHessian_zero
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : ℝ) :
    (deriv
        (fun currentElectricTime : ℝ =>
          deriv
            (fun probeElectricTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                electric
                magnetic
                probeElectricTime
                magneticTime
                electricCurl
                magneticCurl
                current)
            currentElectricTime)
        electricTime =
      0) ∧
      (deriv
          (fun currentMagneticTime : ℝ =>
            deriv
              (fun probeElectricTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  electric
                  magnetic
                  probeElectricTime
                  currentMagneticTime
                  electricCurl
                  magneticCurl
                  current)
              electricTime)
          magneticTime =
        0) ∧
      (deriv
          (fun currentElectricTime : ℝ =>
            deriv
              (fun probeMagneticTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  electric
                  magnetic
                  currentElectricTime
                  probeMagneticTime
                  electricCurl
                  magneticCurl
                  current)
              magneticTime)
          electricTime =
        0) ∧
      (deriv
          (fun currentMagneticTime : ℝ =>
            deriv
              (fun probeMagneticTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  electric
                  magnetic
                  electricTime
                  probeMagneticTime
                  electricCurl
                  magneticCurl
                  current)
              currentMagneticTime)
          magneticTime =
        0) := by
  constructor

  · have hMomentumFunction :
        (fun currentElectricTime : ℝ =>
          deriv
            (fun probeElectricTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                electric
                magnetic
                probeElectricTime
                magneticTime
                electricCurl
                magneticCurl
                current)
            currentElectricTime) =
          (fun _ : ℝ =>
            -(ε₀ / 2) * magnetic) := by
      funext currentElectricTime

      exact
        (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          electric
          magnetic
          currentElectricTime
          magneticTime
          electricCurl
          magneticCurl
          current).1

    rw [hMomentumFunction]

    simpa using
      (hasDerivAt_const
        (x := electricTime)
        (-(ε₀ / 2) * magnetic)).deriv

  constructor

  · have hMomentumFunction :
        (fun currentMagneticTime : ℝ =>
          deriv
            (fun probeElectricTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                electric
                magnetic
                probeElectricTime
                currentMagneticTime
                electricCurl
                magneticCurl
                current)
            electricTime) =
          (fun _ : ℝ =>
            -(ε₀ / 2) * magnetic) := by
      funext currentMagneticTime

      exact
        (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          electric
          magnetic
          electricTime
          currentMagneticTime
          electricCurl
          magneticCurl
          current).1

    rw [hMomentumFunction]

    simpa using
      (hasDerivAt_const
        (x := magneticTime)
        (-(ε₀ / 2) * magnetic)).deriv

  constructor

  · have hMomentumFunction :
        (fun currentElectricTime : ℝ =>
          deriv
            (fun probeMagneticTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                electric
                magnetic
                currentElectricTime
                probeMagneticTime
                electricCurl
                magneticCurl
                current)
            magneticTime) =
          (fun _ : ℝ =>
            (ε₀ / 2) * electric) := by
      funext currentElectricTime

      exact
        (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          electric
          magnetic
          currentElectricTime
          magneticTime
          electricCurl
          magneticCurl
          current).2

    rw [hMomentumFunction]

    simpa using
      (hasDerivAt_const
        (x := electricTime)
        ((ε₀ / 2) * electric)).deriv

  · have hMomentumFunction :
        (fun currentMagneticTime : ℝ =>
          deriv
            (fun probeMagneticTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                electric
                magnetic
                electricTime
                probeMagneticTime
                electricCurl
                magneticCurl
                current)
            currentMagneticTime) =
          (fun _ : ℝ =>
            (ε₀ / 2) * electric) := by
      funext currentMagneticTime

      exact
        (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          electric
          magnetic
          electricTime
          currentMagneticTime
          electricCurl
          magneticCurl
          current).2

    rw [hMomentumFunction]

    simpa using
      (hasDerivAt_const
        (x := magneticTime)
        ((ε₀ / 2) * electric)).deriv

/--
A momentum pair lies in the temporal Legendre image exactly when it satisfies
the two antisymmetric primary constraints.

For fixed electric and magnetic coordinates, the temporal jets contribute no
additional momentum freedom.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalLegendreImage_iff_primaryConstraints
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current
      electricMomentum magneticMomentum : ℝ) :
    ((electricMomentum =
        deriv
          (fun currentElectricTime : ℝ =>
            hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
              ε₀
              μ₀
              electric
              magnetic
              currentElectricTime
              magneticTime
              electricCurl
              magneticCurl
              current)
          electricTime) ∧
      (magneticMomentum =
        deriv
          (fun currentMagneticTime : ℝ =>
            hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
              ε₀
              μ₀
              electric
              magnetic
              electricTime
              currentMagneticTime
              electricCurl
              magneticCurl
              current)
          magneticTime)) ↔
      (electricMomentum +
          (ε₀ / 2) * magnetic =
        0) ∧
      (magneticMomentum -
          (ε₀ / 2) * electric =
        0) := by
  have hMomenta :=
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
      ε₀
      μ₀
      electric
      magnetic
      electricTime
      magneticTime
      electricCurl
      magneticCurl
      current

  constructor

  · rintro ⟨hElectricMomentum, hMagneticMomentum⟩

    constructor

    · rw [hElectricMomentum, hMomenta.1]
      ring

    · rw [hMagneticMomentum, hMomenta.2]
      ring

  · rintro ⟨hElectricConstraint, hMagneticConstraint⟩

    constructor

    · calc
        electricMomentum =
            -(ε₀ / 2) * magnetic := by
              linarith
        _ =
            deriv
              (fun currentElectricTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  electric
                  magnetic
                  currentElectricTime
                  magneticTime
                  electricCurl
                  magneticCurl
                  current)
              electricTime :=
          hMomenta.1.symm

    · calc
        magneticMomentum =
            (ε₀ / 2) * electric := by
              linarith
        _ =
            deriv
              (fun currentMagneticTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  electric
                  magnetic
                  electricTime
                  currentMagneticTime
                  electricCurl
                  magneticCurl
                  current)
              magneticTime :=
          hMomenta.2.symm

/--
For fixed electric and magnetic coordinates, the two primary constraints
determine exactly one temporal canonical-momentum pair.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_primaryConstraintMomentum_unique
    (ε₀ electric magnetic
      electricMomentum magneticMomentum : ℝ)
    (hConstraints :
      (electricMomentum +
          (ε₀ / 2) * magnetic =
        0) ∧
      (magneticMomentum -
          (ε₀ / 2) * electric =
        0)) :
    (electricMomentum, magneticMomentum) =
      (-(ε₀ / 2) * magnetic,
        (ε₀ / 2) * electric) := by
  apply Prod.ext

  · dsimp
    linarith [hConstraints.1]

  · dsimp
    linarith [hConstraints.2]

/--
A vector momentum pair belongs to the componentwise temporal Legendre image
exactly when every spatial component satisfies the two antisymmetric primary
constraints.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_vectorTemporalLegendreImage_iff_primaryConstraints
    (ε₀ μ₀ : ℝ)
    (electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current
      electricMomentum magneticMomentum : MaxwellVector3) :
    ((electricMomentum =
        fun i : Fin 3 =>
          deriv
            (fun currentElectricTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                (electric i)
                (magnetic i)
                currentElectricTime
                (magneticTime i)
                (electricCurl i)
                (magneticCurl i)
                (current i))
            (electricTime i)) ∧
      (magneticMomentum =
        fun i : Fin 3 =>
          deriv
            (fun currentMagneticTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                (electric i)
                (magnetic i)
                (electricTime i)
                currentMagneticTime
                (electricCurl i)
                (magneticCurl i)
                (current i))
            (magneticTime i))) ↔
      (∀ i : Fin 3,
        electricMomentum i +
            (ε₀ / 2) * magnetic i =
          0) ∧
      (∀ i : Fin 3,
        magneticMomentum i -
            (ε₀ / 2) * electric i =
          0) := by
  constructor

  · rintro
      ⟨hElectricImage,
        hMagneticImage⟩

    constructor

    · intro i

      have hMomenta :=
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          (electric i)
          (magnetic i)
          (electricTime i)
          (magneticTime i)
          (electricCurl i)
          (magneticCurl i)
          (current i)

      rw [hElectricImage, hMomenta.1]

      ring

    · intro i

      have hMomenta :=
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          (electric i)
          (magnetic i)
          (electricTime i)
          (magneticTime i)
          (electricCurl i)
          (magneticCurl i)
          (current i)

      rw [hMagneticImage, hMomenta.2]

      ring

  · rintro
      ⟨hElectricConstraints,
        hMagneticConstraints⟩

    constructor

    · funext i

      have hMomenta :=
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          (electric i)
          (magnetic i)
          (electricTime i)
          (magneticTime i)
          (electricCurl i)
          (magneticCurl i)
          (current i)

      calc
        electricMomentum i =
            -(ε₀ / 2) * magnetic i := by
              linarith [hElectricConstraints i]
        _ =
            deriv
              (fun currentElectricTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  (electric i)
                  (magnetic i)
                  currentElectricTime
                  (magneticTime i)
                  (electricCurl i)
                  (magneticCurl i)
                  (current i))
              (electricTime i) :=
          hMomenta.1.symm

    · funext i

      have hMomenta :=
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
          ε₀
          μ₀
          (electric i)
          (magnetic i)
          (electricTime i)
          (magneticTime i)
          (electricCurl i)
          (magneticCurl i)
          (current i)

      calc
        magneticMomentum i =
            (ε₀ / 2) * electric i := by
              linarith [hMagneticConstraints i]
        _ =
            deriv
              (fun currentMagneticTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  (electric i)
                  (magnetic i)
                  (electricTime i)
                  currentMagneticTime
                  (electricCurl i)
                  (magneticCurl i)
                  (current i))
              (magneticTime i) :=
          hMomenta.2.symm

/--
The vector temporal Legendre-image predicate is independent of both temporal
jet fields.

Changing electric and magnetic temporal jets does not change which momentum
pairs are admitted by the primary-constraint surface.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_vectorTemporalLegendreImage_independent_of_temporalJets
    (ε₀ μ₀ : ℝ)
    (electric magnetic
      electricTime₁ magneticTime₁
      electricTime₂ magneticTime₂
      electricCurl magneticCurl
      current
      electricMomentum magneticMomentum : MaxwellVector3) :
    ((electricMomentum =
        fun i : Fin 3 =>
          deriv
            (fun currentElectricTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                (electric i)
                (magnetic i)
                currentElectricTime
                (magneticTime₁ i)
                (electricCurl i)
                (magneticCurl i)
                (current i))
            (electricTime₁ i)) ∧
      (magneticMomentum =
        fun i : Fin 3 =>
          deriv
            (fun currentMagneticTime : ℝ =>
              hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                ε₀
                μ₀
                (electric i)
                (magnetic i)
                (electricTime₁ i)
                currentMagneticTime
                (electricCurl i)
                (magneticCurl i)
                (current i))
            (magneticTime₁ i))) ↔
      ((electricMomentum =
          fun i : Fin 3 =>
            deriv
              (fun currentElectricTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  (electric i)
                  (magnetic i)
                  currentElectricTime
                  (magneticTime₂ i)
                  (electricCurl i)
                  (magneticCurl i)
                  (current i))
              (electricTime₂ i)) ∧
        (magneticMomentum =
          fun i : Fin 3 =>
            deriv
              (fun currentMagneticTime : ℝ =>
                hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
                  ε₀
                  μ₀
                  (electric i)
                  (magnetic i)
                  (electricTime₂ i)
                  currentMagneticTime
                  (electricCurl i)
                  (magneticCurl i)
                  (current i))
              (magneticTime₂ i))) := by
  exact
    (hiddenSectorReducedJointMaxwellCandidate_vectorTemporalLegendreImage_iff_primaryConstraints
        ε₀
        μ₀
        electric
        magnetic
        electricTime₁
        magneticTime₁
        electricCurl
        magneticCurl
        current
        electricMomentum
        magneticMomentum).trans
      (hiddenSectorReducedJointMaxwellCandidate_vectorTemporalLegendreImage_iff_primaryConstraints
        ε₀
        μ₀
        electric
        magnetic
        electricTime₂
        magneticTime₂
        electricCurl
        magneticCurl
        current
        electricMomentum
        magneticMomentum).symm

/--
The complete vector temporal Legendre map is the explicit antisymmetric
primary-constraint momentum pair.

Its value depends only on the electric and magnetic coordinate fields and is
constant with respect to both temporal-jet fields.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_vectorTemporalLegendreMap_eq_primaryConstraintMomentum
    (ε₀ μ₀ : ℝ)
    (electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : MaxwellVector3) :
    ((fun i : Fin 3 =>
        deriv
          (fun currentElectricTime : ℝ =>
            hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
              ε₀
              μ₀
              (electric i)
              (magnetic i)
              currentElectricTime
              (magneticTime i)
              (electricCurl i)
              (magneticCurl i)
              (current i))
          (electricTime i)),
      fun i : Fin 3 =>
        deriv
          (fun currentMagneticTime : ℝ =>
            hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
              ε₀
              μ₀
              (electric i)
              (magnetic i)
              (electricTime i)
              currentMagneticTime
              (electricCurl i)
              (magneticCurl i)
              (current i))
          (magneticTime i)) =
      ((fun i : Fin 3 =>
          -(ε₀ / 2) * magnetic i),
        fun i : Fin 3 =>
          (ε₀ / 2) * electric i) := by
  apply Prod.ext

  · funext i

    exact
      (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
        ε₀
        μ₀
        (electric i)
        (magnetic i)
        (electricTime i)
        (magneticTime i)
        (electricCurl i)
        (magneticCurl i)
        (current i)).1

  · funext i

    exact
      (hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_temporalMomenta_exact
        ε₀
        μ₀
        (electric i)
        (magnetic i)
        (electricTime i)
        (magneticTime i)
        (electricCurl i)
        (magneticCurl i)
        (current i)).2

/--
For nonzero permittivity, the explicit primary-constraint momentum map is
injective in the electric and magnetic coordinate fields.

Consequently, although temporal velocities are absent from the canonical
momenta, the coordinate fields themselves can be recovered uniquely.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumMap_injective
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0) :
    Function.Injective
      (fun fieldPair : MaxwellVector3 × MaxwellVector3 =>
        ((fun i : Fin 3 =>
            -(ε₀ / 2) * fieldPair.2 i),
          fun i : Fin 3 =>
            (ε₀ / 2) * fieldPair.1 i)) := by
  have hHalf :
      ε₀ / 2 ≠ 0 := by
    exact
      div_ne_zero
        hε₀
        (by norm_num)

  intro firstFieldPair secondFieldPair hMomentumEquality

  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  apply Prod.ext

  · funext i

    have hElectricComponent :
        (ε₀ / 2) * electric₁ i =
          (ε₀ / 2) * electric₂ i := by
      exact
        congrArg
          (fun momentumPair :
              MaxwellVector3 × MaxwellVector3 =>
            momentumPair.2 i)
          hMomentumEquality

    exact
      mul_left_cancel₀
        hHalf
        hElectricComponent

  · funext i

    have hMagneticComponent :
        (-(ε₀ / 2)) * magnetic₁ i =
          (-(ε₀ / 2)) * magnetic₂ i := by
      exact
        congrArg
          (fun momentumPair :
              MaxwellVector3 × MaxwellVector3 =>
            momentumPair.1 i)
          hMomentumEquality

    exact
      mul_left_cancel₀
        (neg_ne_zero.mpr hHalf)
        hMagneticComponent

/--
The explicit momentum-to-field reconstruction map for nonzero permittivity.

The magnetic momentum reconstructs the electric field, while the electric
momentum reconstructs the magnetic field with the antisymmetric sign.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
    (ε₀ : ℝ)
    (momentumPair : MaxwellVector3 × MaxwellVector3) :
    MaxwellVector3 × MaxwellVector3 :=
  ((fun i : Fin 3 =>
      (2 / ε₀) * momentumPair.2 i),
    fun i : Fin 3 =>
      -(2 / ε₀) * momentumPair.1 i)

/--
For nonzero permittivity, reconstructing fields after applying the explicit
primary-constraint momentum map returns the original electric and magnetic
fields.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse_leftInverse
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0) :
    Function.LeftInverse
      (hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
        ε₀)
      (fun fieldPair : MaxwellVector3 × MaxwellVector3 =>
        ((fun i : Fin 3 =>
            -(ε₀ / 2) * fieldPair.2 i),
          fun i : Fin 3 =>
            (ε₀ / 2) * fieldPair.1 i)) := by
  intro fieldPair

  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
    ]

    field_simp [hε₀]

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
    ]

    field_simp [hε₀]

/--
For nonzero permittivity, applying the explicit primary-constraint momentum
map after momentum-to-field reconstruction returns every momentum pair.

Thus the coordinate-to-momentum map and reconstruction map are mutual
inverses on the complete vector-pair spaces.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse_rightInverse
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0) :
    Function.RightInverse
      (hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
        ε₀)
      (fun fieldPair : MaxwellVector3 × MaxwellVector3 =>
        ((fun i : Fin 3 =>
            -(ε₀ / 2) * fieldPair.2 i),
          fun i : Fin 3 =>
            (ε₀ / 2) * fieldPair.1 i)) := by
  intro momentumPair

  rcases momentumPair with
    ⟨electricMomentum, magneticMomentum⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
    ]

    field_simp [hε₀]

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumInverse
    ]

    field_simp [hε₀]

/--
Applying the explicit primary-constraint momentum map twice produces negative
scalar multiplication by the squared half-permittivity.

This exposes the map as a scaled complex structure on electric-magnetic field
pairs rather than merely an invertible coordinate transformation.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_primaryConstraintMomentumMap_square
    (ε₀ : ℝ)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    ((fun currentFieldPair :
          MaxwellVector3 × MaxwellVector3 =>
        ((fun i : Fin 3 =>
            -(ε₀ / 2) * currentFieldPair.2 i),
          fun i : Fin 3 =>
            (ε₀ / 2) * currentFieldPair.1 i))
      ((fun i : Fin 3 =>
          -(ε₀ / 2) * fieldPair.2 i),
        fun i : Fin 3 =>
          (ε₀ / 2) * fieldPair.1 i)) =
      ((fun i : Fin 3 =>
          -((ε₀ / 2) ^ 2) * fieldPair.1 i),
        fun i : Fin 3 =>
          -((ε₀ / 2) ^ 2) * fieldPair.2 i) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i
    dsimp
    ring

  · funext i
    dsimp
    ring

/--
The primary-constraint momentum map normalized by its nonzero half-permittivity
scale.

For nonzero permittivity this removes the physical scale while retaining the
antisymmetric electric-magnetic exchange.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
    (ε₀ : ℝ)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    MaxwellVector3 × MaxwellVector3 :=
  ((fun i : Fin 3 =>
      (2 / ε₀) *
        (-(ε₀ / 2) * fieldPair.2 i)),
    fun i : Fin 3 =>
      (2 / ε₀) *
        ((ε₀ / 2) * fieldPair.1 i))

/--
For nonzero permittivity, the normalized primary-constraint momentum map
squares exactly to negative identity.

Hence the normalized electric-magnetic exchange is a genuine complex
structure on the complete pair of MaxwellVector3 coordinate fields.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_square
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
        ε₀
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair) =
      ((fun i : Fin 3 =>
          -fieldPair.1 i),
        fun i : Fin 3 =>
          -fieldPair.2 i) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
    ]

    field_simp [hε₀] <;>
      ring

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
    ]

    field_simp [hε₀] <;>
      ring

/--
For nonzero permittivity, the normalized Maxwell complex structure has no
nonzero real eigenvectors.

Any field pair satisfying a real eigenvalue equation must have identically
zero electric and magnetic components.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_no_nonzero_real_eigenvector
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (eigenvalue : ℝ)
    (hEigen :
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair =
        ((fun i : Fin 3 =>
            eigenvalue * fieldPair.1 i),
          fun i : Fin 3 =>
            eigenvalue * fieldPair.2 i)) :
    fieldPair =
      ((fun _ : Fin 3 => 0),
        fun _ : Fin 3 => 0) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  have hFirst :
      ∀ i : Fin 3,
        -magnetic i =
          eigenvalue * electric i := by
    intro i

    calc
      -magnetic i =
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            (electric, magnetic)).1 i := by
              dsimp [
                hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
              ]
              field_simp [hε₀] <;>
                ring
      _ =
          eigenvalue * electric i := by
            exact
              congrArg
                (fun momentumPair :
                    MaxwellVector3 × MaxwellVector3 =>
                  momentumPair.1 i)
                hEigen

  have hSecond :
      ∀ i : Fin 3,
        electric i =
          eigenvalue * magnetic i := by
    intro i

    calc
      electric i =
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            (electric, magnetic)).2 i := by
              dsimp [
                hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
              ]
              field_simp [hε₀] <;>
                ring
      _ =
          eigenvalue * magnetic i := by
            exact
              congrArg
                (fun momentumPair :
                    MaxwellVector3 × MaxwellVector3 =>
                  momentumPair.2 i)
                hEigen

  have hMagneticZero :
      ∀ i : Fin 3,
        magnetic i = 0 := by
    intro i

    have hAnnihilation :
        (eigenvalue ^ 2 + 1) * magnetic i =
          0 := by
      calc
        (eigenvalue ^ 2 + 1) * magnetic i =
            eigenvalue *
                (eigenvalue * magnetic i) +
              magnetic i := by
                ring
        _ =
            eigenvalue * electric i +
              magnetic i := by
                rw [← hSecond i]
        _ =
            0 := by
              linarith [hFirst i]

    have hCoefficient :
        eigenvalue ^ 2 + 1 ≠ 0 := by
      positivity

    exact
      (mul_eq_zero.mp hAnnihilation).resolve_left
        hCoefficient

  apply Prod.ext

  · funext i

    simpa [hMagneticZero i] using hSecond i

  · funext i

    exact hMagneticZero i

/--
The componentwise electric-magnetic quadratic norm squared.
-/
def
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
    (electric magnetic : ℝ) :
    ℝ :=
  electric ^ 2 + magnetic ^ 2

/--
For nonzero permittivity, the normalized Maxwell complex structure preserves
the electric-magnetic quadratic norm squared in every spatial component.

Thus the normalized canonical exchange is simultaneously complex and
componentwise orthogonal.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_preserves_componentQuadraticNormSq
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (i : Fin 3) :
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).1 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).2 i) =
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
        (fieldPair.1 i)
        (fieldPair.2 i) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq,
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
The componentwise antisymmetric electric-magnetic bilinear form.
-/
def
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
    (electric₁ magnetic₁
      electric₂ magnetic₂ : ℝ) :
    ℝ :=
  electric₁ * magnetic₂ -
    magnetic₁ * electric₂

/--
For nonzero permittivity, the normalized Maxwell complex structure preserves
the componentwise antisymmetric electric-magnetic bilinear form.

Thus the normalized canonical exchange is symplectic in every spatial
component.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_preserves_componentAntisymmetricBilinearForm
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3)
    (i : Fin 3) :
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          firstFieldPair).1 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          firstFieldPair).2 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair).1 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair).2 i) =
      hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
        (firstFieldPair.1 i)
        (firstFieldPair.2 i)
        (secondFieldPair.1 i)
        (secondFieldPair.2 i) := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm,
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
For nonzero permittivity, the componentwise quadratic norm equals the
antisymmetric pairing of a field pair with its normalized complex-structure
image.

This is the direct compatibility identity joining the quadratic form,
symplectic form, and normalized electric-magnetic complex structure.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (i : Fin 3) :
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
        (fieldPair.1 i)
        (fieldPair.2 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).1 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).2 i) =
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
        (fieldPair.1 i)
        (fieldPair.2 i) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm,
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq,
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
For nonzero permittivity, the antisymmetric pairing of a component with its
normalized complex image is strictly positive whenever that electric-magnetic
component is nonzero.

Thus the compatible symplectic-complex pairing induces a positive-definite
quadratic form componentwise.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_antisymmetricPairing_with_normalizedMap_pos_of_component_ne_zero
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (i : Fin 3)
    (hComponent :
      fieldPair.1 i ≠ 0 ∨
        fieldPair.2 i ≠ 0) :
    0 <
      hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
        (fieldPair.1 i)
        (fieldPair.2 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).1 i)
        ((hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair).2 i) := by
  rw [
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
      ε₀
      hε₀
      fieldPair
      i
  ]

  unfold
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

  rcases hComponent with
    hElectric | hMagnetic

  · have hElectricSq :
        0 < (fieldPair.1 i) ^ 2 :=
      sq_pos_of_ne_zero hElectric

    nlinarith [
      sq_nonneg (fieldPair.2 i)
    ]

  · have hMagneticSq :
        0 < (fieldPair.2 i) ^ 2 :=
      sq_pos_of_ne_zero hMagnetic

    nlinarith [
      sq_nonneg (fieldPair.1 i)
    ]

/--
The finite three-component electric-magnetic quadratic norm squared.
-/
def
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    ℝ :=
  hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
      (fieldPair.1 (0 : Fin 3))
      (fieldPair.2 (0 : Fin 3)) +
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
      (fieldPair.1 (1 : Fin 3))
      (fieldPair.2 (1 : Fin 3)) +
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
      (fieldPair.1 (2 : Fin 3))
      (fieldPair.2 (2 : Fin 3))

/--
For nonzero permittivity, the finite three-component quadratic form is
strictly positive whenever at least one electric-magnetic component is
nonzero.

This lifts the componentwise compatible symplectic-complex positivity to the
complete MaxwellVector3 coordinate pair.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq_pos_of_component_ne_zero
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (hNonzero :
      (fieldPair.1 (0 : Fin 3) ≠ 0 ∨
          fieldPair.2 (0 : Fin 3) ≠ 0) ∨
        (fieldPair.1 (1 : Fin 3) ≠ 0 ∨
          fieldPair.2 (1 : Fin 3) ≠ 0) ∨
        (fieldPair.1 (2 : Fin 3) ≠ 0 ∨
          fieldPair.2 (2 : Fin 3) ≠ 0)) :
    0 <
      hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        fieldPair := by
  have hNonneg₀ :
      0 ≤
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
          (fieldPair.1 (0 : Fin 3))
          (fieldPair.2 (0 : Fin 3)) := by
    unfold
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

    positivity

  have hNonneg₁ :
      0 ≤
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
          (fieldPair.1 (1 : Fin 3))
          (fieldPair.2 (1 : Fin 3)) := by
    unfold
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

    positivity

  have hNonneg₂ :
      0 ≤
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
          (fieldPair.1 (2 : Fin 3))
          (fieldPair.2 (2 : Fin 3)) := by
    unfold
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

    positivity

  rcases hNonzero with hComponent₀ | hRemaining

  · have hPositive₀ :=
      hiddenSectorReducedJointMaxwellCandidate_antisymmetricPairing_with_normalizedMap_pos_of_component_ne_zero
        ε₀
        hε₀
        fieldPair
        (0 : Fin 3)
        hComponent₀

    rw [
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
        ε₀
        hε₀
        fieldPair
        (0 : Fin 3)
    ] at hPositive₀

    unfold
      hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq

    nlinarith

  · rcases hRemaining with hComponent₁ | hComponent₂

    · have hPositive₁ :=
        hiddenSectorReducedJointMaxwellCandidate_antisymmetricPairing_with_normalizedMap_pos_of_component_ne_zero
          ε₀
          hε₀
          fieldPair
          (1 : Fin 3)
          hComponent₁

      rw [
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
          ε₀
          hε₀
          fieldPair
          (1 : Fin 3)
      ] at hPositive₁

      unfold
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq

      nlinarith

    · have hPositive₂ :=
        hiddenSectorReducedJointMaxwellCandidate_antisymmetricPairing_with_normalizedMap_pos_of_component_ne_zero
          ε₀
          hε₀
          fieldPair
          (2 : Fin 3)
          hComponent₂

      rw [
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
          ε₀
          hε₀
          fieldPair
          (2 : Fin 3)
      ] at hPositive₂

      unfold
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq

      nlinarith

/--
The finite three-component quadratic norm squared vanishes exactly when both
MaxwellVector3 coordinate fields vanish identically.

Unlike the normalized complex-structure results, this positive-definiteness
characterization requires no assumption on permittivity.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq_eq_zero_iff
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        fieldPair =
      0 ↔
    fieldPair =
      ((fun _ : Fin 3 => 0),
        fun _ : Fin 3 => 0) := by
  have component_eq_zero
      (electric magnetic : ℝ)
      (hComponent :
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            electric
            magnetic =
          0) :
      electric = 0 ∧
        magnetic = 0 := by
    unfold
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
      at hComponent

    have hElectricSq :
        electric ^ 2 = 0 := by
      nlinarith [sq_nonneg magnetic]

    have hMagneticSq :
        magnetic ^ 2 = 0 := by
      nlinarith [sq_nonneg electric]

    constructor

    · have hElectricMul :
          electric * electric = 0 := by
        simpa [pow_two] using hElectricSq

      rcases mul_eq_zero.mp hElectricMul with
        hElectric | hElectric

      · exact hElectric
      · exact hElectric

    · have hMagneticMul :
          magnetic * magnetic = 0 := by
        simpa [pow_two] using hMagneticSq

      rcases mul_eq_zero.mp hMagneticMul with
        hMagnetic | hMagnetic

      · exact hMagnetic
      · exact hMagnetic

  constructor

  · intro hTotal

    have hNonneg₀ :
        0 ≤
          hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (0 : Fin 3))
            (fieldPair.2 (0 : Fin 3)) := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

      positivity

    have hNonneg₁ :
        0 ≤
          hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (1 : Fin 3))
            (fieldPair.2 (1 : Fin 3)) := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

      positivity

    have hNonneg₂ :
        0 ≤
          hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (2 : Fin 3))
            (fieldPair.2 (2 : Fin 3)) := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq

      positivity

    have hComponent₀ :
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (0 : Fin 3))
            (fieldPair.2 (0 : Fin 3)) =
          0 := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        at hTotal

      nlinarith

    have hComponent₁ :
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (1 : Fin 3))
            (fieldPair.2 (1 : Fin 3)) =
          0 := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        at hTotal

      nlinarith

    have hComponent₂ :
        hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
            (fieldPair.1 (2 : Fin 3))
            (fieldPair.2 (2 : Fin 3)) =
          0 := by
      unfold
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        at hTotal

      nlinarith

    have hZero₀ :=
      component_eq_zero
        (fieldPair.1 (0 : Fin 3))
        (fieldPair.2 (0 : Fin 3))
        hComponent₀

    have hZero₁ :=
      component_eq_zero
        (fieldPair.1 (1 : Fin 3))
        (fieldPair.2 (1 : Fin 3))
        hComponent₁

    have hZero₂ :=
      component_eq_zero
        (fieldPair.1 (2 : Fin 3))
        (fieldPair.2 (2 : Fin 3))
        hComponent₂

    apply Prod.ext

    · funext i

      fin_cases i

      · simpa using hZero₀.1
      · simpa using hZero₁.1
      · simpa using hZero₂.1

    · funext i

      fin_cases i

      · simpa using hZero₀.2
      · simpa using hZero₁.2
      · simpa using hZero₂.2

  · intro hZero

    rw [hZero]

    norm_num [
      hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq,
      hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq
    ]

/--
The total three-component antisymmetric electric-magnetic bilinear form.
-/
def
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    ℝ :=
  hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
      (firstFieldPair.1 (0 : Fin 3))
      (firstFieldPair.2 (0 : Fin 3))
      (secondFieldPair.1 (0 : Fin 3))
      (secondFieldPair.2 (0 : Fin 3)) +
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
      (firstFieldPair.1 (1 : Fin 3))
      (firstFieldPair.2 (1 : Fin 3))
      (secondFieldPair.1 (1 : Fin 3))
      (secondFieldPair.2 (1 : Fin 3)) +
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm
      (firstFieldPair.1 (2 : Fin 3))
      (firstFieldPair.2 (2 : Fin 3))
      (secondFieldPair.1 (2 : Fin 3))
      (secondFieldPair.2 (2 : Fin 3))

/--
For nonzero permittivity, the total quadratic norm equals the total
antisymmetric pairing of a MaxwellVector3 field pair with its normalized
complex-structure image.

This lifts the componentwise quadratic-symplectic-complex compatibility
identity to the complete six-dimensional reduced Maxwell coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq_eq_totalAntisymmetricPairing_with_normalizedMap
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        fieldPair
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          fieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
        fieldPair := by
  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq

  rw [
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
      ε₀
      hε₀
      fieldPair
      (0 : Fin 3),
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
      ε₀
      hε₀
      fieldPair
      (1 : Fin 3),
    hiddenSectorReducedJointMaxwellCandidate_componentQuadraticNormSq_eq_antisymmetricPairing_with_normalizedMap
      ε₀
      hε₀
      fieldPair
      (2 : Fin 3)
  ]

/--
For nonzero permittivity, the left kernel of the total antisymmetric
electric-magnetic bilinear form is trivial.

A field pair that pairs to zero with every second field pair must itself
vanish. The normalized complex image supplies the decisive test direction,
because its pairing equals the positive total quadratic norm.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_leftKernel_trivial
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (hKernel :
      ∀ secondFieldPair :
          MaxwellVector3 × MaxwellVector3,
        hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
            fieldPair
            secondFieldPair =
          0) :
    fieldPair =
      ((fun _ : Fin 3 => 0),
        fun _ : Fin 3 => 0) := by
  have hComplexPairingZero :
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
          fieldPair
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            fieldPair) =
        0 :=
    hKernel
      (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
        ε₀
        fieldPair)

  have hQuadraticZero :
      hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq
          fieldPair =
        0 := by
    rw [
      ←
        hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq_eq_totalAntisymmetricPairing_with_normalizedMap
          ε₀
          hε₀
          fieldPair
    ]

    exact hComplexPairingZero

  exact
    (hiddenSectorReducedJointMaxwellCandidate_totalQuadraticNormSq_eq_zero_iff
      fieldPair).mp
      hQuadraticZero

/--
The total three-component electric-magnetic bilinear form is skew-symmetric.

Exchanging its two MaxwellVector3 field-pair arguments reverses the sign of
the total pairing.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_skewSymmetric
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        firstFieldPair
        secondFieldPair =
      -hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        secondFieldPair
        firstFieldPair := by
  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm

  unfold
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm

  ring

/--
For nonzero permittivity, the right kernel of the total antisymmetric
electric-magnetic bilinear form is trivial.

Skew-symmetry converts a right-kernel element into a left-kernel element, so
the previously proved left nondegeneracy forces the field pair to vanish.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_rightKernel_trivial
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3)
    (hKernel :
      ∀ firstFieldPair :
          MaxwellVector3 × MaxwellVector3,
        hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
            firstFieldPair
            fieldPair =
          0) :
    fieldPair =
      ((fun _ : Fin 3 => 0),
        fun _ : Fin 3 => 0) := by
  have hLeftKernel :
      ∀ secondFieldPair :
          MaxwellVector3 × MaxwellVector3,
        hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
            fieldPair
            secondFieldPair =
          0 := by
    intro secondFieldPair

    rw [
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_skewSymmetric
        fieldPair
        secondFieldPair
    ]

    simp [
      hKernel secondFieldPair
    ]

  exact
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_leftKernel_trivial
      ε₀
      hε₀
      fieldPair
      hLeftKernel

/--
The total symmetric electric-magnetic bilinear form on the complete
MaxwellVector3 coordinate-pair space.
-/
def
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    ℝ :=
  firstFieldPair.1 (0 : Fin 3) *
      secondFieldPair.1 (0 : Fin 3) +
    firstFieldPair.2 (0 : Fin 3) *
      secondFieldPair.2 (0 : Fin 3) +
    firstFieldPair.1 (1 : Fin 3) *
      secondFieldPair.1 (1 : Fin 3) +
    firstFieldPair.2 (1 : Fin 3) *
      secondFieldPair.2 (1 : Fin 3) +
    firstFieldPair.1 (2 : Fin 3) *
      secondFieldPair.1 (2 : Fin 3) +
    firstFieldPair.2 (2 : Fin 3) *
      secondFieldPair.2 (2 : Fin 3)

/--
For nonzero permittivity, pairing a first Maxwell field pair
antisymmetrically with the normalized complex image of a second field pair
equals their total symmetric bilinear pairing.

This is the full polarized compatibility law

  ω(first, J second) = g(first, second),

which strengthens the previously proved diagonal quadratic identity.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricPairing_with_normalizedMap_eq_totalSymmetricBilinearForm
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        firstFieldPair
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        firstFieldPair
        secondFieldPair := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm

  unfold
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
For nonzero permittivity, the normalized Maxwell complex structure preserves
the total symmetric electric-magnetic bilinear form in both arguments.

Thus the normalized electric-magnetic quarter-turn is globally orthogonal on
the complete six-dimensional reduced coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_preserves_totalSymmetricBilinearForm
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          firstFieldPair)
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        firstFieldPair
        secondFieldPair := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
For nonzero permittivity, the normalized Maxwell complex structure is
skew-adjoint with respect to the total symmetric electric-magnetic bilinear
form.

Moving the normalized complex structure from the first argument to the second
therefore reverses the sign of the pairing.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_skewAdjoint_totalSymmetricBilinearForm
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          firstFieldPair)
        secondFieldPair =
      -hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        firstFieldPair
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair) := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
  ]

  field_simp [hε₀] <;>
    ring

/--
For nonzero permittivity, the total antisymmetric Maxwell pairing is recovered
from the positive symmetric form and normalized complex structure in either
argument:

  ω(first, second) = g(J first, second)
  ω(first, second) = -g(first, J second).

The two formulas record the exact sign convention determined by the explicit
electric-magnetic quarter-turn.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm_eq_metricComplexPairings
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    (hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        firstFieldPair
        secondFieldPair =
      hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          firstFieldPair)
        secondFieldPair) ∧
    (hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        firstFieldPair
        secondFieldPair =
      -hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        firstFieldPair
        (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
          ε₀
          secondFieldPair)) := by
  have hLeft :
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
          firstFieldPair
          secondFieldPair =
        hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            firstFieldPair)
          secondFieldPair := by
    rcases firstFieldPair with
      ⟨electric₁, magnetic₁⟩

    rcases secondFieldPair with
      ⟨electric₂, magnetic₂⟩

    unfold
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm

    unfold
      hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm

    unfold
      hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
    ]

    field_simp [hε₀] <;>
      ring

  constructor

  · exact hLeft

  · calc
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
          firstFieldPair
          secondFieldPair =
        hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            firstFieldPair)
          secondFieldPair :=
        hLeft
      _ =
        -hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
          firstFieldPair
          (hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
            ε₀
            secondFieldPair) :=
        hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_skewAdjoint_totalSymmetricBilinearForm
          ε₀
          hε₀
          firstFieldPair
          secondFieldPair

/--
The continuous electric-magnetic duality rotation through a real angle.

It acts simultaneously and componentwise on the complete pair of
MaxwellVector3 fields.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    (angle : ℝ)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    MaxwellVector3 × MaxwellVector3 :=
  ((fun i : Fin 3 =>
      Real.cos angle * fieldPair.1 i -
        Real.sin angle * fieldPair.2 i),
    fun i : Fin 3 =>
      Real.sin angle * fieldPair.1 i +
        Real.cos angle * fieldPair.2 i)

/--
Successive Maxwell duality rotations add their angles exactly.

Thus the continuous electric-magnetic rotations form a real one-parameter
group action on the complete reduced Maxwell coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation_add
    (firstAngle secondAngle : ℝ)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        firstAngle
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          secondAngle
          fieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        (firstAngle + secondAngle)
        fieldPair := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_add,
      Real.sin_add
    ]

    ring

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_add,
      Real.sin_add
    ]

    ring

/--
Every continuous electric-magnetic duality rotation preserves the total
symmetric bilinear form.

Consequently, the full one-parameter duality action is orthogonal on the
complete six-dimensional reduced Maxwell coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation_preserves_totalSymmetricBilinearForm
    (angle : ℝ)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          angle
          firstFieldPair)
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          angle
          secondFieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm
        firstFieldPair
        secondFieldPair := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  have hComponent
      (firstElectric firstMagnetic
        secondElectric secondMagnetic : ℝ) :
      (Real.cos angle * firstElectric -
          Real.sin angle * firstMagnetic) *
          (Real.cos angle * secondElectric -
            Real.sin angle * secondMagnetic) +
        (Real.sin angle * firstElectric +
          Real.cos angle * firstMagnetic) *
          (Real.sin angle * secondElectric +
            Real.cos angle * secondMagnetic) =
        firstElectric * secondElectric +
          firstMagnetic * secondMagnetic := by
    calc
      (Real.cos angle * firstElectric -
            Real.sin angle * firstMagnetic) *
            (Real.cos angle * secondElectric -
              Real.sin angle * secondMagnetic) +
          (Real.sin angle * firstElectric +
            Real.cos angle * firstMagnetic) *
            (Real.sin angle * secondElectric +
              Real.cos angle * secondMagnetic) =
        (Real.sin angle ^ 2 + Real.cos angle ^ 2) *
          (firstElectric * secondElectric +
            firstMagnetic * secondMagnetic) := by
              ring
      _ =
        firstElectric * secondElectric +
          firstMagnetic * secondMagnetic := by
            rw [Real.sin_sq_add_cos_sq]
            ring

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalSymmetricBilinearForm

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation
  ]

  calc
    _ =
        ((Real.cos angle * electric₁ (0 : Fin 3) -
              Real.sin angle * magnetic₁ (0 : Fin 3)) *
            (Real.cos angle * electric₂ (0 : Fin 3) -
              Real.sin angle * magnetic₂ (0 : Fin 3)) +
          (Real.sin angle * electric₁ (0 : Fin 3) +
              Real.cos angle * magnetic₁ (0 : Fin 3)) *
            (Real.sin angle * electric₂ (0 : Fin 3) +
              Real.cos angle * magnetic₂ (0 : Fin 3))) +
        ((Real.cos angle * electric₁ (1 : Fin 3) -
              Real.sin angle * magnetic₁ (1 : Fin 3)) *
            (Real.cos angle * electric₂ (1 : Fin 3) -
              Real.sin angle * magnetic₂ (1 : Fin 3)) +
          (Real.sin angle * electric₁ (1 : Fin 3) +
              Real.cos angle * magnetic₁ (1 : Fin 3)) *
            (Real.sin angle * electric₂ (1 : Fin 3) +
              Real.cos angle * magnetic₂ (1 : Fin 3))) +
        ((Real.cos angle * electric₁ (2 : Fin 3) -
              Real.sin angle * magnetic₁ (2 : Fin 3)) *
            (Real.cos angle * electric₂ (2 : Fin 3) -
              Real.sin angle * magnetic₂ (2 : Fin 3)) +
          (Real.sin angle * electric₁ (2 : Fin 3) +
              Real.cos angle * magnetic₁ (2 : Fin 3)) *
            (Real.sin angle * electric₂ (2 : Fin 3) +
              Real.cos angle * magnetic₂ (2 : Fin 3))) := by
          ring
    _ =
        (electric₁ (0 : Fin 3) * electric₂ (0 : Fin 3) +
          magnetic₁ (0 : Fin 3) * magnetic₂ (0 : Fin 3)) +
        (electric₁ (1 : Fin 3) * electric₂ (1 : Fin 3) +
          magnetic₁ (1 : Fin 3) * magnetic₂ (1 : Fin 3)) +
        (electric₁ (2 : Fin 3) * electric₂ (2 : Fin 3) +
          magnetic₁ (2 : Fin 3) * magnetic₂ (2 : Fin 3)) := by
          rw [
            hComponent
              (electric₁ (0 : Fin 3))
              (magnetic₁ (0 : Fin 3))
              (electric₂ (0 : Fin 3))
              (magnetic₂ (0 : Fin 3)),
            hComponent
              (electric₁ (1 : Fin 3))
              (magnetic₁ (1 : Fin 3))
              (electric₂ (1 : Fin 3))
              (magnetic₂ (1 : Fin 3)),
            hComponent
              (electric₁ (2 : Fin 3))
              (magnetic₁ (2 : Fin 3))
              (electric₂ (2 : Fin 3))
              (magnetic₂ (2 : Fin 3))
          ]
    _ = _ := by
          ring

/--
Every continuous electric-magnetic duality rotation preserves the complete
three-component antisymmetric bilinear form.

Consequently, the full one-parameter duality action preserves oriented
electric-magnetic area throughout the reduced Maxwell coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation_preserves_totalAntisymmetricBilinearForm
    (angle : ℝ)
    (firstFieldPair secondFieldPair :
      MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          angle
          firstFieldPair)
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          angle
          secondFieldPair) =
      hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm
        firstFieldPair
        secondFieldPair := by
  rcases firstFieldPair with
    ⟨electric₁, magnetic₁⟩

  rcases secondFieldPair with
    ⟨electric₂, magnetic₂⟩

  have hComponent
      (firstElectric firstMagnetic
        secondElectric secondMagnetic : ℝ) :
      (Real.cos angle * firstElectric -
          Real.sin angle * firstMagnetic) *
          (Real.sin angle * secondElectric +
            Real.cos angle * secondMagnetic) -
        (Real.sin angle * firstElectric +
          Real.cos angle * firstMagnetic) *
          (Real.cos angle * secondElectric -
            Real.sin angle * secondMagnetic) =
        firstElectric * secondMagnetic -
          firstMagnetic * secondElectric := by
    calc
      (Real.cos angle * firstElectric -
            Real.sin angle * firstMagnetic) *
            (Real.sin angle * secondElectric +
              Real.cos angle * secondMagnetic) -
          (Real.sin angle * firstElectric +
            Real.cos angle * firstMagnetic) *
            (Real.cos angle * secondElectric -
              Real.sin angle * secondMagnetic) =
        (Real.sin angle ^ 2 + Real.cos angle ^ 2) *
          (firstElectric * secondMagnetic -
            firstMagnetic * secondElectric) := by
              ring
      _ =
        firstElectric * secondMagnetic -
          firstMagnetic * secondElectric := by
            rw [Real.sin_sq_add_cos_sq]
            ring

  unfold
    hiddenSectorReducedJointMaxwellCandidate_totalAntisymmetricBilinearForm

  unfold
    hiddenSectorReducedJointMaxwellCandidate_componentAntisymmetricBilinearForm

  dsimp [
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation
  ]

  rw [
    hComponent
      (electric₁ (0 : Fin 3))
      (magnetic₁ (0 : Fin 3))
      (electric₂ (0 : Fin 3))
      (magnetic₂ (0 : Fin 3)),
    hComponent
      (electric₁ (1 : Fin 3))
      (magnetic₁ (1 : Fin 3))
      (electric₂ (1 : Fin 3))
      (magnetic₂ (1 : Fin 3)),
    hComponent
      (electric₁ (2 : Fin 3))
      (magnetic₁ (2 : Fin 3))
      (electric₂ (2 : Fin 3))
      (magnetic₂ (2 : Fin 3))
  ]

/--
Rotation through the negative angle is a two-sided inverse of every continuous
electric-magnetic duality rotation.

Hence each element of the one-parameter duality action is an explicit
automorphism of the complete reduced Maxwell coordinate sector.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation_negativeAngle_inverse
    (angle : ℝ)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        (-angle)
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          angle
          fieldPair) =
      fieldPair) ∧
    (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        angle
        (hiddenSectorReducedJointMaxwellCandidate_dualityRotation
          (-angle)
          fieldPair) =
      fieldPair) := by
  constructor

  · rw [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation_add
        (-angle)
        angle
        fieldPair
    ]

    have hAngle :
        -angle + angle = 0 := by
      ring

    rw [hAngle]

    rcases fieldPair with
      ⟨electric, magnetic⟩

    apply Prod.ext

    · funext i

      simp [
        hiddenSectorReducedJointMaxwellCandidate_dualityRotation
      ]

    · funext i

      simp [
        hiddenSectorReducedJointMaxwellCandidate_dualityRotation
      ]

  · rw [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation_add
        angle
        (-angle)
        fieldPair
    ]

    have hAngle :
        angle + -angle = 0 := by
      ring

    rw [hAngle]

    rcases fieldPair with
      ⟨electric, magnetic⟩

    apply Prod.ext

    · funext i

      simp [
        hiddenSectorReducedJointMaxwellCandidate_dualityRotation
      ]

    · funext i

      simp [
        hiddenSectorReducedJointMaxwellCandidate_dualityRotation
      ]

/--
For nonzero permittivity, the normalized primary-constraint momentum map is
exactly the continuous Maxwell duality rotation through π / 2.

Thus the previously constructed complex structure is the quarter-turn element
of the full electric-magnetic duality group.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap_eq_dualityRotation_pi_div_two
    (ε₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap
        ε₀
        fieldPair =
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        (Real.pi / 2)
        fieldPair := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap,
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_pi_div_two,
      Real.sin_pi_div_two
    ]

    field_simp [hε₀] <;>
      ring

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_normalizedPrimaryConstraintMomentumMap,
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_pi_div_two,
      Real.sin_pi_div_two
    ]

    field_simp [hε₀] <;>
      ring

/--
Maxwell duality rotation through π is componentwise negation of both electric
and magnetic fields.

Thus a half-turn in the continuous duality group reverses the complete reduced
Maxwell coordinate pair.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation_pi_eq_componentwise_negation
    (fieldPair : MaxwellVector3 × MaxwellVector3) :
    hiddenSectorReducedJointMaxwellCandidate_dualityRotation
        Real.pi
        fieldPair =
      ((fun i : Fin 3 =>
          -fieldPair.1 i),
        fun i : Fin 3 =>
          -fieldPair.2 i) := by
  rcases fieldPair with
    ⟨electric, magnetic⟩

  apply Prod.ext

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_pi,
      Real.sin_pi
    ]

    ring

  · funext i

    dsimp [
      hiddenSectorReducedJointMaxwellCandidate_dualityRotation
    ]

    rw [
      Real.cos_pi,
      Real.sin_pi
    ]

    ring

/--
A vanishing candidate Euler–Lagrange residual together with the Faraday
equation required by the raw electric-magnetic quarter-turn forces an exact
source compatibility law.

Specifically, the electric current must equal the permeability/permittivity
mismatch multiplied by the magnetic curl:

  J = ((1 / μ₀) - ε₀) curl B.

This identifies the source-sector defect that obstructs quarter-turn duality
covariance of the sourced reduced Maxwell equations.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_quarterTurnFaraday_forces_current_curl_defect
    (ε₀ μ₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3)
    (hResidual :
      hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
          ε₀
          μ₀
          field
          point =
        (0, 0))
    (hQuarterTurnFaraday :
      maxwellTimeDerivative3
          field.electric
          point =
        maxwellCurl3
          field.magnetic
          point) :
    field.current point =
      fun i : Fin 3 =>
        (1 / μ₀ - ε₀) *
          maxwellCurl3
            field.magnetic
            point
            i := by
  have hEvolution :
      UncontractedMaxwellEvolutionAt3
        ε₀
        μ₀
        field
        point :=
    (hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual_eq_zero_iff
      ε₀
      μ₀
      hε₀
      field
      point).1
      hResidual

  funext i

  have hAmpereComponent :
      ε₀ *
          maxwellTimeDerivative3
            field.electric
            point
            i =
        (1 / μ₀) *
            maxwellCurl3
              field.magnetic
              point
              i -
          field.current point i :=
    congrFun
      hEvolution.ampereMaxwell
      i

  have hQuarterTurnComponent :
      maxwellTimeDerivative3
          field.electric
          point
          i =
        maxwellCurl3
          field.magnetic
          point
          i :=
    congrFun
      hQuarterTurnFaraday
      i

  calc
    field.current point i =
        (1 / μ₀) *
              maxwellCurl3
                field.magnetic
                point
                i -
          ((1 / μ₀) *
                maxwellCurl3
                  field.magnetic
                  point
                  i -
            field.current point i) := by
              ring
    _ =
        (1 / μ₀) *
              maxwellCurl3
                field.magnetic
                point
                i -
          ε₀ *
            maxwellTimeDerivative3
              field.electric
              point
              i := by
            rw [← hAmpereComponent]
    _ =
        (1 / μ₀ - ε₀) *
          maxwellCurl3
            field.magnetic
            point
            i := by
          rw [hQuarterTurnComponent]
          ring

/--
At the duality-matched coefficient relation ε₀ = 1 / μ₀, a vanishing
candidate Euler–Lagrange residual together with the quarter-turn Faraday law
forces the electric current to vanish exactly.

This is the zero-defect specialization of the sourced quarter-turn
compatibility theorem; it does not assert full transformed-field covariance.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidate_dualityMatched_quarterTurnFaraday_forces_current_zero
    (μ₀ : ℝ)
    (hμ₀ : μ₀ ≠ 0)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3)
    (hResidual :
      hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
          (1 / μ₀)
          μ₀
          field
          point =
        (0, 0))
    (hQuarterTurnFaraday :
      maxwellTimeDerivative3
          field.electric
          point =
        maxwellCurl3
          field.magnetic
          point) :
    field.current point = 0 := by
  have hReciprocal :
      (1 / μ₀ : ℝ) ≠ 0 := by
    exact
      div_ne_zero
        (by norm_num)
        hμ₀

  have hDefect :=
    hiddenSectorReducedJointMaxwellCandidate_quarterTurnFaraday_forces_current_curl_defect
      (1 / μ₀)
      μ₀
      hReciprocal
      field
      point
      hResidual
      hQuarterTurnFaraday

  funext i

  have hComponent :=
    congrFun
      hDefect
      i

  simpa using hComponent

/--
A smooth Maxwell field together with an independent magnetic-current source.

The existing `SmoothMaxwellField3` carrier retains the electric current, while
`magneticCurrent` supplies the missing source required to formulate nonzero
sourced electric-magnetic duality covariance without changing existing field
constructors.
-/
structure SmoothDualSourcedMaxwellField3 where
  field : SmoothMaxwellField3
  magneticCurrent : MaxwellSpacetime3 → MaxwellVector3

/--
The electric-magnetic quarter-turn action on one source-current pair.

The electric current is sent to negative magnetic current, while the magnetic
current is sent to electric current.  This defines only the source-space action;
no transformed field equation or covariance claim is included here.
-/
def hiddenSectorReducedJointMaxwellCandidate_dualSourceQuarterTurn
    (sourcePair : MaxwellVector3 × MaxwellVector3) :
    MaxwellVector3 × MaxwellVector3 :=
  ((fun i : Fin 3 =>
      -sourcePair.2 i),
    sourcePair.1)

/--
A concrete real four-dimensional vector carrier for the Tri construction.
-/
structure HiddenSectorVector4 where
  c0 : ℝ
  c1 : ℝ
  c2 : ℝ
  c3 : ℝ

/--
The Euclidean bilinear pairing on the concrete four-dimensional carrier.
-/
def hiddenSectorVector4Dot
    (first second : HiddenSectorVector4) : ℝ :=
  first.c0 * second.c0 +
    first.c1 * second.c1 +
    first.c2 * second.c2 +
    first.c3 * second.c3

/--
The three-by-three determinant used in the four-dimensional Tri normal.
-/
def hiddenSectorDeterminant3
    (a00 a01 a02
      a10 a11 a12
      a20 a21 a22 : ℝ) : ℝ :=
  a00 * (a11 * a22 - a12 * a21) -
    a01 * (a10 * a22 - a12 * a20) +
    a02 * (a10 * a21 - a11 * a20)

/--
The oriented Tri normal of three vectors in real four-dimensional space.

Its four coordinates are the signed three-by-three minors of the matrix whose
rows are the three input vectors.  This is the coordinate form of the Hodge
dual of their exterior triple product.
-/
def hiddenSectorVector4TriNormal
    (first second third : HiddenSectorVector4) :
    HiddenSectorVector4 :=
  {
    c0 :=
      hiddenSectorDeterminant3
        first.c1 first.c2 first.c3
        second.c1 second.c2 second.c3
        third.c1 third.c2 third.c3
    c1 :=
      -hiddenSectorDeterminant3
        first.c0 first.c2 first.c3
        second.c0 second.c2 second.c3
        third.c0 third.c2 third.c3
    c2 :=
      hiddenSectorDeterminant3
        first.c0 first.c1 first.c3
        second.c0 second.c1 second.c3
        third.c0 third.c1 third.c3
    c3 :=
      -hiddenSectorDeterminant3
        first.c0 first.c1 first.c2
        second.c0 second.c1 second.c2
        third.c0 third.c1 third.c2
  }

/--
The four-dimensional Tri orthogonality theorem.

For every ordered triple of real four-dimensional vectors, the oriented Tri
normal obtained from the signed three-by-three minors is orthogonal to each of
the three generating vectors.
-/
theorem
    hiddenSectorVector4_triNormal_orthogonal_to_generating_triple
    (first second third : HiddenSectorVector4) :
    hiddenSectorVector4Dot
        (hiddenSectorVector4TriNormal first second third)
        first =
      0 ∧
    hiddenSectorVector4Dot
        (hiddenSectorVector4TriNormal first second third)
        second =
      0 ∧
    hiddenSectorVector4Dot
        (hiddenSectorVector4TriNormal first second third)
        third =
      0 := by
  rcases first with
    ⟨first0, first1, first2, first3⟩

  rcases second with
    ⟨second0, second1, second2, second3⟩

  rcases third with
    ⟨third0, third1, third2, third3⟩

  constructor

  · unfold
      hiddenSectorVector4Dot
      hiddenSectorVector4TriNormal
      hiddenSectorDeterminant3

    ring

  constructor

  · unfold
      hiddenSectorVector4Dot
      hiddenSectorVector4TriNormal
      hiddenSectorDeterminant3

    ring

  · unfold
      hiddenSectorVector4Dot
      hiddenSectorVector4TriNormal
      hiddenSectorDeterminant3

    ring

/--
The squared Euclidean norm of the four-dimensional Tri normal equals the Gram
determinant of its three generating vectors.

This is the concrete signed-minor form of the three-vector Gram identity in
real four-dimensional Euclidean space.
-/
theorem
    hiddenSectorVector4_triNormal_sqNorm_eq_gramDeterminant
    (first second third : HiddenSectorVector4) :
    hiddenSectorVector4Dot
        (hiddenSectorVector4TriNormal first second third)
        (hiddenSectorVector4TriNormal first second third) =
      hiddenSectorDeterminant3
        (hiddenSectorVector4Dot first first)
        (hiddenSectorVector4Dot first second)
        (hiddenSectorVector4Dot first third)
        (hiddenSectorVector4Dot second first)
        (hiddenSectorVector4Dot second second)
        (hiddenSectorVector4Dot second third)
        (hiddenSectorVector4Dot third first)
        (hiddenSectorVector4Dot third second)
        (hiddenSectorVector4Dot third third) := by
  rcases first with
    ⟨first0, first1, first2, first3⟩

  rcases second with
    ⟨second0, second1, second2, second3⟩

  rcases third with
    ⟨third0, third1, third2, third3⟩

  unfold
    hiddenSectorVector4Dot
    hiddenSectorVector4TriNormal
    hiddenSectorDeterminant3

  ring

/--
A strictly positive three-generator Gram determinant forces the
four-dimensional Tri normal to be nonzero.

Combined with the Tri Gram identity, this certifies that every generating
triple with positive squared oriented three-volume has a genuine normal
direction in the concrete four-dimensional Euclidean carrier.
-/
theorem
    hiddenSectorVector4_triNormal_ne_zero_of_gramDeterminant_pos
    (first second third : HiddenSectorVector4)
    (hGramPositive :
      0 <
        hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third)) :
    hiddenSectorVector4TriNormal first second third ≠
      ({
        c0 := 0
        c1 := 0
        c2 := 0
        c3 := 0
      } : HiddenSectorVector4) := by
  intro hTriZero

  have hIdentity :=
    hiddenSectorVector4_triNormal_sqNorm_eq_gramDeterminant
      first
      second
      third

  have hGramZero :
      hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third) =
        0 := by
    rw [← hIdentity, hTriZero]

    norm_num [hiddenSectorVector4Dot]

  exact
    (ne_of_gt hGramPositive)
      hGramZero

/--
Concrete coefficient linear dependence for an ordered triple in the
four-dimensional Euclidean carrier.

The coefficients are required not to vanish simultaneously, and their
componentwise linear combination of the three generators must be zero.
-/
def hiddenSectorVector4TripleLinearlyDependent
    (first second third : HiddenSectorVector4) : Prop :=
  ∃ firstCoefficient secondCoefficient thirdCoefficient : ℝ,
    (firstCoefficient ≠ 0 ∨
      secondCoefficient ≠ 0 ∨
      thirdCoefficient ≠ 0) ∧
    firstCoefficient * first.c0 +
          secondCoefficient * second.c0 +
          thirdCoefficient * third.c0 =
        0 ∧
    firstCoefficient * first.c1 +
          secondCoefficient * second.c1 +
          thirdCoefficient * third.c1 =
        0 ∧
    firstCoefficient * first.c2 +
          secondCoefficient * second.c2 +
          thirdCoefficient * third.c2 =
        0 ∧
    firstCoefficient * first.c3 +
          secondCoefficient * second.c3 +
          thirdCoefficient * third.c3 =
        0

/--
The three-generator Gram determinant vanishes exactly when the ordered
four-dimensional generating triple is linearly dependent.

This closes the concrete Euclidean degeneracy criterion without introducing a
Hodge-star abstraction or changing the existing Tri-normal definition.
-/
theorem
    hiddenSectorVector4_gramDeterminant_eq_zero_iff_tripleLinearlyDependent
    (first second third : HiddenSectorVector4) :
    hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third) =
        0 ↔
      hiddenSectorVector4TripleLinearlyDependent
        first
        second
        third := by
  let gram : Matrix (Fin 3) (Fin 3) ℝ :=
    !![
      hiddenSectorVector4Dot first first,
        hiddenSectorVector4Dot first second,
        hiddenSectorVector4Dot first third;
      hiddenSectorVector4Dot second first,
        hiddenSectorVector4Dot second second,
        hiddenSectorVector4Dot second third;
      hiddenSectorVector4Dot third first,
        hiddenSectorVector4Dot third second,
        hiddenSectorVector4Dot third third
    ]

  have hGramMatrixDeterminant :
      gram.det =
        hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third) := by
    simp [
      gram,
      Matrix.det_fin_three,
      hiddenSectorDeterminant3
    ]

    ring

  constructor

  · intro hGramZero

    have hMatrixDeterminantZero :
        gram.det = 0 := by
      rw [hGramMatrixDeterminant]
      exact hGramZero

    rcases
        (Matrix.exists_mulVec_eq_zero_iff.mpr
          hMatrixDeterminantZero) with
      ⟨coefficient, hCoefficientNonzero, hKernel⟩

    have hCoefficientComponents :
        coefficient (0 : Fin 3) ≠ 0 ∨
          coefficient (1 : Fin 3) ≠ 0 ∨
          coefficient (2 : Fin 3) ≠ 0 := by
      by_cases hFirstCoefficient :
        coefficient (0 : Fin 3) = 0

      · by_cases hSecondCoefficient :
          coefficient (1 : Fin 3) = 0

        · have hThirdCoefficient :
              coefficient (2 : Fin 3) ≠ 0 := by
            intro hThirdCoefficient

            apply hCoefficientNonzero
            funext i
            fin_cases i <;>
              assumption

          exact
            Or.inr
              (Or.inr hThirdCoefficient)

        · exact
            Or.inr
              (Or.inl hSecondCoefficient)

      · exact Or.inl hFirstCoefficient

    have hKernelFirst :=
      congrFun hKernel (0 : Fin 3)

    have hKernelSecond :=
      congrFun hKernel (1 : Fin 3)

    have hKernelThird :=
      congrFun hKernel (2 : Fin 3)

    simp [
      gram,
      Matrix.mulVec,
      dotProduct
    ] at hKernelFirst hKernelSecond hKernelThird

    have hCombinationSquaredNormZero :
        (coefficient (0 : Fin 3) * first.c0 +
            coefficient (1 : Fin 3) * second.c0 +
            coefficient (2 : Fin 3) * third.c0) ^ 2 +
          (coefficient (0 : Fin 3) * first.c1 +
            coefficient (1 : Fin 3) * second.c1 +
            coefficient (2 : Fin 3) * third.c1) ^ 2 +
          (coefficient (0 : Fin 3) * first.c2 +
            coefficient (1 : Fin 3) * second.c2 +
            coefficient (2 : Fin 3) * third.c2) ^ 2 +
          (coefficient (0 : Fin 3) * first.c3 +
            coefficient (1 : Fin 3) * second.c3 +
            coefficient (2 : Fin 3) * third.c3) ^ 2 =
        0 := by
      calc
        _ =
            coefficient (0 : Fin 3) *
                (hiddenSectorVector4Dot first first *
                    coefficient (0 : Fin 3) +
                  hiddenSectorVector4Dot first second *
                    coefficient (1 : Fin 3) +
                  hiddenSectorVector4Dot first third *
                    coefficient (2 : Fin 3)) +
              coefficient (1 : Fin 3) *
                (hiddenSectorVector4Dot second first *
                    coefficient (0 : Fin 3) +
                  hiddenSectorVector4Dot second second *
                    coefficient (1 : Fin 3) +
                  hiddenSectorVector4Dot second third *
                    coefficient (2 : Fin 3)) +
              coefficient (2 : Fin 3) *
                (hiddenSectorVector4Dot third first *
                    coefficient (0 : Fin 3) +
                  hiddenSectorVector4Dot third second *
                    coefficient (1 : Fin 3) +
                  hiddenSectorVector4Dot third third *
                    coefficient (2 : Fin 3)) := by
              unfold hiddenSectorVector4Dot
              ring
        _ = 0 := by
          rw [hKernelFirst, hKernelSecond, hKernelThird]
          ring

    have hCombination0 :
        coefficient (0 : Fin 3) * first.c0 +
              coefficient (1 : Fin 3) * second.c0 +
              coefficient (2 : Fin 3) * third.c0 =
          0 := by
      nlinarith [
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c1 +
            coefficient (1 : Fin 3) * second.c1 +
            coefficient (2 : Fin 3) * third.c1),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c2 +
            coefficient (1 : Fin 3) * second.c2 +
            coefficient (2 : Fin 3) * third.c2),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c3 +
            coefficient (1 : Fin 3) * second.c3 +
            coefficient (2 : Fin 3) * third.c3)
      ]

    have hCombination1 :
        coefficient (0 : Fin 3) * first.c1 +
              coefficient (1 : Fin 3) * second.c1 +
              coefficient (2 : Fin 3) * third.c1 =
          0 := by
      nlinarith [
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c0 +
            coefficient (1 : Fin 3) * second.c0 +
            coefficient (2 : Fin 3) * third.c0),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c2 +
            coefficient (1 : Fin 3) * second.c2 +
            coefficient (2 : Fin 3) * third.c2),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c3 +
            coefficient (1 : Fin 3) * second.c3 +
            coefficient (2 : Fin 3) * third.c3)
      ]

    have hCombination2 :
        coefficient (0 : Fin 3) * first.c2 +
              coefficient (1 : Fin 3) * second.c2 +
              coefficient (2 : Fin 3) * third.c2 =
          0 := by
      nlinarith [
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c0 +
            coefficient (1 : Fin 3) * second.c0 +
            coefficient (2 : Fin 3) * third.c0),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c1 +
            coefficient (1 : Fin 3) * second.c1 +
            coefficient (2 : Fin 3) * third.c1),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c3 +
            coefficient (1 : Fin 3) * second.c3 +
            coefficient (2 : Fin 3) * third.c3)
      ]

    have hCombination3 :
        coefficient (0 : Fin 3) * first.c3 +
              coefficient (1 : Fin 3) * second.c3 +
              coefficient (2 : Fin 3) * third.c3 =
          0 := by
      nlinarith [
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c0 +
            coefficient (1 : Fin 3) * second.c0 +
            coefficient (2 : Fin 3) * third.c0),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c1 +
            coefficient (1 : Fin 3) * second.c1 +
            coefficient (2 : Fin 3) * third.c1),
        sq_nonneg
          (coefficient (0 : Fin 3) * first.c2 +
            coefficient (1 : Fin 3) * second.c2 +
            coefficient (2 : Fin 3) * third.c2)
      ]

    exact
      ⟨coefficient (0 : Fin 3),
        coefficient (1 : Fin 3),
        coefficient (2 : Fin 3),
        hCoefficientComponents,
        hCombination0,
        hCombination1,
        hCombination2,
        hCombination3⟩

  · rintro
      ⟨firstCoefficient,
        secondCoefficient,
        thirdCoefficient,
        hCoefficientComponents,
        hCombination0,
        hCombination1,
        hCombination2,
        hCombination3⟩

    let coefficient : Fin 3 → ℝ :=
      ![
        firstCoefficient,
        secondCoefficient,
        thirdCoefficient
      ]

    have hCoefficientNonzero :
        coefficient ≠ 0 := by
      intro hCoefficientZero

      have hFirstCoefficientZero :
          firstCoefficient = 0 := by
        have :=
          congrFun hCoefficientZero (0 : Fin 3)
        simpa [coefficient] using this

      have hSecondCoefficientZero :
          secondCoefficient = 0 := by
        have :=
          congrFun hCoefficientZero (1 : Fin 3)
        simpa [coefficient] using this

      have hThirdCoefficientZero :
          thirdCoefficient = 0 := by
        have :=
          congrFun hCoefficientZero (2 : Fin 3)
        simpa [coefficient] using this

      rcases hCoefficientComponents with
        hFirstCoefficient |
          hSecondCoefficient |
          hThirdCoefficient

      · exact hFirstCoefficient hFirstCoefficientZero
      · exact hSecondCoefficient hSecondCoefficientZero
      · exact hThirdCoefficient hThirdCoefficientZero

    have hKernel :
        gram.mulVec coefficient = 0 := by
      funext i
      fin_cases i

      · simp [
          gram,
          coefficient,
          Matrix.mulVec,
          dotProduct
        ]

        calc
          hiddenSectorVector4Dot first first * firstCoefficient +
                hiddenSectorVector4Dot first second * secondCoefficient +
                hiddenSectorVector4Dot first third * thirdCoefficient =
              first.c0 *
                    (firstCoefficient * first.c0 +
                      secondCoefficient * second.c0 +
                      thirdCoefficient * third.c0) +
                first.c1 *
                    (firstCoefficient * first.c1 +
                      secondCoefficient * second.c1 +
                      thirdCoefficient * third.c1) +
                first.c2 *
                    (firstCoefficient * first.c2 +
                      secondCoefficient * second.c2 +
                      thirdCoefficient * third.c2) +
                first.c3 *
                    (firstCoefficient * first.c3 +
                      secondCoefficient * second.c3 +
                      thirdCoefficient * third.c3) := by
                  unfold hiddenSectorVector4Dot
                  ring
          _ = 0 := by
            rw [
              hCombination0,
              hCombination1,
              hCombination2,
              hCombination3
            ]
            ring

      · simp [
          gram,
          coefficient,
          Matrix.mulVec,
          dotProduct
        ]

        calc
          hiddenSectorVector4Dot second first * firstCoefficient +
                hiddenSectorVector4Dot second second * secondCoefficient +
                hiddenSectorVector4Dot second third * thirdCoefficient =
              second.c0 *
                    (firstCoefficient * first.c0 +
                      secondCoefficient * second.c0 +
                      thirdCoefficient * third.c0) +
                second.c1 *
                    (firstCoefficient * first.c1 +
                      secondCoefficient * second.c1 +
                      thirdCoefficient * third.c1) +
                second.c2 *
                    (firstCoefficient * first.c2 +
                      secondCoefficient * second.c2 +
                      thirdCoefficient * third.c2) +
                second.c3 *
                    (firstCoefficient * first.c3 +
                      secondCoefficient * second.c3 +
                      thirdCoefficient * third.c3) := by
                  unfold hiddenSectorVector4Dot
                  ring
          _ = 0 := by
            rw [
              hCombination0,
              hCombination1,
              hCombination2,
              hCombination3
            ]
            ring

      · simp [
          gram,
          coefficient,
          Matrix.mulVec,
          dotProduct
        ]

        calc
          hiddenSectorVector4Dot third first * firstCoefficient +
                hiddenSectorVector4Dot third second * secondCoefficient +
                hiddenSectorVector4Dot third third * thirdCoefficient =
              third.c0 *
                    (firstCoefficient * first.c0 +
                      secondCoefficient * second.c0 +
                      thirdCoefficient * third.c0) +
                third.c1 *
                    (firstCoefficient * first.c1 +
                      secondCoefficient * second.c1 +
                      thirdCoefficient * third.c1) +
                third.c2 *
                    (firstCoefficient * first.c2 +
                      secondCoefficient * second.c2 +
                      thirdCoefficient * third.c2) +
                third.c3 *
                    (firstCoefficient * first.c3 +
                      secondCoefficient * second.c3 +
                      thirdCoefficient * third.c3) := by
                  unfold hiddenSectorVector4Dot
                  ring
          _ = 0 := by
            rw [
              hCombination0,
              hCombination1,
              hCombination2,
              hCombination3
            ]
            ring

    have hMatrixDeterminantZero :
        gram.det = 0 :=
      Matrix.exists_mulVec_eq_zero_iff.mp
        ⟨coefficient,
          hCoefficientNonzero,
          hKernel⟩

    rw [hGramMatrixDeterminant] at hMatrixDeterminantZero

    exact hMatrixDeterminantZero

/--
A linearly independent ordered triple in the concrete four-dimensional
Euclidean carrier has strictly positive Gram determinant.

Here linear independence is expressed as the negation of the previously
compiled concrete coefficient-dependence predicate.  Positivity follows from
the Tri Gram identity, nonnegativity of the squared Tri norm, and the exact
zero-determinant dependence criterion.
-/
theorem
    hiddenSectorVector4_gramDeterminant_pos_of_tripleLinearlyIndependent
    (first second third : HiddenSectorVector4)
    (hIndependent :
      ¬ hiddenSectorVector4TripleLinearlyDependent
          first
          second
          third) :
    0 <
      hiddenSectorDeterminant3
        (hiddenSectorVector4Dot first first)
        (hiddenSectorVector4Dot first second)
        (hiddenSectorVector4Dot first third)
        (hiddenSectorVector4Dot second first)
        (hiddenSectorVector4Dot second second)
        (hiddenSectorVector4Dot second third)
        (hiddenSectorVector4Dot third first)
        (hiddenSectorVector4Dot third second)
        (hiddenSectorVector4Dot third third) := by
  have hTriNormNonnegative :
      0 ≤
        hiddenSectorVector4Dot
          (hiddenSectorVector4TriNormal first second third)
          (hiddenSectorVector4TriNormal first second third) := by
    unfold hiddenSectorVector4Dot

    nlinarith [
      sq_nonneg
        ((hiddenSectorVector4TriNormal first second third).c0),
      sq_nonneg
        ((hiddenSectorVector4TriNormal first second third).c1),
      sq_nonneg
        ((hiddenSectorVector4TriNormal first second third).c2),
      sq_nonneg
        ((hiddenSectorVector4TriNormal first second third).c3)
    ]

  have hGramNonnegative :
      0 ≤
        hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third) := by
    rw [
      ← hiddenSectorVector4_triNormal_sqNorm_eq_gramDeterminant
        first
        second
        third
    ]

    exact hTriNormNonnegative

  have hGramNonzero :
      hiddenSectorDeterminant3
          (hiddenSectorVector4Dot first first)
          (hiddenSectorVector4Dot first second)
          (hiddenSectorVector4Dot first third)
          (hiddenSectorVector4Dot second first)
          (hiddenSectorVector4Dot second second)
          (hiddenSectorVector4Dot second third)
          (hiddenSectorVector4Dot third first)
          (hiddenSectorVector4Dot third second)
          (hiddenSectorVector4Dot third third) ≠
        0 := by
    intro hGramZero

    apply hIndependent

    exact
      (hiddenSectorVector4_gramDeterminant_eq_zero_iff_tripleLinearlyDependent
        first
        second
        third).mp
        hGramZero

  exact
    lt_of_le_of_ne
      hGramNonnegative
      (Ne.symm hGramNonzero)

/--
The signed-minor Tri normal of an ordered triple in the concrete Euclidean
four-dimensional carrier is nonzero exactly when that triple is linearly
independent.

The forward direction combines the Tri Gram identity with the exact
zero-Gram/dependence criterion.  The reverse direction uses strict Gram
positivity for independent triples and the compiled nonvanishing theorem.
-/
theorem
    hiddenSectorVector4_triNormal_ne_zero_iff_tripleLinearlyIndependent
    (first second third : HiddenSectorVector4) :
    hiddenSectorVector4TriNormal first second third ≠
          ({
            c0 := 0
            c1 := 0
            c2 := 0
            c3 := 0
          } : HiddenSectorVector4) ↔
      ¬ hiddenSectorVector4TripleLinearlyDependent
          first
          second
          third := by
  constructor

  · intro hTriNonzero hDependent

    have hGramZero :
        hiddenSectorDeterminant3
              (hiddenSectorVector4Dot first first)
              (hiddenSectorVector4Dot first second)
              (hiddenSectorVector4Dot first third)
              (hiddenSectorVector4Dot second first)
              (hiddenSectorVector4Dot second second)
              (hiddenSectorVector4Dot second third)
              (hiddenSectorVector4Dot third first)
              (hiddenSectorVector4Dot third second)
              (hiddenSectorVector4Dot third third) =
          0 :=
      (hiddenSectorVector4_gramDeterminant_eq_zero_iff_tripleLinearlyDependent
        first
        second
        third).2
        hDependent

    let tri : HiddenSectorVector4 :=
      hiddenSectorVector4TriNormal first second third

    have hTriNormZero :
        hiddenSectorVector4Dot tri tri = 0 := by
      dsimp [tri]

      rw [
        hiddenSectorVector4_triNormal_sqNorm_eq_gramDeterminant
          first
          second
          third
      ]

      exact hGramZero

    have hComponent0 : tri.c0 = 0 := by
      unfold hiddenSectorVector4Dot at hTriNormZero

      nlinarith [
        mul_self_nonneg tri.c1,
        mul_self_nonneg tri.c2,
        mul_self_nonneg tri.c3
      ]

    have hComponent1 : tri.c1 = 0 := by
      unfold hiddenSectorVector4Dot at hTriNormZero

      nlinarith [
        mul_self_nonneg tri.c0,
        mul_self_nonneg tri.c2,
        mul_self_nonneg tri.c3
      ]

    have hComponent2 : tri.c2 = 0 := by
      unfold hiddenSectorVector4Dot at hTriNormZero

      nlinarith [
        mul_self_nonneg tri.c0,
        mul_self_nonneg tri.c1,
        mul_self_nonneg tri.c3
      ]

    have hComponent3 : tri.c3 = 0 := by
      unfold hiddenSectorVector4Dot at hTriNormZero

      nlinarith [
        mul_self_nonneg tri.c0,
        mul_self_nonneg tri.c1,
        mul_self_nonneg tri.c2
      ]

    apply hTriNonzero

    change tri =
      ({
        c0 := 0
        c1 := 0
        c2 := 0
        c3 := 0
      } : HiddenSectorVector4)

    cases tri with
    | mk tri0 tri1 tri2 tri3 =>
        simp_all

  · intro hIndependent

    apply
      hiddenSectorVector4_triNormal_ne_zero_of_gramDeterminant_pos
        first
        second
        third

    exact
      hiddenSectorVector4_gramDeterminant_pos_of_tripleLinearlyIndependent
        first
        second
        third
        hIndependent

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
The ordinary magnetic-coordinate derivative of one candidate-density
component.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_magneticDerivative_exact
    (ε₀ μ₀
      electric magnetic
      electricTime magneticTime
      electricCurl magneticCurl
      current : ℝ) :
    deriv
        (fun currentMagnetic : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            electric
            currentMagnetic
            electricTime
            magneticTime
            electricCurl
            magneticCurl
            current)
        magnetic =
      -(ε₀ / 2) * electricTime +
        (1 / (2 * μ₀)) * magneticCurl -
        current := by
  let coefficient : ℝ :=
    -(ε₀ / 2) * electricTime +
      (1 / (2 * μ₀)) * magneticCurl -
      current

  let constantTerm : ℝ :=
    (ε₀ / 2) *
        electric *
        magneticTime +
      (ε₀ / 2) *
        electric *
        electricCurl

  have hAffine :
      HasDerivAt
          (fun currentMagnetic : ℝ =>
            coefficient * currentMagnetic +
              constantTerm)
          coefficient
          magnetic := by
    convert
      ((hasDerivAt_id magnetic).const_mul
          coefficient).add
        (hasDerivAt_const
          (x := magnetic)
          constantTerm)
      using 1 <;>
      simp

  have hFunction :
      (fun currentMagnetic : ℝ =>
        hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
          ε₀
          μ₀
          electric
          currentMagnetic
          electricTime
          magneticTime
          electricCurl
          magneticCurl
          current) =
        (fun currentMagnetic : ℝ =>
          coefficient * currentMagnetic +
            constantTerm) := by
    funext currentMagnetic

    dsimp [coefficient, constantTerm]

    unfold
      hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent

    ring

  rw [hFunction]

  simpa [coefficient] using hAffine.deriv

/--
The magnetic Euler–Lagrange component of the candidate first-jet density.

The second term is minus the time derivative of the magnetic temporal
momentum `(ε₀ / 2) E`. The third term is the formal self-adjoint curl
contribution from `(1 / (2 * μ₀)) B`.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrangeComponent
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 :=
  fun i : Fin 3 =>
    deriv
        (fun currentMagnetic : ℝ =>
          hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent
            ε₀
            μ₀
            (field.electric point i)
            currentMagnetic
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
        (field.magnetic point i) -
      (ε₀ / 2) *
        maxwellTimeDerivative3
          field.electric
          point
          i +
      (1 / (2 * μ₀)) *
        maxwellCurl3
          field.magnetic
          point
          i

/--
The magnetic Euler–Lagrange component of the candidate density is exactly the
second component of the diagonal-multiplied Maxwell residual.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrange_exact
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrangeComponent
        ε₀
        μ₀
        field
        point =
      (hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ε₀
        μ₀
        field
        point).2 := by
  funext i

  unfold
    hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrangeComponent

  rw [
    hiddenSectorReducedJointMaxwellCandidateLocalDensityComponent_magneticDerivative_exact
  ]

  simp [
    hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual,
    hiddenSectorReducedJointMaxwellResidual
  ] <;>
    ring

/--
The complete electric/magnetic Euler–Lagrange residual reconstructed from the
candidate local first-jet density.
-/
noncomputable def
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    MaxwellVector3 × MaxwellVector3 :=
  (hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrangeComponent
      ε₀
      μ₀
      field
      point,
    hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrangeComponent
      ε₀
      μ₀
      field
      point)

/--
Both Euler–Lagrange components of the candidate local density agree exactly
with the diagonal-multiplied Maxwell residual.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual_exact
    (ε₀ μ₀ : ℝ)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
        ε₀
        μ₀
        field
        point =
      hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual
        ε₀
        μ₀
        field
        point := by
  apply Prod.ext

  · exact
      hiddenSectorReducedJointMaxwellCandidateElectricEulerLagrange_exact
        ε₀
        μ₀
        field
        point

  · exact
      hiddenSectorReducedJointMaxwellCandidateMagneticEulerLagrange_exact
        ε₀
        μ₀
        field
        point

/--
For nonzero permittivity, the candidate Euler–Lagrange residual vanishes
exactly when the repository's uncontracted Maxwell evolution equations hold.
-/
theorem
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual_eq_zero_iff
    (ε₀ μ₀ : ℝ)
    (hε₀ : ε₀ ≠ 0)
    (field : SmoothMaxwellField3)
    (point : MaxwellSpacetime3) :
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
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
  rw [
    hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual_exact
  ]

  exact
    (hiddenSectorReducedJointMaxwellDiagonalMultipliedResidual_eq_zero_iff
      ε₀
      μ₀
      hε₀
      field
      point).trans
      (hiddenSectorReducedJointMaxwellResidual_eq_zero_iff
        ε₀
        μ₀
        field
        point)

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
For nonzero permittivity, the affine hidden trajectory, stationary source
amplitude, and static-curl field solve the source equation, hidden
Euler–Lagrange equation, and reconstructed Maxwell Euler–Lagrange equations
simultaneously.
-/
theorem
    hiddenSectorReducedJoint_affine_staticCurl_candidateVariational_solution
    (q₀ momentum ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hε₀ : ε₀ ≠ 0)
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
        hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual
            ε₀
            μ₀
            (hiddenSectorReducedJointStaticCurlField
              momentum
              μ₀
              domain)
            point =
          (0, 0)) := by
  have hSimultaneous :=
    hiddenSectorReducedJoint_affine_staticCurl_simultaneous_solution
      q₀
      momentum
      ε₀
      μ₀
      domain
      hμ₀
      hVolume

  refine
    ⟨hSimultaneous.1,
      hSimultaneous.2.1,
      ?_⟩

  intro point

  exact
    (hiddenSectorReducedJointMaxwellCandidateEulerLagrangeResidual_eq_zero_iff
      ε₀
      μ₀
      hε₀
      (hiddenSectorReducedJointStaticCurlField
        momentum
        μ₀
        domain)
      point).2
      (hSimultaneous.2.2 point)

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
