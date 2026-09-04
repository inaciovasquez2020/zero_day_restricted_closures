Standalone local-duality exclusion of the remaining BETTI-A state for the saturated
H01-C4 m=3 endpoint in the homogeneous q=4, height-two multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,
    P = (l1,l2),
    D = P/Q,
    X = Proj(B),
    L = Proj(S/P),

  in the saturated H01-C4 m=3 endpoint with

    ht(Q)=2,
    depth_m(B)=1,
    Q=Q^sat,
    sigma=4,
    Hilb_B(0,1,2,3,4,5,6,...)
      =(1,4,6,8,9,10,11,...),
    dim_C B_n=n+5 for n>=3,
    Hilb_D(t)=(2*t+t^2+t^3)/(1-t),
    e(D)=4.

The preceding two files reduce the endpoint to the unique numerical minimal
resolution BETTI-A:

  0
    -> S(-4)^2 direct_sum S(-6)
    -> S(-3)^4 direct_sum S(-5)^2
    -> S(-2)^4
    -> S
    -> B
    -> 0.

This file performs one bounded task only: compare the degree -1 and degree 0
pieces of Ext^3_S(B,S(-4)) with the exact section-ring local cohomology values.
The comparison excludes BETTI-A and therefore closes H01-C4.  It does not enter
the distinct H01 m=2 cubic states, q<=3, or full order-13 closure.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE DEGREE ZERO AND ONE LOCAL-COHOMOLOGY VALUES
--------------------------------------------------------------------------

The exact graded sequence

  0 -> D -> B -> S/P -> 0

sheafifies to

  0 -> Dtilde -> O_X -> O_L -> 0.

The module D is one-dimensional Cohen-Macaulay of multiplicity four, so Dtilde
is a zero-dimensional sheaf of length four.  Hence for every twist n,

  h^0(Dtilde(n))=4,
  h^i(Dtilde(n))=0 for i>0.

For n>=0 one also has

  h^0(O_L(n))=n+1,
  h^1(O_L(n))=0.

Therefore

  h^0(O_X(0))=5,
  h^0(O_X(1))=6.

Because Q is saturated,

  H^0_m(B)=0.

The standard graded section-ring exact sequence gives

  0 -> B_n -> H^0(X,O_X(n)) -> H^1_m(B)_n -> 0

for n=0,1.  Using B_0=1 and B_1=4 gives

  dim_C H^1_m(B)_0=5-1=4,
  dim_C H^1_m(B)_1=6-4=2.

Theorem H01_C4_m3_H1m_low_degrees:
  One has

    dim_C H^1_m(B)_0=4,
    dim_C H^1_m(B)_1=2.
Qed.

--------------------------------------------------------------------------
2. LOCAL DUALITY TRANSFERS THESE VALUES TO Ext^3
--------------------------------------------------------------------------

Since S has four variables and canonical module S(-4), graded local duality
identifies

  H^1_m(B)_n^dual
    ~= Ext^3_S(B,S(-4))_(-n).

Thus

  dim_C Ext^3_S(B,S(-4))_0=4,
  dim_C Ext^3_S(B,S(-4))_(-1)=2.

--------------------------------------------------------------------------
3. THE FINAL SEXTIC SECOND SYZYGY HAS TWO INDEPENDENT LINEAR ENTRIES
--------------------------------------------------------------------------

Write the BETTI-A tail as

  F3 = S(-4)^2 direct_sum S(-6),
  F2 = S(-3)^4 direct_sum S(-5)^2.

For the unique S(-6) summand of F3, write its component in the two S(-5)
summands of F2 as the pair of linear forms

  (r1,r2).

The remaining component of that column, into S(-3)^4, consists of cubics and
plays no role in degree -1 below.

After applying Hom_S(-,S(-4)),

  F2^dual = S(-1)^4 direct_sum S(1)^2,
  F3^dual = S^2 direct_sum S(2).

In degree -1, the S(-1)^4 source and S^2 target vanish.  The relevant map is
therefore

  C^2 -> S_1,
  (a,b) |-> a*r1+b*r2.

Hence

  dim_C Ext^3_S(B,S(-4))_(-1)
    =4-dim_C span(r1,r2).

The exact local-duality value from Section 2 is two, so

  dim_C span(r1,r2)=2.

Thus r1 and r2 are linearly independent.

Theorem H01_C4_m3_final_linear_pair_independent:
  The two linear entries of the final sextic second syzygy into S(-5)^2 are
  independent.
Qed.

--------------------------------------------------------------------------
4. DEGREE ZERO NOW FORCES Ext^3 TO HAVE DIMENSION FIVE
--------------------------------------------------------------------------

Consider the same dual map in degree zero.

The S(-1)^4 source still contributes nothing in degree zero.  The source from
S(1)^2 is

  S_1^2,

of dimension eight, while the target is

  C^2 direct_sum S_2.

The map from S_1^2 lands only in the S_2 component and is

  (a,b) |-> a*r1+b*r2.

Because r1,r2 are independent, the degree-two piece of the ideal (r1,r2) has

  dim_C (r1,r2)_2
    = dim_C S_2 - dim_C (S/(r1,r2))_2
    = 10-3
    = 7.

The two constant target classes in C^2 cannot be hit in degree zero because the
only source that maps to them is S(-1)^4, whose degree-zero piece is zero.
Therefore

  dim_C Ext^3_S(B,S(-4))_0
    = 2 + (10-7)
    = 5.

But Section 2 gives the exact local-duality value

  dim_C Ext^3_S(B,S(-4))_0=4.

Contradiction.

Theorem H01_C4_m3_BETTI_A_is_impossible:
  BETTI-A cannot occur.
Qed.

--------------------------------------------------------------------------
5. H01-C4 IS EMPTY
--------------------------------------------------------------------------

The preceding saturation reduction already proved that every H01-C4 state with
m>=4 is empty and that any surviving H01-C4 state must have m=3.

For m=3 the Betti frontier left only BETTI-A or BETTI-B.  The preceding file
excluded BETTI-B, and Section 4 above excludes BETTI-A.

Therefore no H01-C4 state exists.

Theorem H01_C4_is_empty:
  The complete H01-C4 branch is empty.
Qed.

--------------------------------------------------------------------------
6. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_final_linear_pair_independent.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_BETTI_A_empty.
  q4_height2_multiplicity_one_depth_one_H01_C4_closed.

COMBINED_WITH_PREVIOUS:
  q4_height2_multiplicity_one_depth_one_H01_C5_closed.

IMPORTANT_NONCONCLUSION:
  This does NOT close all H01, because the distinct m=2 cubic states remain.
  It does NOT close every q=4 height-two branch.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C4_closed.
  q4_height2_multiplicity_one_depth_one_H01_C5_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Return to the distinct H01 m=2 Artinian state.  There

    dim D_3=3,
    sigma=3+tau_3,
    sigma in {3,4,5},
    tau_3 in {0,1,2}.

  Classify or exclude these three cubic-defect values before any tangent
  estimate.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
