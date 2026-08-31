import Std
import Std.Tactic

universe u

namespace ZeroDayRestrictedClosures

/-- Repository-local function iteration, avoiding unavailable iterate notation. -/
def iterate {α : Type u} (f : α → α) : Nat → α → α
  | 0, x => x
  | Nat.succ n, x => iterate f n (f x)

/-- An intended unrestricted state with a bounded encoded component and
an arbitrary payload preserved by the transition. -/
structure IntendedUnrestrictedState (Payload : Type u) where
  encoded : Fin 256
  payload : Payload

/-- Repository-local carrier equivalence with explicit inverse laws. -/
structure CarrierEquivalence (α β : Type u) where
  toFun : α → β
  invFun : β → α
  leftInverse : ∀ x, invFun (toFun x) = x
  rightInverse : ∀ y, toFun (invFun y) = y

/-- The intended state carrier and product-form carrier are mutually inverse. -/
def intendedStateProductEquivalence (Payload : Type u) :
    CarrierEquivalence
      (IntendedUnrestrictedState Payload)
      (Fin 256 × Payload) where
  toFun state := (state.encoded, state.payload)
  invFun state := ⟨state.1, state.2⟩
  leftInverse state := by
    cases state
    rfl
  rightInverse state := by
    cases state
    rfl

/-- The absorbing encoded state. -/
def intendedClosedEncoded : Fin 256 :=
  ⟨255, by omega⟩

/-- Increment the encoded state until the absorbing state `255`. -/
def intendedEncodedStep (encoded : Fin 256) : Fin 256 :=
  if h : encoded.val < 255 then
    ⟨encoded.val + 1, by omega⟩
  else
    intendedClosedEncoded

/-- Preserve the payload while saturating the encoded component at `255`. -/
def intendedStep {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    IntendedUnrestrictedState Payload :=
  ⟨intendedEncodedStep state.encoded, state.payload⟩

/-- Replace only the encoded component by the absorbing state. -/
def intendedClosedState {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    IntendedUnrestrictedState Payload :=
  ⟨intendedClosedEncoded, state.payload⟩

theorem intendedStep_iterate {Payload : Type u} (n : Nat)
    (state : IntendedUnrestrictedState Payload) :
    iterate intendedStep n state =
      ⟨iterate intendedEncodedStep n state.encoded, state.payload⟩ := by
  induction n generalizing state with
  | zero =>
      rfl
  | succ n ih =>
      simp [iterate, intendedStep, ih]

/-- Every finite intended transition preserves the payload exactly. -/
theorem intendedStep_iterate_payload
    {Payload : Type u}
    (n : Nat)
    (state : IntendedUnrestrictedState Payload) :
    (iterate intendedStep n state).payload = state.payload := by
  simpa using
    congrArg
      IntendedUnrestrictedState.payload
      (intendedStep_iterate n state)

/-- A proposition depending only on the payload is invariant under every
finite intended transition. -/
theorem intendedStep_iterate_payload_property_iff
    {Payload : Type u}
    (P : Payload → Prop)
    (n : Nat)
    (state : IntendedUnrestrictedState Payload) :
    P (iterate intendedStep n state).payload ↔ P state.payload := by
  rw [intendedStep_iterate_payload n state]

/-- If a payload property is false initially, no finite intended transition can
make it true. -/
theorem intendedStep_cannot_create_payload_property
    {Payload : Type u}
    (P : Payload → Prop)
    (state : IntendedUnrestrictedState Payload)
    (hNot : ¬ P state.payload) :
    ∀ n : Nat, ¬ P (iterate intendedStep n state).payload := by
  intro n hProperty
  exact hNot
    ((intendedStep_iterate_payload_property_iff P n state).mp hProperty)

/-- Every one of the `256` encoded states reaches `255` in its exact
remaining rank. -/
theorem intendedEncodedStep_reaches_closed :
    ∀ encoded : Fin 256,
      iterate intendedEncodedStep (255 - encoded.val) encoded =
        intendedClosedEncoded := by
  native_decide

/-- Bounded closure for the explicitly defined intended finite-state model. -/
def IntendedUnrestrictedStateClosure {Payload : Type u} : Prop :=
  ∀ state : IntendedUnrestrictedState Payload,
    ∃ n : Nat, n ≤ 255 ∧
      iterate intendedStep n state = intendedClosedState state

/-- Every intended state reaches its payload-preserving closed state within
at most `255` saturating transitions. -/
theorem intendedUnrestrictedStateClosure {Payload : Type u} :
    IntendedUnrestrictedStateClosure (Payload := Payload) := by
  intro state
  refine ⟨255 - state.encoded.val, by omega, ?_⟩
  rw [intendedStep_iterate]
  have h := intendedEncodedStep_reaches_closed state.encoded
  simpa [intendedClosedState] using
    congrArg
      (fun encoded =>
        IntendedUnrestrictedState.mk encoded state.payload)
      h

/-- The bounded closure can witness a payload property at a reachable closed
state exactly when that property was already true of the initial payload.

In particular, the finite-state closure dynamics cannot manufacture any new
semantic fact carried solely by `Payload`.
-/
theorem intendedUnrestrictedStateClosure_payload_property_iff_initial
    {Payload : Type u}
    (P : Payload → Prop)
    (state : IntendedUnrestrictedState Payload) :
    (∃ n : Nat,
        n ≤ 255 ∧
        iterate intendedStep n state = intendedClosedState state ∧
        P (iterate intendedStep n state).payload) ↔
      P state.payload := by
  constructor
  · rintro ⟨n, _, _, hProperty⟩
    exact
      (intendedStep_iterate_payload_property_iff P n state).mp hProperty
  · intro hProperty
    obtain ⟨n, hn, hClosed⟩ :=
      intendedUnrestrictedStateClosure state
    refine ⟨n, hn, hClosed, ?_⟩
    exact
      (intendedStep_iterate_payload_property_iff P n state).mpr hProperty

/-- Product-form transition on `Fin 256 × Payload`. -/
def productFormStep {Payload : Type u}
    (state : Fin 256 × Payload) : Fin 256 × Payload :=
  (intendedEncodedStep state.1, state.2)

/-- Product-form absorbing state with preserved payload. -/
def productFormClosedState {Payload : Type u}
    (state : Fin 256 × Payload) : Fin 256 × Payload :=
  (intendedClosedEncoded, state.2)

theorem productFormStep_iterate {Payload : Type u} (n : Nat)
    (state : Fin 256 × Payload) :
    iterate productFormStep n state =
      (iterate intendedEncodedStep n state.1, state.2) := by
  induction n generalizing state with
  | zero =>
      rfl
  | succ n ih =>
      simp [iterate, productFormStep, ih]

/-- Product-form closure predicate recorded by the transport surface. -/
def ProductFormZeroDayClosureState {Payload : Type u}
    (state : Fin 256 × Payload) : Prop :=
  ∃ n : Nat, n ≤ 255 ∧
    iterate productFormStep n state = productFormClosedState state

/-- Every product-form state reaches `(255, payload)` within at most
`255` saturating transitions. -/
theorem ProductFormRestrictedLiftClosure {Payload : Type u} :
    ∀ state : Fin 256 × Payload,
      ProductFormZeroDayClosureState state := by
  intro state
  refine ⟨255 - state.1.val, by omega, ?_⟩
  rw [productFormStep_iterate]
  have h := intendedEncodedStep_reaches_closed state.1
  simpa [productFormClosedState] using
    congrArg
      (fun encoded : Fin 256 => (encoded, state.2))
      h

/-- The carrier map intertwines the intended and product-form transitions. -/
theorem intendedStateProductEquivalence_step {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    (intendedStateProductEquivalence Payload).toFun
        (intendedStep state) =
      productFormStep
        ((intendedStateProductEquivalence Payload).toFun state) := by
  rfl

/-- The carrier map intertwines the intended and product-form closed states. -/
theorem intendedStateProductEquivalence_closedState {Payload : Type u}
    (state : IntendedUnrestrictedState Payload) :
    (intendedStateProductEquivalence Payload).toFun
        (intendedClosedState state) =
      productFormClosedState
        ((intendedStateProductEquivalence Payload).toFun state) := by
  rfl

/-- The carrier map intertwines every finite transition iterate. -/
theorem intendedStateProductEquivalence_iterate {Payload : Type u}
    (n : Nat) (state : IntendedUnrestrictedState Payload) :
    (intendedStateProductEquivalence Payload).toFun
        (iterate intendedStep n state) =
      iterate productFormStep n
        ((intendedStateProductEquivalence Payload).toFun state) := by
  induction n generalizing state with
  | zero =>
      rfl
  | succ n ih =>
      simp only [iterate]
      rw [ih]
      rfl

/-- Product-form closure transports through the explicit carrier
correspondence to the intended-state closure predicate. -/
theorem productFormRestrictedLiftClosure_to_intendedUnrestrictedStateClosure
    {Payload : Type u}
    (hProduct :
      ∀ state : Fin 256 × Payload,
        ProductFormZeroDayClosureState state) :
    IntendedUnrestrictedStateClosure (Payload := Payload) := by
  intro state

  let carrier := intendedStateProductEquivalence Payload
  obtain ⟨n, hn, hProductStep⟩ := hProduct (carrier.toFun state)

  refine ⟨n, hn, ?_⟩

  have hMapped :
      carrier.toFun (iterate intendedStep n state) =
        carrier.toFun (intendedClosedState state) := by
    rw [intendedStateProductEquivalence_iterate]
    rw [intendedStateProductEquivalence_closedState]
    exact hProductStep

  calc
    iterate intendedStep n state =
        carrier.invFun
          (carrier.toFun (iterate intendedStep n state)) := by
      symm
      exact carrier.leftInverse _
    _ =
        carrier.invFun
          (carrier.toFun (intendedClosedState state)) :=
      congrArg carrier.invFun hMapped
    _ = intendedClosedState state :=
      carrier.leftInverse _

/-- The proved product-form closure theorem discharges the transport premise. -/
theorem intendedUnrestrictedStateClosure_from_productForm
    {Payload : Type u} :
    IntendedUnrestrictedStateClosure (Payload := Payload) :=
  productFormRestrictedLiftClosure_to_intendedUnrestrictedStateClosure
    ProductFormRestrictedLiftClosure

end ZeroDayRestrictedClosures
