import Mathlib
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.LinearAlgebra.CrossProduct

namespace Chronos.Frontier

open MeasureTheory Set

theorem directionalFlowFractionB_conditionalIntegralBound
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    (μ : Measure α)
    (B : Set α)
    (c : ℝ)
    (u : α → ℝ)
    (S : α → E)
    (_hB_measurable : MeasurableSet B)
    (_hB_bounded : Bornology.IsBounded B)
    (_hc : 0 < c)
    (hu : IntegrableOn u B μ)
    (_hu_nonnegative : 0 ≤ᵐ[μ.restrict B] u)
    (hS : IntegrableOn S B μ)
    (hflux : ∀ᵐ x ∂μ.restrict B, ‖S x‖ ≤ c * u x)
    (_hEB_positive : 0 < ∫ x in B, u x ∂μ) :
    ‖∫ x in B, S x ∂μ‖ ≤ ∫ x in B, ‖S x‖ ∂μ ∧
      ∫ x in B, ‖S x‖ ∂μ ≤ c * ∫ x in B, u x ∂μ := by
  constructor
  · exact norm_integral_le_integral_norm S
  · have hcu :
        Integrable (fun x => c * u x) (μ.restrict B) := by
      refine (hu.smul c).congr ?_
      filter_upwards with x
      simp [Pi.smul_apply, smul_eq_mul]
    have hmono :
        ∫ x in B, ‖S x‖ ∂μ ≤ ∫ x in B, c * u x ∂μ := by
      exact integral_mono_ae hS.norm hcu hflux
    calc
      ∫ x in B, ‖S x‖ ∂μ
          ≤ ∫ x in B, c * u x ∂μ := hmono
      _ = c * ∫ x in B, u x ∂μ := by
        exact integral_const_mul c u


/--
Conditional directional-flow scaling consequence of the existing integral
bound:

    ‖∫_B S‖ / c³ ≤ (∫_B u) / c².

This theorem does not assert Lorentz invariance, conservation, empirical
realization, or a universal physical law `E = m * c³`.
-/
theorem directionalFlowMassB_conditionalUpperBound
    {α E : Type*}
    [MeasurableSpace α]
    [Bornology α]
    [NormedAddCommGroup E]
    [NormedSpace ℝ E]
    [CompleteSpace E]
    (μ : Measure α)
    (B : Set α)
    (c : ℝ)
    (u : α → ℝ)
    (S : α → E)
    (hB_measurable : MeasurableSet B)
    (hB_bounded : Bornology.IsBounded B)
    (hc : 0 < c)
    (hu : IntegrableOn u B μ)
    (hu_nonnegative : 0 ≤ᵐ[μ.restrict B] u)
    (hS : IntegrableOn S B μ)
    (hflux : ∀ᵐ x ∂μ.restrict B, ‖S x‖ ≤ c * u x)
    (hEB_positive : 0 < ∫ x in B, u x ∂μ) :
    ‖∫ x in B, S x ∂μ‖ / c ^ 3 ≤
      (∫ x in B, u x ∂μ) / c ^ 2 := by
  have hIntegral :=
    directionalFlowFractionB_conditionalIntegralBound
      μ B c u S
      hB_measurable
      hB_bounded
      hc
      hu
      hu_nonnegative
      hS
      hflux
      hEB_positive
  have hNormBound :
      ‖∫ x in B, S x ∂μ‖ ≤
        c * ∫ x in B, u x ∂μ :=
    le_trans hIntegral.1 hIntegral.2
  have hc3 : 0 < c ^ 3 :=
    pow_pos hc 3
  calc
    ‖∫ x in B, S x ∂μ‖ / c ^ 3
        ≤ (c * ∫ x in B, u x ∂μ) / c ^ 3 := by
      exact
        (div_le_div_iff₀ hc3 hc3).2
          (mul_le_mul_of_nonneg_right
            hNormBound
            (le_of_lt hc3))
    _ = (∫ x in B, u x ∂μ) / c ^ 2 := by
      field_simp [ne_of_gt hc]


/--
The scale-weighted algebraic inequality underlying the classical vacuum
Poynting-flux bound.

It follows from the nonnegativity of `(e - c * b)²`. No sign hypotheses on
`e` or `b` are required. This is an algebraic theorem only; it does not yet
construct electromagnetic fields or a three-dimensional cross product.
-/
theorem poynting_algebraic_bound
    (e b c : ℝ)
    (hc : 0 < c) :
    e * b ≤
      (1 / (2 * c)) * e ^ 2 +
        (c / 2) * b ^ 2 := by
  have hSquare :
      0 ≤ (e - c * b) ^ 2 :=
    sq_nonneg (e - c * b)
  have hRearranged :
      2 * c * (e * b) ≤
        e ^ 2 + c ^ 2 * b ^ 2 := by
    nlinarith
  have hReordered :
      e * b * (2 * c) ≤
        e ^ 2 + c ^ 2 * b ^ 2 := by
    simpa [mul_assoc, mul_comm, mul_left_comm] using hRearranged
  have hTwoC :
      0 < 2 * c := by
    nlinarith
  have hDivided :
      e * b ≤
        (e ^ 2 + c ^ 2 * b ^ 2) / (2 * c) := by
    exact (le_div_iff₀ hTwoC).2 hReordered
  calc
    e * b
        ≤ (e ^ 2 + c ^ 2 * b ^ 2) / (2 * c) :=
      hDivided
    _ =
        (1 / (2 * c)) * e ^ 2 +
          (c / 2) * b ^ 2 := by
      field_simp [ne_of_gt hc]


/--
Three-dimensional Euclidean vectors represented with Mathlib's `L²`
inner-product norm.
-/
abbrev EuclideanVector3 :=
  EuclideanSpace ℝ (Fin 3)

/--
The ordinary three-dimensional cross product, transported into Mathlib's
Euclidean `L²` space.
-/
noncomputable def euclideanCrossProduct
    (v w : EuclideanVector3) :
    EuclideanVector3 :=
  WithLp.toLp 2 ((crossProduct v.ofLp) w.ofLp)

/--
The geometric cross-product bound in three-dimensional Euclidean space:
`‖v × w‖ ≤ ‖v‖ ‖w‖`.

The proof uses Mathlib's exact scalar quadruple-product identity and the
nonnegativity of the squared dot product.
-/
theorem euclideanCrossProduct_norm_le
    (v w : EuclideanVector3) :
    ‖euclideanCrossProduct v w‖ ≤
      ‖v‖ * ‖w‖ := by
  have hDotSelf
      (x : EuclideanVector3) :
      dotProduct x.ofLp x.ofLp =
        ‖x‖ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq x]
    rw [PiLp.inner_apply]
    change
      (∑ i, x.ofLp i * x.ofLp i) =
        (∑ i, x.ofLp i * x.ofLp i)
    rfl

  have hCrossSelf :
      dotProduct
          ((crossProduct v.ofLp) w.ofLp)
          ((crossProduct v.ofLp) w.ofLp) =
        ‖euclideanCrossProduct v w‖ ^ 2 := by
    rw [
      ← real_inner_self_eq_norm_sq
        (euclideanCrossProduct v w)
    ]
    rw [PiLp.inner_apply]
    change
      (∑ i,
          ((crossProduct v.ofLp) w.ofLp) i *
            ((crossProduct v.ofLp) w.ofLp) i) =
        (∑ i,
          ((crossProduct v.ofLp) w.ofLp) i *
            ((crossProduct v.ofLp) w.ofLp) i)
    rfl

  have hCrossDot :
      dotProduct
          ((crossProduct v.ofLp) w.ofLp)
          ((crossProduct v.ofLp) w.ofLp) =
        dotProduct v.ofLp v.ofLp *
            dotProduct w.ofLp w.ofLp -
          dotProduct v.ofLp w.ofLp *
            dotProduct v.ofLp w.ofLp := by
    simpa [dotProduct, mul_comm] using
      (cross_dot_cross
        v.ofLp
        w.ofLp
        v.ofLp
        w.ofLp)

  have hSquared :
      ‖euclideanCrossProduct v w‖ ^ 2 ≤
        (‖v‖ * ‖w‖) ^ 2 := by
    calc
      ‖euclideanCrossProduct v w‖ ^ 2 =
          dotProduct
            ((crossProduct v.ofLp) w.ofLp)
            ((crossProduct v.ofLp) w.ofLp) :=
        hCrossSelf.symm
      _ =
          dotProduct v.ofLp v.ofLp *
              dotProduct w.ofLp w.ofLp -
            dotProduct v.ofLp w.ofLp *
              dotProduct v.ofLp w.ofLp :=
        hCrossDot
      _ ≤
          dotProduct v.ofLp v.ofLp *
            dotProduct w.ofLp w.ofLp := by
        nlinarith [
          sq_nonneg
            (dotProduct v.ofLp w.ofLp)
        ]
      _ = ‖v‖ ^ 2 * ‖w‖ ^ 2 := by
        rw [hDotSelf v, hDotSelf w]
      _ = (‖v‖ * ‖w‖) ^ 2 := by
        ring

  have hRight :
      0 ≤ ‖v‖ * ‖w‖ :=
    mul_nonneg
      (norm_nonneg v)
      (norm_nonneg w)

  apply
    (mul_self_le_mul_self_iff
      (norm_nonneg (euclideanCrossProduct v w))
      hRight).2

  simpa [pow_two] using hSquared


/--
The classical vacuum Poynting vector
`S = (1 / μ₀) • (E × B)` in three-dimensional Euclidean space.
-/
noncomputable def vacuumPoyntingVector
    (μ₀ : ℝ)
    (E B : EuclideanVector3) :
    EuclideanVector3 :=
  (1 / μ₀) • euclideanCrossProduct E B

/--
The classical vacuum electromagnetic energy density
`u = (ε₀ / 2) ‖E‖² + (1 / (2 μ₀)) ‖B‖²`.
-/
noncomputable def vacuumElectromagneticEnergyDensity
    (ε₀ μ₀ : ℝ)
    (E B : EuclideanVector3) :
    ℝ :=
  (ε₀ / 2) * ‖E‖ ^ 2 +
    (1 / (2 * μ₀)) * ‖B‖ ^ 2

/--
The classical pointwise vacuum electromagnetic energy-flux bound:

`‖S‖ ≤ c u`.

The proof combines the exact three-dimensional cross-product norm bound,
the scale-weighted algebraic inequality, and the vacuum-constant relation
`ε₀ μ₀ c² = 1`.

This theorem is pointwise. It does not assert Maxwell evolution equations,
energy conservation, empirical evidence, or a new physical law.
-/
theorem vacuumPoyntingVector_norm_le_speed_mul_energyDensity
    (E B : EuclideanVector3)
    (ε₀ μ₀ c : ℝ)
    (hμ₀ : 0 < μ₀)
    (hc : 0 < c)
    (hVacuumConstants :
      ε₀ * μ₀ * c ^ 2 = 1) :
    ‖vacuumPoyntingVector μ₀ E B‖ ≤
      c *
        vacuumElectromagneticEnergyDensity
          ε₀ μ₀ E B := by
  have hμ₀ne :
      μ₀ ≠ 0 :=
    ne_of_gt hμ₀

  have hcne :
      c ≠ 0 :=
    ne_of_gt hc

  have hDenominator :
      μ₀ * c ^ 2 ≠ 0 :=
    mul_ne_zero
      hμ₀ne
      (pow_ne_zero 2 hcne)

  have hε₀ :
      ε₀ = 1 / (μ₀ * c ^ 2) := by
    apply (eq_div_iff hDenominator).2
    simpa [mul_assoc] using hVacuumConstants

  have hInverseMuPositive :
      0 < 1 / μ₀ :=
    one_div_pos.mpr hμ₀

  have hInverseMuNonnegative :
      0 ≤ 1 / μ₀ :=
    le_of_lt hInverseMuPositive

  have hGeometric :
      ‖euclideanCrossProduct E B‖ ≤
        ‖E‖ * ‖B‖ :=
    euclideanCrossProduct_norm_le E B

  have hAlgebraic :
      ‖E‖ * ‖B‖ ≤
        (1 / (2 * c)) * ‖E‖ ^ 2 +
          (c / 2) * ‖B‖ ^ 2 :=
    poynting_algebraic_bound
      ‖E‖
      ‖B‖
      c
      hc

  calc
    ‖vacuumPoyntingVector μ₀ E B‖ =
        (1 / μ₀) *
          ‖euclideanCrossProduct E B‖ := by
      rw [vacuumPoyntingVector, norm_smul]
      change
        |1 / μ₀| *
            ‖euclideanCrossProduct E B‖ =
          (1 / μ₀) *
            ‖euclideanCrossProduct E B‖
      rw [abs_of_pos hInverseMuPositive]
    _ ≤
        (1 / μ₀) * (‖E‖ * ‖B‖) := by
      exact
        mul_le_mul_of_nonneg_left
          hGeometric
          hInverseMuNonnegative
    _ ≤
        (1 / μ₀) *
          ((1 / (2 * c)) * ‖E‖ ^ 2 +
            (c / 2) * ‖B‖ ^ 2) := by
      exact
        mul_le_mul_of_nonneg_left
          hAlgebraic
          hInverseMuNonnegative
    _ =
        c *
          vacuumElectromagneticEnergyDensity
            ε₀ μ₀ E B := by
      rw [
        vacuumElectromagneticEnergyDensity,
        hε₀
      ]
      field_simp [hμ₀ne, hcne]

/--
Algebraic kernel of the local Poynting identity.

The inputs represent the scalar contractions

* `eDotDtE = E · ∂ₜE`,
* `bDotDtB = B · ∂ₜB`,
* `eDotCurlB = E · curl B`,
* `bDotCurlE = B · curl E`,
* `jDotE = J · E`,
* `divCross = div (E × B)`.

`hFaraday`, `hAmpere`, and `hDivCross` are exactly the contracted
Maxwell equations and the divergence-of-cross-product identity.
-/
theorem localPoyntingIdentity_algebraicKernel
    (ε₀ μ₀
      eDotDtE bDotDtB
      eDotCurlB bDotCurlE
      jDotE divCross : ℝ)
    (hFaraday :
      bDotDtB = -bDotCurlE)
    (hAmpere :
      ε₀ * eDotDtE =
        (1 / μ₀) * eDotCurlB - jDotE)
    (hDivCross :
      divCross =
        bDotCurlE - eDotCurlB) :
    ε₀ * eDotDtE +
        (1 / μ₀) * bDotDtB +
        (1 / μ₀) * divCross =
      -jDotE := by
  rw [hFaraday, hDivCross]
  linarith

/--
Composition of the time fundamental theorem, the spatial divergence
theorem, and the space-time integral of the local Poynting identity.

The quantities represent

* `U₁ - U₀`: change of stored electromagnetic energy,
* `timeEnergyDerivative`: time integral of the spatial energy derivative,
* `volumeDivergence`: space-time integral of `div S`,
* `boundaryFlux`: time-integrated outward boundary flux,
* `work`: space-time integral of `J · E`.
-/
theorem integratedSpacetimeEnergyBalance_from_FTC_and_divergence
    (U₀ U₁
      timeEnergyDerivative
      volumeDivergence
      boundaryFlux
      work : ℝ)
    (hFTC :
      U₁ - U₀ =
        timeEnergyDerivative)
    (hDivergence :
      volumeDivergence =
        boundaryFlux)
    (hIntegratedLocal :
      timeEnergyDerivative +
          volumeDivergence =
        -work) :
    U₁ - U₀ + boundaryFlux =
      -work := by
  linarith

/--
Algebraic equality criterion for the three-dimensional cross-product
bound.

Under the substitution

* `x = ‖E‖`,
* `y = c ‖B‖`,
* `r = c ‖E × B‖`,
* `d = c |E · B|`,

`hLagrange` is the scaled Lagrange identity.
-/
theorem crossMagnitudeEquality_iff_dotZero_algebraic
    (x y r d : ℝ)
    (hx : 0 ≤ x)
    (hy : 0 ≤ y)
    (hr : 0 ≤ r)
    (hLagrange :
      r ^ 2 + d ^ 2 =
        x ^ 2 * y ^ 2) :
    r = x * y ↔ d = 0 := by
  constructor
  · intro hrxy
    have hd2 : d ^ 2 = 0 := by
      rw [hrxy] at hLagrange
      nlinarith
    have hdmul : d * d = 0 := by
      simpa [pow_two] using hd2
    rcases mul_eq_zero.mp hdmul with hd0 | hd0
    · exact hd0
    · exact hd0
  · intro hd0
    have hxy_nonneg :
        0 ≤ x * y :=
      mul_nonneg hx hy
    have hsquares :
        r ^ 2 = (x * y) ^ 2 := by
      calc
        r ^ 2 = x ^ 2 * y ^ 2 := by
          rw [hd0] at hLagrange
          nlinarith
        _ = (x * y) ^ 2 := by
          ring
    rcases
        (sq_eq_sq_iff_eq_or_eq_neg.mp hsquares)
      with h | h
    · exact h
    · nlinarith

/--
Both directions of the null electromagnetic equality characterization.

With

* `x = ‖E‖`,
* `y = c ‖B‖`,
* `r = c ‖E × B‖`,
* `d = c |E · B|`,

the equation `2 * r = x² + y²` is the normalized form of
`‖S‖ = c * u`.

The conclusion `d = 0 ∧ x = y` is exactly

`E · B = 0 ∧ ‖E‖ = c ‖B‖`.
-/
theorem nullElectromagneticEquality_algebraic_iff
    (x y r d : ℝ)
    (hx : 0 ≤ x)
    (hy : 0 ≤ y)
    (hr : 0 ≤ r)
    (hCrossBound :
      r ≤ x * y)
    (hLagrange :
      r ^ 2 + d ^ 2 =
        x ^ 2 * y ^ 2) :
    2 * r = x ^ 2 + y ^ 2 ↔
      d = 0 ∧ x = y := by
  have hCrossEquality :
      r = x * y ↔ d = 0 :=
    crossMagnitudeEquality_iff_dotZero_algebraic
      x y r d hx hy hr hLagrange
  constructor
  · intro hEndpoint
    have hAMGM :
        2 * x * y ≤ x ^ 2 + y ^ 2 := by
      nlinarith [sq_nonneg (x - y)]
    have hrxy :
        r = x * y := by
      nlinarith
    have hxy :
        x = y := by
      nlinarith [sq_nonneg (x - y)]
    exact
      ⟨hCrossEquality.mp hrxy, hxy⟩
  · rintro ⟨hd0, hxy⟩
    have hrxy :
        r = x * y :=
      hCrossEquality.mpr hd0
    rw [hrxy, hxy]
    ring

/-
BOUNDARY := ¬ uncontracted_Maxwell_evolution_equations_formalized
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/-!
## Field-level Maxwell differential operators on `ℝ × ℝ³`

The spatial carrier is represented directly as `Fin 3 → ℝ`. This avoids
the `WithLp` wrapper used by `EuclideanVector3` while retaining the exact
three-dimensional coordinate type required by `crossProduct`.
-/

/-- Coordinate representation of a vector in three-dimensional space. -/
abbrev MaxwellVector3 :=
  Fin 3 → ℝ

/-- A space-time point consisting of time and three spatial coordinates. -/
abbrev MaxwellSpacetime3 :=
  ℝ × MaxwellVector3

/-- A scalar field on space-time. -/
abbrev MaxwellScalarField3 :=
  MaxwellSpacetime3 → ℝ

/-- A three-vector field on space-time. -/
abbrev MaxwellVectorField3 :=
  MaxwellSpacetime3 → MaxwellVector3

/-- Unit direction in the time coordinate. -/
def maxwellTimeDirection3 :
    MaxwellSpacetime3 :=
  (1, 0)

/-- Unit direction in spatial coordinate `i`. -/
def maxwellSpatialDirection3
    (i : Fin 3) :
    MaxwellSpacetime3 :=
  (
    0,
    fun j =>
      if j = i then 1 else 0
  )

/-- Fréchet derivative in the time direction. -/
noncomputable def maxwellTimeDerivative3
    {Y : Type*}
    [NormedAddCommGroup Y]
    [NormedSpace ℝ Y]
    (f : MaxwellSpacetime3 → Y)
    (p : MaxwellSpacetime3) :
    Y :=
  (fderiv ℝ f p) maxwellTimeDirection3

/-- Fréchet derivative in spatial coordinate `i`. -/
noncomputable def maxwellSpatialDerivative3
    {Y : Type*}
    [NormedAddCommGroup Y]
    [NormedSpace ℝ Y]
    (f : MaxwellSpacetime3 → Y)
    (i : Fin 3)
    (p : MaxwellSpacetime3) :
    Y :=
  (fderiv ℝ f p)
    (maxwellSpatialDirection3 i)

/-- Euclidean coordinate dot product on `Fin 3 → ℝ`. -/
def maxwellDot3
    (u v : MaxwellVector3) :
    ℝ :=
  ∑ i : Fin 3, u i * v i

/-- Three-dimensional coordinate cross product. -/
def maxwellCross3
    (u v : MaxwellVector3) :
    MaxwellVector3 :=
  crossProduct u v

/-- Spatial divergence of a space-time vector field. -/
noncomputable def maxwellDivergence3
    (F : MaxwellVectorField3)
    (p : MaxwellSpacetime3) :
    ℝ :=
  ∑ i : Fin 3,
    maxwellSpatialDerivative3
      (fun q => F q i)
      i
      p

/-- Spatial curl of a space-time vector field. -/
noncomputable def maxwellCurl3
    (F : MaxwellVectorField3)
    (p : MaxwellSpacetime3) :
    MaxwellVector3 :=
  fun i =>
    if i = (0 : Fin 3) then
      maxwellSpatialDerivative3
          (fun q => F q (2 : Fin 3))
          (1 : Fin 3)
          p -
        maxwellSpatialDerivative3
          (fun q => F q (1 : Fin 3))
          (2 : Fin 3)
          p
    else if i = (1 : Fin 3) then
      maxwellSpatialDerivative3
          (fun q => F q (0 : Fin 3))
          (2 : Fin 3)
          p -
        maxwellSpatialDerivative3
          (fun q => F q (2 : Fin 3))
          (0 : Fin 3)
          p
    else
      maxwellSpatialDerivative3
          (fun q => F q (1 : Fin 3))
          (0 : Fin 3)
          p -
        maxwellSpatialDerivative3
          (fun q => F q (0 : Fin 3))
          (1 : Fin 3)
          p

/-- Continuously differentiable electric, magnetic, and current fields. -/
structure SmoothMaxwellField3 where
  electric : MaxwellVectorField3
  magnetic : MaxwellVectorField3
  current : MaxwellVectorField3
  electric_contDiff :
    ContDiff ℝ 1 electric
  magnetic_contDiff :
    ContDiff ℝ 1 magnetic
  current_contDiff :
    ContDiff ℝ 1 current

/--
Field-level contracted Maxwell hypotheses at one space-time point.

The divergence-of-cross-product identity is not stored as a hypothesis.
It is derived from the six component differentiability hypotheses.
-/
structure ContractedMaxwellPoyntingAt3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3) :
    Prop where
  faraday_contracted :
    maxwellDot3
        (F.magnetic p)
        (maxwellTimeDerivative3 F.magnetic p) =
      -maxwellDot3
        (F.magnetic p)
        (maxwellCurl3 F.electric p)
  ampereMaxwell_contracted :
    ε₀ *
        maxwellDot3
          (F.electric p)
          (maxwellTimeDerivative3 F.electric p) =
      (1 / μ₀) *
          maxwellDot3
            (F.electric p)
            (maxwellCurl3 F.magnetic p) -
        maxwellDot3
          (F.current p)
          (F.electric p)
  electric_component_zero_differentiable :
    DifferentiableAt ℝ
      (fun q => F.electric q (0 : Fin 3))
      p
  electric_component_one_differentiable :
    DifferentiableAt ℝ
      (fun q => F.electric q (1 : Fin 3))
      p
  electric_component_two_differentiable :
    DifferentiableAt ℝ
      (fun q => F.electric q (2 : Fin 3))
      p
  magnetic_component_zero_differentiable :
    DifferentiableAt ℝ
      (fun q => F.magnetic q (0 : Fin 3))
      p
  magnetic_component_one_differentiable :
    DifferentiableAt ℝ
      (fun q => F.magnetic q (1 : Fin 3))
      p
  magnetic_component_two_differentiable :
    DifferentiableAt ℝ
      (fun q => F.magnetic q (2 : Fin 3))
      p


/-
BOUNDARY := ¬ uncontracted_Maxwell_evolution_equations_formalized
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Fréchet product rule evaluated in one spatial coordinate direction.
-/
theorem maxwellSpatialDerivative3_mul
    (f g : MaxwellScalarField3)
    (i : Fin 3)
    (p : MaxwellSpacetime3)
    (hf : DifferentiableAt ℝ f p)
    (hg : DifferentiableAt ℝ g p) :
    maxwellSpatialDerivative3
        (fun q => f q * g q)
        i
        p =
      f p * maxwellSpatialDerivative3 g i p +
        g p * maxwellSpatialDerivative3 f i p := by
  have h :=
    congrArg
      (fun L : MaxwellSpacetime3 →L[ℝ] ℝ =>
        L (maxwellSpatialDirection3 i))
      (fderiv_fun_mul hf hg)
  simpa [
    maxwellSpatialDerivative3,
    smul_eq_mul
  ] using h

/-
PROVED := spatial_Frechet_product_rule
PROVED := spatial_Frechet_subtraction_rule
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ uncontracted_Maxwell_evolution_equations_formalized
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Fréchet subtraction rule evaluated in one spatial coordinate direction.
-/
theorem maxwellSpatialDerivative3_sub
    (f g : MaxwellScalarField3)
    (i : Fin 3)
    (p : MaxwellSpacetime3)
    (hf : DifferentiableAt ℝ f p)
    (hg : DifferentiableAt ℝ g p) :
    maxwellSpatialDerivative3
        (fun q => f q - g q)
        i
        p =
      maxwellSpatialDerivative3 f i p -
        maxwellSpatialDerivative3 g i p := by
  have hfg :
      HasFDerivAt
        (fun q => f q - g q)
        (fderiv ℝ f p - fderiv ℝ g p)
        p :=
    hf.hasFDerivAt.sub hg.hasFDerivAt
  have h :=
    congrArg
      (fun L : MaxwellSpacetime3 →L[ℝ] ℝ =>
        L (maxwellSpatialDirection3 i))
      hfg.fderiv
  simpa [
    maxwellSpatialDerivative3
  ] using h

/-
PROVED := spatial_Frechet_product_rule
PROVED := spatial_Frechet_subtraction_rule
PROVED := coordinate_cross_product_expansion
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ uncontracted_Maxwell_evolution_equations_formalized
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
The three coordinate formulas for the Mathlib cross product on
`Fin 3 → ℝ`.
-/
theorem maxwellCross3_coordinate_expansion
    (u v : MaxwellVector3) :
    maxwellCross3 u v (0 : Fin 3) =
        u 1 * v 2 - u 2 * v 1 ∧
      maxwellCross3 u v (1 : Fin 3) =
        u 2 * v 0 - u 0 * v 2 ∧
      maxwellCross3 u v (2 : Fin 3) =
        u 0 * v 1 - u 1 * v 0 := by
  simp [maxwellCross3, cross_apply]

/-
PROVED := coordinate_cross_product_expansion
BOUNDARY := ¬ differentiated_cross_product_coordinates_one_and_two_proved
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Spatial derivative of the zeroth cross-product coordinate:

`∂₀(E × B)₀ =
  E₁ ∂₀B₂ + B₂ ∂₀E₁ -
  (E₂ ∂₀B₁ + B₁ ∂₀E₂)`.
-/
theorem maxwellSpatialDerivative3_cross_coordinate_zero
    (E B : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hE1 :
      DifferentiableAt ℝ
        (fun q => E q (1 : Fin 3))
        p)
    (hE2 :
      DifferentiableAt ℝ
        (fun q => E q (2 : Fin 3))
        p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => B q (1 : Fin 3))
        p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => B q (2 : Fin 3))
        p) :
    maxwellSpatialDerivative3
        (fun q =>
          maxwellCross3
            (E q)
            (B q)
            (0 : Fin 3))
        (0 : Fin 3)
        p =
      (
        E p (1 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (2 : Fin 3))
              (0 : Fin 3)
              p +
          B p (2 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (1 : Fin 3))
              (0 : Fin 3)
              p
      ) -
      (
        E p (2 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (1 : Fin 3))
              (0 : Fin 3)
              p +
          B p (1 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (2 : Fin 3))
              (0 : Fin 3)
              p
      ) := by
  have hCoordinate :
      (fun q =>
        maxwellCross3
          (E q)
          (B q)
          (0 : Fin 3)) =
      (fun q =>
        E q (1 : Fin 3) * B q (2 : Fin 3) -
          E q (2 : Fin 3) * B q (1 : Fin 3)) := by
    funext q
    exact
      (maxwellCross3_coordinate_expansion
        (E q)
        (B q)).1

  rw [hCoordinate]

  rw [
    maxwellSpatialDerivative3_sub
      (fun q =>
        E q (1 : Fin 3) * B q (2 : Fin 3))
      (fun q =>
        E q (2 : Fin 3) * B q (1 : Fin 3))
      (0 : Fin 3)
      p
      (hE1.mul hB2)
      (hE2.mul hB1)
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (1 : Fin 3))
      (fun q => B q (2 : Fin 3))
      (0 : Fin 3)
      p
      hE1
      hB2
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (2 : Fin 3))
      (fun q => B q (1 : Fin 3))
      (0 : Fin 3)
      p
      hE2
      hB1
  ]

/-
PROVED := differentiated_cross_product_coordinate_zero
BOUNDARY := ¬ differentiated_cross_product_coordinate_two_proved
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Spatial derivative of the first cross-product coordinate:

`∂₁(E × B)₁ =
  E₂ ∂₁B₀ + B₀ ∂₁E₂ -
  (E₀ ∂₁B₂ + B₂ ∂₁E₀)`.
-/
theorem maxwellSpatialDerivative3_cross_coordinate_one
    (E B : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hE0 :
      DifferentiableAt ℝ
        (fun q => E q (0 : Fin 3))
        p)
    (hE2 :
      DifferentiableAt ℝ
        (fun q => E q (2 : Fin 3))
        p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => B q (0 : Fin 3))
        p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => B q (2 : Fin 3))
        p) :
    maxwellSpatialDerivative3
        (fun q =>
          maxwellCross3
            (E q)
            (B q)
            (1 : Fin 3))
        (1 : Fin 3)
        p =
      (
        E p (2 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (0 : Fin 3))
              (1 : Fin 3)
              p +
          B p (0 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (2 : Fin 3))
              (1 : Fin 3)
              p
      ) -
      (
        E p (0 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (2 : Fin 3))
              (1 : Fin 3)
              p +
          B p (2 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (0 : Fin 3))
              (1 : Fin 3)
              p
      ) := by
  have hCoordinate :
      (fun q =>
        maxwellCross3
          (E q)
          (B q)
          (1 : Fin 3)) =
      (fun q =>
        E q (2 : Fin 3) * B q (0 : Fin 3) -
          E q (0 : Fin 3) * B q (2 : Fin 3)) := by
    funext q
    exact
      (maxwellCross3_coordinate_expansion
        (E q)
        (B q)).2.1

  rw [hCoordinate]

  rw [
    maxwellSpatialDerivative3_sub
      (fun q =>
        E q (2 : Fin 3) * B q (0 : Fin 3))
      (fun q =>
        E q (0 : Fin 3) * B q (2 : Fin 3))
      (1 : Fin 3)
      p
      (hE2.mul hB0)
      (hE0.mul hB2)
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (2 : Fin 3))
      (fun q => B q (0 : Fin 3))
      (1 : Fin 3)
      p
      hE2
      hB0
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (0 : Fin 3))
      (fun q => B q (2 : Fin 3))
      (1 : Fin 3)
      p
      hE0
      hB2
  ]

/-
PROVED := differentiated_cross_product_coordinate_zero
PROVED := differentiated_cross_product_coordinate_one
PROVED := differentiated_cross_product_coordinate_two
BOUNDARY := ¬ divergence_cross_product_identity_from_fderiv_proved
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Spatial derivative of the second cross-product coordinate:

`∂₂(E × B)₂ =
  E₀ ∂₂B₁ + B₁ ∂₂E₀ -
  (E₁ ∂₂B₀ + B₀ ∂₂E₁)`.
-/
theorem maxwellSpatialDerivative3_cross_coordinate_two
    (E B : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hE0 :
      DifferentiableAt ℝ
        (fun q => E q (0 : Fin 3))
        p)
    (hE1 :
      DifferentiableAt ℝ
        (fun q => E q (1 : Fin 3))
        p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => B q (0 : Fin 3))
        p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => B q (1 : Fin 3))
        p) :
    maxwellSpatialDerivative3
        (fun q =>
          maxwellCross3
            (E q)
            (B q)
            (2 : Fin 3))
        (2 : Fin 3)
        p =
      (
        E p (0 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (1 : Fin 3))
              (2 : Fin 3)
              p +
          B p (1 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (0 : Fin 3))
              (2 : Fin 3)
              p
      ) -
      (
        E p (1 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => B q (0 : Fin 3))
              (2 : Fin 3)
              p +
          B p (0 : Fin 3) *
            maxwellSpatialDerivative3
              (fun q => E q (1 : Fin 3))
              (2 : Fin 3)
              p
      ) := by
  have hCoordinate :
      (fun q =>
        maxwellCross3
          (E q)
          (B q)
          (2 : Fin 3)) =
      (fun q =>
        E q (0 : Fin 3) * B q (1 : Fin 3) -
          E q (1 : Fin 3) * B q (0 : Fin 3)) := by
    funext q
    exact
      (maxwellCross3_coordinate_expansion
        (E q)
        (B q)).2.2

  rw [hCoordinate]

  rw [
    maxwellSpatialDerivative3_sub
      (fun q =>
        E q (0 : Fin 3) * B q (1 : Fin 3))
      (fun q =>
        E q (1 : Fin 3) * B q (0 : Fin 3))
      (2 : Fin 3)
      p
      (hE0.mul hB1)
      (hE1.mul hB0)
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (0 : Fin 3))
      (fun q => B q (1 : Fin 3))
      (2 : Fin 3)
      p
      hE0
      hB1
  ]

  rw [
    maxwellSpatialDerivative3_mul
      (fun q => E q (1 : Fin 3))
      (fun q => B q (0 : Fin 3))
      (2 : Fin 3)
      p
      hE1
      hB0
  ]

/-
PROVED := differentiated_cross_product_coordinate_zero
PROVED := differentiated_cross_product_coordinate_one
PROVED := differentiated_cross_product_coordinate_two
PROVED := divergence_cross_product_identity_from_fderiv
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Field-level divergence-of-cross-product identity:

`div (E × B) = B · curl E - E · curl B`.
-/
theorem maxwellDivergence3_cross_eq_dot_curl_sub_dot_curl
    (E B : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hE0 :
      DifferentiableAt ℝ
        (fun q => E q (0 : Fin 3)) p)
    (hE1 :
      DifferentiableAt ℝ
        (fun q => E q (1 : Fin 3)) p)
    (hE2 :
      DifferentiableAt ℝ
        (fun q => E q (2 : Fin 3)) p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => B q (0 : Fin 3)) p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => B q (1 : Fin 3)) p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => B q (2 : Fin 3)) p) :
    maxwellDivergence3
        (fun q => maxwellCross3 (E q) (B q))
        p =
      maxwellDot3 (B p) (maxwellCurl3 E p) -
        maxwellDot3 (E p) (maxwellCurl3 B p) := by
  have h0 :=
    maxwellSpatialDerivative3_cross_coordinate_zero
      E B p hE1 hE2 hB1 hB2

  have h1 :=
    maxwellSpatialDerivative3_cross_coordinate_one
      E B p hE0 hE2 hB0 hB2

  have h2 :=
    maxwellSpatialDerivative3_cross_coordinate_two
      E B p hE0 hE1 hB0 hB1

  unfold maxwellDivergence3

  simp [Fin.sum_univ_succ]

  rw [h0, h1, h2]

  simp [
    maxwellDot3,
    maxwellCurl3,
    Fin.sum_univ_succ
  ]

  ring

/-
PROVED := divergence_cross_product_identity_from_fderiv
PROVED := contracted_Maxwell_structure_uses_derived_divergence_identity
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
The local field-level Poynting identity with the cross-product divergence
derived from the six component differentiability hypotheses.
-/
theorem localPoyntingIdentity_fieldLevel3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
    (h :
      ContractedMaxwellPoyntingAt3
        ε₀ μ₀ F p) :
    ε₀ *
          maxwellDot3
            (F.electric p)
            (maxwellTimeDerivative3 F.electric p) +
        (1 / μ₀) *
          maxwellDot3
            (F.magnetic p)
            (maxwellTimeDerivative3 F.magnetic p) +
        (1 / μ₀) *
          maxwellDivergence3
            (fun q =>
              maxwellCross3
                (F.electric q)
                (F.magnetic q))
            p =
      -maxwellDot3
        (F.current p)
        (F.electric p) := by
  have hDivergenceCross :
      maxwellDivergence3
          (fun q =>
            maxwellCross3
              (F.electric q)
              (F.magnetic q))
          p =
        maxwellDot3
            (F.magnetic p)
            (maxwellCurl3 F.electric p) -
          maxwellDot3
            (F.electric p)
            (maxwellCurl3 F.magnetic p) :=
    maxwellDivergence3_cross_eq_dot_curl_sub_dot_curl
      F.electric
      F.magnetic
      p
      h.electric_component_zero_differentiable
      h.electric_component_one_differentiable
      h.electric_component_two_differentiable
      h.magnetic_component_zero_differentiable
      h.magnetic_component_one_differentiable
      h.magnetic_component_two_differentiable

  exact
    localPoyntingIdentity_algebraicKernel
      ε₀
      μ₀
      (maxwellDot3
        (F.electric p)
        (maxwellTimeDerivative3 F.electric p))
      (maxwellDot3
        (F.magnetic p)
        (maxwellTimeDerivative3 F.magnetic p))
      (maxwellDot3
        (F.electric p)
        (maxwellCurl3 F.magnetic p))
      (maxwellDot3
        (F.magnetic p)
        (maxwellCurl3 F.electric p))
      (maxwellDot3
        (F.current p)
        (F.electric p))
      (maxwellDivergence3
        (fun q =>
          maxwellCross3
            (F.electric q)
            (F.magnetic q))
        p)
      h.faraday_contracted
      h.ampereMaxwell_contracted
      hDivergenceCross

/-
PROVED := contracted_Maxwell_structure_uses_derived_divergence_identity
PROVED := local_Poynting_identity_uses_six_component_differentiability_hypotheses
PROVED := uncontracted_Maxwell_evolution_equations_formalized
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Uncontracted Faraday and Ampère–Maxwell evolution equations at one
space-time point.

The Ampère–Maxwell equation is written in the componentwise scaled form

`ε₀ ∂ₜE = (1 / μ₀) curl B - J`,

which is algebraically equivalent to the usual SI equation whenever
`ε₀ ≠ 0`.
-/
structure UncontractedMaxwellEvolutionAt3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3) :
    Prop where
  faraday :
    maxwellTimeDerivative3 F.magnetic p =
      fun i =>
        -maxwellCurl3 F.electric p i
  ampereMaxwell :
    (fun i =>
      ε₀ *
        maxwellTimeDerivative3
          F.electric
          p
          i) =
      (fun i =>
        (1 / μ₀) *
            maxwellCurl3
              F.magnetic
              p
              i -
          F.current p i)

/--
The contracted Faraday scalar equation follows from the uncontracted
vector equation by taking the dot product with `B`.
-/
theorem faradayContracted_of_uncontracted
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
    (h :
      UncontractedMaxwellEvolutionAt3
        ε₀ μ₀ F p) :
    maxwellDot3
        (F.magnetic p)
        (maxwellTimeDerivative3 F.magnetic p) =
      -maxwellDot3
        (F.magnetic p)
        (maxwellCurl3 F.electric p) := by
  have hDot :=
    congrArg
      (fun v : MaxwellVector3 =>
        maxwellDot3
          (F.magnetic p)
          v)
      h.faraday
  simpa [
    maxwellDot3,
    Fin.sum_univ_succ
  ] using hDot

/--
The contracted Ampère–Maxwell scalar equation follows from the
uncontracted vector equation by taking the dot product with `E`.
-/
theorem ampereMaxwellContracted_of_uncontracted
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
    (h :
      UncontractedMaxwellEvolutionAt3
        ε₀ μ₀ F p) :
    ε₀ *
        maxwellDot3
          (F.electric p)
          (maxwellTimeDerivative3 F.electric p) =
      (1 / μ₀) *
          maxwellDot3
            (F.electric p)
            (maxwellCurl3 F.magnetic p) -
        maxwellDot3
          (F.current p)
          (F.electric p) := by
  have hDot :=
    congrArg
      (fun v : MaxwellVector3 =>
        maxwellDot3
          (F.electric p)
          v)
      h.ampereMaxwell
  simp [
    maxwellDot3,
    Fin.sum_univ_succ
  ] at hDot ⊢
  ring_nf at hDot ⊢
  exact hDot

/--
Construction of the contracted local Poynting hypotheses from the
uncontracted Maxwell equations and the six component differentiability
hypotheses.
-/
theorem contractedMaxwellPoyntingAt3_of_uncontracted
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
    (hEvolution :
      UncontractedMaxwellEvolutionAt3
        ε₀ μ₀ F p)
    (hE0 :
      DifferentiableAt ℝ
        (fun q => F.electric q (0 : Fin 3))
        p)
    (hE1 :
      DifferentiableAt ℝ
        (fun q => F.electric q (1 : Fin 3))
        p)
    (hE2 :
      DifferentiableAt ℝ
        (fun q => F.electric q (2 : Fin 3))
        p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (0 : Fin 3))
        p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (1 : Fin 3))
        p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (2 : Fin 3))
        p) :
    ContractedMaxwellPoyntingAt3
      ε₀ μ₀ F p := by
  refine
    {
      faraday_contracted :=
        faradayContracted_of_uncontracted
          ε₀ μ₀ F p hEvolution
      ampereMaxwell_contracted :=
        ampereMaxwellContracted_of_uncontracted
          ε₀ μ₀ F p hEvolution
      electric_component_zero_differentiable := hE0
      electric_component_one_differentiable := hE1
      electric_component_two_differentiable := hE2
      magnetic_component_zero_differentiable := hB0
      magnetic_component_one_differentiable := hB1
      magnetic_component_two_differentiable := hB2
    }

/--
The local field-level Poynting identity derived from the uncontracted
Faraday and Ampère–Maxwell equations.
-/
theorem localPoyntingIdentity_fieldLevel3_of_uncontracted
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
    (hEvolution :
      UncontractedMaxwellEvolutionAt3
        ε₀ μ₀ F p)
    (hE0 :
      DifferentiableAt ℝ
        (fun q => F.electric q (0 : Fin 3))
        p)
    (hE1 :
      DifferentiableAt ℝ
        (fun q => F.electric q (1 : Fin 3))
        p)
    (hE2 :
      DifferentiableAt ℝ
        (fun q => F.electric q (2 : Fin 3))
        p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (0 : Fin 3))
        p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (1 : Fin 3))
        p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => F.magnetic q (2 : Fin 3))
        p) :
    ε₀ *
          maxwellDot3
            (F.electric p)
            (maxwellTimeDerivative3 F.electric p) +
        (1 / μ₀) *
          maxwellDot3
            (F.magnetic p)
            (maxwellTimeDerivative3 F.magnetic p) +
        (1 / μ₀) *
          maxwellDivergence3
            (fun q =>
              maxwellCross3
                (F.electric q)
                (F.magnetic q))
            p =
      -maxwellDot3
        (F.current p)
        (F.electric p) := by
  exact
    localPoyntingIdentity_fieldLevel3
      ε₀
      μ₀
      F
      p
      (
        contractedMaxwellPoyntingAt3_of_uncontracted
          ε₀
          μ₀
          F
          p
          hEvolution
          hE0
          hE1
          hE2
          hB0
          hB1
          hB2
      )

/-
PROVED := uncontracted_Maxwell_evolution_equations_formalized
PROVED := contracted_Faraday_derived_from_uncontracted_equation
PROVED := contracted_Ampere_Maxwell_derived_from_uncontracted_equation
PROVED := local_Poynting_identity_derived_from_uncontracted_Maxwell_equations
BOUNDARY := ¬ energy_density_time_derivative_from_fderiv_proved
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/

end Chronos.Frontier
