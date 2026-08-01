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
