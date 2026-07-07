import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace Chronos.Frontier

def ToyMotionBand (V c v : ℝ) : Prop :=
  V < v ∧ v < c

def ToyUnitCoordinate (x : ℝ) : Prop :=
  0 < x ∧ x < 1

def ToyRelativeTimeBand (R : ℝ) : Prop :=
  1 < R ∧ R < 2

def ToyElapsedTimeBand (N E : ℝ) : Prop :=
  N < E ∧ E < 2 * N

def toyX (V c v : ℝ) : ℝ :=
  (v - V) / (c - V)

def toyV (V c x : ℝ) : ℝ :=
  V + x * (c - V)

def toyR (x : ℝ) : ℝ :=
  1 + x

def toyXFromR (R : ℝ) : ℝ :=
  R - 1

def toyE (N R : ℝ) : ℝ :=
  R * N

def toyRFromE (N E : ℝ) : ℝ :=
  E / N

def toyEFromSpeed (V c N v : ℝ) : ℝ :=
  (1 + (v - V) / (c - V)) * N

def toyVFromElapsed (V c N E : ℝ) : ℝ :=
  V + (E / N - 1) * (c - V)

theorem toyX_mem_unit {V c v : ℝ}
    (hVc : V < c) (hv : ToyMotionBand V c v) :
    ToyUnitCoordinate (toyX V c v) := by
  unfold ToyMotionBand ToyUnitCoordinate toyX at *
  have hden : 0 < c - V := by linarith
  constructor
  · exact div_pos (by linarith) hden
  · rw [div_lt_iff hden]
    linarith

theorem toyR_mem_time_band {x : ℝ}
    (hx : ToyUnitCoordinate x) :
    ToyRelativeTimeBand (toyR x) := by
  unfold ToyUnitCoordinate ToyRelativeTimeBand toyR at *
  constructor <;> linarith

theorem toyE_mem_elapsed_band {N R : ℝ}
    (hN : 0 < N) (hR : ToyRelativeTimeBand R) :
    ToyElapsedTimeBand N (toyE N R) := by
  unfold ToyRelativeTimeBand ToyElapsedTimeBand toyE at *
  constructor <;> nlinarith

theorem toyV_toyX {V c v : ℝ} (hVc : V < c) :
    toyV V c (toyX V c v) = v := by
  unfold toyV toyX
  have hden : c - V ≠ 0 := by linarith
  field_simp [hden]
  ring

theorem toyX_toyV {V c x : ℝ} (hVc : V < c) :
    toyX V c (toyV V c x) = x := by
  unfold toyX toyV
  have hden : c - V ≠ 0 := by linarith
  field_simp [hden]
  ring

theorem toyR_toyXFromR (R : ℝ) :
    toyR (toyXFromR R) = R := by
  unfold toyR toyXFromR
  ring

theorem toyXFromR_toyR (x : ℝ) :
    toyXFromR (toyR x) = x := by
  unfold toyXFromR toyR
  ring

theorem toyRFromE_toyE {N R : ℝ} (hN : N ≠ 0) :
    toyRFromE N (toyE N R) = R := by
  unfold toyRFromE toyE
  field_simp [hN]
  ring

theorem toyE_toyRFromE {N E : ℝ} (hN : N ≠ 0) :
    toyE N (toyRFromE N E) = E := by
  unfold toyE toyRFromE
  field_simp [hN]
  ring

theorem toy_forward_elapsed_from_speed (V c N v : ℝ) :
    toyE N (toyR (toyX V c v)) = toyEFromSpeed V c N v := by
  rfl

theorem toy_inverse_speed_from_elapsed {V c N v : ℝ}
    (hVc : V < c) (hN : 0 < N) :
    toyVFromElapsed V c N (toyEFromSpeed V c N v) = v := by
  unfold toyVFromElapsed toyEFromSpeed
  have hden : c - V ≠ 0 := by linarith
  have hNne : N ≠ 0 := by linarith
  field_simp [hden, hNne]
  ring

theorem toyX_strict_mono {V c v1 v2 : ℝ}
    (hVc : V < c) (hv : v1 < v2) :
    toyX V c v1 < toyX V c v2 := by
  unfold toyX
  have hden : 0 < c - V := by linarith
  have hnum : v1 - V < v2 - V := by linarith
  have h := mul_lt_mul_of_pos_right hnum (inv_pos.mpr hden)
  simpa [div_eq_mul_inv] using h

theorem toyR_strict_mono {x1 x2 : ℝ}
    (hx : x1 < x2) :
    toyR x1 < toyR x2 := by
  unfold toyR
  linarith

theorem toyE_strict_mono {N R1 R2 : ℝ}
    (hN : 0 < N) (hR : R1 < R2) :
    toyE N R1 < toyE N R2 := by
  unfold toyE
  exact mul_lt_mul_of_pos_right hR hN

theorem toyVFromElapsed_strict_mono {V c N E1 E2 : ℝ}
    (hVc : V < c) (hN : 0 < N) (hE : E1 < E2) :
    toyVFromElapsed V c N E1 < toyVFromElapsed V c N E2 := by
  unfold toyVFromElapsed
  have hden : 0 < c - V := by linarith
  have hdivRaw := mul_lt_mul_of_pos_right hE (inv_pos.mpr hN)
  have hdiv : E1 / N < E2 / N := by
    simpa [div_eq_mul_inv] using hdivRaw
  have hsub : E1 / N - 1 < E2 / N - 1 := by linarith
  have hmul := mul_lt_mul_of_pos_right hsub hden
  linarith

theorem toy_four_way_forward {V c N v : ℝ}
    (hVc : V < c) (hN : 0 < N) (hv : ToyMotionBand V c v) :
    ToyUnitCoordinate (toyX V c v) ∧
      ToyRelativeTimeBand (toyR (toyX V c v)) ∧
      ToyElapsedTimeBand N (toyE N (toyR (toyX V c v))) := by
  have hx := toyX_mem_unit hVc hv
  have hR := toyR_mem_time_band hx
  have hE := toyE_mem_elapsed_band hN hR
  exact ⟨hx, hR, hE⟩

def toyFourWayBijectionBoundary : String :=
  "BOUNDARY := ¬ toy_four_way_bijection_proves_physical_time_dilation"

def toyFourWayBijectionMissingObject : String :=
  "MISSING_OBJECT := derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"

structure DerivedNonToyRelativeTimeLawTarget where
  Law : ℝ → ℝ
  law_derivation_required : Prop
  realizes_relative_time_scale : Prop
  replaces_toy_law : Prop
  boundary_no_physical_time_dilation_from_toy_bijection : Prop

end Chronos.Frontier
