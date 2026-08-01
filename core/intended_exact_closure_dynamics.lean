import intended_unrestricted_state_closure

universe u

namespace ZeroDayRestrictedClosures

/--
The exact number of saturating transitions remaining before the encoded state
reaches the absorbing value `255`.
-/
def intendedRemainingRank (encoded : Fin 256) : Nat :=
  255 - encoded.val

/--
The absorbing state has rank zero.
-/
theorem intendedRemainingRank_closed :
    intendedRemainingRank intendedClosedEncoded = 0 := by
  native_decide

/--
Until closure, one transition decreases the remaining rank by exactly one.

This is a strict discrete Lyapunov law for the intended encoded dynamics.
-/
theorem intendedEncodedStep_remainingRank_drop :
    ∀ encoded : Fin 256,
      encoded ≠ intendedClosedEncoded →
        intendedRemainingRank (intendedEncodedStep encoded) + 1 =
          intendedRemainingRank encoded := by
  native_decide

/--
The absorbing encoded state is the unique fixed point of the intended
transition.
-/
theorem intendedEncodedStep_unique_fixed_point :
    ∀ encoded : Fin 256,
      intendedEncodedStep encoded = encoded ↔
        encoded = intendedClosedEncoded := by
  native_decide

/--
Exact bounded hitting-time characterization.

For every encoded state and every relevant time `n ≤ 255`, the state has
reached closure after `n` transitions exactly when its remaining rank is at
most `n`.
-/
theorem intendedEncodedStep_exact_closure_time :
    ∀ encoded : Fin 256,
      ∀ n : Fin 256,
        iterate intendedEncodedStep n.val encoded =
            intendedClosedEncoded ↔
          intendedRemainingRank encoded ≤ n.val := by
  native_decide

/--
The state reaches closure at its remaining rank.
-/
theorem intendedEncodedStep_reaches_closed_at_remainingRank
    (encoded : Fin 256) :
    iterate
        intendedEncodedStep
        (intendedRemainingRank encoded)
        encoded =
      intendedClosedEncoded := by
  simpa [intendedRemainingRank] using
    intendedEncodedStep_reaches_closed encoded

/--
No smaller bounded time reaches the absorbing state.
-/
theorem intendedEncodedStep_not_closed_before_remainingRank
    (encoded : Fin 256)
    (n : Fin 256)
    (hEarly :
      n.val < intendedRemainingRank encoded) :
    iterate intendedEncodedStep n.val encoded ≠
      intendedClosedEncoded := by
  intro hClosed

  have hRequired :
      intendedRemainingRank encoded ≤ n.val :=
    (intendedEncodedStep_exact_closure_time encoded n).mp
      hClosed

  omega

/--
The remaining rank is therefore the unique minimal bounded closure time.
-/
theorem intendedEncodedStep_exact_minimal_closure_time
    (encoded : Fin 256) :
    iterate
        intendedEncodedStep
        (intendedRemainingRank encoded)
        encoded =
      intendedClosedEncoded ∧
    ∀ n : Fin 256,
      n.val < intendedRemainingRank encoded →
        iterate intendedEncodedStep n.val encoded ≠
          intendedClosedEncoded := by
  constructor
  · exact
      intendedEncodedStep_reaches_closed_at_remainingRank
        encoded
  · intro n hEarly
    exact
      intendedEncodedStep_not_closed_before_remainingRank
        encoded
        n
        hEarly

/--
Remaining rank for the full intended state. The arbitrary payload has no effect
on closure time.
-/
def intendedStateRemainingRank
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    Nat :=
  intendedRemainingRank state.encoded

/--
The full state reaches its payload-preserving closed state at exactly its
remaining encoded rank.
-/
theorem intendedStep_reaches_closed_at_remainingRank
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    iterate
        intendedStep
        (intendedStateRemainingRank state)
        state =
      intendedClosedState state := by
  rw [intendedStep_iterate]

  have hEncoded :=
    intendedEncodedStep_reaches_closed
      state.encoded

  simpa [
    intendedStateRemainingRank,
    intendedRemainingRank,
    intendedClosedState
  ] using
    congrArg
      (fun encoded : Fin 256 =>
        IntendedUnrestrictedState.mk
          encoded
          state.payload)
      hEncoded

/--
Exact bounded hitting-time characterization for the full intended state.
-/
theorem intendedStep_exact_closure_time
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload)
    (n : Fin 256) :
    iterate intendedStep n.val state =
        intendedClosedState state ↔
      intendedStateRemainingRank state ≤ n.val := by
  constructor
  · intro hClosed

    rw [intendedStep_iterate] at hClosed

    have hEncoded :
        iterate intendedEncodedStep n.val state.encoded =
          intendedClosedEncoded := by
      simpa [intendedClosedState] using
        congrArg
          (fun value :
            IntendedUnrestrictedState Payload =>
              value.encoded)
          hClosed

    simpa [intendedStateRemainingRank] using
      (intendedEncodedStep_exact_closure_time
        state.encoded
        n).mp hEncoded

  · intro hRank

    rw [intendedStep_iterate]

    have hEncoded :
        iterate intendedEncodedStep n.val state.encoded =
          intendedClosedEncoded :=
      (intendedEncodedStep_exact_closure_time
        state.encoded
        n).mpr
        (by
          simpa [intendedStateRemainingRank] using
            hRank)

    simpa [intendedClosedState] using
      congrArg
        (fun encoded : Fin 256 =>
          IntendedUnrestrictedState.mk
            encoded
            state.payload)
        hEncoded

/--
No bounded time smaller than the remaining rank closes the full state.
-/
theorem intendedStep_not_closed_before_remainingRank
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload)
    (n : Fin 256)
    (hEarly :
      n.val < intendedStateRemainingRank state) :
    iterate intendedStep n.val state ≠
      intendedClosedState state := by
  intro hClosed

  have hRequired :
      intendedStateRemainingRank state ≤ n.val :=
    (intendedStep_exact_closure_time state n).mp
      hClosed

  omega

/--
The remaining encoded rank is the unique minimal bounded closure time for the
full payload-preserving state.
-/
theorem intendedStep_exact_minimal_closure_time
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    iterate
        intendedStep
        (intendedStateRemainingRank state)
        state =
      intendedClosedState state ∧
    ∀ n : Fin 256,
      n.val < intendedStateRemainingRank state →
        iterate intendedStep n.val state ≠
          intendedClosedState state := by
  constructor
  · exact
      intendedStep_reaches_closed_at_remainingRank
        state
  · intro n hEarly
    exact
      intendedStep_not_closed_before_remainingRank
        state
        n
        hEarly

end ZeroDayRestrictedClosures
