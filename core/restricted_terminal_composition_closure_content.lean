universe u v

/--
Restricted-only terminal-composition content.

This carrier contains a terminal composite together with an explicit proof that
its use remains inside its supplied restricted scope.
-/
structure RestrictedTerminalCompositionClosureContent
    (TerminalComposite : Type u) where
  terminalComposite : TerminalComposite
  restrictedScope : Prop
  restrictedScopeProof : restrictedScope

/--
The exact projection interface required to extract restricted terminal-
composition content from a restricted composition target.

No unrestricted closure operation is included.
-/
structure RestrictedCompositionTargetExtraction
    (RestrictedCompositionTarget : Type u)
    (TerminalComposite : Type v) where
  terminalComposite :
    RestrictedCompositionTarget → TerminalComposite
  restrictedScope :
    RestrictedCompositionTarget → Prop
  restrictedScopeProof :
    ∀ target, restrictedScope target

/--
Extract restricted terminal-composition content from a target carrying the
required terminal projection and restricted-scope proof.
-/
def extractRestrictedTerminalCompositionClosureContent
    {RestrictedCompositionTarget : Type u}
    {TerminalComposite : Type v}
    (source :
      RestrictedCompositionTargetExtraction
        RestrictedCompositionTarget
        TerminalComposite)
    (target : RestrictedCompositionTarget) :
    RestrictedTerminalCompositionClosureContent TerminalComposite where
  terminalComposite := source.terminalComposite target
  restrictedScope := source.restrictedScope target
  restrictedScopeProof := source.restrictedScopeProof target

/--
The extracted content retains the restricted-scope proof supplied by the
target-extraction interface.
-/
theorem extractRestrictedTerminalCompositionClosureContent_restricted
    {RestrictedCompositionTarget : Type u}
    {TerminalComposite : Type v}
    (source :
      RestrictedCompositionTargetExtraction
        RestrictedCompositionTarget
        TerminalComposite)
    (target : RestrictedCompositionTarget) :
    (extractRestrictedTerminalCompositionClosureContent source target).restrictedScope := by
  exact source.restrictedScopeProof target

namespace ZeroDayRestrictedClosures

universe w

/--
A formal model of the restricted composition target fields recorded by the
repository's target-definition surface.
-/
structure RestrictedCompositionTargetModel
    (TerminalComposite : Type w) where
  terminalRestrictedComposite : TerminalComposite
  restrictedBoundaryInvariant : Prop
  restrictedBoundaryInvariantProof : restrictedBoundaryInvariant
  restrictedChainRealization : Prop
  restrictedChainRealizationProof : restrictedChainRealization
  restrictedScopeGuard : Prop
  restrictedScopeGuardProof : restrictedScopeGuard

/--
The concrete extraction interface for the formal restricted target model.

The extracted scope requires all three restricted guards carried by the target.
-/
def restrictedCompositionTargetModelExtraction
    {TerminalComposite : Type w} :
    RestrictedCompositionTargetExtraction
      (RestrictedCompositionTargetModel TerminalComposite)
      TerminalComposite where
  terminalComposite :=
    fun target => target.terminalRestrictedComposite
  restrictedScope :=
    fun target =>
      target.restrictedBoundaryInvariant ∧
        target.restrictedChainRealization ∧
        target.restrictedScopeGuard
  restrictedScopeProof :=
    fun target =>
      ⟨target.restrictedBoundaryInvariantProof,
        ⟨target.restrictedChainRealizationProof,
          target.restrictedScopeGuardProof⟩⟩

/--
Extract restricted terminal-composition content from the formal target model.
-/
def restrictedCompositionTargetModelClosureContent
    {TerminalComposite : Type w}
    (target : RestrictedCompositionTargetModel TerminalComposite) :
    RestrictedTerminalCompositionClosureContent TerminalComposite :=
  extractRestrictedTerminalCompositionClosureContent
    restrictedCompositionTargetModelExtraction
    target

/-- Extraction preserves the terminal-composite field exactly. -/
theorem restrictedCompositionTargetModelClosureContent_terminalComposite
    {TerminalComposite : Type w}
    (target : RestrictedCompositionTargetModel TerminalComposite) :
    (restrictedCompositionTargetModelClosureContent target).terminalComposite =
      target.terminalRestrictedComposite := by
  rfl

/-- The extracted object retains its complete restricted-scope proof. -/
theorem restrictedCompositionTargetModelClosureContent_restricted
    {TerminalComposite : Type w}
    (target : RestrictedCompositionTargetModel TerminalComposite) :
    (restrictedCompositionTargetModelClosureContent target).restrictedScope := by
  exact
    (restrictedCompositionTargetModelClosureContent target).restrictedScopeProof

end ZeroDayRestrictedClosures

namespace ZeroDayRestrictedClosures

universe g

/--
Formal restricted input model containing exactly the data required to construct
the existing restricted composition target model.
-/
structure RestrictedLiftSourceChainCompositionInputModel
    (TerminalComposite : Type g) where
  terminalComposite : TerminalComposite
  restrictedBoundaryInvariant : Prop
  restrictedBoundaryInvariantProof : restrictedBoundaryInvariant
  restrictedChainRealization : Prop
  restrictedChainRealizationProof : restrictedChainRealization
  restrictedScopeGuard : Prop
  restrictedScopeGuardProof : restrictedScopeGuard

namespace RestrictedLiftSourceChainCompositionInputModel

/--
Construct the restricted composition target model directly from the packaged
restricted lift-source-chain inputs.
-/
def toTarget
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    RestrictedCompositionTargetModel TerminalComposite where
  terminalRestrictedComposite := input.terminalComposite
  restrictedBoundaryInvariant := input.restrictedBoundaryInvariant
  restrictedBoundaryInvariantProof :=
    input.restrictedBoundaryInvariantProof
  restrictedChainRealization := input.restrictedChainRealization
  restrictedChainRealizationProof :=
    input.restrictedChainRealizationProof
  restrictedScopeGuard := input.restrictedScopeGuard
  restrictedScopeGuardProof := input.restrictedScopeGuardProof

end RestrictedLiftSourceChainCompositionInputModel

/--
The restricted lift-source-chain composition gap is discharged when a packaged
input constructs a target preserving all source fields and the extracted target
retains its restricted-scope proof.
-/
def LiftSourceChainCompositionGap
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    Prop :=
  ∃ target : RestrictedCompositionTargetModel TerminalComposite,
    target.terminalRestrictedComposite =
        input.terminalComposite ∧
    target.restrictedBoundaryInvariant =
        input.restrictedBoundaryInvariant ∧
    target.restrictedChainRealization =
        input.restrictedChainRealization ∧
    target.restrictedScopeGuard =
        input.restrictedScopeGuard ∧
    (restrictedCompositionTargetModelClosureContent target).restrictedScope

/--
Every formal restricted lift-source-chain input model discharges the restricted
composition gap by constructing its target and extracting restricted content.
-/
theorem dischargeLiftSourceChainCompositionGap
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    LiftSourceChainCompositionGap input := by
  refine ⟨input.toTarget, ?_⟩
  constructor
  · rfl
  constructor
  · rfl
  constructor
  · rfl
  constructor
  · rfl
  exact
    restrictedCompositionTargetModelClosureContent_restricted
      input.toTarget

/-- The constructed target preserves the terminal-composite input exactly. -/
theorem dischargeLiftSourceChainCompositionGap_terminalComposite
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    input.toTarget.terminalRestrictedComposite =
      input.terminalComposite := by
  rfl

/-- The constructed target preserves the boundary invariant exactly. -/
theorem dischargeLiftSourceChainCompositionGap_boundaryInvariant
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    input.toTarget.restrictedBoundaryInvariant =
      input.restrictedBoundaryInvariant := by
  rfl

/-- The constructed target preserves chain realization exactly. -/
theorem dischargeLiftSourceChainCompositionGap_chainRealization
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    input.toTarget.restrictedChainRealization =
      input.restrictedChainRealization := by
  rfl

/-- The constructed target preserves the restricted-scope guard exactly. -/
theorem dischargeLiftSourceChainCompositionGap_scopeGuard
    {TerminalComposite : Type g}
    (input :
      RestrictedLiftSourceChainCompositionInputModel TerminalComposite) :
    input.toTarget.restrictedScopeGuard =
      input.restrictedScopeGuard := by
  rfl

end ZeroDayRestrictedClosures

namespace ZeroDayRestrictedClosures

universe terminalContractUniverse terminalTargetUniverse

/--
The actual restricted terminal-composite field type.

`C` records the input-contract type and `T` records the bounded target-object
type. The terminal object must carry direct evidence that it remains within the
specified restricted zero-day instance predicate.

This declaration does not construct a terminal composite and does not imply
`ZeroDayClosure`.
-/
structure TerminalComposite
    (C : Type terminalContractUniverse)
    (T : Type terminalTargetUniverse)
    (restricted_zero_day_instance_only : T → Prop) where
  terminal_object : T
  restricted_scope_guard :
    restricted_zero_day_instance_only terminal_object

/--
The restricted-scope evidence carried by a terminal composite is available
without any unrestricted promotion.
-/
theorem TerminalComposite.restricted_scope
    {C : Type terminalContractUniverse}
    {T : Type terminalTargetUniverse}
    {restricted_zero_day_instance_only : T → Prop}
    (terminal :
      TerminalComposite C T restricted_zero_day_instance_only) :
    restricted_zero_day_instance_only terminal.terminal_object := by
  exact terminal.restricted_scope_guard

end ZeroDayRestrictedClosures

namespace ZeroDayRestrictedClosures

universe restrictedClosureContractUniverse
  restrictedClosureTargetUniverse

/--
The actual restricted-closure source described by the repository surface.

`terminalObject` supplies the terminal projection belonging to the boundary
carrier. The source then provides a local closure predicate and direct evidence
that the projected terminal object satisfies it.

This structure does not contain a `TerminalComposite` field and therefore does
not assume the bridge that will be proved below.
-/
structure RestrictedClosureSurface
    (C : Type restrictedClosureContractUniverse)
    (T : Type restrictedClosureTargetUniverse)
    (terminalObject : C → T) where
  boundary : C
  local_closure_predicate : T → Prop
  closure_from_boundary :
    local_closure_predicate (terminalObject boundary)

/--
Bridge 1: every actual restricted-closure source constructs an actual
`TerminalComposite`.

The restricted predicate of the resulting terminal composite is exactly the
source's local closure predicate.
-/
def terminalCompositeOfRestrictedClosureSurface
    {C : Type restrictedClosureContractUniverse}
    {T : Type restrictedClosureTargetUniverse}
    {terminalObject : C → T}
    (source : RestrictedClosureSurface C T terminalObject) :
    TerminalComposite C T source.local_closure_predicate where
  terminal_object :=
    terminalObject source.boundary
  restricted_scope_guard :=
    source.closure_from_boundary

/--
The bridge preserves the boundary's projected terminal object definitionally.
-/
theorem terminalCompositeOfRestrictedClosureSurface_terminal_object
    {C : Type restrictedClosureContractUniverse}
    {T : Type restrictedClosureTargetUniverse}
    {terminalObject : C → T}
    (source : RestrictedClosureSurface C T terminalObject) :
    (terminalCompositeOfRestrictedClosureSurface source).terminal_object =
      terminalObject source.boundary := by
  rfl

/--
The bridge carries the source's restricted local-closure evidence into the
terminal composite.
-/
theorem terminalCompositeOfRestrictedClosureSurface_restricted_scope
    {C : Type restrictedClosureContractUniverse}
    {T : Type restrictedClosureTargetUniverse}
    {terminalObject : C → T}
    (source : RestrictedClosureSurface C T terminalObject) :
    source.local_closure_predicate
      (terminalCompositeOfRestrictedClosureSurface source).terminal_object := by
  exact
    (terminalCompositeOfRestrictedClosureSurface source).restricted_scope_guard

/--
Executable inhabitation statement for the completed source-field bridge.
-/
theorem restrictedClosureSurface_suppliesTerminalComposite
    {C : Type restrictedClosureContractUniverse}
    {T : Type restrictedClosureTargetUniverse}
    {terminalObject : C → T}
    (source : RestrictedClosureSurface C T terminalObject) :
    Nonempty (TerminalComposite C T source.local_closure_predicate) := by
  exact
    ⟨terminalCompositeOfRestrictedClosureSurface source⟩

end ZeroDayRestrictedClosures

namespace ZeroDayRestrictedClosures

universe zeroDayBoundaryStateUniverse

/--
The actual Lean form of the repository's zero-day boundary surface.

`ReachableBy` and `TerminalClosed` remain explicit semantic parameters. This
avoids inventing meanings for those repository-level predicates while retaining
the exact boundary fields recorded by the theorem surface.
-/
structure ZeroDayBoundarySurface
    (State : Type zeroDayBoundaryStateUniverse)
    (ReachableBy :
      (State → State → Prop) → State → State → Prop)
    (TerminalClosed : State → Prop) where
  BoundaryOrder : State → State → Prop
  ExistsAt : State → Prop
  Initial : State
  Terminal : State
  AdmissibleStep : State → State → Prop
  initial_exists :
    ExistsAt Initial
  initial_minimal :
    ∀ state, BoundaryOrder state Initial → ¬ ExistsAt state
  terminal_exists :
    ExistsAt Terminal
  terminal_reachable :
    ReachableBy AdmissibleStep Initial Terminal
  terminal_closed :
    TerminalClosed Terminal
  no_terminal_extension :
    ∀ state, AdmissibleStep Terminal state → state = Terminal

/--
Construct the actual restricted-closure surface carried by a zero-day boundary
surface.

The terminal projection is the boundary's `Terminal` field, and the local
restricted predicate is exactly the supplied `TerminalClosed` predicate.
-/
def zero_day_boundary_surface_implies_restricted_closure
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    RestrictedClosureSurface
      (ZeroDayBoundarySurface State ReachableBy TerminalClosed)
      State
      (fun source => source.Terminal) where
  boundary := boundary
  local_closure_predicate := TerminalClosed
  closure_from_boundary := boundary.terminal_closed

/--
The boundary-to-restricted-closure bridge preserves the terminal object
definitionally.
-/
theorem zero_day_boundary_surface_restricted_closure_terminal
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    (zero_day_boundary_surface_implies_restricted_closure boundary).boundary.Terminal =
      boundary.Terminal := by
  rfl

/--
Compose the completed restricted-closure bridge with the existing
restricted-closure-to-terminal-composite bridge.
-/
def zero_day_boundary_surface_implies_terminal_composite
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    TerminalComposite
      (ZeroDayBoundarySurface State ReachableBy TerminalClosed)
      State
      TerminalClosed :=
  terminalCompositeOfRestrictedClosureSurface
    (zero_day_boundary_surface_implies_restricted_closure boundary)

/--
The composed bridge preserves the boundary terminal exactly.
-/
theorem zero_day_boundary_surface_terminal_composite_object
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    (zero_day_boundary_surface_implies_terminal_composite boundary).terminal_object =
      boundary.Terminal := by
  rfl

/--
The composed terminal composite carries the original terminal-closure proof.
-/
theorem zero_day_boundary_surface_terminal_composite_scope
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    TerminalClosed
      (zero_day_boundary_surface_implies_terminal_composite boundary).terminal_object := by
  exact
    (zero_day_boundary_surface_implies_terminal_composite boundary).restricted_scope_guard

/--
Every supplied zero-day boundary surface therefore inhabits the corresponding
restricted terminal-composite type.
-/
theorem zero_day_boundary_surface_supplies_terminal_composite
    {State : Type zeroDayBoundaryStateUniverse}
    {ReachableBy :
      (State → State → Prop) → State → State → Prop}
    {TerminalClosed : State → Prop}
    (boundary :
      ZeroDayBoundarySurface State ReachableBy TerminalClosed) :
    Nonempty
      (TerminalComposite
        (ZeroDayBoundarySurface State ReachableBy TerminalClosed)
        State
        TerminalClosed) := by
  exact
    ⟨zero_day_boundary_surface_implies_terminal_composite boundary⟩

end ZeroDayRestrictedClosures
