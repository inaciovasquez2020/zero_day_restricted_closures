Standalone stable-trace duality reduction for the residual nonreduced
homogeneous q=3, height-three complete-intersection core in the order-13
deviation-two branch.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_trapped_component_reduction.v.

  Let

    B=S/(q1,q2,q3),
    L=(fbar1,fbar2,fbar3) subset B,
    A=B/L,
    E=End_B(L),
    Lstar=Hom_B(L,B).

  The three quadrics form a regular sequence in four variables, so B is a
  one-dimensional standard graded Gorenstein ring with

    Hilb_B(t)=(1+t)^3/(1-t),
    a(B)=2.

  Since L is m-primary, L_p=B_p at every nonmaximal homogeneous prime p. Thus
  L is a graded maximal Cohen--Macaulay module locally free on the punctured
  spectrum, so graded Auslander--Reiten--Serre duality applies to L.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

ExternalResult graded_AR_Serre_duality_dim1:
  For a Z-graded one-dimensional Gorenstein ring R with a-invariant a and
  X,Y graded MCM modules with Y locally free on the punctured spectrum,

    underlineHom^Z_R(X,Y)
      ~= D underlineHom^Z_R(Y,X(a)),

  functorially. Here underlineHom denotes morphisms modulo those factoring
  through graded projectives. This is Proposition 4.6 of Buchweitz--Iyama--
  Yamaura, Tilting theory for Gorenstein rings in dimension one.

--------------------------------------------------------------------------
1. DEGREEWISE AUSLANDER--REITEN PAIRING
--------------------------------------------------------------------------

Use the grading convention that E_r consists of homogeneous B-linear maps

  L -> L

of internal degree r, equivalently degree-zero maps L -> L(r).

For every s>=1, apply graded_AR_Serre_duality_dim1 with

  X=L,
  Y=L(-s).

Since dim(B)=1 and a(B)=2, the triangulated shift [dim(B)-1] is [0]. After
reindexing internal degree shifts, one obtains a perfect C-duality

  underlineE_{-s}
    ~= D underlineE_{2+s},

where underlineE_r denotes the degree-r stable endomorphism space.

Therefore

  dim_C underlineE_{-s}
    = dim_C underlineE_{2+s}.

Theorem negative_stable_endomorphisms_pair_with_degree_at_least_three:
  For every s>=1,

    dim_C underlineE_{-s}=dim_C underlineE_{2+s}.
Qed.

--------------------------------------------------------------------------
2. IDENTIFY THE POSITIVE STABLE TAIL WITH THE TRACE QUOTIENT
--------------------------------------------------------------------------

Let

  P := tr_B(L)=image(L tensor_B Lstar -> B).

A homogeneous endomorphism of L factors through a graded free B-module exactly
when it is a finite sum of products

  y*alpha,

with y in L and alpha in Lstar. Consequently the degree-r maps factoring
through graded projectives form P_r inside E_r, and

  underlineE_r ~= E_r/P_r.

The punctured-section argument used in the H3-CI defect calculation does not
require reducedness in nonnegative degree: E_r embeds in

  H^0(Proj(B),O(r)),

which has dimension eight for every r, while B_r has dimension eight for
r>=3 and B_r is already contained in E_r. Hence

  E_r=B_r for every r>=3.

Thus, for r>=3,

  underlineE_r ~= B_r/P_r ~= (B/P)_r.

Combining this with Section 1 gives, for every s>=1,

  dim_C underlineE_{-s}
    = dim_C (B/P)_{2+s}.

Theorem stable_negative_defect_is_trace_tail:

  sum_{s>=1} dim_C underlineE_{-s}
    = length_C (B/P)_{>=3}.
Qed.

The sum is finite because P contains the m-primary ideal L, so B/P has finite
length.

--------------------------------------------------------------------------
3. SPLIT THE FULL NEGATIVE DEFECT INTO TWO EXPLICIT PIECES
--------------------------------------------------------------------------

For each r, let

  F_r := P_r subset E_r

be the subspace of degree-r endomorphisms factoring through graded projectives.
Degreewise there is an exact sequence

  0 -> F_r -> E_r -> underlineE_r -> 0.

Define

  phi_neg := sum_{s>=1} dim_C F_{-s}.

Then

  delta_neg
    := sum_{s>=1} dim_C E_{-s}
     = phi_neg + sum_{s>=1} dim_C underlineE_{-s}
     = phi_neg + length_C(B/P)_{>=3}.

Theorem exact_negative_defect_trace_decomposition:

  delta_neg
    = phi_neg + length_C(B/tr_B(L))_{>=3}.
Qed.

This replaces the opaque quantity delta_neg by two concrete finite objects:

  (i) negative-degree trace products L*L, measured by phi_neg;
  (ii) the degree-at-least-three tail of the Artinian trace quotient B/tr(L).

--------------------------------------------------------------------------
4. UPDATED SUFFICIENT INEQUALITY
--------------------------------------------------------------------------

The preceding rigidity reduction gives

  epsilon_L:=length_C Ext^1_B(L,L)>=1,

and the tangent formula gives

  length_C Hom_B(L,A)
    =N-delta_nonneg-delta_neg+epsilon_L,

with

  delta_nonneg<=12.

Hence it is sufficient to prove

  phi_neg
    + length_C(B/tr_B(L))_{>=3}
    - epsilon_L
      <=7.

Equivalently, the remaining obstruction is no longer an arbitrary collection
of negative endomorphisms: its stable quotient is exactly the high-degree tail
of a finite trace quotient, and only the negative factor-through part remains
to be compared directly with self-extensions.

RESULT:
  exact_negative_defect_trace_decomposition.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove the displayed sufficient inequality.
  It does NOT close R1 or R2.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation using the explicitly named
  external graded Auslander--Reiten--Serre duality theorem.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  delta_neg is exactly decomposed into negative trace-factor maps plus the
  high-degree trace-quotient tail.

MISSING_OBJECT:
  Prove

    phi_neg + length_C(B/tr_B(L))_{>=3} - epsilon_L <= 7

  for the residual R1/R2 degree patterns, beginning with R2.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, attack R2 by expressing F_{-s}=(L*L)_{-s} through the two
     degree-d generators and the degree-e escape generator.
  3. Compare the kernel of L tensor Lstar -> tr(L) with Ext^1_B(L,L), using
     only a verified exact sequence or duality.
  4. Bound the remaining trace-quotient tail by the multiplicity-eight generic
     component data.
  5. Do not promote H3-CI until the compensated bound is proved.