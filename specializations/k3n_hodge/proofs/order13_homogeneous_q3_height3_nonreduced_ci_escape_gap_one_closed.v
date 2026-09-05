Standalone tangent closure of the escape-gap-one residual nonreduced
homogeneous q=3, height-three complete-intersection core in the order-13
deviation-two branch.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_rigidity_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_trapped_component_reduction.v.

  Let

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3),
    B := S/Q,
    I := Q+(f1,f2,f3),
    L := I/Q subset B,
    A := B/L,
    N := length_C(A)>=32,

  where B is the one-dimensional graded Gorenstein complete intersection of
  three quadrics.  We are in the residual nonreduced case where the least
  nonzero slice

    U := L_d

  consists entirely of zero divisors.

  For each trapped minimal prime

    q in T(U) := { q in Min(B) : U subset q },

  let

    e_q := min { deg(fi) : fi notin q },

  and set

    D := max_{q in T(U)} (e_q-d).

  This file performs one bounded task only: close the subcase

    D=1.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. ONLY THE FIRST NEGATIVE ENDOMORPHISM LAYER CAN SURVIVE
--------------------------------------------------------------------------

Put

    E := End_B(L).

The trapped-component finite-window theorem gives

    E_{-s}=0

for every s>D.  Under D=1 this becomes

    E_{-s}=0 for every s>=2.

Hence

    delta_neg := sum_{s>=1} dim_C E_{-s}
               = dim_C E_{-1}.

--------------------------------------------------------------------------
2. THE FIRST NEGATIVE LAYER HAS DIMENSION AT MOST SEVEN
--------------------------------------------------------------------------

Because B is one-dimensional Cohen--Macaulay over C, choose a homogeneous
linear nonzerodivisor

    h in B_1.

Since L is an m-primary ideal, h is also a nonzerodivisor on L.  Therefore h
is a nonzerodivisor on E: if h*x=0 as an endomorphism of L, then

    h*x(y)=0

for every y in L, and L-regularity of h forces x(y)=0 for every y.

Thus multiplication by h gives an injection

    E_{-1} -> E_0.

Its image has zero intersection with B_0=C.  Indeed, suppose

    h*x=c

for x in E_{-1} and nonzero c in C.  Since x preserves L,

    c*L = h*x(L) subset h*L.

As c is a unit, this gives

    L subset h*L.

But h*L subset L, hence L=h*L, contradicting graded Nakayama; equivalently,
if d is the least degree with L_d nonzero, then (hL)_d=0 while L_d is nonzero.

Therefore multiplication by h followed by the quotient map induces an
injection

    E_{-1} -> E_0/B_0.

From the universal punctured-section count for the H3-CI core,

    dim_C(E_0/B_0) <= 8-1=7.

Consequently

    dim_C E_{-1} <= 7

and hence

    delta_neg <= 7.

Theorem escape_gap_one_negative_defect_at_most_seven:
  If D=1, then

    delta_neg<=7.
Qed.

--------------------------------------------------------------------------
3. TANGENT CLOSURE
--------------------------------------------------------------------------

The rigidity reduction gives

    epsilon_L := length_C Ext^1_B(L,L) >= 1,

and the nonnegative endomorphism defect satisfies

    delta_nonneg <= 12.

The intrinsic tangent formula is

    length_C Hom_B(L,A)
      = N-delta_nonneg-delta_neg+epsilon_L.

Therefore, under D=1,

    length_C Hom_B(L,A)
      >= N-12-7+1
      = N-18.

The natural injection

    Hom_B(L,A) -> Hom_S(I,A)

then gives

    dim_C Hom_S(I,A) >= N-18.

Since

    N-18 > N-20,

the necessary order-13 tangent-deficit gate cannot hold.

Theorem homogeneous_q3_height3_nonreduced_CI_escape_gap_one_is_closed:
  No residual nonreduced H3-CI candidate with

    D=1

  satisfies

    dim_C Hom_S(I,A) <= N-20.
Qed.

--------------------------------------------------------------------------
4. DEGREE-PATTERN CONSEQUENCES
--------------------------------------------------------------------------

In the R2 branch

    d1=d2<d3,

one has D=d3-d1.  Hence the entire adjacent-degree subcase

    (d1,d2,d3)=(d,d,d+1)

is closed.

In the R1 branch

    d1<d2<=d3,

any case in which every trapped component is already escaped in degree d+1 is
closed.  In particular

    (d1,d2,d3)=(d,d+1,d+1)

is closed.

RESULT:
  homogeneous_q3_height3_nonreduced_CI_escape_gap_one_is_closed.

IMPORTANT_NONCONCLUSION:
  This does not close residual cases with D>=2.
  It does not close all R1 or all R2.
  It does not close the full nonreduced H3-CI child.
  It does not close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  D=1 residual nonreduced H3-CI is tangent-closed.
  not D>=2 residual nonreduced H3-CI closed.
  not homogeneous_q3_height3_nonreduced_CI_closed.
  not homogeneous_q3_closed.

MISSING_OBJECT:
  In the residual D>=2 branches, compare the deeper negative layers

    E_{-2},...,E_{-D}

  with Ext^1_B(L,L) strongly enough to prove

    sum_{s=2..D} dim_C E_{-s} <= epsilon_L,

  which, together with dim_C E_{-1}<=7, would imply

    delta_neg-epsilon_L<=7.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, attack D=2 first by proving dim_C E_{-2}<=epsilon_L.
  3. Do not stack a parent promotion before that deeper-layer comparison is
     proved.
