Standalone tangent closure of the reduced homogeneous q=3, height-three
complete-intersection core in the order-13 deviation-two branch.

SCOPE:
  Continue from order13_homogeneous_q3_height_split.v.

  Let

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3),
    B := S/Q,
    I := Q+(f1,f2,f3),
    L := I/Q=(fbar1,fbar2,fbar3) subset B,
    A := B/L,
    N := length_C(A)>=32,

  where q1,q2,q3 are a regular sequence of quadrics, so B is a
  one-dimensional graded Gorenstein complete intersection with

    Hilb_B(t)=(1+t)^3/(1-t),

and assume additionally in this file that B is reduced.

This file performs one bounded task only: close this reduced H3-CI child by a
finite birational-overring bound.  The nonreduced H3-CI child and both H2
children remain untouched.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

ExternalResult one_dimensional_gorenstein_local_duality:
  If B is one-dimensional Gorenstein and A is a finite-length B-module, then

    Ext^1_B(A,B)

  is the Matlis dual of A.  In particular

    length Ext^1_B(A,B)=length A.

ExternalResult punctured_section_embedding:
  If E is a finite graded B-module with E_p=B_p for every homogeneous prime
  p different from the irrelevant maximal ideal m, then every nonnegative
  graded piece E_n embeds into

    H^0(Proj(B), O_Proj(B)(n)).

--------------------------------------------------------------------------
1. DUALITY FORMULA FOR THE INTRINSIC CURVE-CORE TANGENT MODULE
--------------------------------------------------------------------------

Because L is m-primary in the one-dimensional Cohen--Macaulay ring B, the
module L is maximal Cohen--Macaulay.  Hence

    Ext^1_B(L,B)=0.

Put

    Lstar := Hom_B(L,B),
    E := End_B(L),
    delta_L := length_C(E/B),
    epsilon_L := length_C Ext^1_B(L,L).

Theorem H3_CI_intrinsic_tangent_length_formula:

    length_C Hom_B(L,A)
      = N-delta_L+epsilon_L.

Proof:
  Apply Hom_B(-,B) to

    0 -> L -> B -> A -> 0.

  Since Hom_B(A,B)=0 and Ext^1_B(B,B)=0, one obtains

    0 -> B -> Lstar -> Ext^1_B(A,B) -> 0.

  By one-dimensional Gorenstein local duality,

    length_C(Lstar/B)=N.

  Next apply Hom_B(L,-) to the same short exact sequence.  Since
  Ext^1_B(L,B)=0,

    0 -> E -> Lstar -> Hom_B(L,A)
      -> Ext^1_B(L,L) -> 0

  is exact.

  Taking finite lengths gives

    length Hom_B(L,A)
      = length(Lstar/E)+epsilon_L
      = length(Lstar/B)-length(E/B)+epsilon_L
      = N-delta_L+epsilon_L.
Qed.

Corollary intrinsic_tangent_lower_bound_from_endomorphism_defect:

    length_C Hom_B(L,A) >= N-delta_L.
Qed.

--------------------------------------------------------------------------
2. REDUCED COMPLETE-INTERSECTION CORE HAS DEFECT AT MOST TWELVE
--------------------------------------------------------------------------

Let

    X := Proj(B).

Since B is a complete intersection of three quadrics in four variables,
X is a zero-dimensional complete intersection of length eight.  Because B is
reduced, X is reduced as well, although only its length is used in the section
count below.

The Hilbert function from the q=3 height split is

    dim B_0=1,
    dim B_1=4,
    dim B_2=7,
    dim B_n=8 for n>=3.

Theorem reduced_H3_CI_endomorphism_defect_at_most_twelve:

    delta_L <= 12.

Proof:
  Since A=B/L has finite length, localization away from m gives

    L_p=B_p

  for every p != m.  Therefore

    E_p=End_{B_p}(L_p)=B_p.

  Thus E/B is supported at m and E is a finite graded birational B-algebra.

  Because B is reduced, its total quotient ring is reduced.  Hence E has no
  nonzero nilpotent homogeneous element.

  We first show that E has no negative-degree element.  If a nonzero
  homogeneous x in E had deg(x)<0, then every power x^r would remain nonzero
  and would lie in E in degree r*deg(x).  But E is finite as a graded B-module,
  so its nonzero graded pieces are bounded below.  This is a contradiction.

  Hence E_n=0 for n<0.

  For n>=0, punctured_section_embedding gives

    E_n subset H^0(X,O_X(n)).

  Since X is zero-dimensional of length eight and O_X(n) is invertible,

    dim_C H^0(X,O_X(n))=8

  for every n.

  Consequently

    dim(E_0/B_0) <= 8-1=7,
    dim(E_1/B_1) <= 8-4=4,
    dim(E_2/B_2) <= 8-7=1.

  For n>=3, B_n already has dimension eight, so E_n=B_n.

  Therefore

    delta_L=length(E/B)
           <=7+4+1
           =12.
Qed.

--------------------------------------------------------------------------
3. EMBED THE INTRINSIC TANGENT MODULE INTO THE AMBIENT ONE
--------------------------------------------------------------------------

The quotient map

    I -> I/Q ~= L

shows that every B-linear map

    L -> A

lifts uniquely to an S-linear map I->A that kills Q.  Hence there is an
injection

    Hom_B(L,A) -> Hom_S(I,A).

Therefore

    dim_C Hom_S(I,A)
      >= dim_C Hom_B(L,A)
      >= N-12.

Since

    N-12 > N-20,

the necessary order-13 tangent-deficit gate fails.

Theorem homogeneous_q3_height3_reduced_CI_is_tangent_closed:
  No homogeneous q=3, ht(Q)=3 candidate with reduced complete-intersection
  quadratic core B=S/Q satisfies

    dim_C Hom_S(I,A) <= N-20.
Qed.

RESULT:
  homogeneous_q3_height3_reduced_CI_is_tangent_closed.

IMPORTANT_NONCONCLUSION:
  The reduced H3-CI child is closed.

  This file does NOT close a nonreduced H3-CI core.  The negative-degree
  nilpotent obstruction is exactly why reducedness is retained here.

  It does NOT close H2-CM or H2-NCM.
  It does NOT close homogeneous q=3.
  It does NOT close q<=2.
  It does NOT promote Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  homogeneous_q3_height3_reduced_CI_is_tangent_closed.
  not homogeneous_q3_height3_nonreduced_CI_closed.
  not homogeneous_q3_closed.
  not homogeneous_q_le_3_closure.
  not OC.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, analyze the nonreduced H3-CI core through the negative-degree
     nilpotent part of End_B(L)/B; do not assume the reduced defect bound.
