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
