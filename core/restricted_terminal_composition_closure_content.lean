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
