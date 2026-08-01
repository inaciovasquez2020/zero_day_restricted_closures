import restricted_boundary_invariant

universe u

namespace ZeroDayRestrictedClosures

/--
A target-realization witness for the restricted lift-source chain.

The supplied terminal composite must contain exactly the terminal state of the
boundary construction, be reachable from the initial state, and retain the
restricted terminal predicate.

No unrestricted closure conclusion follows.
-/
structure TargetRealizesRestrictedLiftSourceChainComposition
    (State : Type u)
    (ReachableBy :
      (State → State → Prop) → State → State → Prop)
    (TerminalClosed : State → Prop)
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed)
    (terminal :
      TerminalComposite
        (ZeroDayBoundarySurface State ReachableBy TerminalClosed)
        State
        TerminalClosed) where
  terminal_object_matches :
    terminal.terminal_object =
      boundary.Terminal
  restricted_chain_reachable :
    ReachableBy
      boundary.AdmissibleStep
      boundary.Initial
      terminal.terminal_object
  restricted_scope_realized :
    TerminalClosed terminal.terminal_object

/--
Bridge 3: a zero-day boundary realizes the restricted source-chain composition
of the terminal composite generated from that boundary.
-/
def targetRealizesRestrictedLiftSourceChainCompositionOfZeroDayBoundarySurface
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    TargetRealizesRestrictedLiftSourceChainComposition
      State
      ReachableBy
      TerminalClosed
      boundary
      (zero_day_boundary_surface_implies_terminal_composite boundary) where
  terminal_object_matches :=
    zero_day_boundary_surface_terminal_composite_object
      boundary

  restricted_chain_reachable := by
    rw [
      zero_day_boundary_surface_terminal_composite_object
        boundary
    ]
    exact boundary.terminal_reachable

  restricted_scope_realized := by
    exact
      (zero_day_boundary_surface_implies_terminal_composite
        boundary).restricted_scope_guard

/--
The generic realization identifies the generated terminal object with the
boundary terminal.
-/
theorem targetRealizesRestrictedLiftSourceChainComposition_terminal
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    (zero_day_boundary_surface_implies_terminal_composite
      boundary).terminal_object =
      boundary.Terminal := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.terminal_object_matches
      (targetRealizesRestrictedLiftSourceChainCompositionOfZeroDayBoundarySurface
        boundary)

/--
The generic realization exposes reachability from the initial state to the
generated terminal object.
-/
theorem targetRealizesRestrictedLiftSourceChainComposition_reachable
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    ReachableBy
      boundary.AdmissibleStep
      boundary.Initial
      (zero_day_boundary_surface_implies_terminal_composite
        boundary).terminal_object := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.restricted_chain_reachable
      (targetRealizesRestrictedLiftSourceChainCompositionOfZeroDayBoundarySurface
        boundary)

/--
The generated terminal composite retains its restricted-scope evidence.
-/
theorem targetRealizesRestrictedLiftSourceChainComposition_scope
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    TerminalClosed
      (zero_day_boundary_surface_implies_terminal_composite
        boundary).terminal_object := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.restricted_scope_realized
      (targetRealizesRestrictedLiftSourceChainCompositionOfZeroDayBoundarySurface
        boundary)

/--
The concrete intended finite-state terminal composite realizes its restricted
source-chain composition.
-/
def intendedUnitTargetRealizesRestrictedLiftSourceChainComposition :
    TargetRealizesRestrictedLiftSourceChainComposition
      (IntendedUnrestrictedState Unit)
      (fun step => StepReachableBy step)
      (fun state => intendedStep state = state)
      intendedUnitZeroDayBoundarySurface
      intendedUnitTerminalComposite :=
  targetRealizesRestrictedLiftSourceChainCompositionOfZeroDayBoundarySurface
    intendedUnitZeroDayBoundarySurface

/--
The concrete realization reaches the intended terminal composite from the
concrete initial state.
-/
theorem intendedUnitTargetRealization_reachable :
    StepReachableBy
      (fun current next =>
        next = intendedStep current)
      intendedUnitInitialState
      intendedUnitTerminalComposite.terminal_object := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.restricted_chain_reachable
      intendedUnitTargetRealizesRestrictedLiftSourceChainComposition

/--
The concrete realization identifies the terminal-composite object with the
terminal state of the concrete boundary.
-/
theorem intendedUnitTargetRealization_terminal_object :
    intendedUnitTerminalComposite.terminal_object =
      intendedUnitZeroDayBoundarySurface.Terminal := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.terminal_object_matches
      intendedUnitTargetRealizesRestrictedLiftSourceChainComposition

/--
The concrete realization retains the restricted terminal fixed-point proof.
-/
theorem intendedUnitTargetRealization_restricted_scope :
    intendedStep intendedUnitTerminalComposite.terminal_object =
      intendedUnitTerminalComposite.terminal_object := by
  exact
    TargetRealizesRestrictedLiftSourceChainComposition.restricted_scope_realized
      intendedUnitTargetRealizesRestrictedLiftSourceChainComposition

/--
The concrete target-realization type is inhabited.
-/
theorem intendedUnitTargetRealization_nonempty :
    Nonempty
      (TargetRealizesRestrictedLiftSourceChainComposition
        (IntendedUnrestrictedState Unit)
        (fun step => StepReachableBy step)
        (fun state => intendedStep state = state)
        intendedUnitZeroDayBoundarySurface
        intendedUnitTerminalComposite) := by
  exact
    ⟨intendedUnitTargetRealizesRestrictedLiftSourceChainComposition⟩

end ZeroDayRestrictedClosures
