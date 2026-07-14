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


/--
The time derivative of one component of a differentiable Pi-valued
field is the corresponding component of its vector-valued derivative.
-/
theorem maxwellTimeDerivative3_apply
    (V : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hV : DifferentiableAt ℝ V p)
    (i : Fin 3) :
    maxwellTimeDerivative3
        (fun q => V q i)
        p =
      maxwellTimeDerivative3 V p i := by
  have hi :=
    (hasFDerivAt_pi'.mp hV.hasFDerivAt) i
  have h :=
    congrArg
      (fun L : MaxwellSpacetime3 →L[ℝ] ℝ =>
        L maxwellTimeDirection3)
      hi.fderiv
  simpa [maxwellTimeDerivative3] using h

/-
PROVED := time_derivative_of_vector_component
PROVED := energy_density_time_derivative_from_fderiv
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Fréchet addition rule evaluated in the time direction.
-/
theorem maxwellTimeDerivative3_add
    (f g : MaxwellScalarField3)
    (p : MaxwellSpacetime3)
    (hf : DifferentiableAt ℝ f p)
    (hg : DifferentiableAt ℝ g p) :
    maxwellTimeDerivative3
        (fun q => f q + g q)
        p =
      maxwellTimeDerivative3 f p +
        maxwellTimeDerivative3 g p := by
  have hfg :
      HasFDerivAt
        (fun q => f q + g q)
        (fderiv ℝ f p + fderiv ℝ g p)
        p :=
    hf.hasFDerivAt.add hg.hasFDerivAt
  have h :=
    congrArg
      (fun L : MaxwellSpacetime3 →L[ℝ] ℝ =>
        L maxwellTimeDirection3)
      hfg.fderiv
  simpa [maxwellTimeDerivative3] using h

/--
Fréchet multiplication rule evaluated in the time direction.
-/
theorem maxwellTimeDerivative3_mul
    (f g : MaxwellScalarField3)
    (p : MaxwellSpacetime3)
    (hf : DifferentiableAt ℝ f p)
    (hg : DifferentiableAt ℝ g p) :
    maxwellTimeDerivative3
        (fun q => f q * g q)
        p =
      f p * maxwellTimeDerivative3 g p +
        g p * maxwellTimeDerivative3 f p := by
  have h :=
    congrArg
      (fun L : MaxwellSpacetime3 →L[ℝ] ℝ =>
        L maxwellTimeDirection3)
      (fderiv_fun_mul hf hg)
  simpa [
    maxwellTimeDerivative3,
    smul_eq_mul
  ] using h

/--
A constant scalar factor passes through the time derivative.
-/
theorem maxwellTimeDerivative3_const_mul
    (a : ℝ)
    (f : MaxwellScalarField3)
    (p : MaxwellSpacetime3)
    (hf : DifferentiableAt ℝ f p) :
    maxwellTimeDerivative3
        (fun q => a * f q)
        p =
      a * maxwellTimeDerivative3 f p := by
  have hconst :
      DifferentiableAt ℝ
        (fun _ : MaxwellSpacetime3 => a)
        p :=
    differentiableAt_const a
  have h :=
    maxwellTimeDerivative3_mul
      (fun _ : MaxwellSpacetime3 => a)
      f
      p
      hconst
      hf
  simpa [maxwellTimeDerivative3] using h

/--
Componentwise differentiability implies differentiability of the
three-vector field.
-/
theorem maxwellVectorField3_differentiableAt
    (V : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hV0 :
      DifferentiableAt ℝ
        (fun q => V q (0 : Fin 3))
        p)
    (hV1 :
      DifferentiableAt ℝ
        (fun q => V q (1 : Fin 3))
        p)
    (hV2 :
      DifferentiableAt ℝ
        (fun q => V q (2 : Fin 3))
        p) :
    DifferentiableAt ℝ V p := by
  rw [differentiableAt_pi]
  intro i
  fin_cases i
  · exact hV0
  · exact hV1
  · exact hV2

/--
The squared coordinate norm represented by `maxwellDot3 V V` is
differentiable when all three components are differentiable.
-/
theorem maxwellDot3_self_differentiableAt
    (V : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hV0 :
      DifferentiableAt ℝ
        (fun q => V q (0 : Fin 3))
        p)
    (hV1 :
      DifferentiableAt ℝ
        (fun q => V q (1 : Fin 3))
        p)
    (hV2 :
      DifferentiableAt ℝ
        (fun q => V q (2 : Fin 3))
        p) :
    DifferentiableAt ℝ
      (fun q =>
        maxwellDot3
          (V q)
          (V q))
      p := by
  have hCoordinate :
      (fun q =>
        maxwellDot3
          (V q)
          (V q)) =
      (fun q =>
        V q (0 : Fin 3) * V q (0 : Fin 3) +
          (
            V q (1 : Fin 3) * V q (1 : Fin 3) +
              V q (2 : Fin 3) * V q (2 : Fin 3)
          )) := by
    funext q
    simp [
      maxwellDot3,
      Fin.sum_univ_succ
    ]

  rw [hCoordinate]

  exact
    (hV0.mul hV0).add
      (
        (hV1.mul hV1).add
          (hV2.mul hV2)
      )

/--
Time derivative of the squared coordinate norm:

`∂ₜ(V · V) = 2 V · ∂ₜV`.
-/
theorem maxwellTimeDerivative3_dot_self
    (V : MaxwellVectorField3)
    (p : MaxwellSpacetime3)
    (hV0 :
      DifferentiableAt ℝ
        (fun q => V q (0 : Fin 3))
        p)
    (hV1 :
      DifferentiableAt ℝ
        (fun q => V q (1 : Fin 3))
        p)
    (hV2 :
      DifferentiableAt ℝ
        (fun q => V q (2 : Fin 3))
        p) :
    maxwellTimeDerivative3
        (fun q =>
          maxwellDot3
            (V q)
            (V q))
        p =
      2 *
        maxwellDot3
          (V p)
          (maxwellTimeDerivative3 V p) := by
  have hV :
      DifferentiableAt ℝ V p :=
    maxwellVectorField3_differentiableAt
      V p hV0 hV1 hV2

  have hCoordinate :
      (fun q =>
        maxwellDot3
          (V q)
          (V q)) =
      (fun q =>
        V q (0 : Fin 3) * V q (0 : Fin 3) +
          (
            V q (1 : Fin 3) * V q (1 : Fin 3) +
              V q (2 : Fin 3) * V q (2 : Fin 3)
          )) := by
    funext q
    simp [
      maxwellDot3,
      Fin.sum_univ_succ
    ]

  rw [hCoordinate]

  rw [
    maxwellTimeDerivative3_add
      (fun q =>
        V q (0 : Fin 3) * V q (0 : Fin 3))
      (fun q =>
        V q (1 : Fin 3) * V q (1 : Fin 3) +
          V q (2 : Fin 3) * V q (2 : Fin 3))
      p
      (hV0.mul hV0)
      ((hV1.mul hV1).add (hV2.mul hV2))
  ]

  rw [
    maxwellTimeDerivative3_add
      (fun q =>
        V q (1 : Fin 3) * V q (1 : Fin 3))
      (fun q =>
        V q (2 : Fin 3) * V q (2 : Fin 3))
      p
      (hV1.mul hV1)
      (hV2.mul hV2)
  ]

  rw [
    maxwellTimeDerivative3_mul
      (fun q => V q (0 : Fin 3))
      (fun q => V q (0 : Fin 3))
      p
      hV0
      hV0
  ]

  rw [
    maxwellTimeDerivative3_mul
      (fun q => V q (1 : Fin 3))
      (fun q => V q (1 : Fin 3))
      p
      hV1
      hV1
  ]

  rw [
    maxwellTimeDerivative3_mul
      (fun q => V q (2 : Fin 3))
      (fun q => V q (2 : Fin 3))
      p
      hV2
      hV2
  ]

  rw [
    maxwellTimeDerivative3_apply
      V p hV (0 : Fin 3),
    maxwellTimeDerivative3_apply
      V p hV (1 : Fin 3),
    maxwellTimeDerivative3_apply
      V p hV (2 : Fin 3)
  ]

  simp [
    maxwellDot3,
    Fin.sum_univ_succ
  ]

  ring

/--
Field-level electromagnetic energy density:

`u = (ε₀ / 2) (E · E) + (1 / (2 μ₀)) (B · B)`.
-/
noncomputable def maxwellEnergyDensity3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3) :
    MaxwellScalarField3 :=
  fun p =>
    (ε₀ / 2) *
        maxwellDot3
          (F.electric p)
          (F.electric p) +
      (1 / (2 * μ₀)) *
        maxwellDot3
          (F.magnetic p)
          (F.magnetic p)

/--
The Fréchet time derivative of electromagnetic energy density is the
sum of the electric and magnetic contraction terms.
-/
theorem maxwellEnergyDensity3_timeDerivative
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (p : MaxwellSpacetime3)
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
    maxwellTimeDerivative3
        (maxwellEnergyDensity3 ε₀ μ₀ F)
        p =
      ε₀ *
          maxwellDot3
            (F.electric p)
            (maxwellTimeDerivative3 F.electric p) +
        (1 / μ₀) *
          maxwellDot3
            (F.magnetic p)
            (maxwellTimeDerivative3 F.magnetic p) := by
  have hEDot :
      DifferentiableAt ℝ
        (fun q =>
          maxwellDot3
            (F.electric q)
            (F.electric q))
        p :=
    maxwellDot3_self_differentiableAt
      F.electric p hE0 hE1 hE2

  have hBDot :
      DifferentiableAt ℝ
        (fun q =>
          maxwellDot3
            (F.magnetic q)
            (F.magnetic q))
        p :=
    maxwellDot3_self_differentiableAt
      F.magnetic p hB0 hB1 hB2

  change
    maxwellTimeDerivative3
        (fun q =>
          (ε₀ / 2) *
              maxwellDot3
                (F.electric q)
                (F.electric q) +
            (1 / (2 * μ₀)) *
              maxwellDot3
                (F.magnetic q)
                (F.magnetic q))
        p =
      _

  rw [
    maxwellTimeDerivative3_add
      (fun q =>
        (ε₀ / 2) *
          maxwellDot3
            (F.electric q)
            (F.electric q))
      (fun q =>
        (1 / (2 * μ₀)) *
          maxwellDot3
            (F.magnetic q)
            (F.magnetic q))
      p
      ((differentiableAt_const (ε₀ / 2)).mul hEDot)
      ((differentiableAt_const (1 / (2 * μ₀))).mul hBDot)
  ]

  rw [
    maxwellTimeDerivative3_const_mul
      (ε₀ / 2)
      (fun q =>
        maxwellDot3
          (F.electric q)
          (F.electric q))
      p
      hEDot
  ]

  rw [
    maxwellTimeDerivative3_const_mul
      (1 / (2 * μ₀))
      (fun q =>
        maxwellDot3
          (F.magnetic q)
          (F.magnetic q))
      p
      hBDot
  ]

  rw [
    maxwellTimeDerivative3_dot_self
      F.electric p hE0 hE1 hE2,
    maxwellTimeDerivative3_dot_self
      F.magnetic p hB0 hB1 hB2
  ]

  ring

/--
Local Poynting conservation written with the time derivative of the
electromagnetic energy density.
-/
theorem localPoyntingConservation_fieldLevel3_of_uncontracted
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
    maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          p +
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
  rw [
    maxwellEnergyDensity3_timeDerivative
      ε₀ μ₀ F p
      hE0 hE1 hE2
      hB0 hB1 hB2
  ]

  exact
    localPoyntingIdentity_fieldLevel3_of_uncontracted
      ε₀ μ₀ F p
      hEvolution
      hE0 hE1 hE2
      hB0 hB1 hB2

/-
PROVED := Frechet_time_addition_rule
PROVED := Frechet_time_product_rule
PROVED := time_derivative_of_vector_component
PROVED := time_derivative_of_dot_self
PROVED := energy_density_time_derivative_from_fderiv
PROVED := local_Poynting_conservation_in_energy_density_form
PROVED := divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
A closed rectangular spatial domain in `ℝ³`.
-/
structure MaxwellRectangularDomain3 where
  lower : MaxwellVector3
  upper : MaxwellVector3
  lower_le_upper : lower ≤ upper

/--
The Poynting spatial slice at a fixed time:

`Sₜ(x) = (1 / μ₀) • (E(t,x) × B(t,x))`.
-/
noncomputable def maxwellPoyntingSpatialSlice3
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ) :
    MaxwellVector3 → MaxwellVector3 :=
  fun x =>
    (1 / μ₀) •
      maxwellCross3
        (F.electric (t, x))
        (F.magnetic (t, x))

/--
The divergence of a spatial vector field, expressed directly through
its Fréchet derivative on `ℝ³`.
-/
noncomputable def maxwellSpatialSliceDivergence3
    (S : MaxwellVector3 → MaxwellVector3) :
    MaxwellVector3 → ℝ :=
  fun x =>
    ∑ i : Fin 3,
      (fderiv ℝ S x)
        (Pi.single i 1)
        i

/--
The signed outward flux through the six coordinate faces of a closed
rectangular domain.
-/
noncomputable def maxwellRectangularBoundaryFlux3
    (D : MaxwellRectangularDomain3)
    (S : MaxwellVector3 → MaxwellVector3) :
    ℝ :=
  ∑ i : Fin 3,
    (
      (
        ∫ y in
          Set.Icc
            (D.lower ∘ Fin.succAbove i)
            (D.upper ∘ Fin.succAbove i),
          S
              (Fin.insertNth
                i
                (D.upper i)
                y)
              i
      ) -
      (
        ∫ y in
          Set.Icc
            (D.lower ∘ Fin.succAbove i)
            (D.upper ∘ Fin.succAbove i),
          S
              (Fin.insertNth
                i
                (D.lower i)
                y)
              i
      )
    )

/--
Divergence theorem on a closed rectangular domain in `ℝ³`.

The volume integral of the Fréchet divergence equals the signed sum of
the six coordinate-face flux integrals.
-/
theorem maxwellRectangularDivergenceTheorem3
    (D : MaxwellRectangularDomain3)
    (S : MaxwellVector3 → MaxwellVector3)
    (hContinuous :
      ContinuousOn
        S
        (Set.Icc D.lower D.upper))
    (hDifferentiable :
      ∀ x ∈
        Set.pi
          Set.univ
          (fun i =>
            Set.Ioo
              (D.lower i)
              (D.upper i)),
        DifferentiableAt ℝ S x)
    (hIntegrable :
      IntegrableOn
        (maxwellSpatialSliceDivergence3 S)
        (Set.Icc D.lower D.upper)) :
    (∫ x in Set.Icc D.lower D.upper,
        maxwellSpatialSliceDivergence3 S x) =
      maxwellRectangularBoundaryFlux3 D S := by
  have hRaw :=
    MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable
      D.lower
      D.upper
      D.lower_le_upper
      S
      (fun x => fderiv ℝ S x)
      (∅ : Set MaxwellVector3)
      (by simp)
      hContinuous
      (by
        intro x hx
        exact
          (
            hDifferentiable
              x
              hx.1
          ).hasFDerivAt)
      (by
        simpa [maxwellSpatialSliceDivergence3] using
          hIntegrable)

  simpa [
    maxwellSpatialSliceDivergence3,
    maxwellRectangularBoundaryFlux3
  ] using hRaw

/--
The rectangular-domain divergence theorem specialized to the
electromagnetic Poynting spatial slice.
-/
theorem maxwellPoyntingRectangularDivergenceTheorem3
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3)
    (hContinuous :
      ContinuousOn
        (maxwellPoyntingSpatialSlice3 μ₀ F t)
        (Set.Icc D.lower D.upper))
    (hDifferentiable :
      ∀ x ∈
        Set.pi
          Set.univ
          (fun i =>
            Set.Ioo
              (D.lower i)
              (D.upper i)),
        DifferentiableAt ℝ
          (maxwellPoyntingSpatialSlice3 μ₀ F t)
          x)
    (hIntegrable :
      IntegrableOn
        (
          maxwellSpatialSliceDivergence3
            (maxwellPoyntingSpatialSlice3 μ₀ F t)
        )
        (Set.Icc D.lower D.upper)) :
    (
      ∫ x in Set.Icc D.lower D.upper,
        maxwellSpatialSliceDivergence3
          (maxwellPoyntingSpatialSlice3 μ₀ F t)
          x
    ) =
      maxwellRectangularBoundaryFlux3
        D
        (maxwellPoyntingSpatialSlice3 μ₀ F t) := by
  exact
    maxwellRectangularDivergenceTheorem3
      D
      (maxwellPoyntingSpatialSlice3 μ₀ F t)
      hContinuous
      hDifferentiable
      hIntegrable

/-
PROVED := rectangular_spatial_domain_carrier
PROVED := electromagnetic_Poynting_spatial_slice
PROVED := rectangular_boundary_flux_as_signed_face_integrals
PROVED := divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ spacetime_divergence_identified_with_spatial_slice_divergence
BOUNDARY := ¬ spatially_integrated_local_Poynting_balance
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Each coordinate of the Maxwell cross-product field is differentiable
when the six electric and magnetic coordinate functions are
differentiable.
-/
theorem maxwellCross3_component_differentiableAt
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
    (hE2 :
      DifferentiableAt ℝ
        (fun q => E q (2 : Fin 3))
        p)
    (hB0 :
      DifferentiableAt ℝ
        (fun q => B q (0 : Fin 3))
        p)
    (hB1 :
      DifferentiableAt ℝ
        (fun q => B q (1 : Fin 3))
        p)
    (hB2 :
      DifferentiableAt ℝ
        (fun q => B q (2 : Fin 3))
        p) :
    ∀ i : Fin 3,
      DifferentiableAt ℝ
        (fun q =>
          maxwellCross3
            (E q)
            (B q)
            i)
        p := by
  intro i
  fin_cases i
  ·
    simpa [
      maxwellCross3,
      cross_apply
    ] using
      (
        (hE1.mul hB2).sub
          (hE2.mul hB1)
      )
  ·
    simpa [
      maxwellCross3,
      cross_apply
    ] using
      (
        (hE2.mul hB0).sub
          (hE0.mul hB2)
      )
  ·
    simpa [
      maxwellCross3,
      cross_apply
    ] using
      (
        (hE0.mul hB1).sub
          (hE1.mul hB0)
      )

/-
PROVED := cross_product_component_differentiability
PROVED := fixed_time_spatial_derivative_composition
BOUNDARY := ¬ spacetime_divergence_identified_with_spatial_slice_divergence
BOUNDARY := ¬ spatially_integrated_local_Poynting_balance
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
The derivative of a fixed-time spatial restriction in coordinate
direction `i` is the spacetime spatial derivative in direction `i`.
-/
theorem maxwellFixedTimeSpatialDerivative3
    (f : MaxwellScalarField3)
    (t : ℝ)
    (x : MaxwellVector3)
    (i : Fin 3)
    (hf :
      DifferentiableAt ℝ
        f
        (t, x)) :
    (fderiv ℝ
        (fun y : MaxwellVector3 =>
          f (t, y))
        x)
        (Pi.single i 1) =
      maxwellSpatialDerivative3
        f
        i
        (t, x) := by
  have hEmbedding :
      HasFDerivAt
        (fun y : MaxwellVector3 =>
          ((t, y) : MaxwellSpacetime3))
        (ContinuousLinearMap.inr
          ℝ
          ℝ
          MaxwellVector3)
        x := by
    exact
      hasFDerivAt_prodMk_right
        t
        x

  have hComposition :
      HasFDerivAt
        (fun y : MaxwellVector3 =>
          f (t, y))
        (
          (fderiv ℝ f (t, x)).comp
            (
              ContinuousLinearMap.inr
                ℝ
                ℝ
                MaxwellVector3
            )
        )
        x :=
    hf.hasFDerivAt.comp
      x
      hEmbedding

  have hDirection :
      (
        ContinuousLinearMap.inr
          ℝ
          ℝ
          MaxwellVector3
      )
          (Pi.single i 1) =
        maxwellSpatialDirection3 i := by
    apply Prod.ext
    · rfl
    ·
      funext j
      simp [
        maxwellSpatialDirection3,
        Pi.single_apply,
        eq_comm
      ]

  unfold maxwellSpatialDerivative3

  rw [hComposition.fderiv]

  simp only [
    ContinuousLinearMap.comp_apply
  ]

  rw [hDirection]

/-
PROVED := fixed_time_spatial_derivative_composition
PROVED := spacetime_divergence_identified_with_spatial_slice_divergence
BOUNDARY := ¬ spatially_integrated_local_Poynting_balance
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
Evaluation of a differentiable Pi-valued Fréchet derivative at one
output coordinate agrees with the derivative of that coordinate
function.
-/
theorem maxwellSpatialSliceFDeriv_apply
    (S : MaxwellVector3 → MaxwellVector3)
    (x : MaxwellVector3)
    (hS : DifferentiableAt ℝ S x)
    (i : Fin 3)
    (v : MaxwellVector3) :
    (fderiv ℝ S x) v i =
      (fderiv ℝ
        (fun y =>
          S y i)
        x)
        v := by
  have hi :=
    (hasFDerivAt_pi'.mp
      hS.hasFDerivAt) i

  have h :=
    congrArg
      (fun L : MaxwellVector3 →L[ℝ] ℝ =>
        L v)
      hi.fderiv

  simpa using h.symm

/--
A constant real factor passes through a scalar-valued Fréchet
derivative evaluated in any spatial direction.
-/
theorem maxwellFDeriv_const_mul
    (a : ℝ)
    (f : MaxwellVector3 → ℝ)
    (x v : MaxwellVector3)
    (hf : DifferentiableAt ℝ f x) :
    (fderiv ℝ
        (fun y =>
          a * f y)
        x)
        v =
      a *
        (fderiv ℝ f x) v := by
  have hConst :
      DifferentiableAt ℝ
        (fun _ : MaxwellVector3 =>
          a)
        x :=
    differentiableAt_const a

  have h :=
    congrArg
      (fun L : MaxwellVector3 →L[ℝ] ℝ =>
        L v)
      (fderiv_fun_mul hConst hf)

  simpa [smul_eq_mul] using h

/--
At a fixed time and spatial point, the Fréchet divergence of the
Poynting spatial slice equals the scaled spacetime divergence used by
the local Poynting conservation theorem.
-/
theorem maxwellPoyntingSpatialSliceDivergence_eq_spacetimeDivergence
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (x : MaxwellVector3)
    (hE0 :
      DifferentiableAt ℝ
        (fun q =>
          F.electric q (0 : Fin 3))
        (t, x))
    (hE1 :
      DifferentiableAt ℝ
        (fun q =>
          F.electric q (1 : Fin 3))
        (t, x))
    (hE2 :
      DifferentiableAt ℝ
        (fun q =>
          F.electric q (2 : Fin 3))
        (t, x))
    (hB0 :
      DifferentiableAt ℝ
        (fun q =>
          F.magnetic q (0 : Fin 3))
        (t, x))
    (hB1 :
      DifferentiableAt ℝ
        (fun q =>
          F.magnetic q (1 : Fin 3))
        (t, x))
    (hB2 :
      DifferentiableAt ℝ
        (fun q =>
          F.magnetic q (2 : Fin 3))
        (t, x)) :
    maxwellSpatialSliceDivergence3
        (maxwellPoyntingSpatialSlice3
          μ₀ F t)
        x =
      (1 / μ₀) *
        maxwellDivergence3
          (fun q =>
            maxwellCross3
              (F.electric q)
              (F.magnetic q))
          (t, x) := by
  have hCross :
      ∀ i : Fin 3,
        DifferentiableAt ℝ
          (fun q =>
            maxwellCross3
              (F.electric q)
              (F.magnetic q)
              i)
          (t, x) :=
    maxwellCross3_component_differentiableAt
      F.electric
      F.magnetic
      (t, x)
      hE0
      hE1
      hE2
      hB0
      hB1
      hB2

  have hEmbedding :
      DifferentiableAt ℝ
        (fun y : MaxwellVector3 =>
          ((t, y) : MaxwellSpacetime3))
        x :=
    (
      hasFDerivAt_prodMk_right
        t
        x
    ).differentiableAt

  have hSlice :
      DifferentiableAt ℝ
        (maxwellPoyntingSpatialSlice3
          μ₀ F t)
        x := by
    rw [differentiableAt_pi]
    intro i

    have hFixed :
        DifferentiableAt ℝ
          (fun y : MaxwellVector3 =>
            maxwellCross3
              (F.electric (t, y))
              (F.magnetic (t, y))
              i)
          x :=
      (hCross i).comp
        x
        hEmbedding

    have hConst :
        DifferentiableAt ℝ
          (fun _ : MaxwellVector3 =>
            (1 / μ₀ : ℝ))
          x :=
      differentiableAt_const (1 / μ₀)

    simpa [
      maxwellPoyntingSpatialSlice3,
      Pi.smul_apply,
      smul_eq_mul
    ] using
      hConst.mul hFixed

  unfold
    maxwellSpatialSliceDivergence3
    maxwellDivergence3

  rw [Finset.mul_sum]

  apply Finset.sum_congr rfl

  intro i _

  have hFixed :
      DifferentiableAt ℝ
        (fun y : MaxwellVector3 =>
          maxwellCross3
            (F.electric (t, y))
            (F.magnetic (t, y))
            i)
        x :=
    (hCross i).comp
      x
      hEmbedding

  rw [
    maxwellSpatialSliceFDeriv_apply
      (maxwellPoyntingSpatialSlice3
        μ₀ F t)
      x
      hSlice
      i
      (Pi.single i 1)
  ]

  change
    (fderiv ℝ
        (fun y : MaxwellVector3 =>
          (1 / μ₀) *
            maxwellCross3
              (F.electric (t, y))
              (F.magnetic (t, y))
              i)
        x)
        (Pi.single i 1) =
      (1 / μ₀) *
        maxwellSpatialDerivative3
          (fun q =>
            maxwellCross3
              (F.electric q)
              (F.magnetic q)
              i)
          i
          (t, x)

  rw [
    maxwellFDeriv_const_mul
      (1 / μ₀)
      (fun y : MaxwellVector3 =>
        maxwellCross3
          (F.electric (t, y))
          (F.magnetic (t, y))
          i)
      x
      (Pi.single i 1)
      hFixed
  ]

  rw [
    maxwellFixedTimeSpatialDerivative3
      (fun q =>
        maxwellCross3
          (F.electric q)
          (F.magnetic q)
          i)
      t
      x
      i
      (hCross i)
  ]

/-
PROVED := Pi_valued_Frechet_coordinate_projection
PROVED := constant_factor_passes_through_spatial_Frechet_derivative
PROVED := three_coordinate_derivative_identities_summed
PROVED := spacetime_divergence_identified_with_spatial_slice_divergence
BOUNDARY := ¬ spatially_integrated_local_Poynting_balance
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/


/--
At a fixed time, integration of the local Poynting conservation law
over a spatial set gives the volume balance between the time derivative
of electromagnetic energy density, the spatial divergence of the
Poynting vector, and the work density `J · E`.
-/
theorem maxwellFixedTimeSpatiallyIntegratedLocalPoyntingIdentity3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (Ω : Set MaxwellVector3)
    (hEvolution :
      ∀ x : MaxwellVector3,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (t, x))
    (hE0 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.electric q (0 : Fin 3))
          (t, x))
    (hE1 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.electric q (1 : Fin 3))
          (t, x))
    (hE2 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.electric q (2 : Fin 3))
          (t, x))
    (hB0 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.magnetic q (0 : Fin 3))
          (t, x))
    (hB1 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.magnetic q (1 : Fin 3))
          (t, x))
    (hB2 :
      ∀ x : MaxwellVector3,
        DifferentiableAt ℝ
          (fun q =>
            F.magnetic q (2 : Fin 3))
          (t, x))
    (hTimeIntegrable :
      IntegrableOn
        (fun x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        Ω)
    (hDivergenceIntegrable :
      IntegrableOn
        (
          maxwellSpatialSliceDivergence3
            (maxwellPoyntingSpatialSlice3
              μ₀ F t)
        )
        Ω) :
    (
      ∫ x in Ω,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)
    ) +
      (
        ∫ x in Ω,
          maxwellSpatialSliceDivergence3
            (maxwellPoyntingSpatialSlice3
              μ₀ F t)
            x
      ) =
    -(
      ∫ x in Ω,
        maxwellDot3
          (F.current (t, x))
          (F.electric (t, x))
    ) := by
  have hAE :
      (
        fun x =>
          maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (t, x) +
            maxwellSpatialSliceDivergence3
              (maxwellPoyntingSpatialSlice3
                μ₀ F t)
              x
      ) =ᵐ[volume.restrict Ω]
      (
        fun x =>
          -maxwellDot3
            (F.current (t, x))
            (F.electric (t, x))
      ) :=
    Filter.Eventually.of_forall
      (fun x => by
        have hLocal :=
          localPoyntingConservation_fieldLevel3_of_uncontracted
            ε₀
            μ₀
            F
            (t, x)
            (hEvolution x)
            (hE0 x)
            (hE1 x)
            (hE2 x)
            (hB0 x)
            (hB1 x)
            (hB2 x)

        have hBridge :=
          maxwellPoyntingSpatialSliceDivergence_eq_spacetimeDivergence
            μ₀
            F
            t
            x
            (hE0 x)
            (hE1 x)
            (hE2 x)
            (hB0 x)
            (hB1 x)
            (hB2 x)

        calc
          maxwellTimeDerivative3
                (maxwellEnergyDensity3 ε₀ μ₀ F)
                (t, x) +
              maxwellSpatialSliceDivergence3
                (maxwellPoyntingSpatialSlice3
                  μ₀ F t)
                x =
            maxwellTimeDerivative3
                (maxwellEnergyDensity3 ε₀ μ₀ F)
                (t, x) +
              (1 / μ₀) *
                maxwellDivergence3
                  (fun q =>
                    maxwellCross3
                      (F.electric q)
                      (F.magnetic q))
                  (t, x) := by
                    rw [hBridge]
          _ =
            -maxwellDot3
              (F.current (t, x))
              (F.electric (t, x)) :=
                hLocal)

  have hIntegral :=
    integral_congr_ae hAE

  rw [
    integral_add
      hTimeIntegrable
      hDivergenceIntegrable
  ] at hIntegral

  rw [integral_neg] at hIntegral

  exact hIntegral

/-
PROVED := fixed_time_spatially_integrated_local_Poynting_identity
BOUNDARY := ¬ differentiation_under_spatial_integral_instantiated
BOUNDARY := ¬ rectangular_boundary_flux_substituted_into_fixed_time_balance
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ integrated_rectangular_Poynting_energy_balance
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/

/--
Total electromagnetic energy stored in a rectangular spatial domain
at time `t`.
-/
noncomputable def maxwellTotalElectromagneticEnergy3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t : ℝ) :
    ℝ :=
  ∫ x in Set.Icc D.lower D.upper,
    maxwellEnergyDensity3 ε₀ μ₀ F (t, x)
/--
Differentiation under the rectangular spatial integral under explicit
local domination, measurability, integrability, and pointwise
derivative hypotheses.
-/
theorem maxwellTotalElectromagneticEnergy3_hasDerivAt_of_dominated
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t : ℝ)
    (s : Set ℝ)
    (bound : MaxwellVector3 → ℝ)
    (hs : s ∈ nhds t)
    (hEnergyMeasurable :
      ∀ᶠ τ in nhds t,
        AEStronglyMeasurable
          (fun x =>
            maxwellEnergyDensity3
              ε₀ μ₀ F (τ, x))
          (volume.restrict
            (Set.Icc D.lower D.upper)))
    (hEnergyIntegrable :
      Integrable
        (fun x =>
          maxwellEnergyDensity3
            ε₀ μ₀ F (t, x))
        (volume.restrict
          (Set.Icc D.lower D.upper)))
    (hTimeDerivativeMeasurable :
      AEStronglyMeasurable
        (fun x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        (volume.restrict
          (Set.Icc D.lower D.upper)))
    (hDerivativeBound :
      ∀ᵐ x ∂
        volume.restrict
          (Set.Icc D.lower D.upper),
        ∀ τ ∈ s,
          ‖maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)‖ ≤
            bound x)
    (hBoundIntegrable :
      Integrable
        bound
        (volume.restrict
          (Set.Icc D.lower D.upper)))
    (hPointwiseDerivative :
      ∀ᵐ x ∂
        volume.restrict
          (Set.Icc D.lower D.upper),
        ∀ τ ∈ s,
          HasDerivAt
            (fun σ =>
              maxwellEnergyDensity3
                ε₀ μ₀ F (σ, x))
            (maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
            τ) :
    Integrable
        (fun x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        (volume.restrict
          (Set.Icc D.lower D.upper)) ∧
      HasDerivAt
        (maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D)
        (∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        t := by
  simpa [
    maxwellTotalElectromagneticEnergy3
  ] using
    (hasDerivAt_integral_of_dominated_loc_of_deriv_le
      (μ :=
        volume.restrict
          (Set.Icc D.lower D.upper))
      (F :=
        fun τ x =>
          maxwellEnergyDensity3
            ε₀ μ₀ F (τ, x))
      (F' :=
        fun τ x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x))
      (x₀ := t)
      (s := s)
      (bound := bound)
      hs
      hEnergyMeasurable
      hEnergyIntegrable
      hTimeDerivativeMeasurable
      hDerivativeBound
      hBoundIntegrable
      hPointwiseDerivative)
/--
The fixed-time rectangular Poynting balance obtained by replacing the
volume integral of the divergence with the signed six-face flux.
-/
theorem maxwellFixedTimeRectangularPoyntingBalance3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3)
    (hIntegratedLocal :
      (∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x)) +
        (∫ x in Set.Icc D.lower D.upper,
          maxwellSpatialSliceDivergence3
            (maxwellPoyntingSpatialSlice3 μ₀ F t)
            x) =
      -(∫ x in Set.Icc D.lower D.upper,
          maxwellDot3
            (F.current (t, x))
            (F.electric (t, x))))
    (hContinuous :
      ContinuousOn
        (maxwellPoyntingSpatialSlice3 μ₀ F t)
        (Set.Icc D.lower D.upper))
    (hDifferentiable :
      ∀ x ∈
        Set.pi
          Set.univ
          (fun i =>
            Set.Ioo
              (D.lower i)
              (D.upper i)),
        DifferentiableAt ℝ
          (maxwellPoyntingSpatialSlice3 μ₀ F t)
          x)
    (hDivergenceIntegrable :
      IntegrableOn
        (maxwellSpatialSliceDivergence3
          (maxwellPoyntingSpatialSlice3 μ₀ F t))
        (Set.Icc D.lower D.upper)) :
    (∫ x in Set.Icc D.lower D.upper,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)) +
      maxwellRectangularBoundaryFlux3
        D
        (maxwellPoyntingSpatialSlice3 μ₀ F t) =
    -(∫ x in Set.Icc D.lower D.upper,
        maxwellDot3
          (F.current (t, x))
          (F.electric (t, x))) := by
  rw [
    ← maxwellPoyntingRectangularDivergenceTheorem3
      μ₀
      F
      t
      D
      hContinuous
      hDifferentiable
      hDivergenceIntegrable
  ]

  exact hIntegratedLocal
/--
The time fundamental theorem of calculus for total electromagnetic
energy in the rectangular domain.
-/
theorem maxwellTotalElectromagneticEnergy3_timeFTC
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hDerivative :
      ∀ τ ∈ Set.uIcc t₀ t₁,
        HasDerivAt
          (maxwellTotalElectromagneticEnergy3
            ε₀ μ₀ F D)
          (∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
          τ)
    (hDerivativeIntervalIntegrable :
      IntervalIntegrable
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
        volume
        t₀
        t₁) :
    maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₁ -
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₀ =
      ∫ τ in t₀..t₁,
        ∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x) := by
  have hFTC :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      (f :=
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D)
      (f' :=
        fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
      hDerivative
      hDerivativeIntervalIntegrable

  exact hFTC.symm
/--
Integrated rectangular Poynting balance obtained from the already
established fixed-time balance and the total-energy time FTC.

The fixed-time balance is an explicit premise so this theorem performs
only the final temporal integration and algebraic packaging.
-/
theorem maxwellIntegratedRectangularPoyntingBalance3
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hDerivative :
      ∀ τ ∈ Set.uIcc t₀ t₁,
        HasDerivAt
          (maxwellTotalElectromagneticEnergy3
            ε₀ μ₀ F D)
          (∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
          τ)
    (hDerivativeIntervalIntegrable :
      IntervalIntegrable
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
        volume
        t₀
        t₁)
    (hFluxIntervalIntegrable :
      IntervalIntegrable
        (fun τ =>
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ))
        volume
        t₀
        t₁)
    (hFixedTimeBalance :
      ∀ τ : ℝ,
        (∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)) +
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
        -(∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x)))) :
    maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₁ -
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₀ +
        (∫ τ in t₀..t₁,
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
      -(∫ τ in t₀..t₁,
          ∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x))) := by
  have hFTC :=
    maxwellTotalElectromagneticEnergy3_timeFTC
      ε₀
      μ₀
      F
      D
      t₀
      t₁
      hDerivative
      hDerivativeIntervalIntegrable

  have hIntegratedLocal :
      (∫ τ in t₀..t₁,
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)) +
        (∫ τ in t₀..t₁,
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
      -(∫ τ in t₀..t₁,
          ∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x))) := by
    calc
      (∫ τ in t₀..t₁,
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)) +
          (∫ τ in t₀..t₁,
            maxwellRectangularBoundaryFlux3
              D
              (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
        ∫ τ in t₀..t₁,
          ((∫ x in Set.Icc D.lower D.upper,
              maxwellTimeDerivative3
                (maxwellEnergyDensity3 ε₀ μ₀ F)
                (τ, x)) +
            maxwellRectangularBoundaryFlux3
              D
              (maxwellPoyntingSpatialSlice3 μ₀ F τ)) := by
            exact
              (intervalIntegral.integral_add
                hDerivativeIntervalIntegrable
                hFluxIntervalIntegrable).symm
      _ =
        ∫ τ in t₀..t₁,
          -(∫ x in Set.Icc D.lower D.upper,
              maxwellDot3
                (F.current (τ, x))
                (F.electric (τ, x))) := by
            apply intervalIntegral.integral_congr
            intro τ hτ
            exact hFixedTimeBalance τ
      _ =
        -(∫ τ in t₀..t₁,
            ∫ x in Set.Icc D.lower D.upper,
              maxwellDot3
                (F.current (τ, x))
                (F.electric (τ, x))) := by
            rw [intervalIntegral.integral_neg]

  exact
    integratedSpacetimeEnergyBalance_from_FTC_and_divergence
      (maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₀)
      (maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₁)
      (∫ τ in t₀..t₁,
        ∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x))
      (∫ τ in t₀..t₁,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ))
      (∫ τ in t₀..t₁,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ))
      (∫ τ in t₀..t₁,
        ∫ x in Set.Icc D.lower D.upper,
          maxwellDot3
            (F.current (τ, x))
            (F.electric (τ, x)))
      hFTC
      rfl
      hIntegratedLocal

/-
PROVED := integrated_rectangular_Poynting_balance_from_fixed_time_balance_and_FTC
BOUNDARY := ¬ analytic_hypotheses_derived_for_every_Maxwell_field
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a `SmoothMaxwellField3`, the six component-differentiability
premises of the fixed-time spatially integrated local Poynting identity
follow directly from the stored `ContDiff ℝ 1` field regularity.
-/
theorem maxwellFixedTimeSpatiallyIntegratedLocalPoyntingIdentity3_of_smooth
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (Ω : Set MaxwellVector3)
    (hEvolution :
      ∀ x : MaxwellVector3,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (t, x))
    (hTimeIntegrable :
      IntegrableOn
        (fun x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        Ω)
    (hDivergenceIntegrable :
      IntegrableOn
        (maxwellSpatialSliceDivergence3
          (maxwellPoyntingSpatialSlice3 μ₀ F t))
        Ω) :
    (∫ x in Ω,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)) +
      (∫ x in Ω,
        maxwellSpatialSliceDivergence3
          (maxwellPoyntingSpatialSlice3 μ₀ F t)
          x) =
    -(∫ x in Ω,
        maxwellDot3
          (F.current (t, x))
          (F.electric (t, x))) := by
  have hElectric :
      ∀ (i : Fin 3) (x : MaxwellVector3),
        DifferentiableAt ℝ
          (fun q => F.electric q i)
          (t, x) := by
    intro i x

    have hVector :
        DifferentiableAt ℝ
          F.electric
          (t, x) :=
      (F.electric_contDiff.differentiable
        (by norm_num))
        (t, x)

    exact
      (differentiableAt_pi.mp hVector) i

  have hMagnetic :
      ∀ (i : Fin 3) (x : MaxwellVector3),
        DifferentiableAt ℝ
          (fun q => F.magnetic q i)
          (t, x) := by
    intro i x

    have hVector :
        DifferentiableAt ℝ
          F.magnetic
          (t, x) :=
      (F.magnetic_contDiff.differentiable
        (by norm_num))
        (t, x)

    exact
      (differentiableAt_pi.mp hVector) i

  exact
    maxwellFixedTimeSpatiallyIntegratedLocalPoyntingIdentity3
      ε₀
      μ₀
      F
      t
      Ω
      hEvolution
      (hElectric (0 : Fin 3))
      (hElectric (1 : Fin 3))
      (hElectric (2 : Fin 3))
      (hMagnetic (0 : Fin 3))
      (hMagnetic (1 : Fin 3))
      (hMagnetic (2 : Fin 3))
      hTimeIntegrable
      hDivergenceIntegrable

/-
PROVED := smooth_field_regularities_supply_all_component_differentiability
PROVED := fixed_time_spatial_integration_without_six_redundant_component_hypotheses
BOUNDARY := ¬ spatial_integrability_derived_from_smoothness_on_rectangular_domain
BOUNDARY := ¬ fixed_time_boundary_flux_balance_derived_from_smoothness_alone
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
At every fixed time, the Poynting spatial slice of a
`SmoothMaxwellField3` is differentiable on all of `ℝ³`.
-/
theorem maxwellPoyntingSpatialSlice3_differentiable
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ) :
    Differentiable ℝ
      (maxwellPoyntingSpatialSlice3 μ₀ F t) := by
  intro x

  have hEmbedding :
      DifferentiableAt ℝ
        (fun y : MaxwellVector3 =>
          ((t, y) : MaxwellSpacetime3))
        x :=
    (hasFDerivAt_prodMk_right t x).differentiableAt

  have hElectric :
      DifferentiableAt ℝ F.electric (t, x) :=
    (F.electric_contDiff.differentiable
      (by norm_num))
      (t, x)

  have hMagnetic :
      DifferentiableAt ℝ F.magnetic (t, x) :=
    (F.magnetic_contDiff.differentiable
      (by norm_num))
      (t, x)

  have hCross :
      ∀ i : Fin 3,
        DifferentiableAt ℝ
          (fun q =>
            maxwellCross3
              (F.electric q)
              (F.magnetic q)
              i)
          (t, x) :=
    maxwellCross3_component_differentiableAt
      F.electric
      F.magnetic
      (t, x)
      ((differentiableAt_pi.mp hElectric) (0 : Fin 3))
      ((differentiableAt_pi.mp hElectric) (1 : Fin 3))
      ((differentiableAt_pi.mp hElectric) (2 : Fin 3))
      ((differentiableAt_pi.mp hMagnetic) (0 : Fin 3))
      ((differentiableAt_pi.mp hMagnetic) (1 : Fin 3))
      ((differentiableAt_pi.mp hMagnetic) (2 : Fin 3))

  rw [differentiableAt_pi]

  intro i

  have hFixedCross :
      DifferentiableAt ℝ
        (fun y : MaxwellVector3 =>
          maxwellCross3
            (F.electric (t, y))
            (F.magnetic (t, y))
            i)
        x :=
    (hCross i).comp x hEmbedding

  have hConstant :
      DifferentiableAt ℝ
        (fun _ : MaxwellVector3 =>
          (1 / μ₀ : ℝ))
        x :=
    differentiableAt_const (1 / μ₀)

  simpa [
    maxwellPoyntingSpatialSlice3,
    Pi.smul_apply,
    smul_eq_mul
  ] using hConstant.mul hFixedCross

/-
PROVED := fixed_time_Poynting_spatial_slice_differentiable_from_smooth_fields
PROVED := fixed_time_Poynting_spatial_slice_continuous_from_differentiability
BOUNDARY := ¬ spatial_divergence_integrability_derived_on_rectangular_domain
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
At each fixed time, the Poynting spatial slice of a
`SmoothMaxwellField3` is continuously differentiable of order one.
-/
theorem maxwellPoyntingSpatialSlice3_contDiff
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ) :
    ContDiff ℝ 1
      (maxwellPoyntingSpatialSlice3 μ₀ F t) := by
  have hEmbedding :
      ContDiff ℝ 1
        (fun y : MaxwellVector3 =>
          ((t, y) : MaxwellSpacetime3)) :=
    contDiff_const.prodMk contDiff_id

  have hElectricVector :
      ContDiff ℝ 1
        (fun y : MaxwellVector3 =>
          F.electric (t, y)) := by
    simpa only [Function.comp_apply] using
      F.electric_contDiff.comp hEmbedding

  have hMagneticVector :
      ContDiff ℝ 1
        (fun y : MaxwellVector3 =>
          F.magnetic (t, y)) := by
    simpa only [Function.comp_apply] using
      F.magnetic_contDiff.comp hEmbedding

  have hElectric :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun y : MaxwellVector3 =>
            F.electric (t, y) i) :=
    fun i =>
      (contDiff_pi.mp hElectricVector) i

  have hMagnetic :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun y : MaxwellVector3 =>
            F.magnetic (t, y) i) :=
    fun i =>
      (contDiff_pi.mp hMagneticVector) i

  have hScale :
      ContDiff ℝ 1
        (fun _ : MaxwellVector3 =>
          (1 / μ₀ : ℝ)) :=
    contDiff_const

  rw [contDiff_pi]
  intro i
  fin_cases i

  · have hCross :
        ContDiff ℝ 1
          (fun y : MaxwellVector3 =>
            F.electric (t, y) (1 : Fin 3) *
                F.magnetic (t, y) (2 : Fin 3) -
              F.electric (t, y) (2 : Fin 3) *
                F.magnetic (t, y) (1 : Fin 3)) :=
      ((hElectric (1 : Fin 3)).mul
          (hMagnetic (2 : Fin 3))).sub
        ((hElectric (2 : Fin 3)).mul
          (hMagnetic (1 : Fin 3)))

    simpa [
      maxwellPoyntingSpatialSlice3,
      maxwellCross3,
      cross_apply,
      Pi.smul_apply,
      smul_eq_mul
    ] using hScale.mul hCross

  · have hCross :
        ContDiff ℝ 1
          (fun y : MaxwellVector3 =>
            F.electric (t, y) (2 : Fin 3) *
                F.magnetic (t, y) (0 : Fin 3) -
              F.electric (t, y) (0 : Fin 3) *
                F.magnetic (t, y) (2 : Fin 3)) :=
      ((hElectric (2 : Fin 3)).mul
          (hMagnetic (0 : Fin 3))).sub
        ((hElectric (0 : Fin 3)).mul
          (hMagnetic (2 : Fin 3)))

    simpa [
      maxwellPoyntingSpatialSlice3,
      maxwellCross3,
      cross_apply,
      Pi.smul_apply,
      smul_eq_mul
    ] using hScale.mul hCross

  · have hCross :
        ContDiff ℝ 1
          (fun y : MaxwellVector3 =>
            F.electric (t, y) (0 : Fin 3) *
                F.magnetic (t, y) (1 : Fin 3) -
              F.electric (t, y) (1 : Fin 3) *
                F.magnetic (t, y) (0 : Fin 3)) :=
      ((hElectric (0 : Fin 3)).mul
          (hMagnetic (1 : Fin 3))).sub
        ((hElectric (1 : Fin 3)).mul
          (hMagnetic (0 : Fin 3)))

    simpa [
      maxwellPoyntingSpatialSlice3,
      maxwellCross3,
      cross_apply,
      Pi.smul_apply,
      smul_eq_mul
    ] using hScale.mul hCross

/-
PROVED := fixed_time_Poynting_spatial_slice_is_C1
PROVED := Poynting_spatial_slice_fderiv_is_continuous
BOUNDARY := ¬ spatial_divergence_continuity_derived
BOUNDARY := ¬ spatial_divergence_integrability_derived_on_rectangular_domain
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
The Fréchet-coordinate divergence of a continuously differentiable
spatial vector field is continuous.
-/
theorem maxwellSpatialSliceDivergence3_continuous_of_contDiff
    (S : MaxwellVector3 → MaxwellVector3)
    (hS : ContDiff ℝ 1 S) :
    Continuous
      (maxwellSpatialSliceDivergence3 S) := by
  unfold maxwellSpatialSliceDivergence3

  exact
    continuous_finset_sum
      Finset.univ
      (fun i _ => by
        have hSingle :
            Continuous
              (fun _ : MaxwellVector3 =>
                (Pi.single i (1 : ℝ) :
                  MaxwellVector3)) :=
          continuous_const

        have hPair :
            Continuous
              (fun x : MaxwellVector3 =>
                (x,
                  (Pi.single i (1 : ℝ) :
                    MaxwellVector3))) :=
          continuous_id.prodMk hSingle

        have hDirectionalDerivative :
            Continuous
              (fun x : MaxwellVector3 =>
                (fderiv ℝ S x)
                  (Pi.single i (1 : ℝ))) :=
          (hS.continuous_fderiv_apply
            (by norm_num)).comp hPair

        exact
          (continuous_apply i).comp
            hDirectionalDerivative)

/--
The spatial divergence of the fixed-time Poynting slice of a smooth
Maxwell field is continuous.
-/
theorem maxwellPoyntingSpatialSliceDivergence3_continuous
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ) :
    Continuous
      (maxwellSpatialSliceDivergence3
        (maxwellPoyntingSpatialSlice3 μ₀ F t)) := by
  exact
    maxwellSpatialSliceDivergence3_continuous_of_contDiff
      (maxwellPoyntingSpatialSlice3 μ₀ F t)
      (maxwellPoyntingSpatialSlice3_contDiff
        μ₀ F t)
/--
The continuous spatial divergence of the fixed-time Poynting slice is
integrable over every closed rectangular domain.
-/
theorem maxwellPoyntingSpatialSliceDivergence3_integrableOn_rectangularDomain
    (μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3) :
    IntegrableOn
      (maxwellSpatialSliceDivergence3
        (maxwellPoyntingSpatialSlice3 μ₀ F t))
      (Set.Icc D.lower D.upper) := by
  exact
    (maxwellPoyntingSpatialSliceDivergence3_continuous
      μ₀ F t).integrableOn_Icc

/-
PROVED := Poynting_spatial_divergence_integrable_on_every_rectangular_domain
BOUNDARY := ¬ time_derivative_integrability_derived_on_rectangular_domain
BOUNDARY := ¬ fixed_time_rectangular_balance_packaged_from_smoothness
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth Maxwell field, the fixed-time rectangular Poynting
balance follows without separate component-regularity, continuity,
differentiability, or divergence-integrability premises.
-/
theorem maxwellFixedTimeRectangularPoyntingBalance3_of_smooth
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3)
    (hEvolution :
      ∀ x : MaxwellVector3,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (t, x))
    (hTimeIntegrable :
      IntegrableOn
        (fun x =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        (Set.Icc D.lower D.upper)) :
    (∫ x in Set.Icc D.lower D.upper,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)) +
      maxwellRectangularBoundaryFlux3
        D
        (maxwellPoyntingSpatialSlice3 μ₀ F t) =
    -(∫ x in Set.Icc D.lower D.upper,
        maxwellDot3
          (F.current (t, x))
          (F.electric (t, x))) := by
  have hDivergenceIntegrable :=
    maxwellPoyntingSpatialSliceDivergence3_integrableOn_rectangularDomain
      μ₀
      F
      t
      D

  have hIntegratedLocal :=
    maxwellFixedTimeSpatiallyIntegratedLocalPoyntingIdentity3_of_smooth
      ε₀
      μ₀
      F
      t
      (Set.Icc D.lower D.upper)
      hEvolution
      hTimeIntegrable
      hDivergenceIntegrable

  have hPoyntingDifferentiable :=
    maxwellPoyntingSpatialSlice3_differentiable
      μ₀
      F
      t

  exact
    maxwellFixedTimeRectangularPoyntingBalance3
      ε₀
      μ₀
      F
      t
      D
      hIntegratedLocal
      hPoyntingDifferentiable.continuous.continuousOn
      (fun x _ => hPoyntingDifferentiable x)
      hDivergenceIntegrable

/-
PROVED := fixed_time_rectangular_Poynting_balance_packaged_from_smoothness
PROVED := spatial_continuity_premise_eliminated
PROVED := spatial_differentiability_premise_eliminated
PROVED := divergence_integrability_premise_eliminated
BOUNDARY := ¬ time_derivative_integrability_derived_on_rectangular_domain
BOUNDARY := ¬ time_interval_integrability_derived_from_smoothness
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a `SmoothMaxwellField3`, the Fréchet time derivative of the
electromagnetic energy density is continuous on spacetime.
-/
theorem maxwellEnergyDensity3_timeDerivative_continuous
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3) :
    Continuous
      (maxwellTimeDerivative3
        (maxwellEnergyDensity3 ε₀ μ₀ F)) := by
  have hElectric :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.electric p i) :=
    fun i =>
      (contDiff_pi.mp F.electric_contDiff) i

  have hMagnetic :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.magnetic p i) :=
    fun i =>
      (contDiff_pi.mp F.magnetic_contDiff) i

  have hElectricDotExpanded :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          F.electric p (0 : Fin 3) *
              F.electric p (0 : Fin 3) +
            (F.electric p (1 : Fin 3) *
                F.electric p (1 : Fin 3) +
              F.electric p (2 : Fin 3) *
                F.electric p (2 : Fin 3))) :=
    ((hElectric (0 : Fin 3)).mul
        (hElectric (0 : Fin 3))).add
      (((hElectric (1 : Fin 3)).mul
          (hElectric (1 : Fin 3))).add
        ((hElectric (2 : Fin 3)).mul
          (hElectric (2 : Fin 3))))

  have hMagneticDotExpanded :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          F.magnetic p (0 : Fin 3) *
              F.magnetic p (0 : Fin 3) +
            (F.magnetic p (1 : Fin 3) *
                F.magnetic p (1 : Fin 3) +
              F.magnetic p (2 : Fin 3) *
                F.magnetic p (2 : Fin 3))) :=
    ((hMagnetic (0 : Fin 3)).mul
        (hMagnetic (0 : Fin 3))).add
      (((hMagnetic (1 : Fin 3)).mul
          (hMagnetic (1 : Fin 3))).add
        ((hMagnetic (2 : Fin 3)).mul
          (hMagnetic (2 : Fin 3))))

  have hElectricDot :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.electric p)
            (F.electric p)) := by
    simpa [
      maxwellDot3,
      Fin.sum_univ_succ
    ] using hElectricDotExpanded

  have hMagneticDot :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.magnetic p)
            (F.magnetic p)) := by
    simpa [
      maxwellDot3,
      Fin.sum_univ_succ
    ] using hMagneticDotExpanded

  have hElectricScale :
      ContDiff ℝ 1
        (fun _ : MaxwellSpacetime3 =>
          ε₀ / 2) :=
    contDiff_const

  have hMagneticScale :
      ContDiff ℝ 1
        (fun _ : MaxwellSpacetime3 =>
          1 / (2 * μ₀)) :=
    contDiff_const

  have hEnergy :
      ContDiff ℝ 1
        (maxwellEnergyDensity3 ε₀ μ₀ F) := by
    change
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          (ε₀ / 2) *
              maxwellDot3
                (F.electric p)
                (F.electric p) +
            (1 / (2 * μ₀)) *
              maxwellDot3
                (F.magnetic p)
                (F.magnetic p))

    exact
      (hElectricScale.mul hElectricDot).add
        (hMagneticScale.mul hMagneticDot)

  have hPair :
      Continuous
        (fun p : MaxwellSpacetime3 =>
          (p, maxwellTimeDirection3)) :=
    continuous_id.prodMk continuous_const

  have hDerivative :
      Continuous
        (fun p : MaxwellSpacetime3 =>
          (fderiv ℝ
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            p)
            maxwellTimeDirection3) :=
    (hEnergy.continuous_fderiv_apply
      (by norm_num)).comp hPair

  simpa [maxwellTimeDerivative3] using hDerivative

/-
PROVED := electromagnetic_energy_density_time_derivative_continuous
BOUNDARY := ¬ time_derivative_integrability_derived_on_rectangular_domain
BOUNDARY := ¬ time_interval_integrability_derived_from_smoothness
-/
/--
At every fixed time, the electromagnetic energy-density time
derivative of a smooth Maxwell field is integrable on every closed
rectangular spatial domain.
-/
theorem maxwellEnergyDensity3_timeDerivative_integrableOn_rectangularDomain
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3) :
    IntegrableOn
      (fun x : MaxwellVector3 =>
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x))
      (Set.Icc D.lower D.upper) := by
  have hEmbedding :
      Continuous
        (fun x : MaxwellVector3 =>
          ((t, x) : MaxwellSpacetime3)) :=
    continuous_const.prodMk continuous_id

  have hSlice :
      Continuous
        (fun x : MaxwellVector3 =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x)) :=
    (maxwellEnergyDensity3_timeDerivative_continuous
      ε₀
      μ₀
      F).comp hEmbedding

  exact hSlice.integrableOn_Icc

/-
PROVED := energy_density_time_derivative_integrable_on_every_rectangular_domain
BOUNDARY := ¬ time_interval_integrability_derived_from_smoothness
BOUNDARY := ¬ unconditional_integrated_rectangular_balance_packaged
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth Maxwell field satisfying the uncontracted Maxwell
evolution equations, the fixed-time rectangular Poynting balance
requires no separately supplied spatial analytic hypotheses.
-/
theorem maxwellFixedTimeRectangularPoyntingBalance3_of_smooth_evolution
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (t : ℝ)
    (D : MaxwellRectangularDomain3)
    (hEvolution :
      ∀ x : MaxwellVector3,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (t, x)) :
    (∫ x in Set.Icc D.lower D.upper,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)) +
      maxwellRectangularBoundaryFlux3
        D
        (maxwellPoyntingSpatialSlice3 μ₀ F t) =
    -(∫ x in Set.Icc D.lower D.upper,
        maxwellDot3
          (F.current (t, x))
          (F.electric (t, x))) := by
  exact
    maxwellFixedTimeRectangularPoyntingBalance3_of_smooth
      ε₀
      μ₀
      F
      t
      D
      hEvolution
      (maxwellEnergyDensity3_timeDerivative_integrableOn_rectangularDomain
        ε₀
        μ₀
        F
        t
        D)

/-
PROVED := fixed_time_rectangular_Poynting_balance_from_smooth_Maxwell_evolution
PROVED := fixed_time_energy_derivative_integrability_premise_eliminated
BOUNDARY := ¬ time_interval_integrability_derived_from_smoothness
BOUNDARY := ¬ total_energy_derivative_FTC_hypotheses_fully_derived
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
The spatial integral of the electromagnetic energy-density time
derivative is interval integrable in time.

The proof uses continuity on the compact time-space rectangle followed
by Fubini integrability.
-/
theorem maxwellSpatiallyIntegratedEnergyDerivative_intervalIntegrable
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ) :
    IntervalIntegrable
      (fun τ =>
        ∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x))
      volume
      t₀
      t₁ := by
  have hCompactTime :
      IsCompact (Set.uIcc t₀ t₁) :=
    isCompact_uIcc

  have hCompactSpace :
      IsCompact (Set.Icc D.lower D.upper) :=
    isCompact_Icc

  have hCompactProduct :
      IsCompact
        (Set.uIcc t₀ t₁ ×ˢ
          Set.Icc D.lower D.upper) :=
    hCompactTime.prod hCompactSpace

  have hSpacetimeIntegrableOn :
      IntegrableOn
        (maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F))
        (Set.uIcc t₀ t₁ ×ˢ
          Set.Icc D.lower D.upper)
        (volume : Measure MaxwellSpacetime3) :=
    ContinuousOn.integrableOn_compact
      hCompactProduct
      (maxwellEnergyDensity3_timeDerivative_continuous
        ε₀
        μ₀
        F).continuousOn

  have hSpacetimeIntegrable :
      Integrable
        (maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F))
        (((volume : Measure ℝ).restrict
              (Set.uIcc t₀ t₁)).prod
          ((volume : Measure MaxwellVector3).restrict
              (Set.Icc D.lower D.upper))) := by
    rw [Measure.prod_restrict]
    exact hSpacetimeIntegrableOn

  have hIntegratedTime :
      Integrable
        (fun τ =>
          ∫ x,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)
            ∂((volume : Measure MaxwellVector3).restrict
              (Set.Icc D.lower D.upper)))
        ((volume : Measure ℝ).restrict
          (Set.uIcc t₀ t₁)) :=
    hSpacetimeIntegrable.integral_prod_left

  have hIntegratedOnTimeInterval :
      IntegrableOn
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
        (Set.uIcc t₀ t₁)
        volume := by
    simpa only [IntegrableOn] using hIntegratedTime

  exact hIntegratedOnTimeInterval.intervalIntegrable

/-
PROVED := spatially_integrated_energy_derivative_interval_integrable
PROVED := spacetime_compact_product_integrability
BOUNDARY := ¬ total_energy_derivative_HasDerivAt_fully_derived
BOUNDARY := ¬ boundary_flux_interval_integrability_derived
BOUNDARY := ¬ unconditional_integrated_rectangular_balance_packaged
-/
/--
For every smooth Maxwell field, differentiation passes through the
rectangular spatial energy integral.

The required local dominating bound is obtained from continuity of the
energy-density time derivative on a compact time-space rectangle.
-/
theorem maxwellTotalElectromagneticEnergy3_hasDerivAt_of_smooth
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t : ℝ) :
    HasDerivAt
      (maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D)
      (∫ x in Set.Icc D.lower D.upper,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x))
      t := by
  have hElectric :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.electric p i) :=
    fun i =>
      (contDiff_pi.mp F.electric_contDiff) i

  have hMagnetic :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.magnetic p i) :=
    fun i =>
      (contDiff_pi.mp F.magnetic_contDiff) i

  have hElectricDotExpanded :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          F.electric p (0 : Fin 3) *
              F.electric p (0 : Fin 3) +
            (F.electric p (1 : Fin 3) *
                F.electric p (1 : Fin 3) +
              F.electric p (2 : Fin 3) *
                F.electric p (2 : Fin 3))) :=
    ((hElectric (0 : Fin 3)).mul
        (hElectric (0 : Fin 3))).add
      (((hElectric (1 : Fin 3)).mul
          (hElectric (1 : Fin 3))).add
        ((hElectric (2 : Fin 3)).mul
          (hElectric (2 : Fin 3))))

  have hMagneticDotExpanded :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          F.magnetic p (0 : Fin 3) *
              F.magnetic p (0 : Fin 3) +
            (F.magnetic p (1 : Fin 3) *
                F.magnetic p (1 : Fin 3) +
              F.magnetic p (2 : Fin 3) *
                F.magnetic p (2 : Fin 3))) :=
    ((hMagnetic (0 : Fin 3)).mul
        (hMagnetic (0 : Fin 3))).add
      (((hMagnetic (1 : Fin 3)).mul
          (hMagnetic (1 : Fin 3))).add
        ((hMagnetic (2 : Fin 3)).mul
          (hMagnetic (2 : Fin 3))))

  have hElectricDot :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.electric p)
            (F.electric p)) := by
    simpa [
      maxwellDot3,
      Fin.sum_univ_succ
    ] using hElectricDotExpanded

  have hMagneticDot :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.magnetic p)
            (F.magnetic p)) := by
    simpa [
      maxwellDot3,
      Fin.sum_univ_succ
    ] using hMagneticDotExpanded

  have hElectricScale :
      ContDiff ℝ 1
        (fun _ : MaxwellSpacetime3 =>
          ε₀ / 2) :=
    contDiff_const

  have hMagneticScale :
      ContDiff ℝ 1
        (fun _ : MaxwellSpacetime3 =>
          1 / (2 * μ₀)) :=
    contDiff_const

  have hEnergy :
      ContDiff ℝ 1
        (maxwellEnergyDensity3 ε₀ μ₀ F) := by
    change
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          (ε₀ / 2) *
              maxwellDot3
                (F.electric p)
                (F.electric p) +
            (1 / (2 * μ₀)) *
              maxwellDot3
                (F.magnetic p)
                (F.magnetic p))

    exact
      (hElectricScale.mul hElectricDot).add
        (hMagneticScale.mul hMagneticDot)

  let s : Set ℝ :=
    Set.Icc (t - 1) (t + 1)

  let K : Set MaxwellSpacetime3 :=
    s ×ˢ Set.Icc D.lower D.upper

  have hs :
      s ∈ nhds t := by
    dsimp [s]
    exact
      Icc_mem_nhds
        (by linarith)
        (by linarith)

  have hKCompact :
      IsCompact K := by
    dsimp [K, s]
    exact
      isCompact_Icc.prod
        isCompact_Icc

  have hDerivativeNormContinuous :
      Continuous
        (fun p : MaxwellSpacetime3 =>
          ‖maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              p‖) :=
    (maxwellEnergyDensity3_timeDerivative_continuous
      ε₀
      μ₀
      F).norm

  have hBounded :
      BddAbove
        ((fun p : MaxwellSpacetime3 =>
            ‖maxwellTimeDerivative3
                (maxwellEnergyDensity3 ε₀ μ₀ F)
                p‖) '' K) :=
    hKCompact.bddAbove_image
      hDerivativeNormContinuous.continuousOn

  rcases hBounded with ⟨C, hC⟩

  have hEnergyMeasurable :
      ∀ᶠ τ in nhds t,
        AEStronglyMeasurable
          (fun x : MaxwellVector3 =>
            maxwellEnergyDensity3
              ε₀ μ₀ F (τ, x))
          (volume.restrict
            (Set.Icc D.lower D.upper)) := by
    filter_upwards [] with τ

    have hEmbedding :
        Continuous
          (fun x : MaxwellVector3 =>
            ((τ, x) : MaxwellSpacetime3)) :=
      continuous_const.prodMk
        continuous_id

    exact
      (hEnergy.continuous.comp
        hEmbedding).aestronglyMeasurable

  have hEnergySliceContinuous :
      Continuous
        (fun x : MaxwellVector3 =>
          maxwellEnergyDensity3
            ε₀ μ₀ F (t, x)) := by
    have hEmbedding :
        Continuous
          (fun x : MaxwellVector3 =>
            ((t, x) : MaxwellSpacetime3)) :=
      continuous_const.prodMk
        continuous_id

    exact hEnergy.continuous.comp hEmbedding

  have hEnergyIntegrable :
      Integrable
        (fun x : MaxwellVector3 =>
          maxwellEnergyDensity3
            ε₀ μ₀ F (t, x))
        (volume.restrict
          (Set.Icc D.lower D.upper)) :=
    hEnergySliceContinuous.integrableOn_Icc

  have hDerivativeSliceContinuous :
      Continuous
        (fun x : MaxwellVector3 =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x)) := by
    have hEmbedding :
        Continuous
          (fun x : MaxwellVector3 =>
            ((t, x) : MaxwellSpacetime3)) :=
      continuous_const.prodMk
        continuous_id

    exact
      (maxwellEnergyDensity3_timeDerivative_continuous
        ε₀
        μ₀
        F).comp hEmbedding

  have hTimeDerivativeMeasurable :
      AEStronglyMeasurable
        (fun x : MaxwellVector3 =>
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (t, x))
        (volume.restrict
          (Set.Icc D.lower D.upper)) :=
    hDerivativeSliceContinuous.aestronglyMeasurable

  have hDerivativeBound :
      ∀ᵐ x ∂
        volume.restrict
          (Set.Icc D.lower D.upper),
        ∀ τ ∈ s,
          ‖maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x)‖ ≤
            C := by
    filter_upwards [
      MeasureTheory.ae_restrict_mem
        (measurableSet_Icc :
          MeasurableSet
            (Set.Icc D.lower D.upper))
    ] with x hx

    intro τ hτ

    apply hC

    refine ⟨((τ, x) : MaxwellSpacetime3), ?_, rfl⟩
    exact ⟨hτ, hx⟩

  have hBoundContinuous :
      Continuous
        (fun _ : MaxwellVector3 => C) :=
    continuous_const

  have hBoundIntegrable :
      Integrable
        (fun _ : MaxwellVector3 => C)
        (volume.restrict
          (Set.Icc D.lower D.upper)) :=
    hBoundContinuous.integrableOn_Icc

  have hEnergyDifferentiable :
      Differentiable ℝ
        (maxwellEnergyDensity3 ε₀ μ₀ F) :=
    hEnergy.differentiable
      (by norm_num)

  have hPointwiseDerivative :
      ∀ᵐ x ∂
        volume.restrict
          (Set.Icc D.lower D.upper),
        ∀ τ ∈ s,
          HasDerivAt
            (fun σ =>
              maxwellEnergyDensity3
                ε₀ μ₀ F (σ, x))
            (maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
            τ := by
    filter_upwards [] with x

    intro τ hτ

    have hOuter :
        HasFDerivAt
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (fderiv ℝ
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x))
          (τ, x) :=
      (hEnergyDifferentiable
        (τ, x)).hasFDerivAt

    have hInner :
        HasDerivAt
          (fun σ : ℝ =>
            ((σ, x) : MaxwellSpacetime3))
          maxwellTimeDirection3
          τ := by
      simpa [maxwellTimeDirection3] using
        (hasFDerivAt_prodMk_left
          τ
          x).hasDerivAt

    have hComposition :=
      hOuter.comp_hasDerivAt
        τ
        hInner

    simpa [
      Function.comp_def,
      maxwellTimeDerivative3
    ] using hComposition

  exact
    (maxwellTotalElectromagneticEnergy3_hasDerivAt_of_dominated
      (ε₀ := ε₀)
      (μ₀ := μ₀)
      (F := F)
      (D := D)
      (t := t)
      (s := s)
      (bound := fun _ : MaxwellVector3 => C)
      hs
      hEnergyMeasurable
      hEnergyIntegrable
      hTimeDerivativeMeasurable
      hDerivativeBound
      hBoundIntegrable
      hPointwiseDerivative).2

/-
PROVED := total_electromagnetic_energy_HasDerivAt_from_smoothness
PROVED := local_uniform_domination_derived_from_compactness
PROVED := differentiation_under_rectangular_spatial_integral_fully_derived
BOUNDARY := ¬ boundary_flux_interval_integrability_derived
BOUNDARY := ¬ unconditional_integrated_rectangular_balance_packaged
-/
/--
The electromagnetic work density `J · E` of a smooth Maxwell field is
continuous on spacetime.
-/
theorem maxwellWorkDensity3_continuous
    (F : SmoothMaxwellField3) :
    Continuous
      (fun p : MaxwellSpacetime3 =>
        maxwellDot3
          (F.current p)
          (F.electric p)) := by
  have hCurrent :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.current p i) :=
    fun i =>
      (contDiff_pi.mp F.current_contDiff) i

  have hElectric :
      ∀ i : Fin 3,
        ContDiff ℝ 1
          (fun p : MaxwellSpacetime3 =>
            F.electric p i) :=
    fun i =>
      (contDiff_pi.mp F.electric_contDiff) i

  have hExpanded :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          F.current p (0 : Fin 3) *
              F.electric p (0 : Fin 3) +
            (F.current p (1 : Fin 3) *
                F.electric p (1 : Fin 3) +
              F.current p (2 : Fin 3) *
                F.electric p (2 : Fin 3))) :=
    ((hCurrent (0 : Fin 3)).mul
        (hElectric (0 : Fin 3))).add
      (((hCurrent (1 : Fin 3)).mul
          (hElectric (1 : Fin 3))).add
        ((hCurrent (2 : Fin 3)).mul
          (hElectric (2 : Fin 3))))

  have hWork :
      ContDiff ℝ 1
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.current p)
            (F.electric p)) := by
    simpa [
      maxwellDot3,
      Fin.sum_univ_succ
    ] using hExpanded

  exact hWork.continuous

/--
The rectangular spatial integral of electromagnetic work density is
interval integrable in time.
-/
theorem maxwellSpatiallyIntegratedWork_intervalIntegrable
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ) :
    IntervalIntegrable
      (fun τ =>
        ∫ x in Set.Icc D.lower D.upper,
          maxwellDot3
            (F.current (τ, x))
            (F.electric (τ, x)))
      volume
      t₀
      t₁ := by
  have hCompactTime :
      IsCompact (Set.uIcc t₀ t₁) :=
    isCompact_uIcc

  have hCompactSpace :
      IsCompact (Set.Icc D.lower D.upper) :=
    isCompact_Icc

  have hCompactProduct :
      IsCompact
        (Set.uIcc t₀ t₁ ×ˢ
          Set.Icc D.lower D.upper) :=
    hCompactTime.prod hCompactSpace

  have hSpacetimeIntegrableOn :
      IntegrableOn
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.current p)
            (F.electric p))
        (Set.uIcc t₀ t₁ ×ˢ
          Set.Icc D.lower D.upper)
        (volume : Measure MaxwellSpacetime3) :=
    ContinuousOn.integrableOn_compact
      hCompactProduct
      (maxwellWorkDensity3_continuous
        F).continuousOn

  have hSpacetimeIntegrable :
      Integrable
        (fun p : MaxwellSpacetime3 =>
          maxwellDot3
            (F.current p)
            (F.electric p))
        (((volume : Measure ℝ).restrict
              (Set.uIcc t₀ t₁)).prod
          ((volume : Measure MaxwellVector3).restrict
              (Set.Icc D.lower D.upper))) := by
    rw [Measure.prod_restrict]
    exact hSpacetimeIntegrableOn

  have hIntegratedTime :
      Integrable
        (fun τ =>
          ∫ x,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x))
            ∂((volume : Measure MaxwellVector3).restrict
              (Set.Icc D.lower D.upper)))
        ((volume : Measure ℝ).restrict
          (Set.uIcc t₀ t₁)) :=
    hSpacetimeIntegrable.integral_prod_left

  have hIntegratedOnTimeInterval :
      IntegrableOn
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x)))
        (Set.uIcc t₀ t₁)
        volume := by
    simpa only [IntegrableOn] using hIntegratedTime

  exact hIntegratedOnTimeInterval.intervalIntegrable

/-
PROVED := electromagnetic_work_density_continuous
PROVED := spatially_integrated_electromagnetic_work_interval_integrable
BOUNDARY := ¬ boundary_flux_interval_integrability_derived
BOUNDARY := ¬ unconditional_integrated_rectangular_balance_packaged
-/
/--
For a smooth Maxwell field satisfying the uncontracted Maxwell
evolution equations, the rectangular Poynting boundary flux is
interval integrable in time.

The proof rewrites the flux using the fixed-time energy balance and
the already established time integrability of the spatial energy
derivative and electromagnetic work.
-/
theorem maxwellRectangularBoundaryFlux3_intervalIntegrable_of_smooth_evolution
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x)) :
    IntervalIntegrable
      (fun τ =>
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ))
      volume
      t₀
      t₁ := by
  have hEnergyDerivative :
      IntervalIntegrable
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))
        volume
        t₀
        t₁ :=
    maxwellSpatiallyIntegratedEnergyDerivative_intervalIntegrable
      ε₀
      μ₀
      F
      D
      t₀
      t₁

  have hWork :
      IntervalIntegrable
        (fun τ =>
          ∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x)))
        volume
        t₀
        t₁ :=
    maxwellSpatiallyIntegratedWork_intervalIntegrable
      F
      D
      t₀
      t₁

  have hFluxIdentity :
      (fun τ =>
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
      (fun τ =>
        -(∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x))) -
          (∫ x in Set.Icc D.lower D.upper,
            maxwellTimeDerivative3
              (maxwellEnergyDensity3 ε₀ μ₀ F)
              (τ, x))) := by
    funext τ

    have hBalance :=
      maxwellFixedTimeRectangularPoyntingBalance3_of_smooth_evolution
        ε₀
        μ₀
        F
        τ
        D
        (hEvolution τ)

    linarith

  rw [hFluxIdentity]

  exact hWork.neg.sub hEnergyDerivative

/-
PROVED := rectangular_boundary_flux_interval_integrable
PROVED := boundary_flux_integrability_derived_from_fixed_time_balance
BOUNDARY := ¬ unconditional_integrated_rectangular_balance_packaged
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
The fixed-time rectangular Poynting balances assembled as a theorem
family indexed by time.
-/
theorem maxwellFixedTimeRectangularPoyntingBalance3_family_of_smooth_evolution
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x)) :
    ∀ τ : ℝ,
      (∫ x in Set.Icc D.lower D.upper,
          maxwellTimeDerivative3
            (maxwellEnergyDensity3 ε₀ μ₀ F)
            (τ, x)) +
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
      -(∫ x in Set.Icc D.lower D.upper,
          maxwellDot3
            (F.current (τ, x))
            (F.electric (τ, x))) := by
  intro τ

  exact
    maxwellFixedTimeRectangularPoyntingBalance3_of_smooth_evolution
      ε₀
      μ₀
      F
      τ
      D
      (hEvolution τ)

/-
PROVED := fixed_time_rectangular_balance_family_from_smooth_Maxwell_evolution
BOUNDARY := ¬ smooth_integrated_rectangular_balance_packaged
-/
/--
The integrated rectangular Poynting balance for a smooth Maxwell
field satisfying the uncontracted Maxwell evolution equations at
every spacetime point.

All analytic differentiation and integrability premises are supplied
by the previously derived smooth-field theorems.
-/
theorem maxwellIntegratedRectangularPoyntingBalance3_of_smooth_evolution
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x)) :
    maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₁ -
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₀ +
        (∫ τ in t₀..t₁,
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
      -(∫ τ in t₀..t₁,
          ∫ x in Set.Icc D.lower D.upper,
            maxwellDot3
              (F.current (τ, x))
              (F.electric (τ, x))) := by
  exact
    maxwellIntegratedRectangularPoyntingBalance3
      (ε₀ := ε₀)
      (μ₀ := μ₀)
      (F := F)
      (D := D)
      (t₀ := t₀)
      (t₁ := t₁)
      (hDerivative :=
        fun τ _ =>
          maxwellTotalElectromagneticEnergy3_hasDerivAt_of_smooth
            ε₀
            μ₀
            F
            D
            τ)
      (hDerivativeIntervalIntegrable :=
        maxwellSpatiallyIntegratedEnergyDerivative_intervalIntegrable
          ε₀
          μ₀
          F
          D
          t₀
          t₁)
      (hFluxIntervalIntegrable :=
        maxwellRectangularBoundaryFlux3_intervalIntegrable_of_smooth_evolution
          ε₀
          μ₀
          F
          D
          t₀
          t₁
          hEvolution)
      (hFixedTimeBalance :=
        maxwellFixedTimeRectangularPoyntingBalance3_family_of_smooth_evolution
          ε₀
          μ₀
          F
          D
          hEvolution)

/-
PROVED := integrated_rectangular_Poynting_balance_from_smooth_Maxwell_evolution
PROVED := total_energy_differentiation_instantiated
PROVED := energy_derivative_interval_integrability_instantiated
PROVED := boundary_flux_interval_integrability_instantiated
PROVED := fixed_time_balance_family_instantiated
BOUNDARY := ¬ uncontracted_Maxwell_evolution_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth source-free Maxwell field, the change in stored
electromagnetic energy plus the time-integrated outward rectangular
boundary flux is zero.
-/
theorem maxwellIntegratedRectangularPoyntingBalance3_sourceFree_of_smooth_evolution
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0) :
    maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₁ -
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₀ +
        (∫ τ in t₀..t₁,
          maxwellRectangularBoundaryFlux3
            D
            (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
      0 := by
  have hBalance :=
    maxwellIntegratedRectangularPoyntingBalance3_of_smooth_evolution
      ε₀
      μ₀
      F
      D
      t₀
      t₁
      hEvolution

  simpa [
    hCurrentZero,
    maxwellDot3
  ] using hBalance

/-
PROVED := source_free_integrated_rectangular_Poynting_balance
PROVED := stored_energy_change_plus_boundary_flux_equals_zero
BOUNDARY := ¬ zero_boundary_flux_assumed
BOUNDARY := ¬ total_electromagnetic_energy_time_invariance_without_isolation
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
A smooth source-free Maxwell field has exactly conserved total
electromagnetic energy between two times whenever its time-integrated
outward boundary flux vanishes.
-/
theorem maxwellTotalElectromagneticEnergy3_conserved_of_sourceFree_zeroIntegratedFlux
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0)
    (hIntegratedFluxZero :
      (∫ τ in t₀..t₁,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
        0) :
    maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₁ =
      maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₀ := by
  have hBalance :=
    maxwellIntegratedRectangularPoyntingBalance3_sourceFree_of_smooth_evolution
      ε₀
      μ₀
      F
      D
      t₀
      t₁
      hEvolution
      hCurrentZero

  rw [hIntegratedFluxZero] at hBalance
  linarith

/-
PROVED := source_free_zero_integrated_flux_total_energy_conservation
PROVED := total_electromagnetic_energy_equal_at_interval_endpoints
BOUNDARY := ¬ pointwise_zero_boundary_flux_derived
BOUNDARY := ¬ isolation_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
A smooth source-free Maxwell field has exactly conserved total
electromagnetic energy between any two times whenever its outward
rectangular boundary flux vanishes pointwise in time.
-/
theorem maxwellTotalElectromagneticEnergy3_conserved_of_sourceFree_zeroBoundaryFlux
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t₀ t₁ : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0)
    (hBoundaryFluxZero :
      ∀ τ : ℝ,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
        0) :
    maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₁ =
      maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D t₀ := by
  have hIntegratedFluxZero :
      (∫ τ in t₀..t₁,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ)) =
        0 := by
    simp [hBoundaryFluxZero]

  exact
    maxwellTotalElectromagneticEnergy3_conserved_of_sourceFree_zeroIntegratedFlux
      ε₀
      μ₀
      F
      D
      t₀
      t₁
      hEvolution
      hCurrentZero
      hIntegratedFluxZero

/-
PROVED := pointwise_zero_boundary_flux_implies_zero_integrated_flux
PROVED := source_free_pointwise_isolated_total_energy_conservation
PROVED := total_electromagnetic_energy_equal_at_arbitrary_endpoint_times
BOUNDARY := ¬ pointwise_zero_boundary_flux_derived_without_assumption
BOUNDARY := ¬ isolation_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth source-free Maxwell field with pointwise zero outward
rectangular boundary flux, total electromagnetic energy has the same
value at every pair of times.
-/
theorem maxwellTotalElectromagneticEnergy3_constant_of_sourceFree_zeroBoundaryFlux
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0)
    (hBoundaryFluxZero :
      ∀ τ : ℝ,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
        0) :
    ∀ t₀ t₁ : ℝ,
      maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₀ =
        maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D t₁ := by
  intro t₀ t₁

  exact
    (maxwellTotalElectromagneticEnergy3_conserved_of_sourceFree_zeroBoundaryFlux
      ε₀
      μ₀
      F
      D
      t₀
      t₁
      hEvolution
      hCurrentZero
      hBoundaryFluxZero).symm

/-
PROVED := total_electromagnetic_energy_pairwise_constant
PROVED := arbitrary_time_pair_energy_equality_packaged
BOUNDARY := ¬ pointwise_zero_boundary_flux_derived_without_assumption
BOUNDARY := ¬ isolation_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth source-free Maxwell field with pointwise zero outward
rectangular boundary flux, total electromagnetic energy has derivative
zero at every time.
-/
theorem maxwellTotalElectromagneticEnergy3_hasDerivAt_zero_of_sourceFree_zeroBoundaryFlux
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0)
    (hBoundaryFluxZero :
      ∀ τ : ℝ,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
        0) :
    HasDerivAt
      (maxwellTotalElectromagneticEnergy3
        ε₀ μ₀ F D)
      0
      t := by
  have hIntegratedEnergyDerivativeZero :
      (∫ x in Set.Icc D.lower D.upper,
        maxwellTimeDerivative3
          (maxwellEnergyDensity3 ε₀ μ₀ F)
          (t, x)) =
        0 := by
    have hBalance :=
      maxwellFixedTimeRectangularPoyntingBalance3_of_smooth_evolution
        ε₀
        μ₀
        F
        t
        D
        (hEvolution t)

    simpa [
      hCurrentZero,
      hBoundaryFluxZero,
      maxwellDot3
    ] using hBalance

  have hDerivative :=
    maxwellTotalElectromagneticEnergy3_hasDerivAt_of_smooth
      ε₀
      μ₀
      F
      D
      t

  simpa [hIntegratedEnergyDerivativeZero] using hDerivative

/-
PROVED := isolated_source_free_total_energy_derivative_is_zero
PROVED := integrated_energy_density_time_derivative_is_zero
PROVED := local_differential_energy_conservation
BOUNDARY := ¬ pointwise_zero_boundary_flux_derived_without_assumption
BOUNDARY := ¬ isolation_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
/--
For a smooth source-free Maxwell field with pointwise zero outward
rectangular boundary flux, the derivative of total electromagnetic
energy is zero at every time.
-/
theorem maxwellTotalElectromagneticEnergy3_deriv_eq_zero_of_sourceFree_zeroBoundaryFlux
    (ε₀ μ₀ : ℝ)
    (F : SmoothMaxwellField3)
    (D : MaxwellRectangularDomain3)
    (t : ℝ)
    (hEvolution :
      ∀ τ x,
        UncontractedMaxwellEvolutionAt3
          ε₀ μ₀ F (τ, x))
    (hCurrentZero :
      ∀ p : MaxwellSpacetime3,
        F.current p = 0)
    (hBoundaryFluxZero :
      ∀ τ : ℝ,
        maxwellRectangularBoundaryFlux3
          D
          (maxwellPoyntingSpatialSlice3 μ₀ F τ) =
        0) :
    deriv
        (maxwellTotalElectromagneticEnergy3
          ε₀ μ₀ F D)
        t =
      0 := by
  exact
    (maxwellTotalElectromagneticEnergy3_hasDerivAt_zero_of_sourceFree_zeroBoundaryFlux
      ε₀
      μ₀
      F
      D
      t
      hEvolution
      hCurrentZero
      hBoundaryFluxZero).deriv

/-
PROVED := isolated_source_free_total_energy_deriv_equals_zero
PROVED := local_differential_energy_conservation_in_deriv_form
BOUNDARY := ¬ pointwise_zero_boundary_flux_derived_without_assumption
BOUNDARY := ¬ isolation_derived_without_assumption
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/
end Chronos.Frontier
