import core.intended_encoded_step_graph

universe u

namespace ZeroDayRestrictedClosures

/-- Reaching the payload-preserving intended closed state is exactly reaching
the absorbing encoded quotient state. -/
theorem intendedStateClosureAt_iff_encodedClosureAt
    {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    (∃ n : Nat, n ≤ 255 ∧
      iterate intendedStep n state = intendedClosedState state) ↔
      IntendedEncodedClosureAt state.encoded := by
  constructor
  · rintro ⟨n, hn, hstate⟩
    refine ⟨n, hn, ?_⟩
    rw [intendedStep_iterate] at hstate
    have hencoded :=
      congrArg IntendedUnrestrictedState.encoded hstate
    simpa [intendedClosedState] using hencoded
  · rintro ⟨n, hn, hencoded⟩
    refine ⟨n, hn, ?_⟩
    rw [intendedStep_iterate]
    change
      IntendedUnrestrictedState.mk
          (iterate intendedEncodedStep n state.encoded)
          state.payload =
        IntendedUnrestrictedState.mk intendedClosedEncoded state.payload
    exact congrArg
      (fun encoded =>
        IntendedUnrestrictedState.mk encoded state.payload)
      hencoded


/-- Global intended-state closure is exactly the encoded closure condition
applied pointwise to every represented payload-bearing state. -/
theorem intendedUnrestrictedStateClosure_iff_pointwiseEncodedClosure
    {Payload : Type u} :
    IntendedUnrestrictedStateClosure (Payload := Payload) ↔
      ∀ state : IntendedUnrestrictedState Payload,
        IntendedEncodedClosureAt state.encoded := by
  constructor
  · intro hClosure state
    exact
      (intendedStateClosureAt_iff_encodedClosureAt state).mp
        (hClosure state)
  · intro hEncoded state
    exact
      (intendedStateClosureAt_iff_encodedClosureAt state).mpr
        (hEncoded state)


end ZeroDayRestrictedClosures
