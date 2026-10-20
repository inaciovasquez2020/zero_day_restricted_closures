# Zero Day: finite becoming, restricted infinity, and backtrack synthesis

Status: RESEARCH FRAMEWORK — NOT A PROOF OF A UNIVERSAL ORIGIN

## 1. Intended thesis

Zero Day investigates whether what comes to be is finite, while infinity belongs only to restricted classes of things. The goal is not merely to infer a first moment from finite objects. The deeper question is whether finite becoming, together with a principled restriction on infinity, can explain the emergence of temporal order and establish an origin boundary.

This document preserves that stronger target. It does not assume that every existent is finite, that the total collection of existents is finite, or that the temporal history is already finite.

## 2. Type distinctions that must not be collapsed

Let:

- `B(x)`: x is something that comes to be.
- `Fin_B(x)`: x is finite in the explicitly chosen sense relevant to becoming.
- `Inf(x)`: x is infinite in an explicitly chosen sense.
- `AllowedInf(x)`: x belongs to a class for which infinity is permitted by the theory.
- `R(a,b)`: a relation between distinguishable states/conditions.
- `T(a,b)`: a derived temporal-order relation, if derivation succeeds.

Candidate restricted-infinity premise:

`forall x, Inf(x) -> AllowedInf(x)`

Candidate finite-becoming premise:

`forall x, B(x) -> Fin_B(x)`

These statements alone do not entail a first moment. A further bridge must show that the global history, or the chain of conditions relevant to becoming, is not an allowed infinite object/process. If the global temporal order is excluded from the permitted infinity classes, that exclusion must be argued independently rather than built into the definition of `Fin_B`.

## 3. Backtrack dependency graph

Work backward from the observed existence of finite things:

1. **Present existents:** identify the class of things claimed to have come to be.
2. **Becoming:** specify what “came to be” means without silently presupposing external time.
3. **Finitude:** specify whether finitude concerns size, duration, internal structure, number of stages, or another property. These meanings are not interchangeable.
4. **Restricted infinity:** enumerate which kinds of objects, structures, or processes may be infinite, and why.
5. **Relation:** establish whether distinct conditions can be related without already assuming a temporal order.
6. **Order:** prove that the relation yields an asymmetric, coherent order rather than an arbitrary graph, cycle, or unordered collection.
7. **Temporal interpretation:** justify why that order deserves to be interpreted as time, rather than merely logical, causal, spatial, or structural dependence.
8. **Origin boundary:** prove the order has a first element. Sufficient routes include a nonempty finite ordered state set or independently established well-foundedness.
9. **Universal scope:** show that the temporal model captures all existence relevant to the claim. A first state in one model does not by itself prove an origin of absolutely everything.

Dependency sketch:

`finite becoming + restricted infinity`
`        | (missing bridge)`
`no admissible infinite regress of becoming`
`        | (derive relation and ordering)`
`well-founded temporal order`
`        | (nonempty domain)`
`first temporal state`
`        | (exhaustiveness premise)`
`universal Zero Day boundary`

Every arrow is a separate proof obligation. No arrow should be treated as established merely because the next concept has been named.

## 4. What backtracking currently establishes

### Established mathematics

- A nonempty finite set with a strict total order has a first element.
- A nonempty well-founded strict order has a minimal element; for a strict total order, that element is the first.
- Finite individual objects or a finite object collection do not, by themselves, imply finite history or a first state.

### Countermodel boundary

The companion JSON countermodel uses a singleton object domain and integer-indexed states. It refutes the inference from finite objects to a first temporal state. It does **not** refute the stronger Zero Day proposal that finite becoming plus a justified restriction on admissible infinity might rule out an infinite regress. That stronger proposal has not yet been formalized sufficiently to test.

### Unproved obligations

- An independent definition of `Fin_B`.
- A non-circular restriction on which infinities are admissible.
- A proof that the global history is not one of the admissible infinite structures.
- A derivation from non-temporal relations to temporal ordering.
- A proof that the derived order is well-founded.
- A scope/exhaustiveness principle connecting the first temporal state to the origin of all existence.

## 5. Relevant research and its limits

- The standard cosmological model is strongly supported as a description of the universe's evolution from a hot, dense early state. That does not alone settle an absolute origin: https://plato.stanford.edu/entries/cosmology/
- The Borde–Guth–Vilenkin theorem gives a conditional past-incompleteness result for relevant expanding spacetimes. Past incompleteness is not itself a proof of creation from nothing: https://arxiv.org/abs/gr-qc/0110012
- The actual/potential infinity distinction separates completed infinite totalities from indefinitely extensible processes: https://plato.stanford.edu/entries/infinity/ and https://doi.org/10.1111/nous.12208
- Quantum-gravity research explores relational and emergent accounts of time, but no consensus result proves that time must emerge from finite becoming: https://link.springer.com/article/10.1007/JHEP05(2021)025 and https://arxiv.org/abs/gr-qc/9901024

These sources motivate distinctions and possible research routes. They do not prove Zero Day.

## 6. Strongest useful candidate theorem

**Conditional Finite-Becoming Boundary Theorem (candidate):**

If (i) all becoming-relevant states are represented in a nonempty state domain S, (ii) the derived temporal relation is a strict total order on S, and (iii) an independently justified Zero Day principle proves S is finite or the order is well-founded, then S has a first state.

The mathematical conclusion follows from (iii). The substantive Zero Day work is to justify (iii) from finite becoming and restricted infinity without assuming the first state, temporal finitude, or well-foundedness in disguise.

## 7. Falsification / backtrack tests

1. **Definition test:** Can `Fin_B` be stated without using “first,” “beginning,” “finite past,” or “well-founded”?
2. **Allowed-infinity test:** Is an infinite chain of prior conditions in a class the theory permits to be infinite? If yes, the origin does not follow yet. If no, prove why it is excluded.
3. **Circularity test:** Does any premise already assume time, temporal order, or a first boundary?
4. **Countermodel test:** Construct a model satisfying every proposed premise but lacking a first state. If one exists, the proposed implication is not valid.
5. **Scope test:** Could something outside the derived temporal domain still count as existent under the theory? If yes, the result is not yet an origin of all existence.

## 8. Status

`FINITE_BECOMING -> FIRST_TIME := NOT_PROVED`

`RESTRICTED_INFINITY_BRIDGE := NOT_FORMALIZED`

`TIME_FROM_RELATIONS := OPEN`

`UNIVERSAL_ZERO_DAY_ORIGIN := OPEN`

No unconditional creation theorem, physical cosmological conclusion, or metaphysical conclusion is claimed.
