import core.vasquez_obstruction

namespace ZeroDayRestrictedClosures

/-- The minimal charge data needed for ordered path holonomy. -/
structure ChargeSystem (Charge : Type u) where
  identity : Charge
  compose : Charge → Charge → Charge
  compose_assoc : ∀ a b c, compose (compose a b) c = compose a (compose b c)
  identity_compose : ∀ a, compose identity a = a
  compose_identity : ∀ a, compose a identity = a
  decidableEq : DecidableEq Charge

/-- Ordered composition of edge charges along a path. -/
def pathHolonomy {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (π : SimplePath G S T) : Charge :=
  π.pathEdges.foldl (fun total e => chargeSystem.compose total (charge e))
    chargeSystem.identity

/-- Zero precisely for trivial holonomy, and one otherwise. -/
def holonomyBit {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (π : SimplePath G S T) : Nat :=
  letI := chargeSystem.decidableEq
  if @pathHolonomy Charge chargeSystem State G S T charge π =
      chargeSystem.identity then 0 else 1

theorem holonomyBit_eq_zero_or_one {Charge : Type u}
    (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (π : SimplePath G S T) :
    holonomyBit chargeSystem charge π = 0 ∨
      holonomyBit chargeSystem charge π = 1 := by
  letI := chargeSystem.decidableEq
  by_cases h : pathHolonomy chargeSystem charge π = chargeSystem.identity
  · left; simp [holonomyBit, h]
  · right; simp [holonomyBit, h]

theorem holonomyBit_eq_zero_iff {Charge : Type u}
    (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (π : SimplePath G S T) :
    holonomyBit chargeSystem charge π = 0 ↔
      pathHolonomy chargeSystem charge π = chargeSystem.identity := by
  letI := chargeSystem.decidableEq
  simp [holonomyBit]

def augmentedPathCost {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (π : SimplePath G S T) : Nat × Nat :=
  (bottleneckB defect π, holonomyBit chargeSystem charge π)

def lexMinNatPair (a b : Nat × Nat) : Nat × Nat :=
  if a.1 < b.1 then a
  else if b.1 < a.1 then b
  else if a.2 ≤ b.2 then a else b

def minExtendedNatPair (x : Nat × Nat) (y : Option (Nat × Nat)) :
    Option (Nat × Nat) :=
  match y with
  | none => some x
  | some z => some (lexMinNatPair x z)

def augmentedObstructionB {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (P : FinitePathCollection G S T) : Option (Nat × Nat) :=
  P.paths.foldr
    (fun π current =>
      minExtendedNatPair (augmentedPathCost chargeSystem charge defect π) current)
    none

theorem lexMinNatPair_fst (a b : Nat × Nat) :
    (lexMinNatPair a b).1 = min a.1 b.1 := by
  unfold lexMinNatPair
  split <;> rename_i h₁
  · omega
  · split <;> rename_i h₂
    · omega
    · have : a.1 = b.1 := by omega
      split <;> simp [this]

theorem augmentedObstructionB_first_component {Charge : Type u}
    (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (P : FinitePathCollection G S T) :
    Option.map Prod.fst (augmentedObstructionB chargeSystem charge defect P) =
      obstructionB defect P := by
  unfold augmentedObstructionB obstructionB
  induction P.paths with
  | nil => rfl
  | cons π paths ih =>
      simp only [List.foldr_cons]
      rw [← ih]
      cases h : paths.foldr
        (fun π current =>
          minExtendedNatPair
            (augmentedPathCost chargeSystem charge defect π) current) none with
      | none =>
          simp [minExtendedNatPair, minExtendedNat, h, augmentedPathCost]
      | some p =>
          simp [minExtendedNatPair, minExtendedNat, h, augmentedPathCost,
            lexMinNatPair_fst]

theorem lexMinNatPair_eq_zero_iff (a b : Nat × Nat) :
    lexMinNatPair a b = (0, 0) ↔ a = (0, 0) ∨ b = (0, 0) := by
  rcases a with ⟨a₁, a₂⟩
  rcases b with ⟨b₁, b₂⟩
  simp only [lexMinNatPair, Prod.fst, Prod.snd]
  split <;> rename_i h₁
  · have : b₁ ≠ 0 := by omega
    simp [this]
  · split <;> rename_i h₂
    · have : a₁ ≠ 0 := by omega
      simp [this]
    · have heq : a₁ = b₁ := by omega
      subst b₁
      split <;> rename_i h₃ <;> simp_all <;> omega

theorem fold_minExtendedNatPair_eq_zero_iff (xs : List (Nat × Nat)) :
    xs.foldr minExtendedNatPair none = some (0, 0) ↔ (0, 0) ∈ xs := by
  induction xs with
  | nil => simp
  | cons x xs ih =>
      cases h : xs.foldr minExtendedNatPair none with
      | none =>
          have hempty : xs = [] := by
            cases xs with
            | nil => rfl
            | cons y ys =>
                simp only [List.foldr_cons, minExtendedNatPair] at h
                split at h <;> contradiction
          subst xs
          simp [minExtendedNatPair, eq_comm]
      | some y =>
          have hy : y = (0, 0) ↔ (0, 0) ∈ xs := by
            rw [← ih, h]
            simp
          simp only [List.foldr_cons, h, minExtendedNatPair]
          simp only [Option.some.injEq, List.mem_cons]
          change lexMinNatPair x y = (0, 0) ↔ _
          rw [lexMinNatPair_eq_zero_iff, hy]
          simp [eq_comm]

theorem augmentedObstructionB_eq_zero_iff_exists_zero_trivial_path
    {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (P : FinitePathCollection G S T) :
    augmentedObstructionB chargeSystem charge defect P = some (0, 0) ↔
      ∃ π : SimplePath G S T,
        (∀ e, e ∈ π.pathEdges → defect e = 0) ∧
        pathHolonomy chargeSystem charge π = chargeSystem.identity := by
  rw [show augmentedObstructionB chargeSystem charge defect P =
      (P.paths.map (augmentedPathCost chargeSystem charge defect)).foldr
        minExtendedNatPair none by
      exact (List.foldr_map).symm]
  rw [fold_minExtendedNatPair_eq_zero_iff]
  simp only [List.mem_map]
  constructor
  · rintro ⟨π, hmem, hcost⟩
    refine ⟨π, ?_, ?_⟩
    · apply (bottleneckB_eq_zero_iff_all_edges_zero defect π).1
      simpa [augmentedPathCost] using congrArg Prod.fst hcost
    · apply (holonomyBit_eq_zero_iff chargeSystem charge π).1
      simpa [augmentedPathCost] using congrArg Prod.snd hcost
  · rintro ⟨π, hlocal, hhol⟩
    refine ⟨π, P.complete π, ?_⟩
    simp [augmentedPathCost,
      (bottleneckB_eq_zero_iff_all_edges_zero defect π).2 hlocal,
      (holonomyBit_eq_zero_iff chargeSystem charge π).2 hhol]

def ClosureCharacterizedByZeroTrivialPath {Charge : Type u}
    (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (UnrestrictedClosure : Prop) : Prop :=
  UnrestrictedClosure ↔
    ∃ π : SimplePath G S T,
      (∀ e, e ∈ π.pathEdges → defect e = 0) ∧
      pathHolonomy chargeSystem charge π = chargeSystem.identity

theorem augmentedObstructionB_complete_for_characterized_closure
    {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State : Type v} {G : DependencyGraph State} {S T : State}
    (charge : DirectedEdge State → Charge) (defect : DirectedEdge State → Nat)
    (P : FinitePathCollection G S T) (UnrestrictedClosure : Prop)
    (characterized : ClosureCharacterizedByZeroTrivialPath
      (G := G) (S := S) (T := T) chargeSystem charge defect
      UnrestrictedClosure) :
    augmentedObstructionB chargeSystem charge defect P = some (0, 0) ↔
      UnrestrictedClosure := by
  rw [augmentedObstructionB_eq_zero_iff_exists_zero_trivial_path]
  exact characterized.symm

structure ChargePreservingRestrictedStateEquivalence
    {Charge : Type u} (chargeSystem : ChargeSystem Charge)
    {State₁ State₂ : Type v}
    (G₁ : DependencyGraph State₁) (G₂ : DependencyGraph State₂)
    (S₁ T₁ : State₁) (S₂ T₂ : State₂)
    (charge₁ : DirectedEdge State₁ → Charge)
    (charge₂ : DirectedEdge State₂ → Charge)
    (defect₁ : DirectedEdge State₁ → Nat)
    (defect₂ : DirectedEdge State₂ → Nat) where
  restricted : RestrictedStateEquivalence G₁ G₂ S₁ T₁ S₂ T₂ defect₁ defect₂
  charge_preserved : ∀ e, charge₂ (restricted.edgeEquiv e) = charge₁ e

theorem foldl_charge_map_preserved {Charge : Type u}
    (chargeSystem : ChargeSystem Charge)
    {State₁ State₂ : Type v}
    (edgeEquiv : DirectedEdge State₁ → DirectedEdge State₂)
    (charge₁ : DirectedEdge State₁ → Charge)
    (charge₂ : DirectedEdge State₂ → Charge)
    (hcharge : ∀ e, charge₂ (edgeEquiv e) = charge₁ e)
    (es : List (DirectedEdge State₁)) (initial : Charge) :
    (es.map edgeEquiv).foldl
        (fun total e => chargeSystem.compose total (charge₂ e)) initial =
      es.foldl (fun total e => chargeSystem.compose total (charge₁ e)) initial := by
  induction es generalizing initial with
  | nil => rfl
  | cons e es ih =>
      simp [hcharge, ih]

theorem ChargePreservingRestrictedStateEquivalence.pathHolonomy_preserved
    {Charge : Type u} {chargeSystem : ChargeSystem Charge}
    {State₁ State₂ : Type v}
    {G₁ : DependencyGraph State₁} {G₂ : DependencyGraph State₂}
    {S₁ T₁ : State₁} {S₂ T₂ : State₂}
    {charge₁ : DirectedEdge State₁ → Charge}
    {charge₂ : DirectedEdge State₂ → Charge}
    {defect₁ : DirectedEdge State₁ → Nat}
    {defect₂ : DirectedEdge State₂ → Nat}
    (equiv : ChargePreservingRestrictedStateEquivalence chargeSystem
      G₁ G₂ S₁ T₁ S₂ T₂ charge₁ charge₂ defect₁ defect₂)
    (π : SimplePath G₁ S₁ T₁) :
    pathHolonomy chargeSystem charge₂ (equiv.restricted.toPath π) =
      pathHolonomy chargeSystem charge₁ π := by
  unfold pathHolonomy
  rw [equiv.restricted.pathEdges_preserved]
  exact foldl_charge_map_preserved chargeSystem equiv.restricted.edgeEquiv
    charge₁ charge₂ equiv.charge_preserved π.pathEdges chargeSystem.identity

theorem ChargePreservingRestrictedStateEquivalence.augmentedObstructionB_preserved
    {Charge : Type u} {chargeSystem : ChargeSystem Charge}
    {State₁ State₂ : Type v}
    {G₁ : DependencyGraph State₁} {G₂ : DependencyGraph State₂}
    {S₁ T₁ : State₁} {S₂ T₂ : State₂}
    {charge₁ : DirectedEdge State₁ → Charge}
    {charge₂ : DirectedEdge State₂ → Charge}
    {defect₁ : DirectedEdge State₁ → Nat}
    {defect₂ : DirectedEdge State₂ → Nat}
    (equiv : ChargePreservingRestrictedStateEquivalence chargeSystem
      G₁ G₂ S₁ T₁ S₂ T₂ charge₁ charge₂ defect₁ defect₂)
    (P : FinitePathCollection G₁ S₁ T₁) :
    augmentedObstructionB chargeSystem charge₂ defect₂
        (equiv.restricted.transportPathCollection P) =
      augmentedObstructionB chargeSystem charge₁ defect₁ P := by
  unfold augmentedObstructionB RestrictedStateEquivalence.transportPathCollection
  simp only
  induction P.paths with
  | nil => rfl
  | cons π paths ih =>
      simp only [List.map_cons, List.foldr_cons]
      rw [ih]
      have hcost :
          augmentedPathCost chargeSystem charge₂ defect₂
              (equiv.restricted.toPath π) =
            augmentedPathCost chargeSystem charge₁ defect₁ π := by
        apply Prod.ext
        · exact equiv.restricted.bottleneckB_preserved π
        · letI := chargeSystem.decidableEq
          simp [augmentedPathCost, holonomyBit,
            equiv.pathHolonomy_preserved π]
      rw [hcost]

def boolXorChargeSystem : ChargeSystem Bool where
  identity := false
  compose := xor
  compose_assoc := by decide
  identity_compose := by decide
  compose_identity := by decide
  decidableEq := inferInstance

theorem parity_augmented_obstruction_value :
    augmentedObstructionB boolXorChargeSystem parityCharge parityDefect
      parityPathCollection = some (0, 1) := by
  rfl

theorem vasquez_local_component_alone_incomplete :
    obstructionB parityDefect parityPathCollection = some 0 ∧
    ¬ parityUnrestrictedClosure ∧
    augmentedObstructionB boolXorChargeSystem parityCharge parityDefect
      parityPathCollection ≠ some (0, 0) := by
  exact ⟨zero_obstruction_global_parity_counterexample.1,
    zero_obstruction_global_parity_counterexample.2.1, by
      rw [parity_augmented_obstruction_value]
      decide⟩

def holonomyOnlyCharge (_ : DirectedEdge ParityState) : Bool := false

def holonomyOnlyDefect (e : DirectedEdge ParityState) : Nat :=
  match e.source, e.target with
  | .S, .M => 1
  | _, _ => 0

def holonomyOnlyUnrestrictedClosure : Prop :=
  ∃ π : SimplePath parityGraph .S .T,
    (∀ e, e ∈ π.pathEdges → holonomyOnlyDefect e = 0) ∧
    pathHolonomy boolXorChargeSystem holonomyOnlyCharge π =
      boolXorChargeSystem.identity

theorem holonomy_component_alone_incomplete :
    holonomyBit boolXorChargeSystem holonomyOnlyCharge parityPath = 0 ∧
    obstructionB holonomyOnlyDefect parityPathCollection = some 1 ∧
    ¬ holonomyOnlyUnrestrictedClosure ∧
    augmentedObstructionB boolXorChargeSystem holonomyOnlyCharge
      holonomyOnlyDefect parityPathCollection ≠ some (0, 0) := by
  refine ⟨rfl, rfl, ?_, by decide⟩
  rintro ⟨π, hlocal, hhol⟩
  rw [parity_path_complete π] at hlocal
  have := hlocal paritySM (by simp [parityPath])
  simp [holonomyOnlyDefect, paritySM] at this

theorem augmented_obstruction_minimal_complete :
    (∀ {Charge : Type u} (chargeSystem : ChargeSystem Charge)
        {State : Type v} {G : DependencyGraph State} {S T : State}
        (charge : DirectedEdge State → Charge)
        (defect : DirectedEdge State → Nat)
        (P : FinitePathCollection G S T) (UnrestrictedClosure : Prop),
        ClosureCharacterizedByZeroTrivialPath
          (G := G) (S := S) (T := T) chargeSystem charge defect
          UnrestrictedClosure →
        (augmentedObstructionB chargeSystem charge defect P = some (0, 0) ↔
          UnrestrictedClosure)) ∧
    (obstructionB parityDefect parityPathCollection = some 0 ∧
      ¬ parityUnrestrictedClosure ∧
      augmentedObstructionB boolXorChargeSystem parityCharge parityDefect
        parityPathCollection ≠ some (0, 0)) ∧
    (holonomyBit boolXorChargeSystem holonomyOnlyCharge parityPath = 0 ∧
      obstructionB holonomyOnlyDefect parityPathCollection = some 1 ∧
      ¬ holonomyOnlyUnrestrictedClosure ∧
      augmentedObstructionB boolXorChargeSystem holonomyOnlyCharge
        holonomyOnlyDefect parityPathCollection ≠ some (0, 0)) := by
  refine ⟨?_, vasquez_local_component_alone_incomplete,
    holonomy_component_alone_incomplete⟩
  intro Charge chargeSystem State G S T charge defect P closure h
  exact augmentedObstructionB_complete_for_characterized_closure
    chargeSystem charge defect P closure h

end ZeroDayRestrictedClosures
