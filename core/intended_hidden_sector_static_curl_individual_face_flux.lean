import intended_hidden_sector_static_curl_face_flux

namespace ZeroDayRestrictedClosures

open MeasureTheory Set
open Chronos.Frontier

noncomputable def hiddenSectorStaticCurlAxisOneFaceArea
    (domain : MaxwellRectangularDomain3) :
    ℝ :=
  ∫ _y in
      Set.Icc
        (domain.lower ∘
          Fin.succAbove (1 : Fin 3))
        (domain.upper ∘
          Fin.succAbove (1 : Fin 3)),
    (1 : ℝ)

theorem hiddenSectorStaticCurlMagnetic_coordinateTwo_exact
    (k : ℝ)
    (point : MaxwellSpacetime3) :
    hiddenSectorStaticCurlMagnetic
        k
        point
        (2 : Fin 3) =
      -k * point.2 (1 : Fin 3) := by
  simp [
    hiddenSectorStaticCurlMagnetic,
    hiddenSectorStaticCurlMagneticCLM,
    hiddenSectorStaticCurlMagneticComponentCLM,
    hiddenSectorSpatialCoordinateCLM,
    smul_eq_mul
  ]

theorem hiddenSectorStaticCurl_poynting_coordinateOne_exact
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
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
        (1 : Fin 3) =
      (A / hiddenSectorRectangularVolume domain) *
        position (1 : Fin 3) := by
  change
    (1 / μ₀) *
        maxwellCross3
          hiddenSectorAxis0
          (hiddenSectorStaticCurlMagnetic
            (μ₀ * A /
              hiddenSectorRectangularVolume domain)
            (time, position))
          (1 : Fin 3) =
      (A / hiddenSectorRectangularVolume domain) *
        position (1 : Fin 3)

  rw [
    (maxwellCross3_coordinate_expansion
      hiddenSectorAxis0
      (hiddenSectorStaticCurlMagnetic
        (μ₀ * A /
          hiddenSectorRectangularVolume domain)
        (time, position))).2.1
  ]

  rw [
    hiddenSectorStaticCurlMagnetic_coordinateTwo_exact
  ]

  simp [hiddenSectorAxis0]
  field_simp [ne_of_gt hμ₀, hVolume]

theorem hiddenSectorStaticCurl_upperFaceOne_flux_exact
    (A μ₀ : ℝ)
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
        (1 : Fin 3) =
      (A / hiddenSectorRectangularVolume domain) *
        domain.upper (1 : Fin 3) *
        hiddenSectorStaticCurlAxisOneFaceArea domain := by
  rw [
    hiddenSectorStaticCurlUpperFaceFlux_eq_coordinateIntegral
  ]

  calc
    (∫ y in
        Set.Icc
          (domain.lower ∘
            Fin.succAbove (1 : Fin 3))
          (domain.upper ∘
            Fin.succAbove (1 : Fin 3)),
      maxwellPoyntingSpatialSlice3
        μ₀
        (hiddenSectorStaticCurlField
          A
          μ₀
          domain)
        time
        (Fin.insertNth
          (1 : Fin 3)
          (domain.upper (1 : Fin 3))
          y)
        (1 : Fin 3)) =
      ∫ _y in
          Set.Icc
            (domain.lower ∘
              Fin.succAbove (1 : Fin 3))
            (domain.upper ∘
              Fin.succAbove (1 : Fin 3)),
        (A / hiddenSectorRectangularVolume domain) *
          domain.upper (1 : Fin 3) := by
            apply integral_congr_ae
            filter_upwards with y

            have hPointwise :=
              hiddenSectorStaticCurl_poynting_coordinateOne_exact
                A
                μ₀
                domain
                hμ₀
                hVolume
                time
                (Fin.insertNth
                  (1 : Fin 3)
                  (domain.upper (1 : Fin 3))
                  y)

            simpa using hPointwise

    _ =
      ((A / hiddenSectorRectangularVolume domain) *
          domain.upper (1 : Fin 3)) *
        (∫ _y in
          Set.Icc
            (domain.lower ∘
              Fin.succAbove (1 : Fin 3))
            (domain.upper ∘
              Fin.succAbove (1 : Fin 3)),
          (1 : ℝ)) := by
            rw [← integral_const_mul]
            simp

    _ =
      (A / hiddenSectorRectangularVolume domain) *
        domain.upper (1 : Fin 3) *
        hiddenSectorStaticCurlAxisOneFaceArea domain := by
          rfl

theorem hiddenSectorStaticCurl_lowerFaceOne_flux_exact
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A
        μ₀
        domain
        time
        (1 : Fin 3) =
      -(
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain) := by
  rw [
    hiddenSectorStaticCurlLowerFaceFlux_eq_neg_coordinateIntegral
  ]

  have hCoordinateIntegral :
      (∫ y in
          Set.Icc
            (domain.lower ∘
              Fin.succAbove (1 : Fin 3))
            (domain.upper ∘
              Fin.succAbove (1 : Fin 3)),
        maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth
            (1 : Fin 3)
            (domain.lower (1 : Fin 3))
            y)
          (1 : Fin 3)) =
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain := by
    calc
      (∫ y in
          Set.Icc
            (domain.lower ∘
              Fin.succAbove (1 : Fin 3))
            (domain.upper ∘
              Fin.succAbove (1 : Fin 3)),
        maxwellPoyntingSpatialSlice3
          μ₀
          (hiddenSectorStaticCurlField
            A
            μ₀
            domain)
          time
          (Fin.insertNth
            (1 : Fin 3)
            (domain.lower (1 : Fin 3))
            y)
          (1 : Fin 3)) =
        ∫ _y in
            Set.Icc
              (domain.lower ∘
                Fin.succAbove (1 : Fin 3))
              (domain.upper ∘
                Fin.succAbove (1 : Fin 3)),
          (A / hiddenSectorRectangularVolume domain) *
            domain.lower (1 : Fin 3) := by
              apply integral_congr_ae
              filter_upwards with y

              have hPointwise :=
                hiddenSectorStaticCurl_poynting_coordinateOne_exact
                  A
                  μ₀
                  domain
                  hμ₀
                  hVolume
                  time
                  (Fin.insertNth
                    (1 : Fin 3)
                    (domain.lower (1 : Fin 3))
                    y)

              simpa using hPointwise

      _ =
        ((A / hiddenSectorRectangularVolume domain) *
            domain.lower (1 : Fin 3)) *
          (∫ _y in
            Set.Icc
              (domain.lower ∘
                Fin.succAbove (1 : Fin 3))
              (domain.upper ∘
                Fin.succAbove (1 : Fin 3)),
            (1 : ℝ)) := by
              rw [← integral_const_mul]
              simp

      _ =
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain := by
            rfl

  rw [hCoordinateIntegral]

theorem hiddenSectorStaticCurl_individualFaceFormulas_sum_eq_amplitude
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (time : ℝ) :
    (A / hiddenSectorRectangularVolume domain) *
          domain.upper (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain -
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain =
      A := by
  have hSum :=
    hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
      A
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  have hUpper :=
    hiddenSectorStaticCurl_upperFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  have hLower :=
    hiddenSectorStaticCurl_lowerFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  calc
    (A / hiddenSectorRectangularVolume domain) *
          domain.upper (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain -
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain =
      hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (1 : Fin 3) +
        hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (1 : Fin 3) := by
            rw [hUpper, hLower]
            ring

    _ = A := hSum

theorem hiddenSectorStaticCurl_axisOneFaces_equal_of_centered
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hCentered :
      domain.lower (1 : Fin 3) =
        -domain.upper (1 : Fin 3))
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (1 : Fin 3) =
      hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (1 : Fin 3) := by
  have hUpper :=
    hiddenSectorStaticCurl_upperFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  have hLower :=
    hiddenSectorStaticCurl_lowerFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  calc
    hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (1 : Fin 3) =
      (A / hiddenSectorRectangularVolume domain) *
        domain.upper (1 : Fin 3) *
        hiddenSectorStaticCurlAxisOneFaceArea domain :=
      hUpper

    _ =
      -(
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain) := by
            rw [hCentered]
            ring

    _ =
      hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (1 : Fin 3) :=
      hLower.symm

theorem hiddenSectorStaticCurl_centered_axisOneFaces_each_eq_half
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hCentered :
      domain.lower (1 : Fin 3) =
        -domain.upper (1 : Fin 3))
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (1 : Fin 3) =
        A / 2 ∧
      hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (1 : Fin 3) =
        A / 2 := by
  have hEqual :=
    hiddenSectorStaticCurl_axisOneFaces_equal_of_centered
      A
      μ₀
      domain
      hμ₀
      hVolume
      hCentered
      time

  have hSum :=
    hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
      A
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  constructor <;> nlinarith

theorem hiddenSectorStaticCurl_lowerFaceOne_flux_zero_of_lower_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hLowerZero :
      domain.lower (1 : Fin 3) =
        0)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A μ₀ domain time (1 : Fin 3) =
      0 := by
  have hLower :=
    hiddenSectorStaticCurl_lowerFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  calc
    hiddenSectorStaticCurlLowerFaceFlux
          A μ₀ domain time (1 : Fin 3) =
      -(
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain) :=
      hLower

    _ = 0 := by
      rw [hLowerZero]
      ring

theorem hiddenSectorStaticCurl_upperFaceOne_flux_eq_amplitude_of_lower_zero
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hLowerZero :
      domain.lower (1 : Fin 3) =
        0)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
        A μ₀ domain time (1 : Fin 3) =
      A := by
  have hSum :=
    hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
      A
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  have hLower :=
    hiddenSectorStaticCurl_lowerFaceOne_flux_zero_of_lower_zero
      A
      μ₀
      domain
      hμ₀
      hVolume
      hLowerZero
      time

  rw [hLower, add_zero] at hSum
  exact hSum

theorem hiddenSectorStaticCurl_upperFaceOne_flux_zero_of_upper_zero
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hUpperZero :
      domain.upper (1 : Fin 3) =
        0)
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
        A μ₀ domain time (1 : Fin 3) =
      0 := by
  have hUpper :=
    hiddenSectorStaticCurl_upperFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      hVolume
      time

  calc
    hiddenSectorStaticCurlUpperFaceFlux
          A μ₀ domain time (1 : Fin 3) =
      (A / hiddenSectorRectangularVolume domain) *
        domain.upper (1 : Fin 3) *
        hiddenSectorStaticCurlAxisOneFaceArea domain :=
      hUpper

    _ = 0 := by
      rw [hUpperZero]
      ring

theorem hiddenSectorStaticCurl_lowerFaceOne_flux_eq_amplitude_of_upper_zero
    (A ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hUpperZero :
      domain.upper (1 : Fin 3) =
        0)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A μ₀ domain time (1 : Fin 3) =
      A := by
  have hSum :=
    hiddenSectorStaticCurl_axisOneFaces_sum_eq_amplitude
      A
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      time

  have hUpper :=
    hiddenSectorStaticCurl_upperFaceOne_flux_zero_of_upper_zero
      A
      μ₀
      domain
      hμ₀
      hVolume
      hUpperZero
      time

  rw [hUpper, zero_add] at hSum
  exact hSum

theorem hiddenSectorStaticCurl_upperFaceOne_flux_pos
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hA : 0 < A)
    (hμ₀ : 0 < μ₀)
    (hVolumePositive :
      0 < hiddenSectorRectangularVolume domain)
    (hUpper :
      0 < domain.upper (1 : Fin 3))
    (hArea :
      0 < hiddenSectorStaticCurlAxisOneFaceArea domain)
    (time : ℝ) :
    0 <
      hiddenSectorStaticCurlUpperFaceFlux
        A μ₀ domain time (1 : Fin 3) := by
  rw [
    hiddenSectorStaticCurl_upperFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      (ne_of_gt hVolumePositive)
      time
  ]

  exact
    mul_pos
      (mul_pos
        (div_pos hA hVolumePositive)
        hUpper)
      hArea

theorem hiddenSectorStaticCurl_lowerFaceOne_flux_pos_of_lower_neg
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hA : 0 < A)
    (hμ₀ : 0 < μ₀)
    (hVolumePositive :
      0 < hiddenSectorRectangularVolume domain)
    (hLower :
      domain.lower (1 : Fin 3) < 0)
    (hArea :
      0 < hiddenSectorStaticCurlAxisOneFaceArea domain)
    (time : ℝ) :
    0 <
      hiddenSectorStaticCurlLowerFaceFlux
        A μ₀ domain time (1 : Fin 3) := by
  rw [
    hiddenSectorStaticCurl_lowerFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      (ne_of_gt hVolumePositive)
      time
  ]

  have hNegativeProduct :
      (A / hiddenSectorRectangularVolume domain) *
            domain.lower (1 : Fin 3) *
            hiddenSectorStaticCurlAxisOneFaceArea domain <
        0 :=
    mul_neg_of_neg_of_pos
      (mul_neg_of_pos_of_neg
        (div_pos hA hVolumePositive)
        hLower)
      hArea

  exact neg_pos.mpr hNegativeProduct

theorem hiddenSectorStaticCurl_lowerFaceOne_flux_neg_of_lower_pos
    (A μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hA : 0 < A)
    (hμ₀ : 0 < μ₀)
    (hVolumePositive :
      0 < hiddenSectorRectangularVolume domain)
    (hLower :
      0 < domain.lower (1 : Fin 3))
    (hArea :
      0 < hiddenSectorStaticCurlAxisOneFaceArea domain)
    (time : ℝ) :
    hiddenSectorStaticCurlLowerFaceFlux
        A μ₀ domain time (1 : Fin 3) <
      0 := by
  rw [
    hiddenSectorStaticCurl_lowerFaceOne_flux_exact
      A
      μ₀
      domain
      hμ₀
      (ne_of_gt hVolumePositive)
      time
  ]

  have hPositiveProduct :
      0 <
        (A / hiddenSectorRectangularVolume domain) *
          domain.lower (1 : Fin 3) *
          hiddenSectorStaticCurlAxisOneFaceArea domain :=
    mul_pos
      (mul_pos
        (div_pos hA hVolumePositive)
        hLower)
      hArea

  exact neg_neg_of_pos hPositiveProduct

theorem real_cast_two_pow_succ_div_two
    (n : Nat) :
    (((2 ^ (n + 1) : Nat) : ℝ) / 2) =
      ((2 ^ n : Nat) : ℝ) := by
  norm_num [pow_succ]

theorem darkMatterUnitCoupling_staticCurl_centered_faces_each_exact
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hCentered :
      domain.lower (1 : Fin 3) =
        -domain.upper (1 : Fin 3))
    (time : ℝ) :
    hiddenSectorStaticCurlUpperFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) =
        ((2 ^ 254 : Nat) : ℝ) ∧
      hiddenSectorStaticCurlLowerFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) =
        ((2 ^ 254 : Nat) : ℝ) := by
  have hHalf :=
    hiddenSectorStaticCurl_centered_axisOneFaces_each_eq_half
      (darkMatterClosureAmplitude
        1
        1
        darkMatterExplosionInitialState : ℝ)
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      hCentered
      time

  have hScalar :
      (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) /
          2 =
        ((2 ^ 254 : Nat) : ℝ) := by
    calc
      (darkMatterClosureAmplitude
          1
          1
          darkMatterExplosionInitialState : ℝ) /
          2 =
        ((2 ^ 255 : Nat) : ℝ) / 2 := by
          rw [
            darkMatterUnitCoupling_closureAmplitude_real_exact
          ]

      _ =
        ((2 ^ 254 : Nat) : ℝ) := by
          simpa using
            real_cast_two_pow_succ_div_two 254

  exact
    ⟨hHalf.1.trans hScalar,
      hHalf.2.trans hScalar⟩

theorem darkMatterUnitCoupling_staticCurl_centered_faces_pos
    (ε₀ μ₀ : ℝ)
    (domain : MaxwellRectangularDomain3)
    (hμ₀ : 0 < μ₀)
    (hVolume :
      hiddenSectorRectangularVolume domain ≠ 0)
    (hCentered :
      domain.lower (1 : Fin 3) =
        -domain.upper (1 : Fin 3))
    (time : ℝ) :
    0 <
        hiddenSectorStaticCurlUpperFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) ∧
      0 <
        hiddenSectorStaticCurlLowerFaceFlux
          (darkMatterClosureAmplitude
            1
            1
            darkMatterExplosionInitialState : ℝ)
          μ₀
          domain
          time
          (1 : Fin 3) := by
  have hExact :=
    darkMatterUnitCoupling_staticCurl_centered_faces_each_exact
      ε₀
      μ₀
      domain
      hμ₀
      hVolume
      hCentered
      time

  constructor

  · rw [hExact.1]
    positivity

  · rw [hExact.2]
    positivity

end ZeroDayRestrictedClosures
