universe u

namespace ZeroDayRestrictedClosures

/-- A directed dependency edge with explicit source and target states. -/
structure DirectedEdge (State : Type u) where
  source : State
  target : State

end ZeroDayRestrictedClosures
