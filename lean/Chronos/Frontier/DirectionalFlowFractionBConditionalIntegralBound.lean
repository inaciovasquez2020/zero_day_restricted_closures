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
BOUNDARY := ¬ field_level_Maxwell_differential_operators_formalized
BOUNDARY := ¬ divergence_theorem_instantiated_for_the_electromagnetic_domain
BOUNDARY := ¬ time_FTC_instantiated_for_total_electromagnetic_energy
BOUNDARY := ¬ external_measurement_receipt_present
BOUNDARY := ¬ universal_physical_law_E_eq_mc3
-/

end Chronos.Frontier
