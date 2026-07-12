import Chronos.Frontier.DirectionalFlowFractionBConditionalIntegralBound

namespace Chronos
namespace Frontier

structure BoundedEvidence (Hypothesis : Prop) where
  hypothesis : Hypothesis
  measuredDataRecorded : Prop
  calibrationRecorded : Prop
  uncertaintyBounded : Prop
  provenanceRecorded : Prop
  scopeRestricted : Prop

def EvidenceAdmissible {Hypothesis : Prop}
    (e : BoundedEvidence Hypothesis) : Prop :=
  e.measuredDataRecorded ∧
    e.calibrationRecorded ∧
    e.uncertaintyBounded ∧
    e.provenanceRecorded ∧
    e.scopeRestricted

theorem boundedEvidence_populatesHypothesis
    {Hypothesis : Prop}
    (e : BoundedEvidence Hypothesis)
    (_ : EvidenceAdmissible e) :
    Hypothesis :=
  e.hypothesis

def EvidenceSupportsConclusion
    {Hypothesis Conclusion : Prop}
    (e : BoundedEvidence Hypothesis) : Prop :=
  EvidenceAdmissible e ∧ (Hypothesis → Conclusion)

theorem boundedEvidence_appliesExistingBridge
    {Hypothesis Conclusion : Prop}
    (e : BoundedEvidence Hypothesis)
    (h : EvidenceSupportsConclusion (Conclusion := Conclusion) e) :
    Conclusion :=
  h.2 e.hypothesis

theorem boundedEvidence_cannotStrengthenWithoutBridge
    {Hypothesis Conclusion : Prop}
    (e : BoundedEvidence Hypothesis)
    (noBridge : ¬ (Hypothesis → Conclusion)) :
    ¬ EvidenceSupportsConclusion (Conclusion := Conclusion) e := by
  intro hSupports
  exact noBridge hSupports.2

end Frontier
end Chronos
