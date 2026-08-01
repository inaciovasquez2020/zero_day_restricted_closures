import intended_zero_day_boundary_surface

universe u

namespace ZeroDayRestrictedClosures

/--
The restricted boundary invariant carried by a terminal state.

It records the two terminal-boundary properties already present in
`ZeroDayBoundarySurface`:

* the terminal state satisfies the restricted terminal-closure predicate;
* every admissible transition from the terminal state is trivial.

This declaration does not imply unrestricted closure.
-/
structure RestrictedBoundaryInvariant
    (State : Type u)
    (AdmissibleStep : State → State → Prop)
    (TerminalClosed : State → Prop)
    (terminal : State) where
  terminal_closed :
    TerminalClosed terminal
  no_terminal_extension :
    ∀ state,
      AdmissibleStep terminal state →
      state = terminal

/--
Every zero-day boundary surface supplies the restricted invariant of its
terminal state.
-/
def restrictedBoundaryInvariantOfZeroDayBoundarySurface
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    RestrictedBoundaryInvariant
      State
      boundary.AdmissibleStep
      TerminalClosed
      boundary.Terminal where
  terminal_closed :=
    boundary.terminal_closed
  no_terminal_extension :=
    boundary.no_terminal_extension

/--
Bridge 2: the `TerminalComposite` constructed from a zero-day boundary carries
the corresponding restricted boundary invariant.
-/
def terminalCompositeRestrictedBoundaryInvariantOfZeroDayBoundarySurface
    {State : Type u}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    RestrictedBoundaryInvariant
      State
      boundary.AdmissibleStep
      TerminalClosed
      (zero_day_boundary_surface_implies_terminal_composite
        boundary).terminal_object := by
  rw [
    zero_day_boundary_surface_terminal_composite_object
      boundary
  ]

  exact
    restrictedBoundaryInvariantOfZeroDayBoundarySurface
      boundary

/--
The boundary invariant's closure field agrees with the restricted-scope proof
inside the generated terminal composite.
-/
theorem terminalCompositeRestrictedBoundaryInvariant_closed
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
    (terminalCompositeRestrictedBoundaryInvariantOfZeroDayBoundarySurface
      boundary).terminal_closed

/--
The concrete intended finite-state terminal composite carries an actual
restricted boundary invariant.
-/
def intendedUnitRestrictedBoundaryInvariant :
    RestrictedBoundaryInvariant
      (IntendedUnrestrictedState Unit)
      (fun current next =>
        next = intendedStep current)
      (fun state =>
        intendedStep state = state)
      intendedUnitTerminalComposite.terminal_object :=
  terminalCompositeRestrictedBoundaryInvariantOfZeroDayBoundarySurface
    intendedUnitZeroDayBoundarySurface

/--
The concrete boundary invariant proves that the intended terminal object is a
fixed point.
-/
theorem intendedUnitRestrictedBoundaryInvariant_closed :
    intendedStep intendedUnitTerminalComposite.terminal_object =
      intendedUnitTerminalComposite.terminal_object := by
  exact
    intendedUnitRestrictedBoundaryInvariant.terminal_closed

/--
The concrete boundary invariant proves that every admissible outgoing step
from the intended terminal object is trivial.
-/
theorem intendedUnitRestrictedBoundaryInvariant_no_extension
    (state : IntendedUnrestrictedState Unit)
    (hStep :
      state =
        intendedStep
          intendedUnitTerminalComposite.terminal_object) :
    state =
      intendedUnitTerminalComposite.terminal_object := by
  exact
    intendedUnitRestrictedBoundaryInvariant.no_terminal_extension
      state
      hStep

/--
The concrete restricted boundary-invariant type is inhabited.
-/
theorem intendedUnitRestrictedBoundaryInvariant_nonempty :
    Nonempty
      (RestrictedBoundaryInvariant
        (IntendedUnrestrictedState Unit)
        (fun current next =>
          next = intendedStep current)
        (fun state =>
          intendedStep state = state)
        intendedUnitTerminalComposite.terminal_object) := by
  exact
    ⟨intendedUnitRestrictedBoundaryInvariant⟩

end ZeroDayRestrictedClosures
