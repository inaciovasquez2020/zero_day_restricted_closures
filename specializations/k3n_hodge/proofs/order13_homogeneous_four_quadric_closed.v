Standalone closure of the homogeneous q=4 order-13 deviation-two branch.

SCOPE:
  Let

    S := C[x1,x2,x3,x4],
    I subset S homogeneous and m-primary,
    A := S/I,
    mu(I)=6,
    length_C(A)=N>=32,

  with exactly four quadratic minimal generators.  Put

    Q := (I_2),
    I=Q+(f,g),
    deg(f),deg(g)>=3.

This file performs one bounded task only: combine the already-closed height-two
and height-three four-quadric branches.

It does not enter homogeneous q<=3, the unrestricted nonhomogeneous local
frontier, or Oblivion Closure.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EXACT HEIGHT SPLIT
--------------------------------------------------------------------------

The established four-quadric height theorem proves

    ht(Q) in {2,3}.

The case ht(Q)=4 is impossible because four quadratic parameters would give

    length(S/Q)=16,

contradicting

    length(A)=N>=32.

The two final generators force ht(Q)>=2, so there are no additional height
cases.

--------------------------------------------------------------------------
2. HEIGHT TWO
--------------------------------------------------------------------------

The height-two parent closure proves

    q4_height2_closed.

Thus no homogeneous q=4 candidate with

    ht(Q)=2

passes the necessary order-13 tangent-deficit gate.

--------------------------------------------------------------------------
3. HEIGHT THREE
--------------------------------------------------------------------------

The height-three low-multiplicity classification proves

    1 <= e(S/Q) <= 6

and exhausts every surviving h-vector row.  Its final endpoint theorem proves

    q4_height3_low_multiplicity_frontier_is_exhausted.

Thus no homogeneous q=4 candidate with

    ht(Q)=3

survives the established height-three row inventory.

--------------------------------------------------------------------------
4. HOMOGENEOUS q=4 CLOSURE
--------------------------------------------------------------------------

Theorem homogeneous_q4_closed:
  No homogeneous order-13 deviation-two candidate with exactly four quadratic
  minimal generators survives the established necessary tangent/structural
  gates.

Proof:
  By the exact height split,

    ht(Q)=2 or ht(Q)=3.

  The ht(Q)=2 branch is closed by q4_height2_closed.

  The ht(Q)=3 branch is exhausted by

    q4_height3_low_multiplicity_frontier_is_exhausted.

  Therefore no homogeneous q=4 branch survives.
Qed.

RESULT:
  homogeneous_q4_closed.

DEPENDENCIES:
  four_quadric_core_has_height_two_or_three.
  q4_height2_closed.
  q4_height3_low_multiplicity_frontier_is_exhausted.

IMPORTANT_NONCONCLUSION:
  This file closes only the homogeneous q=4 branch.

  It does NOT close homogeneous q<=3.
  It does NOT close the unrestricted nonhomogeneous local deviation-two
  frontier.
  It does NOT establish generic order-13 algebraicity.
  It does NOT promote Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  homogeneous_q4_closed.
  not homogeneous_q_le_3_closure.
  not unrestricted_local_deviation_two_closure.
  not OC.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, inspect the current homogeneous q<=3 frontier and attack only
     its weakest surviving branch.
