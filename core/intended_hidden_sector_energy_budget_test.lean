import intended_dark_matter_explosion_test

universe u

namespace ZeroDayRestrictedClosures

/--
A finite conserved hidden-sector trajectory.

At every tested time, visible amplitude plus the remaining hidden reserve
equals one fixed total budget. Visible amplification therefore cannot appear
without a corresponding reserve decrease.
-/
structure ConservedHiddenSectorTrajectory
    (χDM initialAmplitude totalBudget maxStep : Nat) where
  reserve : Nat → Nat
  conservation :
    ∀ n : Nat,
      n ≤ maxStep →
        darkMatterAmplitude χDM initialAmplitude n +
            reserve n =
          totalBudget

/--
One amplification step consists of the previous visible amplitude plus the
additional coupling-generated amount.
-/
theorem darkMatterAmplitude_step_decomposition
    (χDM initialAmplitude n : Nat) :
    darkMatterAmplitude
        χDM
        initialAmplitude
        (n + 1) =
      darkMatterAmplitude χDM initialAmplitude n * χDM +
        darkMatterAmplitude χDM initialAmplitude n := by
  simp [
    darkMatterAmplitude,
    darkMatterStepMultiplier,
    Nat.mul_add
  ]

/--
Every visible amplitude in a conserved trajectory is bounded above by the
total available budget.
-/
theorem conservedHiddenSector_amplitude_le_budget
    {χDM initialAmplitude totalBudget maxStep : Nat}
    (trajectory :
      ConservedHiddenSectorTrajectory
        χDM
        initialAmplitude
        totalBudget
        maxStep)
    (n : Nat)
    (hStep : n ≤ maxStep) :
    darkMatterAmplitude χDM initialAmplitude n ≤
      totalBudget := by
  have hConservation :=
    trajectory.conservation n hStep
  omega

/--
The additional visible amplitude generated in one step is paid for exactly by
a decrease in the hidden-sector reserve.
-/
theorem conservedHiddenSector_exact_reserve_transfer
    {χDM initialAmplitude totalBudget maxStep : Nat}
    (trajectory :
      ConservedHiddenSectorTrajectory
        χDM
        initialAmplitude
        totalBudget
        maxStep)
    (n : Nat)
    (hNext : n + 1 ≤ maxStep) :
    trajectory.reserve n =
      darkMatterAmplitude χDM initialAmplitude n * χDM +
        trajectory.reserve (n + 1) := by
  have hCurrentStep :
      n ≤ maxStep :=
    Nat.le_trans
      (Nat.le_succ n)
      hNext

  have hCurrent :=
    trajectory.conservation n hCurrentStep

  have hFollowing :=
    trajectory.conservation (n + 1) hNext

  have hEqual :
      darkMatterAmplitude χDM initialAmplitude n +
          trajectory.reserve n =
        darkMatterAmplitude χDM initialAmplitude n +
          (darkMatterAmplitude χDM initialAmplitude n * χDM +
            trajectory.reserve (n + 1)) := by
    calc
      darkMatterAmplitude χDM initialAmplitude n +
            trajectory.reserve n =
          totalBudget :=
        hCurrent
      _ =
          darkMatterAmplitude
              χDM
              initialAmplitude
              (n + 1) +
            trajectory.reserve (n + 1) :=
        hFollowing.symm
      _ =
          (darkMatterAmplitude χDM initialAmplitude n * χDM +
              darkMatterAmplitude χDM initialAmplitude n) +
            trajectory.reserve (n + 1) := by
        rw [darkMatterAmplitude_step_decomposition]
      _ =
          darkMatterAmplitude χDM initialAmplitude n +
            (darkMatterAmplitude χDM initialAmplitude n * χDM +
              trajectory.reserve (n + 1)) := by
        ac_rfl

  exact Nat.add_left_cancel hEqual

/--
A conserved trajectory extending through the exact closure time of a supplied
state.
-/
abbrev ConservedHiddenSectorThroughClosure
    {Payload : Type u}
    (χDM initialAmplitude totalBudget : Nat)
    (state : IntendedUnrestrictedState Payload) :
    Type :=
  ConservedHiddenSectorTrajectory
    χDM
    initialAmplitude
    totalBudget
    (intendedStateRemainingRank state)

/--
Under conservation, the closure amplitude cannot exceed the fixed total
budget.
-/
theorem conservedHiddenSector_closureAmplitude_le_budget
    {Payload : Type u}
    {χDM initialAmplitude totalBudget : Nat}
    {state : IntendedUnrestrictedState Payload}
    (trajectory :
      ConservedHiddenSectorThroughClosure
        χDM
        initialAmplitude
        totalBudget
        state) :
    darkMatterClosureAmplitude
        χDM
        initialAmplitude
        state ≤
      totalBudget := by
  unfold darkMatterClosureAmplitude

  exact
    conservedHiddenSector_amplitude_le_budget
      trajectory
      (intendedStateRemainingRank state)
      (Nat.le_refl
        (intendedStateRemainingRank state))

/--
Any proposed explosion threshold above the conserved total budget is
impossible.
-/
theorem conservedHiddenSector_blocks_unfunded_explosion
    {Payload : Type u}
    {χDM initialAmplitude totalBudget threshold : Nat}
    {state : IntendedUnrestrictedState Payload}
    (trajectory :
      ConservedHiddenSectorThroughClosure
        χDM
        initialAmplitude
        totalBudget
        state)
    (hBudget : totalBudget < threshold) :
    ¬ DarkMatterExplosionAtClosure
        χDM
        initialAmplitude
        threshold
        state := by
  intro hExplosion
  unfold DarkMatterExplosionAtClosure at hExplosion

  have hBound :=
    conservedHiddenSector_closureAmplitude_le_budget
      trajectory

  omega

/--
The zero-coupling control admits a conserved unit-budget trajectory with zero
hidden reserve.
-/
def darkMatterZeroCouplingUnitBudgetTrajectory :
    ConservedHiddenSectorThroughClosure
      0
      1
      1
      darkMatterExplosionInitialState where
  reserve :=
    fun _ => 0

  conservation := by
    intro n _
    simpa using
      (darkMatterAmplitude_zero_coupling 1 n)

/--
The conserved zero-coupling control remains bounded by budget one.
-/
theorem darkMatterZeroCouplingUnitBudget_control :
    darkMatterClosureAmplitude
        0
        1
        darkMatterExplosionInitialState ≤
      1 := by
  exact
    conservedHiddenSector_closureAmplitude_le_budget
      darkMatterZeroCouplingUnitBudgetTrajectory

/--
Any conserved unit-coupling trajectory through the rank-255 test requires a
total budget of at least `2^255`.
-/
theorem darkMatterUnitCoupling_conserved_budget_lower_bound
    (totalBudget : Nat)
    (trajectory :
      ConservedHiddenSectorThroughClosure
        1
        1
        totalBudget
        darkMatterExplosionInitialState) :
    2 ^ 255 ≤ totalBudget := by
  have hBound :=
    conservedHiddenSector_closureAmplitude_le_budget
      trajectory

  rw [darkMatterUnitCoupling_exact_explosion] at hBound
  exact hBound

/--
The rank-255 unit-coupling response therefore requires a conserved budget of at
least `10^70`.
-/
theorem darkMatterUnitCoupling_requires_test_threshold_budget
    (totalBudget : Nat)
    (trajectory :
      ConservedHiddenSectorThroughClosure
        1
        1
        totalBudget
        darkMatterExplosionInitialState) :
    10 ^ 70 ≤ totalBudget := by
  have hThreshold :
      10 ^ 70 ≤ 2 ^ 255 := by
    native_decide

  exact
    Nat.le_trans
      hThreshold
      (darkMatterUnitCoupling_conserved_budget_lower_bound
        totalBudget
        trajectory)

/--
No total budget below `10^70` can support the rank-255 unit-coupling
amplification while preserving conservation.
-/
theorem darkMatterUnitCoupling_no_subthreshold_conserved_trajectory
    (totalBudget : Nat)
    (hBudget : totalBudget < 10 ^ 70) :
    ¬ Nonempty
        (ConservedHiddenSectorThroughClosure
          1
          1
          totalBudget
          darkMatterExplosionInitialState) := by
  rintro ⟨trajectory⟩

  have hRequired :
      10 ^ 70 ≤ totalBudget :=
    darkMatterUnitCoupling_requires_test_threshold_budget
      totalBudget
      trajectory

  omega

end ZeroDayRestrictedClosures
