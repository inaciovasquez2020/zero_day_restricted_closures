Standalone variant-truth lattice for the order-13 restricted-closure program.

PURPOSE:
  Record proof status as a mathematical information object rather than as an
  informal progress label.

  The lattice is deliberately fail-closed: proving that one child variant is
  excluded does not promote its parent, and proving a structural reduction is
  not the same as proving exclusion.

  This file does not add a new order-13 theorem.  It records the exact logical
  status of variants already established on this branch and defines the only
  admissible promotion rules.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. VARIANT PREDICATE
--------------------------------------------------------------------------

For every structural variant V in the order-13 search, define

  Excluded(V)

as the proposition:

  no algebra A belonging to V can satisfy the currently required necessary
  order-13 tangent gate.

In the homogeneous local-Artin branch the gate is

  t(A) := dim_C Hom_S(I,A) <= length_C(A)-20.

The truth lattice below concerns only the proposition Excluded(V).

It does not identify exclusion from this necessary gate with the full generic
order-13 Hodge/semiregularity theorem.

--------------------------------------------------------------------------
2. FOUR INFORMATION STATES
--------------------------------------------------------------------------

For a variant V assign exactly one information state

  UNKNOWN
  EXCLUDED
  SURVIVES
  CONFLICT.

Semantics:

  UNKNOWN:
    neither Excluded(V) nor its negation has been established.

  EXCLUDED:
    Excluded(V) has been proved within the stated scope.

  SURVIVES:
    a concrete member of V has been proved to satisfy the current necessary
    gate, so Excluded(V) is false.

  CONFLICT:
    both an exclusion proof and a surviving witness are recorded.  This is a
    verification failure state and no theorem promotion is admissible until
    the conflict is resolved.

The information order is the diamond

                 CONFLICT
                /        \
          EXCLUDED      SURVIVES
                \        /
                  UNKNOWN.

Equivalently,

  UNKNOWN <= EXCLUDED <= CONFLICT,
  UNKNOWN <= SURVIVES <= CONFLICT,

with EXCLUDED and SURVIVES incomparable.

This is an information lattice, not an ordering in which EXCLUDED is
mathematically "larger" than SURVIVES.

--------------------------------------------------------------------------
3. JOIN OPERATION
--------------------------------------------------------------------------

Define join(x,y) by

  join(UNKNOWN,x)       = x,
  join(EXCLUDED,EXCLUDED) = EXCLUDED,
  join(SURVIVES,SURVIVES) = SURVIVES,
  join(EXCLUDED,SURVIVES) = CONFLICT,
  join(CONFLICT,x)        = CONFLICT,

and symmetrically in the two inputs.

The join records accumulation of evidence about the same variant.

It must NOT be used to combine distinct sibling variants into the truth state
of their parent.  Parent promotion requires an explicit coverage rule below.

--------------------------------------------------------------------------
4. ADMISSIBLE STATUS PROMOTIONS
--------------------------------------------------------------------------

Rule proof_of_exclusion:
  UNKNOWN -> EXCLUDED

is admissible only after a proof of Excluded(V) is recorded with its exact
scope and dependencies.

Rule surviving_witness:
  UNKNOWN -> SURVIVES

is admissible only after a concrete member of V is proved to satisfy the
current necessary gate.

Rule contradiction_detection:
  EXCLUDED + SURVIVES -> CONFLICT.

Once CONFLICT is reached, all upward theorem promotion halts.

No other direct promotion is admissible.

In particular these transitions are forbidden:

  structural_reduction -> EXCLUDED,
  finite_case_split -> EXCLUDED,
  one_closed_child -> parent EXCLUDED,
  pseudo-formal_documentation -> MACHINE_VERIFIED,
  tangent-gate exclusion -> full_order13_closure.

--------------------------------------------------------------------------
5. VARIANT COVERAGE RULE
--------------------------------------------------------------------------

Suppose a parent variant P has children

  V_1,...,V_r.

A proof that the children are exhaustive means

  P = V_1 union ... union V_r

at the level of mathematical objects under consideration.

Only after that exhaustiveness theorem is available may one use

  Excluded(V_1),...,Excluded(V_r)

in order to conclude

  Excluded(P).

Thus parent exclusion requires either

  (A) a direct proof of Excluded(P),

or

  (B) an exhaustive child decomposition together with EXCLUDED status for
      every child.

Missing even one child leaves the parent UNKNOWN.

A parent is not SURVIVES merely because one child is UNKNOWN.
A parent becomes SURVIVES only from an actual surviving witness belonging to
that parent.

--------------------------------------------------------------------------
6. REDUCTION STATUS IS ORTHOGONAL TO TRUTH STATUS
--------------------------------------------------------------------------

For bookkeeping, a variant may separately carry a structural progress tag

  UNTOUCHED
  ISOLATED
  REDUCED
  CLASSIFIED
  CLOSED.

These tags measure how much of the variant has been analyzed.
They do not change the truth state by themselves.

Examples:

  CLASSIFIED + UNKNOWN

is valid: the objects can be classified while the tangent gate remains open.

  CLOSED + EXCLUDED

is valid: the variant has been completely eliminated.

  CLOSED + SURVIVES

is also logically possible: a complete analysis may produce a genuine
surviving witness rather than an exclusion.

The program must therefore store structural progress and truth information as
separate coordinates.

--------------------------------------------------------------------------
7. CURRENT q=4 HEIGHT-TWO INSTANTIATION
--------------------------------------------------------------------------

At branch head immediately preceding this file, the Cohen--Macaulay line core
has been tangent-closed.

Let

  V_line

be the homogeneous q=4, ht(Q)=2, Qsat=(l1,l2), Cohen--Macaulay line-core
variant with the standing order-13 length condition N>=32.

The proved tangent bound is

  t(A) >= 2*N-34.

Since

  2*N-34 > N-20

for N>=32, one has

  Excluded(V_line).

Therefore

  truth(V_line) = EXCLUDED,
  progress(V_line) = CLOSED.

The internal line-core syzygy branches satisfy

  s=0,
  s=1,
  s=2,

and their union is exhaustive inside V_line.
The subsequent tangent theorem is universal over V_line, so each of these
subvariants is also EXCLUDED.

Thus

  truth(V_line_s0) = EXCLUDED,
  truth(V_line_s1) = EXCLUDED,
  truth(V_line_s2) = EXCLUDED.

The depth-one saturated height-two core has not been closed.
Let

  V_depth1

be that remaining q=4 height-two depth-one variant.
Then

  truth(V_depth1) = UNKNOWN.

No surviving witness satisfying the gate is claimed.
No exclusion proof is claimed.

Consequently the full q=4 height-two parent remains

  truth(V_q4_height2) = UNKNOWN.

The closed Cohen--Macaulay line child may not be promoted through the still-open
V_depth1 child.

--------------------------------------------------------------------------
8. HIGHER FRONTIER STATES
--------------------------------------------------------------------------

The current branch also records

  truth(V_homogeneous_q_le_3) = UNKNOWN,
  truth(V_full_order13)       = UNKNOWN.

These statements are mandatory nonpromotion guards.

In particular

  truth(V_line)=EXCLUDED

must never be rewritten as

  truth(V_q4_height2)=EXCLUDED

without closing every remaining exhaustive q=4 height-two child, and it must
never be rewritten as

  truth(V_full_order13)=EXCLUDED

without closing all other surviving branches and supplying the required
coverage theorems.

--------------------------------------------------------------------------
9. CURRENT LATTICE SNAPSHOT
--------------------------------------------------------------------------

Using E=EXCLUDED and ?=UNKNOWN, the current local snapshot is

  full_order13                                      ?
      |
      +-- homogeneous deviation-two frontier       ?
              |
              +-- q=4 height-two                    ?
              |      |
              |      +-- CM line core               E
              |      |      |
              |      |      +-- s=0                 E
              |      |      +-- s=1                 E
              |      |      +-- s=2                 E
              |      |
              |      +-- depth-one saturated core   ?
              |
              +-- q<=3                              ?

Only statuses explicitly established by the current branch are assigned.
Other branches are intentionally omitted rather than guessed.

--------------------------------------------------------------------------
10. FAIL-CLOSED INVARIANTS
--------------------------------------------------------------------------

Invariant no_parent_promotion_from_partial_coverage:
  If an exhaustive child of P remains UNKNOWN, then child exclusions alone do
  not establish Excluded(P).

Invariant no_truth_from_progress:
  CLASSIFIED or CLOSED as a structural label does not imply EXCLUDED unless the
  exclusion proposition itself has been proved.

Invariant no_full_theorem_from_tangent_gate:
  Excluding a local variant using the necessary tangent gate does not by itself
  prove the generic order-13 semiregularity/algebraicity theorem.

Invariant conflict_stops_promotion:
  Any CONFLICT state blocks every theorem promotion that depends on that
  variant until the inconsistency is resolved.

Invariant exact_scope:
  Every EXCLUDED state inherits all hypotheses of the proof that established
  it.  Dropping homogeneity, height, saturation, Cohen--Macaulayness, length, or
  other hypotheses creates a new variant whose truth state defaults to UNKNOWN
  unless separately proved.

--------------------------------------------------------------------------
11. CURRENT BOUNDARY
--------------------------------------------------------------------------

TRUTH_LATTICE_ESTABLISHED:
  yes, as a proof-status protocol.

NEW_ORDER13_THEOREM:
  none.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

CURRENT_EXCLUDED_NODE:
  q4_height2_CM_line_core.

CURRENT_NEAREST_UNKNOWN_NODE:
  q4_height2_depth_one_saturated_core.

BOUNDARY:
  not q4_height2_depth_one_core_closed.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

NEXT_BOUNDED_OBJECT:
  Work only on the nearest UNKNOWN node

    q4_height2_depth_one_saturated_core,

  and identify the smallest possible deficiency module H^1_m(C) compatible
  with four independent quadratic generators.

  Do not change the truth state of any parent until its coverage condition is
  actually met.
