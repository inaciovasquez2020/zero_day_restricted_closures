import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace Chronos.Frontier

structure DirectionalFlowDetectorModel where
  R_B : ℝ
  κ : ℝ
  ε : ℝ
  flowNorm_B : ℝ
  c : ℝ

structure DirectionalFlowCalibrationCertificate
    (D : DirectionalFlowDetectorModel) : Prop where
  gain_pos : 0 < D.κ
  speed_pos : 0 < D.c
  calibration_bound :
    |D.R_B - D.κ * D.flowNorm_B| ≤ D.ε
  signal_above_uncertainty :
    D.ε < D.R_B

namespace DirectionalFlowDetectorModel

noncomputable def mFlow_B
    (D : DirectionalFlowDetectorModel) : ℝ :=
  D.flowNorm_B / D.c ^ 3

noncomputable def calibratedLowerBound_B
    (D : DirectionalFlowDetectorModel) : ℝ :=
  ((D.R_B - D.ε) / D.κ) / D.c ^ 3

end DirectionalFlowDetectorModel

namespace DirectionalFlowCalibrationCertificate

variable {D : DirectionalFlowDetectorModel}

theorem uncertainty_nonneg
    (h : DirectionalFlowCalibrationCertificate D) :
    0 ≤ D.ε := by
  exact le_trans (abs_nonneg _) h.calibration_bound

theorem flowNorm_lower_bound
    (h : DirectionalFlowCalibrationCertificate D) :
    (D.R_B - D.ε) / D.κ ≤ D.flowNorm_B := by
  have hupper :
      D.R_B - D.κ * D.flowNorm_B ≤ D.ε :=
    (abs_le.mp h.calibration_bound).2
  apply (div_le_iff₀ h.gain_pos).2
  nlinarith

theorem calibratedLowerBound_pos
    (h : DirectionalFlowCalibrationCertificate D) :
    0 < D.calibratedLowerBound_B := by
  unfold DirectionalFlowDetectorModel.calibratedLowerBound_B
  exact div_pos
    (div_pos
      (sub_pos.mpr h.signal_above_uncertainty)
      h.gain_pos)
    (pow_pos h.speed_pos 3)

theorem calibratedLowerBound_le_mFlow
    (h : DirectionalFlowCalibrationCertificate D) :
    D.calibratedLowerBound_B ≤ D.mFlow_B := by
  unfold DirectionalFlowDetectorModel.calibratedLowerBound_B
    DirectionalFlowDetectorModel.mFlow_B
  have hc3 : 0 < D.c ^ 3 :=
    pow_pos h.speed_pos 3
  have hinv_nonneg : 0 ≤ (D.c ^ 3)⁻¹ :=
    le_of_lt (inv_pos.mpr hc3)
  have hscaled :=
    mul_le_mul_of_nonneg_right
      (flowNorm_lower_bound h)
      hinv_nonneg
  simpa [div_eq_mul_inv] using hscaled

theorem detector_lower_bound_implication
    (h : DirectionalFlowCalibrationCertificate D) :
    0 < D.calibratedLowerBound_B ∧
      D.calibratedLowerBound_B ≤ D.mFlow_B := by
  exact
    ⟨calibratedLowerBound_pos h,
      calibratedLowerBound_le_mFlow h⟩

theorem mFlow_pos
    (h : DirectionalFlowCalibrationCertificate D) :
    0 < D.mFlow_B := by
  exact lt_of_lt_of_le
    (calibratedLowerBound_pos h)
    (calibratedLowerBound_le_mFlow h)

end DirectionalFlowCalibrationCertificate

end Chronos.Frontier

namespace Chronos.Frontier

/-
A purely arithmetic bounded instance showing that the calibration certificate
and lower-bound theorem are non-vacuous.

This instance is not empirical detector evidence.
-/
namespace DirectionalFlowBoundedArithmeticInstance

def model : DirectionalFlowDetectorModel where
  R_B := 2
  κ := 1
  ε := 1
  flowNorm_B := 2
  c := 1

theorem certificate :
    DirectionalFlowCalibrationCertificate model := by
  refine
    { gain_pos := ?_
      speed_pos := ?_
      calibration_bound := ?_
      signal_above_uncertainty := ?_ }
  · change (0 : ℝ) < 1
    exact zero_lt_one
  · change (0 : ℝ) < 1
    exact zero_lt_one
  · change |(2 : ℝ) - 1 * 2| ≤ 1
    simpa using (show (0 : ℝ) ≤ 1 from zero_le_one)
  · change (1 : ℝ) < 2
    linarith

theorem lower_bound :
    0 < model.calibratedLowerBound_B ∧
      model.calibratedLowerBound_B ≤ model.mFlow_B := by
  exact
    DirectionalFlowCalibrationCertificate.detector_lower_bound_implication
      certificate

theorem positive_flow_mass :
    0 < model.mFlow_B := by
  exact
    DirectionalFlowCalibrationCertificate.mFlow_pos certificate

end DirectionalFlowBoundedArithmeticInstance

end Chronos.Frontier

namespace Chronos.Frontier

/-
The affine detector rule and a bounded response error imply a calibrated
directional-flow residual bound.
-/
theorem affine_response_calibration_bound
    {readout_D k_D b_D y_D flowNorm_B
      δ_readout δ_response : ℝ}
    (hk : 0 ≤ k_D)
    (hreadout :
      |readout_D - (k_D * y_D + b_D)| ≤ δ_readout)
    (hresponse :
      |y_D - flowNorm_B| ≤ δ_response) :
    |(readout_D - b_D) - k_D * flowNorm_B|
      ≤ δ_readout + k_D * δ_response := by
  have hdecomp :
      (readout_D - b_D) - k_D * flowNorm_B =
        (readout_D - (k_D * y_D + b_D)) +
          k_D * (y_D - flowNorm_B) := by
    rw [mul_sub]
    linarith
  rw [hdecomp]
  calc
    |(readout_D - (k_D * y_D + b_D)) +
        k_D * (y_D - flowNorm_B)|
        ≤ |readout_D - (k_D * y_D + b_D)| +
            |k_D * (y_D - flowNorm_B)| :=
      abs_add_le _ _
    _ =
        |readout_D - (k_D * y_D + b_D)| +
          k_D * |y_D - flowNorm_B| := by
      rw [abs_mul, abs_of_nonneg hk]
    _ ≤ δ_readout + k_D * δ_response :=
      add_le_add
        hreadout
        (mul_le_mul_of_nonneg_left hresponse hk)

end Chronos.Frontier

namespace Chronos.Frontier

/--
Constructs the directional-flow calibration certificate from an affine
detector response, bounded readout error, bounded response error, positive
gain and speed, and an independently supplied signal margin.
-/
theorem directionalFlowCalibrationCertificate_of_affine
    {readout_D k_D b_D y_D flowNorm_B
      δ_readout δ_response c : ℝ}
    (hk : 0 < k_D)
    (hc : 0 < c)
    (hreadout :
      |readout_D - (k_D * y_D + b_D)| ≤ δ_readout)
    (hresponse :
      |y_D - flowNorm_B| ≤ δ_response)
    (hsignal :
      δ_readout + k_D * δ_response < readout_D - b_D) :
    DirectionalFlowCalibrationCertificate
      { R_B := readout_D - b_D
        κ := k_D
        ε := δ_readout + k_D * δ_response
        flowNorm_B := flowNorm_B
        c := c } := by
  refine
    { gain_pos := hk
      speed_pos := hc
      calibration_bound := ?_
      signal_above_uncertainty := hsignal }
  exact affine_response_calibration_bound
    (le_of_lt hk)
    hreadout
    hresponse

end Chronos.Frontier

namespace Chronos.Frontier

/--
The affine detector assumptions directly imply a strictly positive calibrated
lower bound for the bounded directional-flow mass.
-/
theorem affine_detector_positive_lower_bound
    {readout_D k_D b_D y_D flowNorm_B
      δ_readout δ_response c : ℝ}
    (hk : 0 < k_D)
    (hc : 0 < c)
    (hreadout :
      |readout_D - (k_D * y_D + b_D)| ≤ δ_readout)
    (hresponse :
      |y_D - flowNorm_B| ≤ δ_response)
    (hsignal :
      δ_readout + k_D * δ_response < readout_D - b_D) :
    let D : DirectionalFlowDetectorModel :=
      { R_B := readout_D - b_D
        κ := k_D
        ε := δ_readout + k_D * δ_response
        flowNorm_B := flowNorm_B
        c := c }
    0 < D.calibratedLowerBound_B ∧
      D.calibratedLowerBound_B ≤ D.mFlow_B := by
  exact
    DirectionalFlowCalibrationCertificate.detector_lower_bound_implication
      (directionalFlowCalibrationCertificate_of_affine
        hk
        hc
        hreadout
        hresponse
        hsignal)

end Chronos.Frontier

namespace Chronos.Frontier

/--
A bounded input contract for independently supplied affine detector values.

Defining this record does not construct an inhabitant, supply measurements,
or assert empirical detector evidence.
-/
structure DirectionalFlowAffineInputRecord where
  readout_D : ℝ
  k_D : ℝ
  b_D : ℝ
  y_D : ℝ
  flowNorm_B : ℝ
  δ_readout : ℝ
  δ_response : ℝ
  c : ℝ
  gain_pos : 0 < k_D
  speed_pos : 0 < c
  readout_error_bound :
    |readout_D - (k_D * y_D + b_D)| ≤ δ_readout
  response_error_bound :
    |y_D - flowNorm_B| ≤ δ_response
  signal_above_total_uncertainty :
    δ_readout + k_D * δ_response < readout_D - b_D

end Chronos.Frontier

namespace Chronos.Frontier

namespace DirectionalFlowAffineInputRecord

/--
Every independently supplied inhabitant of the bounded affine input contract
yields the existing positive directional-flow lower bound.

This theorem does not construct an input-record inhabitant.
-/
theorem positive_lower_bound
    (r : DirectionalFlowAffineInputRecord) :
    let D : DirectionalFlowDetectorModel :=
      { R_B := r.readout_D - r.b_D
        κ := r.k_D
        ε := r.δ_readout + r.k_D * r.δ_response
        flowNorm_B := r.flowNorm_B
        c := r.c }
    0 < D.calibratedLowerBound_B ∧
      D.calibratedLowerBound_B ≤ D.mFlow_B := by
  exact
    affine_detector_positive_lower_bound
      r.gain_pos
      r.speed_pos
      r.readout_error_bound
      r.response_error_bound
      r.signal_above_total_uncertainty

end DirectionalFlowAffineInputRecord

end Chronos.Frontier

namespace Chronos.Frontier

/-
An external admission predicate for a bounded affine detector-input record.

The three evidence propositions must be supplied independently. Defining this
predicate does not construct a record, prove the propositions, or assert that
physical measurements exist.
-/
def DirectionalFlowExternalMeasurementAdmission
    (r : DirectionalFlowAffineInputRecord)
    (measurementRecorded : Prop)
    (calibrationIndependent : Prop)
    (uncertaintyBudgetRecorded : Prop) : Prop :=
  measurementRecorded ∧
    calibrationIndependent ∧
    uncertaintyBudgetRecorded ∧
    |r.readout_D - (r.k_D * r.y_D + r.b_D)| ≤ r.δ_readout ∧
    |r.y_D - r.flowNorm_B| ≤ r.δ_response

end Chronos.Frontier

namespace Chronos.Frontier.Mc3Boundary

/-- Cubically scaled real-number parameter. -/
noncomputable def μ (E c : ℝ) : ℝ :=
  E / c ^ 3

@[simp] theorem μ_eq (E c : ℝ) :
    μ E c = E / c ^ 3 := by
  rfl

theorem μ_eq_mass_div_speed
    (E m c : ℝ)
    (hE : E = m * c ^ 2)
    (hc : c ≠ 0) :
    μ E c = m / c := by
  calc
    μ E c = E / c ^ 3 := μ_eq E c
    _ = m * c ^ 2 / c ^ 3 :=
      congrArg (fun x : ℝ => x / c ^ 3) hE
    _ = c ^ 2 * m / c ^ 3 :=
      congrArg
        (fun x : ℝ => x / c ^ 3)
        (mul_comm m (c ^ 2))
    _ = c ^ 2 * m / (c ^ 2 * c) :=
      congrArg
        (fun x : ℝ => c ^ 2 * m / x)
        (pow_succ c 2)
    _ = m / c :=
      mul_div_mul_left m c (pow_ne_zero 2 hc)

theorem energy_zero_or_speed_one_of_quadratic_and_cubic
    (E m c : ℝ)
    (hQuadratic : E = m * c ^ 2)
    (hCubic : E = m * c ^ 3) :
    E = 0 ∨ c = 1 := by
  by_cases hE : E = 0
  · exact Or.inl hE
  · right
    have hFactorNonzero : m * c ^ 2 ≠ 0 := by
      intro hFactorZero
      apply hE
      calc
        E = m * c ^ 2 := hQuadratic
        _ = 0 := hFactorZero
    have hEqual :
        m * c ^ 2 = m * c ^ 3 :=
      hQuadratic.symm.trans hCubic
    have hCancelled :
        m * c ^ 2 * c = m * c ^ 2 * 1 := by
      calc
        m * c ^ 2 * c = m * (c ^ 2 * c) := by
          rw [mul_assoc]
        _ = m * c ^ 3 := by
          rw [← pow_succ]
        _ = m * c ^ 2 := hEqual.symm
        _ = m * c ^ 2 * 1 := by
          rw [mul_one]
    exact mul_left_cancel₀ hFactorNonzero hCancelled

theorem cubic_of_quadratic_and_energy_zero_or_speed_one
    (E m c : ℝ)
    (hQuadratic : E = m * c ^ 2)
    (hBoundary : E = 0 ∨ c = 1) :
    E = m * c ^ 3 := by
  cases hBoundary with
  | inl hE =>
      have hFactorZero : m * c ^ 2 = 0 :=
        hQuadratic.symm.trans hE
      calc
        E = 0 := hE
        _ = (m * c ^ 2) * c := by
          rw [hFactorZero, zero_mul]
        _ = m * (c ^ 2 * c) := by
          rw [mul_assoc]
        _ = m * c ^ 3 := by
          rw [← pow_succ]
  | inr hc =>
      simpa [hc] using hQuadratic

theorem cubic_iff_energy_zero_or_speed_one
    (E m c : ℝ)
    (hQuadratic : E = m * c ^ 2) :
    E = m * c ^ 3 ↔ E = 0 ∨ c = 1 := by
  constructor
  · intro hCubic
    exact
      energy_zero_or_speed_one_of_quadratic_and_cubic
        E m c hQuadratic hCubic
  · intro hBoundary
    exact
      cubic_of_quadratic_and_energy_zero_or_speed_one
        E m c hQuadratic hBoundary

theorem not_cubic_of_quadratic_and_nondegenerate_boundary
    (E m c : ℝ)
    (hQuadratic : E = m * c ^ 2)
    (hEnergyNonzero : E ≠ 0)
    (hSpeedNotOne : c ≠ 1) :
    E ≠ m * c ^ 3 := by
  intro hCubic
  have hBoundary : E = 0 ∨ c = 1 :=
    energy_zero_or_speed_one_of_quadratic_and_cubic
      E m c hQuadratic hCubic
  cases hBoundary with
  | inl hEnergyZero =>
      exact hEnergyNonzero hEnergyZero
  | inr hSpeedOne =>
      exact hSpeedNotOne hSpeedOne

/-- Energy multiplied by the selected speed scale. -/
noncomputable def P_c (E c : ℝ) : ℝ :=
  E * c

theorem P_c_eq_mass_times_speed_cubed
    (E m c : ℝ)
    (hQuadratic : E = m * c ^ 2) :
    P_c E c = m * c ^ 3 := by
  calc
    P_c E c = E * c := rfl
    _ = (m * c ^ 2) * c :=
      congrArg (fun x : ℝ => x * c) hQuadratic
    _ = m * (c ^ 2 * c) := by
      rw [mul_assoc]
    _ = m * c ^ 3 := by
      rw [← pow_succ]

end Chronos.Frontier.Mc3Boundary
