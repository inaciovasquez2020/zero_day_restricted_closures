import intended_hidden_sector_static_curl_solution

universe u

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

/--
The electromagnetic energy density of the explicit static-curl field has
zero time derivative at every spacetime point.
-/
theorem hiddenSectorStaticCurl_energyDensity_timeDerivative_zero
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (position : MaxwellVector3) :
    maxwellTimeDerivative3
        (maxwellEnergyDensity3
          ε₀
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain))
        (time, position) =
      0 := by
  let field :=
    hiddenSectorStaticCurlField
      A
      μ₀
      domain

  have hElectric :
      ∀ component : Fin 3,
        DifferentiableAt ℝ
          (fun point =>
            field.electric point component)
          (time, position) := by
    intro component

    exact
      (((contDiff_pi.mp
          field.electric_contDiff)
          component).differentiable
        (by norm_num))
        (time, position)

  have hMagnetic :
      ∀ component : Fin 3,
        DifferentiableAt ℝ
          (fun point =>
            field.magnetic point component)
          (time, position) := by
    intro component

    exact
      (((contDiff_pi.mp
          field.magnetic_contDiff)
          component).differentiable
        (by norm_num))
        (time, position)

  have hFormula :=
    maxwellEnergyDensity3_timeDerivative
      ε₀
      μ₀
      field
      (time, position)
      (hElectric (0 : Fin 3))
      (hElectric (1 : Fin 3))
      (hElectric (2 : Fin 3))
      (hMagnetic (0 : Fin 3))
      (hMagnetic (1 : Fin 3))
      (hMagnetic (2 : Fin 3))

  have hElectricDerivative :
      maxwellTimeDerivative3
          field.electric
          (time, position) =
        0 := by
    dsimp [field, hiddenSectorStaticCurlField]

    exact
      hiddenSectorStaticElectric_timeDerivative
        (time, position)

  have hMagneticDerivative :
      maxwellTimeDerivative3
          field.magnetic
          (time, position) =
        0 := by
    dsimp [field, hiddenSectorStaticCurlField]

    exact
      hiddenSectorStaticCurlMagnetic_timeDerivative
        (μ₀ * A /
          hiddenSectorRectangularVolume domain)
        (time, position)

  rw [
    hElectricDerivative,
    hMagneticDerivative
  ] at hFormula

  simpa [maxwellDot3] using hFormula

/--
The spatial integral of the electromagnetic energy-density time derivative
also vanishes.
-/
theorem hiddenSectorStaticCurl_integratedEnergyDerivative_zero
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    (∫ position in Set.Icc domain.lower domain.upper,
      maxwellTimeDerivative3
        (maxwellEnergyDensity3
          ε₀
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain))
        (time, position)) =
      0 := by
  have hPointwise :
      (fun position : MaxwellVector3 =>
        maxwellTimeDerivative3
          (maxwellEnergyDensity3
            ε₀
            μ₀
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain))
          (time, position)) =
        fun _position : MaxwellVector3 =>
          0 := by
    funext position

    exact
      hiddenSectorStaticCurl_energyDensity_timeDerivative_zero
        A
        ε₀
        μ₀
        domain
        time
        position

  rw [hPointwise]
  simp

/--
At every time, the exact rectangular outward Poynting flux of the constructed
static-curl field equals the supplied closure amplitude.
-/
theorem hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time) =
      A := by
  have hBalance :=
    maxwellFixedTimeRectangularPoyntingBalance3_of_smooth_evolution
      ε₀
      μ₀
      (hiddenSectorStaticCurlField
        A
        μ₀
        domain)
      time
      domain
      (fun position =>
        hiddenSectorStaticCurl_evolution
          A
          ε₀
          μ₀
          domain
          hμ₀
          hVolume
          time
          position)

  have hEnergyDerivative :=
    hiddenSectorStaticCurl_integratedEnergyDerivative_zero
      A
      ε₀
      μ₀
      domain
      time

  have hPower :
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
        -A := by
    simpa [hiddenSectorMaxwellPower] using
      hiddenSectorStaticCurl_power
        A
        μ₀
        domain
        hVolume
        time

  rw [
    hEnergyDerivative,
    zero_add,
    hPower
  ] at hBalance

  simpa using hBalance

/--
Over normalized time `[0,1]`, the integrated outward boundary flux equals the
closure amplitude exactly.
-/
theorem hiddenSectorStaticCurl_integratedBoundaryFlux_eq_amplitude
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    (∫ time in (0 : ℝ)..1,
      maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time)) =
      A := by
  calc
    (∫ time in (0 : ℝ)..1,
      maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time)) =
        ∫ _time in (0 : ℝ)..1, A := by
          apply intervalIntegral.integral_congr
          intro time _

          exact
            hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
              A
              ε₀
              μ₀
              domain
              hμ₀
              hVolume
              time

    _ = A := by
      simp

/--
The rank-255 unit-coupling closure amplitude, cast into the reals, is exactly
`2^255`.
-/
theorem darkMatterUnitCoupling_closureAmplitude_real_exact :
    (darkMatterClosureAmplitude
        1
        1
        darkMatterExplosionInitialState : ℝ) =
      ((2 ^ 255 : Nat) : ℝ) := by
  exact_mod_cast darkMatterUnitCoupling_exact_explosion

/--
For rank-255 unit coupling, the outward boundary flux equals `2^255` at every
time.
-/
theorem darkMatterUnitCoupling_staticCurl_boundaryFlux_pointwise_exact
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
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              1
              1
              darkMatterExplosionInitialState : ℝ)
            μ₀
            domain)
          time) =
      ((2 ^ 255 : Nat) : ℝ) := by
  calc
    maxwellRectangularBoundaryFlux3
          domain
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorStaticCurlField
              (darkMatterClosureAmplitude
                1
                1
                darkMatterExplosionInitialState : ℝ)
              μ₀
              domain)
            time) =
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) :=
      hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ)
        ε₀
        μ₀
        domain
        hμ₀
        hVolume
        time

    _ = ((2 ^ 255 : Nat) : ℝ) :=
      darkMatterUnitCoupling_closureAmplitude_real_exact

/--
For rank-255 unit coupling, the normalized-time integrated outward boundary
flux also equals `2^255`.
-/
theorem darkMatterUnitCoupling_staticCurl_integratedBoundaryFlux_exact
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0) :
    (∫ time in (0 : ℝ)..1,
      maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              1
              1
              darkMatterExplosionInitialState : ℝ)
            μ₀
            domain)
          time)) =
      ((2 ^ 255 : Nat) : ℝ) := by
  calc
    (∫ time in (0 : ℝ)..1,
      maxwellRectangularBoundaryFlux3
        domain
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              1
              1
              darkMatterExplosionInitialState : ℝ)
            μ₀
            domain)
          time)) =
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) :=
      hiddenSectorStaticCurl_integratedBoundaryFlux_eq_amplitude
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ)
        ε₀
        μ₀
        domain
        hμ₀
        hVolume

    _ = ((2 ^ 255 : Nat) : ℝ) :=
      darkMatterUnitCoupling_closureAmplitude_real_exact

/--
The constructed rank-255 unit-coupling field is pointwise non-isolated at
every time.
-/
theorem darkMatterUnitCoupling_staticCurl_boundaryFlux_ne_zero
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
          (hiddenSectorStaticCurlField
            (darkMatterClosureAmplitude
              1
              1
              darkMatterExplosionInitialState : ℝ)
            μ₀
            domain)
          time) ≠
      0 := by
  have hExact :=
    darkMatterUnitCoupling_staticCurl_boundaryFlux_pointwise_exact
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  intro hZero

  have hPowerZero :
      ((2 ^ 255 : Nat) : ℝ) =
        0 := by
    calc
      ((2 ^ 255 : Nat) : ℝ) =
          maxwellRectangularBoundaryFlux3
            domain
            (maxwellPoyntingSpatialSlice3
              μ₀
              (hiddenSectorStaticCurlField
                (darkMatterClosureAmplitude
                  1
                  1
                  darkMatterExplosionInitialState : ℝ)
                μ₀
                domain)
              time) :=
        hExact.symm

      _ = 0 :=
        hZero

  have hPositive :
      (0 : ℝ) <
        ((2 ^ 255 : Nat) : ℝ) := by
    positivity

  exact ne_of_gt hPositive hPowerZero

end ZeroDayRestrictedClosures
