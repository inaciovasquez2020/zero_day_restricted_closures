import core.vasquez_directed_edge
import Std

namespace ZeroDayRestrictedClosures

/-- A finite directed dependency graph, with admissibility restricted to listed edges. -/
structure DependencyGraph (State : Type u) where
  edges : List (DirectedEdge State)
  admissible : DirectedEdge State → Prop
  admissible_mem : ∀ e, admissible e → e ∈ edges

/-- Incidence for a vertex list and its consecutive directed edges. -/
inductive EdgeChain {State : Type u} : List State → List (DirectedEdge State) → Prop
  | singleton (v : State) : EdgeChain [v] []
  | cons (v w : State) (vs : List State) (e : DirectedEdge State)
      (es : List (DirectedEdge State)) (hsource : e.source = v)
      (htarget : e.target = w) (h : EdgeChain (w :: vs) es) :
      EdgeChain (v :: w :: vs) (e :: es)

/-- A graph-supported simple admissible path with explicit endpoints. -/
structure SimplePath {State : Type u} (G : DependencyGraph State) (S T : State) where
  vertices : List State
  pathEdges : List (DirectedEdge State)
  startsAt : ∃ rest, vertices = S :: rest
  endsAt : ∃ pre, vertices = pre ++ [T]
  incidence : EdgeChain vertices pathEdges
  noRepeatedVertices : vertices.Nodup
  edgeAdmissible : ∀ e, e ∈ pathEdges → G.admissible e
  edgeInGraph : ∀ e, e ∈ pathEdges → e ∈ G.edges

/-- The repository-native six Boolean missingness indicators on an edge. -/
structure EdgeDefectBits {State : Type u} (e : DirectedEdge State) where
  m_proof : Bool
  m_witness : Bool
  m_invariant : Bool
  m_verifier : Bool
  m_evidence : Bool
  m_guard : Bool

/-- The six-bit Vasquez edge defect, in proof-to-guard priority order. -/
def deltaB {State : Type u} {e : DirectedEdge State} (m : EdgeDefectBits e) : Nat :=
  32 * m.m_proof.toNat + 16 * m.m_witness.toNat + 8 * m.m_invariant.toNat +
  4 * m.m_verifier.toNat + 2 * m.m_evidence.toNat + m.m_guard.toNat

theorem bool_toNat_mem_bits (b : Bool) : b.toNat = 0 ∨ b.toNat = 1 := by
  cases b <;> simp

/-- Maximum edge defect on a path; the zero-edge path has bottleneck zero. -/
def bottleneckB {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (π : SimplePath G S T) : Nat :=
  π.pathEdges.foldr (fun e current => max (defect e) current) 0

/-- The explicit restricted-system data needed to transport the path bottleneck. -/
structure RestrictedStateEquivalence {State₁ State₂ : Type u}
    (G₁ : DependencyGraph State₁) (G₂ : DependencyGraph State₂)
    (S₁ T₁ : State₁) (S₂ T₂ : State₂)
    (defect₁ : DirectedEdge State₁ → Nat)
    (defect₂ : DirectedEdge State₂ → Nat) where
  stateEquiv : State₁ → State₂
  stateEquiv_bijective :
    (∀ ⦃x y⦄, stateEquiv x = stateEquiv y → x = y) ∧
      (∀ y, ∃ x, stateEquiv x = y)
  source_preserved : stateEquiv S₁ = S₂
  target_preserved : stateEquiv T₁ = T₂
  edgeEquiv : DirectedEdge State₁ → DirectedEdge State₂
  edgeEquiv_bijective :
    (∀ ⦃e f⦄, edgeEquiv e = edgeEquiv f → e = f) ∧
      (∀ f, ∃ e, edgeEquiv e = f)
  edge_source_preserved :
    ∀ e, (edgeEquiv e).source = stateEquiv e.source
  edge_target_preserved :
    ∀ e, (edgeEquiv e).target = stateEquiv e.target
  admissible_iff : ∀ e, G₂.admissible (edgeEquiv e) ↔ G₁.admissible e
  toPath : SimplePath G₁ S₁ T₁ → SimplePath G₂ S₂ T₂
  toPath_bijective :
    (∀ ⦃π ρ⦄, toPath π = toPath ρ → π = ρ) ∧
      (∀ ρ, ∃ π, toPath π = ρ)
  pathEdges_preserved :
    ∀ π, (toPath π).pathEdges = π.pathEdges.map edgeEquiv
  defect_preserved : ∀ e, defect₂ (edgeEquiv e) = defect₁ e

theorem RestrictedStateEquivalence.bottleneckB_preserved
    {State₁ State₂ : Type u}
    {G₁ : DependencyGraph State₁} {G₂ : DependencyGraph State₂}
    {S₁ T₁ : State₁} {S₂ T₂ : State₂}
    {defect₁ : DirectedEdge State₁ → Nat}
    {defect₂ : DirectedEdge State₂ → Nat}
    (equiv : RestrictedStateEquivalence G₁ G₂ S₁ T₁ S₂ T₂
      defect₁ defect₂)
    (π : SimplePath G₁ S₁ T₁) :
    bottleneckB defect₂ (equiv.toPath π) =
      bottleneckB defect₁ π := by
  unfold bottleneckB
  rw [equiv.pathEdges_preserved]
  induction π.pathEdges with
  | nil => rfl
  | cons e es ih =>
      simp [equiv.defect_preserved, ih]

/-- An explicit finite enumeration of every admissible simple path. -/
structure FinitePathCollection {State : Type u} (G : DependencyGraph State)
    (S T : State) where
  paths : List (SimplePath G S T)
  complete : ∀ π : SimplePath G S T, π ∈ paths

def RestrictedStateEquivalence.transportPathCollection
    {State₁ State₂ : Type u}
    {G₁ : DependencyGraph State₁} {G₂ : DependencyGraph State₂}
    {S₁ T₁ : State₁} {S₂ T₂ : State₂}
    {defect₁ : DirectedEdge State₁ → Nat}
    {defect₂ : DirectedEdge State₂ → Nat}
    (equiv : RestrictedStateEquivalence G₁ G₂ S₁ T₁ S₂ T₂
      defect₁ defect₂)
    (P : FinitePathCollection G₁ S₁ T₁) :
    FinitePathCollection G₂ S₂ T₂ where
  paths := P.paths.map equiv.toPath
  complete := by
    intro ρ
    obtain ⟨π, hπ⟩ := equiv.toPath_bijective.2 ρ
    subst ρ
    exact List.mem_map_of_mem (P.complete π)

/-- Minimum in `Nat ∪ {+∞}`, represented by `none = +∞`. -/
def minExtendedNat (x : Nat) (y : Option Nat) : Option Nat :=
  match y with
  | none => some x
  | some z => some (min x z)

/-- The Vasquez obstruction; `none` is exactly the no-path value `+∞`. -/
def obstructionB {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (P : FinitePathCollection G S T) : Option Nat :=
  P.paths.foldr (fun π current => minExtendedNat (bottleneckB defect π) current) none

theorem RestrictedStateEquivalence.obstructionB_preserved
    {State₁ State₂ : Type u}
    {G₁ : DependencyGraph State₁} {G₂ : DependencyGraph State₂}
    {S₁ T₁ : State₁} {S₂ T₂ : State₂}
    {defect₁ : DirectedEdge State₁ → Nat}
    {defect₂ : DirectedEdge State₂ → Nat}
    (equiv : RestrictedStateEquivalence G₁ G₂ S₁ T₁ S₂ T₂
      defect₁ defect₂)
    (P : FinitePathCollection G₁ S₁ T₁) :
    obstructionB defect₂ (equiv.transportPathCollection P) =
      obstructionB defect₁ P := by
  unfold obstructionB RestrictedStateEquivalence.transportPathCollection
  simp only
  induction P.paths with
  | nil => rfl
  | cons π paths ih =>
      simp only [List.map_cons, List.foldr_cons]
      rw [equiv.bottleneckB_preserved, ih]

theorem fold_minExtendedNat_eq_none_iff (xs : List Nat) :
    xs.foldr minExtendedNat none = none ↔ xs = [] := by
  cases xs with
  | nil => simp
  | cons x xs =>
      cases h : xs.foldr minExtendedNat none <;> simp [minExtendedNat, h]

theorem nat_min_eq_zero_iff (x y : Nat) : min x y = 0 ↔ x = 0 ∨ y = 0 := by
  omega

theorem nat_max_eq_zero_iff (x y : Nat) : max x y = 0 ↔ x = 0 ∧ y = 0 := by
  omega

theorem fold_minExtendedNat_eq_zero_iff (xs : List Nat) :
    xs.foldr minExtendedNat none = some 0 ↔ 0 ∈ xs := by
  induction xs with
  | nil => simp
  | cons x xs ih =>
      cases htail : xs.foldr minExtendedNat none with
      | none =>
          have hempty : xs = [] :=
            (fold_minExtendedNat_eq_none_iff xs).mp htail
          subst xs
          simp [minExtendedNat, eq_comm]
      | some z =>
          have hz : z = 0 ↔ 0 ∈ xs := by
            rw [← ih, htail]
            simp
          simp [minExtendedNat, htail, nat_min_eq_zero_iff, hz, eq_comm]

theorem obstructionB_eq_zero_iff_exists_bottleneck_zero
    {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (P : FinitePathCollection G S T) :
    obstructionB defect P = some 0 ↔
      ∃ π : SimplePath G S T, bottleneckB defect π = 0 := by
  rw [show obstructionB defect P =
      (P.paths.map (bottleneckB defect)).foldr minExtendedNat none by
        exact (List.foldr_map).symm]
  rw [fold_minExtendedNat_eq_zero_iff]
  simp only [List.mem_map]
  constructor
  · rintro ⟨π, _, hπ⟩
    exact ⟨π, hπ ▸ rfl⟩
  · rintro ⟨π, hπ⟩
    exact ⟨π, P.complete π, hπ⟩

theorem bottleneckB_eq_zero_iff_all_edges_zero
    {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (π : SimplePath G S T) :
    bottleneckB defect π = 0 ↔
      ∀ e, e ∈ π.pathEdges → defect e = 0 := by
  unfold bottleneckB
  induction π.pathEdges with
  | nil => simp
  | cons e es ih =>
      simp [nat_max_eq_zero_iff, ih]

theorem obstructionB_eq_zero_iff_exists_all_zero_path
    {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (P : FinitePathCollection G S T) :
    obstructionB defect P = some 0 ↔
      ∃ π : SimplePath G S T,
        ∀ e, e ∈ π.pathEdges → defect e = 0 := by
  rw [obstructionB_eq_zero_iff_exists_bottleneck_zero]
  apply exists_congr
  intro π
  exact bottleneckB_eq_zero_iff_all_edges_zero defect π

/-- Weak soundness: unrestricted closure supplies an admissible all-zero path. -/
def ClosureSoundness {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (UnrestrictedClosure : Prop) : Prop :=
  UnrestrictedClosure →
    ∃ π : SimplePath G S T, ∀ e, e ∈ π.pathEdges → defect e = 0

theorem nonzero_obstruction_implies_no_unrestricted_closure
    {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (P : FinitePathCollection G S T)
    (UnrestrictedClosure : Prop)
    (sound : ClosureSoundness (G := G) (S := S) (T := T)
      defect UnrestrictedClosure)
    (hnonzero : obstructionB defect P ≠ some 0) :
    ¬ UnrestrictedClosure := by
  intro hclosure
  apply hnonzero
  exact (obstructionB_eq_zero_iff_exists_all_zero_path defect P).2
    (sound hclosure)

/-- The exact additional bridge needed to turn a zero path into global closure. -/
def ZeroPathGluing {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (UnrestrictedClosure : Prop) : Prop :=
  (∃ π : SimplePath G S T,
      ∀ e, e ∈ π.pathEdges → defect e = 0) →
    UnrestrictedClosure

theorem zero_obstruction_implies_closure_iff_zero_path_gluing
    {State : Type u} {G : DependencyGraph State} {S T : State}
    (defect : DirectedEdge State → Nat) (P : FinitePathCollection G S T)
    (UnrestrictedClosure : Prop) :
    (obstructionB defect P = some 0 → UnrestrictedClosure) ↔
      ZeroPathGluing (G := G) (S := S) (T := T)
        defect UnrestrictedClosure := by
  unfold ZeroPathGluing
  rw [obstructionB_eq_zero_iff_exists_all_zero_path]

inductive DiamondState
  | S | a | b | T
  deriving DecidableEq

def diamondSa : DirectedEdge DiamondState := ⟨.S, .a⟩
def diamondAt : DirectedEdge DiamondState := ⟨.a, .T⟩
def diamondSb : DirectedEdge DiamondState := ⟨.S, .b⟩
def diamondBt : DirectedEdge DiamondState := ⟨.b, .T⟩

def diamondEdges : List (DirectedEdge DiamondState) :=
  [diamondSa, diamondAt, diamondSb, diamondBt]

def diamondGraph : DependencyGraph DiamondState where
  edges := diamondEdges
  admissible e := e ∈ diamondEdges
  admissible_mem := by simp_all

def diamondPathA : SimplePath diamondGraph .S .T where
  vertices := [.S, .a, .T]
  pathEdges := [diamondSa, diamondAt]
  startsAt := ⟨[.a, .T], rfl⟩
  endsAt := ⟨[.S, .a], rfl⟩
  incidence := .cons .S .a [.T] diamondSa [diamondAt] rfl rfl
    (.cons .a .T [] diamondAt [] rfl rfl (.singleton DiamondState.T))
  noRepeatedVertices := by simp
  edgeAdmissible := by simp [diamondGraph, diamondEdges]
  edgeInGraph := by simp [diamondGraph, diamondEdges]

def diamondPathB : SimplePath diamondGraph .S .T where
  vertices := [.S, .b, .T]
  pathEdges := [diamondSb, diamondBt]
  startsAt := ⟨[.b, .T], rfl⟩
  endsAt := ⟨[.S, .b], rfl⟩
  incidence := .cons .S .b [.T] diamondSb [diamondBt] rfl rfl
    (.cons .b .T [] diamondBt [] rfl rfl (.singleton DiamondState.T))
  noRepeatedVertices := by simp
  edgeAdmissible := by simp [diamondGraph, diamondEdges]
  edgeInGraph := by simp [diamondGraph, diamondEdges]

theorem singleton_ending_at_diamondT (x : DiamondState)
    (h : ∃ pre, [x] = pre ++ [.T]) : x = .T := by
  rcases h with ⟨pre, h⟩
  have hr := congrArg List.reverse h
  simp at hr
  exact hr.1

theorem diamond_admissible_from_S (e : DirectedEdge DiamondState)
    (h : diamondGraph.admissible e) (hs : e.source = .S) :
    e = diamondSa ∨ e = diamondSb := by
  simp [diamondGraph, diamondEdges, diamondSa, diamondAt,
    diamondSb, diamondBt] at h
  rcases h with h | h | h | h <;> subst e <;>
    simp_all [diamondSa, diamondSb]

theorem diamond_admissible_from_a (e : DirectedEdge DiamondState)
    (h : diamondGraph.admissible e) (hs : e.source = .a) :
    e = diamondAt := by
  simp [diamondGraph, diamondEdges, diamondSa, diamondAt,
    diamondSb, diamondBt] at h
  rcases h with h | h | h | h <;> subst e <;> simp_all [diamondAt]

theorem diamond_admissible_from_b (e : DirectedEdge DiamondState)
    (h : diamondGraph.admissible e) (hs : e.source = .b) :
    e = diamondBt := by
  simp [diamondGraph, diamondEdges, diamondSa, diamondAt,
    diamondSb, diamondBt] at h
  rcases h with h | h | h | h <;> subst e <;> simp_all [diamondBt]

theorem diamond_no_admissible_from_T (e : DirectedEdge DiamondState)
    (h : diamondGraph.admissible e) (hs : e.source = .T) : False := by
  simp [diamondGraph, diamondEdges, diamondSa, diamondAt,
    diamondSb, diamondBt] at h
  rcases h with h | h | h | h <;> subst e <;> simp_all

theorem diamond_paths_complete (π : SimplePath diamondGraph .S .T) :
    π = diamondPathA ∨ π = diamondPathB := by
  rcases π with ⟨vertices, pathEdges, ⟨rest, rfl⟩, hend,
    incidence, nodup, admissible, inGraph⟩
  cases incidence with
  | singleton =>
      have h := singleton_ending_at_diamondT .S hend
      contradiction
  | cons v w vs e es hs ht tail =>
      have he := diamond_admissible_from_S e (admissible e (by simp)) hs
      rcases he with he | he
      · subst e
        simp [diamondSa] at ht
        subst w
        cases tail with
        | singleton =>
            rcases hend with ⟨pre, h⟩
            have hr := congrArg List.reverse h
            simp at hr
        | cons v w vs e es hs ht tail =>
            have he := diamond_admissible_from_a e
              (admissible e (by simp)) hs
            subst e
            simp [diamondAt] at ht
            subst w
            cases tail with
            | singleton =>
                left
                simp [diamondPathA]
            | cons v w vs e es hs ht tail =>
                exact (diamond_no_admissible_from_T e
                  (admissible e (by simp)) hs).elim
      · subst e
        simp [diamondSb] at ht
        subst w
        cases tail with
        | singleton =>
            rcases hend with ⟨pre, h⟩
            have hr := congrArg List.reverse h
            simp at hr
        | cons v w vs e es hs ht tail =>
            have he := diamond_admissible_from_b e
              (admissible e (by simp)) hs
            subst e
            simp [diamondBt] at ht
            subst w
            cases tail with
            | singleton =>
                right
                simp [diamondPathB]
            | cons v w vs e es hs ht tail =>
                exact (diamond_no_admissible_from_T e
                  (admissible e (by simp)) hs).elim

def diamondPathCollection : FinitePathCollection diamondGraph .S .T where
  paths := [diamondPathA, diamondPathB]
  complete π := by
    rcases diamond_paths_complete π with h | h <;> subst π <;> simp

def diamondDefectX (e : DirectedEdge DiamondState) : Nat :=
  match e.source, e.target with
  | .S, .b | .b, .T => 1
  | _, _ => 0

def diamondDefectY (e : DirectedEdge DiamondState) : Nat :=
  match e.source, e.target with
  | .a, .T | .S, .b => 1
  | _, _ => 0

theorem diamond_equal_coarse_data_different_obstruction :
    ([DiamondState.S, .a, .b, .T].length =
      [DiamondState.S, .a, .b, .T].length) ∧
    diamondGraph.edges.length = diamondGraph.edges.length ∧
    diamondGraph.edges = diamondGraph.edges ∧
    List.Perm (diamondEdges.map diamondDefectX)
      (diamondEdges.map diamondDefectY) ∧
    List.Perm ([diamondSa, diamondSb].map diamondDefectX)
      ([diamondSa, diamondSb].map diamondDefectY) ∧
    List.Perm ([diamondAt, diamondBt].map diamondDefectX)
      ([diamondAt, diamondBt].map diamondDefectY) ∧
    obstructionB diamondDefectX diamondPathCollection = some 0 ∧
    obstructionB diamondDefectY diamondPathCollection = some 1 ∧
    obstructionB diamondDefectX diamondPathCollection ≠
      obstructionB diamondDefectY diamondPathCollection := by
  refine ⟨rfl, rfl, rfl, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · decide
  · decide
  · decide
  · rfl
  · rfl
  · decide

inductive ParityState
  | S | M | T
  deriving DecidableEq

def paritySM : DirectedEdge ParityState := ⟨.S, .M⟩
def parityMT : DirectedEdge ParityState := ⟨.M, .T⟩

def parityGraph : DependencyGraph ParityState where
  edges := [paritySM, parityMT]
  admissible e := e = paritySM ∨ e = parityMT
  admissible_mem := by
    intro e h
    rcases h with rfl | rfl <;> simp

def parityPath : SimplePath parityGraph .S .T where
  vertices := [.S, .M, .T]
  pathEdges := [paritySM, parityMT]
  startsAt := ⟨[.M, .T], rfl⟩
  endsAt := ⟨[.S, .M], rfl⟩
  incidence := .cons .S .M [.T] paritySM [parityMT] rfl rfl
    (.cons .M .T [] parityMT [] rfl rfl (.singleton ParityState.T))
  noRepeatedVertices := by simp
  edgeAdmissible := by simp [parityGraph]
  edgeInGraph := by simp [parityGraph]

theorem parity_path_complete (π : SimplePath parityGraph .S .T) :
    π = parityPath := by
  rcases π with ⟨vertices, pathEdges, ⟨rest, rfl⟩, hend,
    incidence, nodup, admissible, inGraph⟩
  cases incidence with
  | singleton =>
      rcases hend with ⟨pre, h⟩
      have hr := congrArg List.reverse h
      simp at hr
  | cons v w vs e es hs ht tail =>
      have he := admissible e (by simp)
      simp [parityGraph, paritySM, parityMT] at he
      rcases he with he | he
      · subst e
        simp [paritySM] at ht
        subst w
        cases tail with
        | singleton =>
            rcases hend with ⟨pre, h⟩
            have hr := congrArg List.reverse h
            simp at hr
        | cons v w vs e es hs ht tail =>
            have he := admissible e (by simp)
            simp [parityGraph, paritySM, parityMT] at he
            rcases he with he | he
            · subst e; simp [paritySM] at hs
            · subst e
              simp [parityMT] at ht
              subst w
              cases tail with
              | singleton => simp [parityPath, paritySM, parityMT]
              | cons v w vs e es hs ht tail =>
                  have he := admissible e (by simp)
                  simp [parityGraph, paritySM, parityMT] at he
                  rcases he with he | he
                  · subst e
                    simp [paritySM] at hs
                  · subst e
                    simp [parityMT] at hs
      · subst e
        simp [parityMT] at hs

def parityPathCollection : FinitePathCollection parityGraph .S .T where
  paths := [parityPath]
  complete π := by
    rw [parity_path_complete π]
    simp

def parityDefect (_ : DirectedEdge ParityState) : Nat := 0

def parityCharge (e : DirectedEdge ParityState) : Bool :=
  match e.source, e.target with
  | .S, .M => true
  | _, _ => false

def parityEvenCompatibility : Prop :=
  parityPath.pathEdges.foldr (fun e total => parityCharge e != total) false = false

def parityUnrestrictedClosure : Prop := parityEvenCompatibility

theorem zero_obstruction_global_parity_counterexample :
    obstructionB parityDefect parityPathCollection = some 0 ∧
    ¬ parityUnrestrictedClosure ∧
    ¬ ZeroPathGluing (G := parityGraph) (S := .S) (T := .T)
      parityDefect parityUnrestrictedClosure := by
  refine ⟨rfl, ?_, ?_⟩
  · simp [parityUnrestrictedClosure, parityEvenCompatibility, parityPath,
      parityCharge, paritySM, parityMT]
  · intro gluing
    have closure := gluing ⟨parityPath, by simp [parityDefect]⟩
    have hnot : ¬ parityUnrestrictedClosure := by
      simp [parityUnrestrictedClosure, parityEvenCompatibility, parityPath,
        parityCharge, paritySM, parityMT]
    exact hnot closure

theorem zero_obstruction_not_sufficient_without_gluing :
    ∃ (UnrestrictedClosure : Prop),
      obstructionB parityDefect parityPathCollection = some 0 ∧
      ¬ UnrestrictedClosure := by
  exact ⟨parityUnrestrictedClosure,
    zero_obstruction_global_parity_counterexample.1,
    zero_obstruction_global_parity_counterexample.2.1⟩

end ZeroDayRestrictedClosures
