import intended_hidden_sector_static_curl_boundary_flux

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

noncomputable def hiddenSectorStaticCurlUpperFaceFlux
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (i : Fin 3) :
    ℝ :=
  ∫ y in
      Set.Icc
        (domain.lower ∘ Fin.succAbove i)
        (domain.upper ∘ Fin.succAbove i),
    maxwellDot3
      (maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        (Fin.insertNth i (domain.upper i) y))
      (maxwellRectangularFaceOutwardNormal3
        (i, true))

noncomputable def hiddenSectorStaticCurlLowerFaceFlux
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (i : Fin 3) :
    ℝ :=
  ∫ y in
      Set.Icc
        (domain.lower ∘ Fin.succAbove i)
        (domain.upper ∘ Fin.succAbove i),
    maxwellDot3
      (maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        (Fin.insertNth i (domain.lower i) y))
      (maxwellRectangularFaceOutwardNormal3
        (i, false))

theorem hiddenSectorStaticCurlUpperFaceFlux_eq_coordinateIntegral
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (i : Fin 3) :
    hiddenSectorStaticCurlUpperFaceFlux
        A
        μ₀
        domain
        time
        i =
      ∫ y in
          Set.Icc
            (domain.lower ∘ Fin.succAbove i)
            (domain.upper ∘ Fin.succAbove i),
        maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth i (domain.upper i) y)
          i := by
  unfold hiddenSectorStaticCurlUpperFaceFlux

  apply integral_congr_ae
  filter_upwards with y

  exact
    maxwellDot3_rectangularUpperFaceOutwardNormal3
      (maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        (Fin.insertNth i (domain.upper i) y))
      i

theorem hiddenSectorStaticCurlLowerFaceFlux_eq_neg_coordinateIntegral
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (i : Fin 3) :
    hiddenSectorStaticCurlLowerFaceFlux
        A
        μ₀
        domain
        time
        i =
      -∫ y in
          Set.Icc
            (domain.lower ∘ Fin.succAbove i)
            (domain.upper ∘ Fin.succAbove i),
        maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth i (domain.lower i) y)
          i := by
  unfold hiddenSectorStaticCurlLowerFaceFlux

  calc
    (∫ y in
        Set.Icc
          (domain.lower ∘ Fin.succAbove i)
          (domain.upper ∘ Fin.succAbove i),
      maxwellDot3
        (maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth i (domain.lower i) y))
        (maxwellRectangularFaceOutwardNormal3
          (i, false))) =
      ∫ y in
          Set.Icc
            (domain.lower ∘ Fin.succAbove i)
            (domain.upper ∘ Fin.succAbove i),
        -maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth i (domain.lower i) y)
          i := by
            apply integral_congr_ae
            filter_upwards with y

            exact
              maxwellDot3_rectangularLowerFaceOutwardNormal3
                (maxwellPoyntingSpatialSlice3
                  μ₀
                  (hiddenSectorStaticCurlField
                    A
                    μ₀
                    domain)
                  time
                  (Fin.insertNth i (domain.lower i) y))
                i

    _ =
      -∫ y in
          Set.Icc
            (domain.lower ∘ Fin.succAbove i)
            (domain.upper ∘ Fin.succAbove i),
        maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth i (domain.lower i) y)
          i := by
            rw [integral_neg]

theorem hiddenSectorStaticCurl_boundaryFlux_eq_sixFaceSum
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
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
      ∑ i : Fin 3,
        (hiddenSectorStaticCurlUpperFaceFlux
            A
            μ₀
            domain
            time
            i +
          hiddenSectorStaticCurlLowerFaceFlux
            A
            μ₀
            domain
            time
            i) := by
  rw [
    maxwellRectangularBoundaryFlux3_signedSixFaceExpansion
  ]

  apply Finset.sum_congr rfl
  intro i _

  rw [
    hiddenSectorStaticCurlUpperFaceFlux_eq_coordinateIntegral,
    hiddenSectorStaticCurlLowerFaceFlux_eq_neg_coordinateIntegral
  ]

  ring

theorem hiddenSectorStaticCurlMagnetic_coordinateOne_zero
    (k : ℝ)
    (point : MaxwellSpacetime3) :
    hiddenSectorStaticCurlMagnetic
        k
        point
        (1 : Fin 3) =
      0 := by
  simp [
    hiddenSectorStaticCurlMagnetic,
    hiddenSectorStaticCurlMagneticCLM,
    hiddenSectorStaticCurlMagneticComponentCLM
  ]

theorem hiddenSectorStaticCurl_poynting_coordinateZero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (position : MaxwellVector3) :
    maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        position
        (0 : Fin 3) =
      0 := by
  change
    (1 / μ₀) *
        maxwellCross3
          hiddenSectorAxis0
          (hiddenSectorStaticCurlMagnetic
            (μ₀ * A /
              hiddenSectorRectangularVolume domain)
            (time, position))
          (0 : Fin 3) =
      0

  rw [
    (maxwellCross3_coordinate_expansion
      hiddenSectorAxis0
      (hiddenSectorStaticCurlMagnetic
        (μ₀ * A /
          hiddenSectorRectangularVolume domain)
        (time, position))).1
  ]

  simp [hiddenSectorAxis0]

theorem hiddenSectorStaticCurl_poynting_coordinateTwo
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ)
    (position : MaxwellVector3) :
    maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        position
        (2 : Fin 3) =
      0 := by
  change
    (1 / μ₀) *
        maxwellCross3
          hiddenSectorAxis0
          (hiddenSectorStaticCurlMagnetic
            (μ₀ * A /
              hiddenSectorRectangularVolume domain)
            (time, position))
          (2 : Fin 3) =
      0

  rw [
    (maxwellCross3_coordinate_expansion
      hiddenSectorAxis0
      (hiddenSectorStaticCurlMagnetic
        (μ₀ * A /
          hiddenSectorRectangularVolume domain)
        (time, position))).2.2
  ]

  rw [
    hiddenSectorStaticCurlMagnetic_coordinateOne_zero
  ]

  simp [hiddenSectorAxis0]

theorem hiddenSectorStaticCurl_upperFaceZero_flux_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
        A
        μ₀
        domain
        time
        (0 : Fin 3) =
      0 := by
  unfold hiddenSectorStaticCurlUpperFaceFlux

  have hIntegrand :
      (fun y : Fin 2 → ℝ =>
        maxwellDot3
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain)
            time
            (Fin.insertNth
              (0 : Fin 3)
              (domain.upper (0 : Fin 3))
              y))
          (maxwellRectangularFaceOutwardNormal3
            ((0 : Fin 3), true))) =
        fun _y : Fin 2 → ℝ =>
          0 := by
    funext y

    rw [
      maxwellDot3_rectangularUpperFaceOutwardNormal3
    ]

    exact
      hiddenSectorStaticCurl_poynting_coordinateZero
        A
        μ₀
        domain
        time
        (Fin.insertNth
          (0 : Fin 3)
          (domain.upper (0 : Fin 3))
          y)

  rw [hIntegrand]
  simp

theorem hiddenSectorStaticCurl_lowerFaceZero_flux_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A
        μ₀
        domain
        time
        (0 : Fin 3) =
      0 := by
  unfold hiddenSectorStaticCurlLowerFaceFlux

  have hIntegrand :
      (fun y : Fin 2 → ℝ =>
        maxwellDot3
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain)
            time
            (Fin.insertNth
              (0 : Fin 3)
              (domain.lower (0 : Fin 3))
              y))
          (maxwellRectangularFaceOutwardNormal3
            ((0 : Fin 3), false))) =
        fun _y : Fin 2 → ℝ =>
          0 := by
    funext y

    rw [
      maxwellDot3_rectangularLowerFaceOutwardNormal3
    ]

    rw [
      hiddenSectorStaticCurl_poynting_coordinateZero
    ]

    simp

  rw [hIntegrand]
  simp

theorem hiddenSectorStaticCurl_upperFaceTwo_flux_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
        A
        μ₀
        domain
        time
        (2 : Fin 3) =
      0 := by
  unfold hiddenSectorStaticCurlUpperFaceFlux

  have hIntegrand :
      (fun y : Fin 2 → ℝ =>
        maxwellDot3
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain)
            time
            (Fin.insertNth
              (2 : Fin 3)
              (domain.upper (2 : Fin 3))
              y))
          (maxwellRectangularFaceOutwardNormal3
            ((2 : Fin 3), true))) =
        fun _y : Fin 2 → ℝ =>
          0 := by
    funext y

    rw [
      maxwellDot3_rectangularUpperFaceOutwardNormal3
    ]

    exact
      hiddenSectorStaticCurl_poynting_coordinateTwo
        A
        μ₀
        domain
        time
        (Fin.insertNth
          (2 : Fin 3)
          (domain.upper (2 : Fin 3))
          y)

  rw [hIntegrand]
  simp

theorem hiddenSectorStaticCurl_lowerFaceTwo_flux_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A
        μ₀
        domain
        time
        (2 : Fin 3) =
      0 := by
  unfold hiddenSectorStaticCurlLowerFaceFlux

  have hIntegrand :
      (fun y : Fin 2 → ℝ =>
        maxwellDot3
          (maxwellPoyntingSpatialSlice3
            μ₀
            (hiddenSectorStaticCurlField
              A
              μ₀
              domain)
            time
            (Fin.insertNth
              (2 : Fin 3)
              (domain.lower (2 : Fin 3))
              y))
          (maxwellRectangularFaceOutwardNormal3
            ((2 : Fin 3), false))) =
        fun _y : Fin 2 → ℝ =>
          0 := by
    funext y

    rw [
      maxwellDot3_rectangularLowerFaceOutwardNormal3
    ]

    rw [
      hiddenSectorStaticCurl_poynting_coordinateTwo
    ]

    simp

  rw [hIntegrand]
  simp

theorem hiddenSectorStaticCurl_fourTransverseFaces_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (0 : Fin 3) =
        0 ∧
      hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (0 : Fin 3) =
        0 ∧
      hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (2 : Fin 3) =
        0 ∧
      hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (2 : Fin 3) =
        0 := by
  exact
    ⟨hiddenSectorStaticCurl_upperFaceZero_flux_zero
        A μ₀ domain time,
      hiddenSectorStaticCurl_lowerFaceZero_flux_zero
        A μ₀ domain time,
      hiddenSectorStaticCurl_upperFaceTwo_flux_zero
        A μ₀ domain time,
      hiddenSectorStaticCurl_lowerFaceTwo_flux_zero
        A μ₀ domain time⟩

theorem hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          A
          μ₀
          domain
          time
          (1 : Fin 3) +
        hiddenSectorStaticCurlLowerFaceFlux
          A
          μ₀
          domain
          time
          (1 : Fin 3) =
      A := by
  have hTotal :=
    hiddenSectorStaticCurl_boundaryFlux_eq_amplitude
      A
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  rw [
    hiddenSectorStaticCurl_boundaryFlux_eq_sixFaceSum
  ] at hTotal

  let facePair : Fin 3 → ℝ :=
    fun i =>
      hiddenSectorStaticCurlUpperFaceFlux
          A
          μ₀
          domain
          time
          i +
        hiddenSectorStaticCurlLowerFaceFlux
          A
          μ₀
          domain
          time
          i

  have hTotal' :
      (∑ i : Fin 3, facePair i) =
        A := by
    simpa [facePair] using hTotal

  have hExpanded :
      (∑ i : Fin 3, facePair i) =
        facePair (0 : Fin 3) +
          facePair (1 : Fin 3) +
          facePair (2 : Fin 3) := by
    simpa [Fin.sum_univ_succ, add_assoc]

  rw [hExpanded] at hTotal'

  have hPairZero :
      facePair (0 : Fin 3) =
        0 := by
    dsimp [facePair]

    rw [
      hiddenSectorStaticCurl_upperFaceZero_flux_zero,
      hiddenSectorStaticCurl_lowerFaceZero_flux_zero
    ]

    ring

  have hPairTwo :
      facePair (2 : Fin 3) =
        0 := by
    dsimp [facePair]

    rw [
      hiddenSectorStaticCurl_upperFaceTwo_flux_zero,
      hiddenSectorStaticCurl_lowerFaceTwo_flux_zero
    ]

    ring

  rw [hPairZero, hPairTwo] at hTotal'

  simpa [facePair] using hTotal'

theorem darkMatterUnitCoupling_staticCurl_axisOneFaces_exact
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) +
        hiddenSectorStaticCurlLowerFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) =
      ((2 ^ 255 : Nat) : ℝ) := by
  calc
    hiddenSectorStaticCurlUpperFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) +
        hiddenSectorStaticCurlLowerFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) =
        (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) :=
      hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
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

theorem darkMatterUnitCoupling_staticCurl_axisOneFaces_ne_zero
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) +
        hiddenSectorStaticCurlLowerFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) ≠
      0 := by
  have hExact :=
    darkMatterUnitCoupling_staticCurl_axisOneFaces_exact
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
          hiddenSectorStaticCurlUpperFaceFlux
              (darkMatterClosureAmplitude
                1
                1
                darkMatterExplosionInitialState : ℝ)
              μ₀
              domain
              time
              (1 : Fin 3) +
            hiddenSectorStaticCurlLowerFaceFlux
              (darkMatterClosureAmplitude
                1
                1
                darkMatterExplosionInitialState : ℝ)
              μ₀
              domain
              time
              (1 : Fin 3) :=
        hExact.symm

      _ = 0 :=
        hZero

  have hPositive :
      (0 : ℝ) <
        ((2 ^ 255 : Nat) : ℝ) := by
    positivity

  exact ne_of_gt hPositive hPowerZero

end ZeroDayRestrictedClosures
