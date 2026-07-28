import core.intended_unrestricted_state_closure
import core.vasquez_augmented_obstruction

namespace ZeroDayRestrictedClosures

/-- The payload quotient: only the transition-relevant encoded component remains. -/
abbrev PayloadQuotientState := Fin 256

/-- Number of strict encoded transitions remaining before the absorbing state. -/
def encodedRemaining (s : PayloadQuotientState) : Nat :=
  255 - s.val

/-- The finite orbit vertices, including the initial vertex. -/
def orbitTailVertices {State : Type u} (step : State → State) :
    Nat → State → List State
  | 0, _ => []
  | Nat.succ n, s => step s :: orbitTailVertices step n (step s)

/-- The finite orbit vertices, including both endpoints. -/
def orbitVertices {State : Type u} (step : State → State)
    (n : Nat) (s : State) : List State :=
  s :: orbitTailVertices step n s

/-- The consecutive directed edges of a finite orbit. -/
def orbitEdges {State : Type u} (step : State → State) :
    Nat → State → List (DirectedEdge State)
  | 0, _ => []
  | Nat.succ n, s =>
      ⟨s, step s⟩ :: orbitEdges step n (step s)

@[simp] theorem orbitVertices_zero {State : Type u} (step : State → State)
    (s : State) : orbitVertices step 0 s = [s] := rfl

@[simp] theorem orbitVertices_succ {State : Type u} (step : State → State)
    (n : Nat) (s : State) :
    orbitVertices step (Nat.succ n) s =
      s :: orbitVertices step n (step s) := rfl

/-- Orbit vertices and orbit edges satisfy the repository incidence relation. -/
theorem orbitEdgeChain {State : Type u} (step : State → State) :
    ∀ n s, EdgeChain (orbitVertices step n s) (orbitEdges step n s)
  | 0, s => .singleton s
  | Nat.succ n, s =>
      .cons s (step s) (orbitTailVertices step n (step s))
        ⟨s, step s⟩ (orbitEdges step n (step s)) rfl rfl
        (orbitEdgeChain step n (step s))

/-- The last orbit vertex is the corresponding transition iterate. -/
theorem orbitVertices_endsAt_iterate {State : Type u} (step : State → State) :
    ∀ n s, ∃ pre,
      orbitVertices step n s = pre ++ [iterate step n s]
  | 0, s => ⟨[], rfl⟩
  | Nat.succ n, s => by
      rcases orbitVertices_endsAt_iterate step n (step s) with ⟨pre, hpre⟩
      refine ⟨s :: pre, ?_⟩
      rw [orbitVertices_succ, hpre]
      rfl

instance payloadQuotientDirectedEdgeDecidableEq :
    DecidableEq (DirectedEdge PayloadQuotientState) := by
  intro e f
  cases e
  cases f
  simp only [DirectedEdge.mk.injEq]
  infer_instance

/-- Every nonterminal encoded transition occurs exactly once in the global edge list. -/
def payloadQuotientEdges : List (DirectedEdge PayloadQuotientState) :=
  orbitEdges intendedEncodedStep 255 ⟨0, by omega⟩

theorem intendedEncodedStep_ne_closed_iff (s : PayloadQuotientState) :
    s ≠ intendedClosedEncoded ↔ s.val < 255 := by
  constructor
  · intro hne
    have hval_ne : s.val ≠ 255 := by
      intro hval
      apply hne
      apply Fin.ext
      simpa [intendedClosedEncoded] using hval
    omega
  · intro hlt heq
    have hval := congrArg Fin.val heq
    simp [intendedClosedEncoded] at hval
    omega

@[simp] theorem intendedEncodedStep_val_of_ne_closed
    (s : PayloadQuotientState) (hne : s ≠ intendedClosedEncoded) :
    (intendedEncodedStep s).val = s.val + 1 := by
  have hlt := (intendedEncodedStep_ne_closed_iff s).1 hne
  simp [intendedEncodedStep, hlt]

@[simp] theorem encodedRemaining_closed :
    encodedRemaining intendedClosedEncoded = 0 := by
  rfl

theorem encodedRemaining_step_of_ne_closed
    (s : PayloadQuotientState) (hne : s ≠ intendedClosedEncoded) :
    encodedRemaining (intendedEncodedStep s) + 1 = encodedRemaining s := by
  have hlt : s.val < 255 :=
    (intendedEncodedStep_ne_closed_iff s).1 hne
  rw [encodedRemaining]
  rw [encodedRemaining]
  rw [intendedEncodedStep_val_of_ne_closed s hne]
  omega

theorem payloadQuotientStepEdge_mem :
    ∀ s : PayloadQuotientState,
      s ≠ intendedClosedEncoded →
        (⟨s, intendedEncodedStep s⟩ : DirectedEdge PayloadQuotientState) ∈
          payloadQuotientEdges := by
  native_decide

/-- Finite dependency graph after quotienting away the preserved payload. -/
def payloadQuotientEncodedStepGraph : DependencyGraph PayloadQuotientState where
  edges := payloadQuotientEdges
  admissible e :=
    e.source ≠ intendedClosedEncoded ∧
      e.target = intendedEncodedStep e.source
  admissible_mem := by
    intro e h
    rcases e with ⟨source, target⟩
    change source ≠ intendedClosedEncoded ∧
      target = intendedEncodedStep source at h
    rcases h with ⟨hsource, htarget⟩
    subst target
    exact payloadQuotientStepEdge_mem source hsource

/-- A bounded orbit uses only admissible encoded-step edges. -/
theorem orbitEdges_admissible_of_le_remaining
    (s : PayloadQuotientState) (n : Nat)
    (hn : n ≤ encodedRemaining s) :
    ∀ e, e ∈ orbitEdges intendedEncodedStep n s →
      payloadQuotientEncodedStepGraph.admissible e := by
  induction n generalizing s with
  | zero =>
      intro e he
      simp [orbitEdges] at he
  | succ n ih =>
      have hs : s ≠ intendedClosedEncoded := by
        intro hs
        subst s
        simp at hn
      have hremaining := encodedRemaining_step_of_ne_closed s hs
      have htail : n ≤ encodedRemaining (intendedEncodedStep s) := by
        omega
      intro e he
      simp only [orbitEdges, List.mem_cons] at he
      rcases he with rfl | he
      · exact ⟨hs, rfl⟩
      · exact ih (s := intendedEncodedStep s) htail e he

/-- The canonical encoded orbit has no repeated vertices. -/
theorem payloadQuotientCanonicalVertices_nodup :
    ∀ s : PayloadQuotientState,
      (orbitVertices intendedEncodedStep (encodedRemaining s) s).Nodup := by
  native_decide

/-- Canonical simple path from any encoded state to the absorbing state. -/
def payloadQuotientCanonicalPath (s : PayloadQuotientState) :
    SimplePath payloadQuotientEncodedStepGraph s intendedClosedEncoded where
  vertices := orbitVertices intendedEncodedStep (encodedRemaining s) s
  pathEdges := orbitEdges intendedEncodedStep (encodedRemaining s) s
  startsAt := ⟨orbitTailVertices intendedEncodedStep (encodedRemaining s) s, rfl⟩
  endsAt := by
    rcases orbitVertices_endsAt_iterate intendedEncodedStep
      (encodedRemaining s) s with ⟨pre, hpre⟩
    refine ⟨pre, ?_⟩
    rw [hpre]
    rw [show encodedRemaining s = 255 - s.val by rfl]
    rw [intendedEncodedStep_reaches_closed]
  incidence := orbitEdgeChain intendedEncodedStep (encodedRemaining s) s
  noRepeatedVertices := payloadQuotientCanonicalVertices_nodup s
  edgeAdmissible :=
    orbitEdges_admissible_of_le_remaining s (encodedRemaining s) (by omega)
  edgeInGraph := by
    intro e he
    exact payloadQuotientEncodedStepGraph.admissible_mem e
      (orbitEdges_admissible_of_le_remaining s (encodedRemaining s) (by omega) e he)

/-- Every admissible edge chain is an initial segment of the deterministic orbit. -/
theorem admissibleEdgeChain_eq_orbit
    {s : PayloadQuotientState} {rest : List PayloadQuotientState}
    {es : List (DirectedEdge PayloadQuotientState)}
    (chain : EdgeChain (s :: rest) es)
    (admissible : ∀ e, e ∈ es →
      payloadQuotientEncodedStepGraph.admissible e) :
    ∃ n,
      s :: rest = orbitVertices intendedEncodedStep n s ∧
      es = orbitEdges intendedEncodedStep n s := by
  induction es generalizing s rest with
  | nil =>
      cases chain with
      | singleton v =>
          exact ⟨0, rfl, rfl⟩
  | cons first tailEdges ih =>
      cases chain with
      | cons _ w vs _ _ hsource htarget tail =>
          have hedge := admissible first (by simp)
          have htail : ∀ f, f ∈ tailEdges →
              payloadQuotientEncodedStepGraph.admissible f := by
            intro f hf
            exact admissible f (by simp [hf])
          rcases ih tail htail with ⟨n, hvertices, hedges⟩
          have hw : w = intendedEncodedStep s := by
            calc
              w = first.target := htarget.symm
              _ = intendedEncodedStep first.source := hedge.2
              _ = intendedEncodedStep s := congrArg intendedEncodedStep hsource
          have hfirst : first = ⟨s, intendedEncodedStep s⟩ := by
            cases first with
            | mk source target =>
                simp only at hsource htarget hedge ⊢
                subst source
                subst target
                simp only at hw
                subst w
                rfl
          subst w
          subst first
          refine ⟨Nat.succ n, ?_, ?_⟩
          · simpa using congrArg (List.cons s) hvertices
          · simpa [orbitEdges] using
              congrArg (List.cons (DirectedEdge.mk s (intendedEncodedStep s))) hedges

/-- Admissibility forbids an orbit from continuing after the absorbing state. -/
theorem admissibleOrbit_length_le_remaining
    (s : PayloadQuotientState) (n : Nat)
    (admissible : ∀ e, e ∈ orbitEdges intendedEncodedStep n s →
      payloadQuotientEncodedStepGraph.admissible e) :
    n ≤ encodedRemaining s := by
  induction n generalizing s with
  | zero => omega
  | succ n ih =>
      have hfirst := admissible
        (⟨s, intendedEncodedStep s⟩ : DirectedEdge PayloadQuotientState)
        (by simp [orbitEdges])
      have htail : ∀ e,
          e ∈ orbitEdges intendedEncodedStep n (intendedEncodedStep s) →
          payloadQuotientEncodedStepGraph.admissible e := by
        intro e he
        exact admissible e (by simp [orbitEdges, he])
      have hn := ih (s := intendedEncodedStep s) htail
      have hremaining := encodedRemaining_step_of_ne_closed s hfirst.1
      omega

/-- Before the remaining rank is exhausted, the iterate has exact unsaturated value. -/
theorem iterate_intendedEncodedStep_val_of_le_remaining
    (n : Nat) (s : PayloadQuotientState)
    (hn : n ≤ encodedRemaining s) :
    (iterate intendedEncodedStep n s).val = s.val + n := by
  induction n generalizing s with
  | zero => rfl
  | succ n ih =>
      have hs : s ≠ intendedClosedEncoded := by
        intro hs
        subst s
        simp at hn
      have hremaining := encodedRemaining_step_of_ne_closed s hs
      have htail : n ≤ encodedRemaining (intendedEncodedStep s) := by
        omega
      simp only [iterate]
      rw [ih (s := intendedEncodedStep s) htail]
      rw [intendedEncodedStep_val_of_ne_closed s hs]
      omega

/-- An orbit ending at `255` cannot be shorter than the remaining rank. -/
theorem orbitEndingAtClosed_remaining_le
    (s : PayloadQuotientState) (n : Nat)
    (hend : ∃ pre,
      orbitVertices intendedEncodedStep n s = pre ++ [intendedClosedEncoded]) :
    encodedRemaining s ≤ n := by
  rcases orbitVertices_endsAt_iterate intendedEncodedStep n s with
    ⟨orbitPre, horbit⟩
  rcases hend with ⟨endPre, hend⟩
  have hiterate : iterate intendedEncodedStep n s = intendedClosedEncoded := by
    have hlast := congrArg List.getLast? (horbit.symm.trans hend)
    simpa using hlast
  apply Nat.le_of_not_gt
  intro hlt
  have hn : n ≤ encodedRemaining s := Nat.le_of_lt hlt
  have hval := iterate_intendedEncodedStep_val_of_le_remaining n s hn
  have hclosed := congrArg Fin.val hiterate
  have hsle : s.val ≤ 255 := by omega
  have hsum : s.val + (255 - s.val) = 255 := by omega
  have hlt255 : s.val + n < 255 := by
    calc
      s.val + n < s.val + (255 - s.val) := Nat.add_lt_add_left hlt s.val
      _ = 255 := hsum
  have heq255 : s.val + n = 255 := by
    rw [← hval]
    simpa [intendedClosedEncoded] using hclosed
  exact (Nat.ne_of_lt hlt255) heq255

/-- The canonical orbit is the unique admissible simple path from `s` to `255`. -/
theorem payloadQuotientCanonicalPath_unique
    (s : PayloadQuotientState)
    (π : SimplePath payloadQuotientEncodedStepGraph s intendedClosedEncoded) :
    π = payloadQuotientCanonicalPath s := by
  rcases π with ⟨vertices, pathEdges, ⟨rest, hstart⟩, hend,
    incidence, nodup, admissible, inGraph⟩
  subst vertices
  rcases admissibleEdgeChain_eq_orbit incidence admissible with
    ⟨n, hvertices, hedges⟩
  have horbitAdmissible : ∀ e,
      e ∈ orbitEdges intendedEncodedStep n s →
      payloadQuotientEncodedStepGraph.admissible e := by
    intro e he
    exact admissible e (by simpa [hedges] using he)
  have hnUpper := admissibleOrbit_length_le_remaining s n horbitAdmissible
  have hendOrbit : ∃ pre,
      orbitVertices intendedEncodedStep n s = pre ++ [intendedClosedEncoded] := by
    rcases hend with ⟨pre, hpre⟩
    exact ⟨pre, hvertices.symm.trans hpre⟩
  have hnLower := orbitEndingAtClosed_remaining_le s n hendOrbit
  have hn : n = encodedRemaining s := by omega
  subst n
  cases hvertices
  cases hedges
  rfl

/-- Singleton finite collection because the admissible simple path is unique. -/
def payloadQuotientCanonicalPathCollection (s : PayloadQuotientState) :
    FinitePathCollection payloadQuotientEncodedStepGraph s intendedClosedEncoded where
  paths := [payloadQuotientCanonicalPath s]
  complete π := by
    rw [payloadQuotientCanonicalPath_unique s π]
    simp

/-- Pointwise encoded closure, independent of the quotient-erased payload. -/
def IntendedEncodedClosureAt (s : PayloadQuotientState) : Prop :=
  ∃ n : Nat, n ≤ 255 ∧
    iterate intendedEncodedStep n s = intendedClosedEncoded

theorem intendedEncodedClosureAt (s : PayloadQuotientState) :
    IntendedEncodedClosureAt s := by
  refine ⟨encodedRemaining s, ?_, ?_⟩
  · simpa [encodedRemaining] using Nat.sub_le 255 s.val
  exact intendedEncodedStep_reaches_closed s

/-- Every quotient edge has zero local defect. -/
def payloadQuotientDefect (_ : DirectedEdge PayloadQuotientState) : Nat := 0

/-- Every quotient edge has identity Boolean charge. -/
def payloadQuotientCharge (_ : DirectedEdge PayloadQuotientState) : Bool := false

theorem payloadQuotientPathHolonomy_trivial
    {s : PayloadQuotientState}
    (π : SimplePath payloadQuotientEncodedStepGraph s intendedClosedEncoded) :
    pathHolonomy boolXorChargeSystem payloadQuotientCharge π =
      boolXorChargeSystem.identity := by
  unfold pathHolonomy
  induction π.pathEdges with
  | nil =>
      rfl
  | cons edge edges ih =>
      simpa [payloadQuotientCharge, boolXorChargeSystem] using ih

/-- The pointwise encoded closure is exactly the zero-defect, trivial-holonomy path condition. -/
theorem intendedEncodedClosure_characterizedByZeroTrivialPath
    (s : PayloadQuotientState) :
    ClosureCharacterizedByZeroTrivialPath
      (G := payloadQuotientEncodedStepGraph)
      (S := s) (T := intendedClosedEncoded)
      boolXorChargeSystem payloadQuotientCharge payloadQuotientDefect
      (IntendedEncodedClosureAt s) := by
  constructor
  · intro hclosure
    refine ⟨payloadQuotientCanonicalPath s, ?_, ?_⟩
    · intro e he
      rfl
    · exact payloadQuotientPathHolonomy_trivial
        (payloadQuotientCanonicalPath s)
  · intro hpath
    exact intendedEncodedClosureAt s

/-- Complete augmented obstruction equation for the payload-quotiented encoded model. -/
theorem payloadQuotientAugmentedObstruction_complete
    (s : PayloadQuotientState) :
    augmentedObstructionB boolXorChargeSystem payloadQuotientCharge
        payloadQuotientDefect (payloadQuotientCanonicalPathCollection s) =
      some (0, 0) ↔ IntendedEncodedClosureAt s := by
  exact augmentedObstructionB_complete_for_characterized_closure
    (G := payloadQuotientEncodedStepGraph)
    (S := s) (T := intendedClosedEncoded)
    boolXorChargeSystem payloadQuotientCharge payloadQuotientDefect
    (payloadQuotientCanonicalPathCollection s)
    (IntendedEncodedClosureAt s)
    (intendedEncodedClosure_characterizedByZeroTrivialPath s)

end ZeroDayRestrictedClosures
