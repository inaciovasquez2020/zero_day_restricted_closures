Standalone twisted-conormal reduction for the residual nonreduced homogeneous
q=3, height-three complete-intersection core in the order-13 deviation-two
branch.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_conductor_duality_reduction.v.

  Let

    B=S/(q1,q2,q3),
    L=(fbar1,fbar2,fbar3) subset B,
    A=B/L,
    N=length_C(A),
    E=End_B(L),

  where B is the one-dimensional standard graded Gorenstein complete
  intersection of three quadrics, L is homogeneous and m-primary, and
  mu_B(L)=3.

  Write

    epsilon_L := length_C Ext^1_B(L,L),
    delta_total := length_C(E/B),
    delta_nonneg := sum_{n>=0} dim_C(E/B)_n,
    delta_neg := sum_{n<0} dim_C E_n.

  Since B is nonnegatively graded,

    delta_total=delta_nonneg+delta_neg.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

ExternalResult HIW_Proposition_5_6:
  Let R be a one-dimensional Gorenstein local ring and I an ideal containing a
  regular element. Put S=End_R(I) and omega_{R/I}=Ext^1_R(R/I,R). Then

    length Ext^1_R(I,I) + length(R/I)
      = length(S/R)
        + length((I/I^2) tensor_{R/I} omega_{R/I}).

  Source:
    C. Huneke, S. B. Iyengar, R. Wiegand,
    Rigid ideals in Gorenstein rings of dimension one,
    Acta Math. Vietnam. 44 (2019), Proposition 5.6.

--------------------------------------------------------------------------
1. APPLY PROPOSITION 5.6 TO THE GRADED H3 CORE
--------------------------------------------------------------------------

All finite-length modules in the present setup are supported at the homogeneous
maximal ideal m of B. Localizing B and L at m therefore preserves their lengths.
The ideal L contains a B-regular element because it is m-primary in the
one-dimensional Cohen--Macaulay ring B.

Define the twisted conormal module

  C_L := (L/L^2) tensor_A omega_A,

where

  omega_A := Ext^1_B(A,B).

Applying HIW_Proposition_5_6 after localization at m, and then translating back
to C-vector-space lengths, gives

  epsilon_L + N
    = delta_total + length_C(C_L).

Using delta_total=delta_nonneg+delta_neg,

  epsilon_L + N
    = delta_nonneg + delta_neg + length_C(C_L).

Theorem exact_H3_defect_twisted_conormal_identity:

  epsilon_L + N
    = delta_nonneg + delta_neg + length_C(C_L).
Qed.

--------------------------------------------------------------------------
2. THE INTRINSIC TANGENT SPACE IS EXACTLY THE TWISTED CONORMAL LENGTH
--------------------------------------------------------------------------

The preceding H3 reductions established

  length_C Hom_B(L,A)
    = N-delta_nonneg-delta_neg+epsilon_L.

Substituting the identity of Section 1 gives

  length_C Hom_B(L,A)=length_C(C_L).

This also follows directly from Artinian canonical duality: every B-linear map
L -> A factors through L/L^2, and the Matlis dual of

  Hom_A(L/L^2,A)

is

  (L/L^2) tensor_A omega_A.

Hence the two finite-length A-modules have equal C-dimension.

Theorem intrinsic_H3_tangent_equals_twisted_conormal:

  length_C Hom_B(L,A)
    = length_C((L/L^2) tensor_A omega_A).
Qed.

The order-13 tangent exclusion requires

  dim_C Hom_S(I,A) > N-20.

Since Hom_B(L,A) injects into Hom_S(I,A), it is therefore enough to prove

  length_C(C_L) > N-20.

Because the lengths are integers, the exact weakest numerical target is

  length_C(C_L) >= N-19.

This is strictly weaker than the previously used sufficient condition

  delta_neg-epsilon_L <= 7.

Indeed Section 1 gives the exact conversion

  delta_neg-epsilon_L
    = N-length_C(C_L)-delta_nonneg.

Thus the compensated conductor inequality was a useful sufficient route, but it
is not the intrinsic remaining tangent gate.

--------------------------------------------------------------------------
3. R2 NEGATIVE LAYERS INJECT INTO A SQUARE-ZERO OVERLAP MODULE
--------------------------------------------------------------------------

Now specialize to the residual R2 pattern

  d1=d2=d<d3=e,

and write homogeneous minimal generators

  L=(u1,u2,v),

with

  deg(u1)=deg(u2)=d,
  deg(v)=e,
  D=e-d.

Put

  J:=(u1,u2),
  K:=Ann_B(J).

Take

  x in E_{-s},
  1<=s<=D.

Since d-s<d and d is the least degree in which L is nonzero,

  x*u1=x*u2=0.

Therefore

  xJ=0.

Also

  x*v in L_{e-s}.

Because e-s<e, the degree-(e-s) piece of L receives no contribution from the
third generator v. Hence

  L_{e-s}=J_{e-s},

so

  x*v in J_{e-s}.

Moreover xJ=0 implies

  (x*v)J=0,

and therefore

  x*v in (J intersect K)_{e-s}.

This defines a graded C-linear map

  theta_s : E_{-s} -> (J intersect K)_{e-s},
  theta_s(x)=x*v.

The map is injective. If x*v=0, then at every trapped minimal prime q the R2
escape property says v is not in q, hence v is a unit in B_q and x_q=0. At every
untrapped minimal prime the preceding trapped-component theorem already gives
x_q=0. Since E is viewed inside the homogeneous total quotient ring and B is
unmixed, vanishing at every minimal localization forces x=0.

Theorem R2_negative_layer_injects_into_annihilator_overlap:
  For every 1<=s<=D,

    E_{-s} injects into (J intersect Ann_B(J))_{e-s}.
Qed.

Summing over the finite window gives

  delta_neg
    <= sum_{r=d}^{e-1} dim_C (J intersect Ann_B(J))_r.

The overlap module is square-zero. Indeed, if a,b lie in J intersect K, then
b lies in J while a annihilates J, so

  a*b=0.

Thus

  (J intersect Ann_B(J))^2=0.

Corollary R2_negative_defect_is_controlled_by_square_zero_overlap_window:

  delta_neg
    <= sum_{r=d}^{e-1} dim_C (J intersect Ann_B(J))_r,

  with

    (J intersect Ann_B(J))^2=0.
Qed.

--------------------------------------------------------------------------
4. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  exact_H3_defect_twisted_conormal_identity.
  intrinsic_H3_tangent_equals_twisted_conormal.
  R2_negative_layer_injects_into_annihilator_overlap.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(C_L)>=N-19.

  It does NOT close R2 or R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation using the explicitly named
  Huneke--Iyengar--Wiegand Proposition 5.6 and standard Artinian canonical
  duality. The new theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The intrinsic H3 tangent problem is exactly a twisted-conormal length problem.
  In R2, every negative endomorphism layer embeds into the finite degree window
  of the square-zero module J intersect Ann_B(J).

MISSING_OBJECT:
  Prove in residual R2 that

    length_C((L/L^2) tensor_A omega_A) >= N-19.

  Equivalently, derive enough twisted-conormal classes from the two equal-degree
  trapped generators and the escape generator, possibly using the square-zero
  overlap J intersect Ann_B(J).

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, analyze the A-module L/L^2 in R2 via J=(u1,u2) and the escape
     generator v.
  3. Isolate the contribution of J intersect Ann_B(J) to the kernel of the
     conormal presentation.
  4. Prove the weakest bound length_C(C_L)>=N-19; do not revert to the stronger
     delta_neg-epsilon_L<=7 unless needed.
  5. Rebuild immediately after the first conormal-length lemma.
