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
  through graded projectives. This is Proposition 4.5 of Buchweitz--Iyama--
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
3. NEGATIVE FACTOR-THROUGH MAPS VANISH
--------------------------------------------------------------------------

For each r, let

  F_r := P_r subset E_r

be the subspace of degree-r endomorphisms factoring through graded projectives.

This is where the previous version carried an unnecessary term. Since B is
standard nonnegatively graded,

  B_r=0 for every r<0.

Because P is a homogeneous ideal of B,

  P_r=0 for every r<0.

Hence

  F_r=0 for every r<0.

Therefore

  phi_neg := sum_{s>=1} dim_C F_{-s}=0.

Theorem negative_factor_through_defect_vanishes:

  phi_neg=0.
Qed.

Consequently the full negative defect is exactly the stable negative defect:

  delta_neg
    := sum_{s>=1} dim_C E_{-s}
     = sum_{s>=1} dim_C underlineE_{-s}
     = length_C(B/tr_B(L))_{>=3}.

Theorem exact_negative_defect_is_trace_tail:

  delta_neg
    = length_C(B/tr_B(L))_{>=3}.
Qed.

--------------------------------------------------------------------------
4. SHARPENED SUFFICIENT INEQUALITY
--------------------------------------------------------------------------

The preceding rigidity reduction gives

  epsilon_L:=length_C Ext^1_B(L,L)>=1,

and the tangent formula gives

  length_C Hom_B(L,A)
    =N-delta_nonneg-delta_neg+epsilon_L,

with

  delta_nonneg<=12.

Using the exact trace-tail identity, it is sufficient to prove

  length_C(B/tr_B(L))_{>=3} - epsilon_L <= 7.

Since epsilon_L>=1, the simpler bound

  length_C(B/tr_B(L))_{>=3} <= 8

is sufficient.

Thus the residual nonreduced H3-CI obstruction has been reduced to one
concrete Artinian quantity: the degree-at-least-three tail of the trace
quotient.

RESULT:
  negative_factor_through_defect_vanishes.
  exact_negative_defect_is_trace_tail.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(B/tr_B(L))_{>=3}<=8.

  It does NOT close R1 or R2.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation using the explicitly named
  external graded Auslander--Reiten--Serre duality theorem.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  delta_neg is exactly the high-degree tail of B/tr_B(L); there is no separate
  negative factor-through contribution.

MISSING_OBJECT:
  Prove, beginning with R2=d1=d2<d3,

    length_C(B/tr_B(L))_{>=3} <= 8,

  or directly prove the sharper compensated inequality

    length_C(B/tr_B(L))_{>=3} - epsilon_L <= 7.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, attack R2 through the trace ideal of the two degree-d trapped
     generators and the degree-e escape generator.
  3. Bound the high-degree trace quotient rather than delta_neg directly.
  4. Use Ext^1 compensation only if the raw trace-tail bound eight fails.
  5. Do not promote H3-CI until R1 and R2 are both closed.
