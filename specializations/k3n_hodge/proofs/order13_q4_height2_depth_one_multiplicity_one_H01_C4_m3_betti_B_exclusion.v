Standalone local-duality exclusion of BETTI-B for the saturated H01-C4 m=3
endpoint in the homogeneous q=4, height-two multiplicity-one, depth-one
order-13 deviation-two program.

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

The preceding Betti-frontier file leaves exactly two numerical resolutions:

BETTI-A:

  0
    -> S(-4)^2 direct_sum S(-6)
    -> S(-3)^4 direct_sum S(-5)^2
    -> S(-2)^4
    -> S
    -> B
    -> 0.

BETTI-B:

  0
    -> S(-4)^2 direct_sum S(-6)^2
    -> S(-3)^4 direct_sum S(-5)^2 direct_sum S(-6)
    -> S(-2)^4
    -> S
    -> B
    -> 0.

This file performs one bounded task only: use the degree-two local-cohomology
value and graded local duality to exclude BETTI-B.  No tangent estimate,
coefficient-matrix classification, H01 m=2 branch, q<=3 branch, or full
order-13 closure is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE PROJECTIVE RESIDUAL HAS LENGTH FOUR
--------------------------------------------------------------------------

The exact graded sequence

  0 -> D -> B -> S/P -> 0

sheafifies to

  0 -> Dtilde -> O_X -> O_L -> 0.

The module D is one-dimensional Cohen-Macaulay and has multiplicity four.
Therefore Dtilde is a zero-dimensional sheaf of length four.  In particular,
for every twist n,

  h^0(Dtilde(n))=4,
  h^i(Dtilde(n))=0 for i>0.

At n=2, since L is a projective line,

  h^0(O_L(2))=3,
  h^1(O_L(2))=0.

Taking cohomology of the sheafified exact sequence therefore gives

  h^0(O_X(2))=4+3=7.

--------------------------------------------------------------------------
2. SATURATION FORCES h^1_m(B)_2=1
--------------------------------------------------------------------------

Because Q is saturated,

  H^0_m(B)=0.

The standard graded section-ring exact sequence gives in degree two

  0 -> B_2 -> H^0(X,O_X(2)) -> H^1_m(B)_2 -> 0.

The H01 Hilbert value is

  dim_C B_2=6.

Hence

  dim_C H^1_m(B)_2
    = h^0(O_X(2)) - dim_C B_2
    = 7-6
    = 1.

Theorem H01_C4_m3_local_cohomology_degree_two:
  One has

    dim_C H^1_m(B)_2=1.
Qed.

--------------------------------------------------------------------------
3. GRADED LOCAL DUALITY FIXES Ext^3 IN DEGREE -2
--------------------------------------------------------------------------

The ambient ring S has four variables and canonical module S(-4).
Graded local duality gives

  H^1_m(B)_2^dual
    ~= Ext^3_S(B,S(-4))_(-2).

Therefore

  dim_C Ext^3_S(B,S(-4))_(-2)=1.

Theorem H01_C4_m3_Ext3_degree_minus_two_is_one:
  One has

    dim_C Ext^3_S(B,S(-4))_(-2)=1.
Qed.

--------------------------------------------------------------------------
4. BETTI-B WOULD FORCE THAT DEGREE TO HAVE DIMENSION TWO
--------------------------------------------------------------------------

Assume BETTI-B.  Then

  F3 = S(-4)^2 direct_sum S(-6)^2,
  F2 = S(-3)^4 direct_sum S(-5)^2 direct_sum S(-6).

Since pd_S(B)=3,

  Ext^3_S(B,S(-4))

is the cokernel of

  Hom_S(F2,S(-4)) -> Hom_S(F3,S(-4)).

Now

  Hom_S(S(-6),S(-4)) ~= S(2).

Thus the two S(-6) summands of F3 contribute a two-dimensional target in
degree -2.

The S(-3)^4 and S(-5)^2 summands of F2 contribute nothing in degree -2,
because

  S(-1)_(-2)=0,
  S(1)_(-2)=0.

The remaining S(-6) summand of F2 contributes one copy of S(2) in degree -2.
However, the component of the minimal differential

  F3 -> F2

from an S(-6) summand of F3 to the S(-6) summand of F2 would have degree zero.
Minimality forbids every such degree-zero entry.  Therefore the dual map from
the degree -2 part of Hom(S(-6),S(-4)) in F2^dual to the two degree -2 target
classes in F3^dual is zero.

Hence BETTI-B forces

  dim_C Ext^3_S(B,S(-4))_(-2)=2.

This contradicts the exact local-duality value one from Section 3.

Theorem H01_C4_m3_BETTI_B_is_impossible:
  BETTI-B cannot occur.
Qed.

--------------------------------------------------------------------------
5. UNIQUE BETTI TABLE
--------------------------------------------------------------------------

Therefore the saturated H01-C4 m=3 endpoint, if realizable, has the unique
minimal graded free resolution

  0
    -> S(-4)^2 direct_sum S(-6)
    -> S(-3)^4 direct_sum S(-5)^2
    -> S(-2)^4
    -> S
    -> B
    -> 0.

Equivalently,

  beta_(1,2)=4,
  beta_(2,3)=4,
  beta_(2,5)=2,
  beta_(3,4)=2,
  beta_(3,6)=1,

and every other graded Betti number is zero.

Theorem H01_C4_m3_unique_Betti_table:
  BETTI-A is the only numerical minimal free resolution compatible with the
  saturated H01-C4 m=3 endpoint.
Qed.

--------------------------------------------------------------------------
6. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_H1m_degree2_equals_one.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_Ext3_degree_minus2_equals_one.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_BETTI_B_empty.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_unique_BETTI_A.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude BETTI-A.
  It does NOT classify the rank-two linear-syzygy matrix up to coordinates.
  It does NOT prove a tangent carrier or tangent-space estimate.
  It does NOT treat the distinct H01 m=2 cubic states.
  It does NOT close all H01.
  It does NOT close every q=4 height-two branch.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_closed.
  q4_height2_multiplicity_one_depth_one_H01_C4_reduced_to_saturated_m3.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_unique_BETTI_A.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in the unique BETTI-A saturated H01-C4 m=3 endpoint.  Use the
  rank-two 4-by-4 linear first-syzygy matrix together with its two linear
  second syzygies to derive the weakest coefficient-matrix normal form or
  tangent carrier.  Do not enter the H01 m=2 branch until this endpoint is
  decided.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
