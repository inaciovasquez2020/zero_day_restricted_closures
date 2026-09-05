Standalone multiplication-quotient refinement for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_tangent_fiber_product_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_nonextendable_colon_dual_reduction.v.

  Let

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    N=length_C(A),

  in residual R2, with

    deg(u1)=deg(u2)=d < e=deg(g),

  and g a homogeneous B-nonzerodivisor chosen by the regular-escape
  reduction. Put

    C=(J:g),
    D=C/J,
    R=B/(g),
    J_R=(J+(g))/(g) subset R.

  Since J and g annihilate A, D is naturally an A-module.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE OVERLAP MAP LIVES ON D, NOT ON ALL OF C
--------------------------------------------------------------------------

The fiber-product reduction gives the exact presentation

  0 -> gC -> J direct_sum Bg -> L -> 0

and therefore

  0 -> Hom_B(L,A)
    -> Hom_B(J,A) direct_sum A
    -> Hom_B(gC,A).

For psi in Hom_B(J,A) and a in A, the overlap difference is

  gc |-> psi(gc)-c*a.

If c lies in J, then

  psi(gc)=g*psi(c)=0

because gA=0, while

  c*a=0

because JA=0. Thus the overlap difference vanishes on J and factors through

  D=C/J.

Using the degree-e identification gC ~= C(-e), set

  M := Hom_A(D(-e),A).

Define

  res : Hom_B(J,A) -> M,
  res(psi)(c mod J) := psi(gc),

and let

  mu : A -> M

be the multiplication family induced by maps Bg -> A,

  mu(a)(c mod J) := c*a,

with the displayed shift understood through gC ~= C(-e).

Then the overlap map is

  Theta(psi,a)=res(psi)-mu(a).

Theorem R2_overlap_factors_through_colon_quotient:
  The fiber-product overlap map has image

    im(Theta)=im(res)+im(mu)

  inside M=Hom_A(D(-e),A).
Qed.

--------------------------------------------------------------------------
2. EXACT QUOTIENT-RANK FORMULA
--------------------------------------------------------------------------

Write

  U:=im(res),

and let

  q : M -> M/U

be the quotient map. Define

  bar_mu := q o mu : A -> M/U.

Linear algebra gives

  rank(Theta)
    = dim_C(U+im(mu))
    = dim_C U + rank(bar_mu).

Also

  dim_C Hom_B(J,A)
    = dim_C ker(res) + dim_C U.

Substituting both identities into the exact fiber-product count

  dim_C Hom_B(L,A)
    = dim_C Hom_B(J,A) + N - rank(Theta)

gives the exact cancellation

  dim_C Hom_B(L,A)
    = N + dim_C ker(res) - rank(bar_mu).

Theorem R2_exact_multiplication_quotient_tangent_formula:

  dim_C Hom_B(L,A)
    = N + dim_C ker(res) - rank(bar_mu).
Qed.

--------------------------------------------------------------------------
3. IDENTIFY THE KERNEL WITH THE TWO-GENERATOR SECTION
--------------------------------------------------------------------------

The nonextendable-colon reduction already established the exact sequence

  0 -> D(-e) -> J/gJ -> J_R -> 0.

Because gA=0, every B-linear map J -> A factors uniquely through J/gJ.
Applying Hom_R(-,A) shows that the kernel of restriction to D(-e) is

  ker(res) ~= Hom_R(J_R,A).

Hence the exact tangent formula becomes

  dim_C Hom_B(L,A)
    = N + dim_C Hom_R(J_R,A) - rank(bar_mu).

Theorem R2_exact_two_generator_compensated_tangent_formula:

  dim_C Hom_B(L,A)
    = N
      + dim_C Hom_R(J_R,A)
      - rank(bar_mu).
Qed.

--------------------------------------------------------------------------
4. RELATION WITH THE PREVIOUS CONNECTING MAP beta
--------------------------------------------------------------------------

Applying Hom_R(-,A) to

  0 -> D(-e) -> J/gJ -> J_R -> 0

gives

  Hom_B(J,A) --res--> M --beta--> Ext^1_R(J_R,A).

Thus

  ker(beta)=im(res)=U,

so beta induces an injection

  M/U -> Ext^1_R(J_R,A)

with image im(beta). Under this identification, bar_mu is exactly the part of
the nonextendable-colon obstruction reached by the multiplication family:

  rank(bar_mu)=rank(beta o mu).

Consequently

  dim_C Hom_B(L,A)
    = N
      + dim_C Hom_R(J_R,A)
      - rank(beta o mu).

Theorem R2_only_multiplication_reached_nonextendability_costs_tangent:
  The full space im(beta) is not the tangent loss. Only im(beta o mu)
  contributes to the fiber-product rank after the two-generator compensation
  is included.
Qed.

--------------------------------------------------------------------------
5. CORRECT SHARP CLOSURE TARGET
--------------------------------------------------------------------------

The order-13 tangent-deficit gate would require

  dim_C Hom_S(I,A) <= N-20.

The natural tangent injection gives

  Hom_B(L,A) -> Hom_S(I,A).

Therefore it suffices to prove

  rank(beta o mu) - dim_C Hom_R(J_R,A) <= 19.

Indeed, the exact formula would then give

  dim_C Hom_B(L,A) >= N-19 > N-20.

Theorem R2_sharp_remaining_tangent_inequality:
  A sufficient remaining inequality for R2 closure is

    rank(beta o mu) - dim_C Hom_R(J_R,A) <= 19.
Qed.

The previously recorded condition

  dim_C im(beta) <= 19

is still sufficient because rank(beta o mu)<=dim_C im(beta), but it is
strictly stronger than what the exact fiber-product geometry requires and is
therefore retired as the active target.

--------------------------------------------------------------------------
6. BOUNDARY
--------------------------------------------------------------------------

RESULT:
  R2_exact_two_generator_compensated_tangent_formula.
  R2_only_multiplication_reached_nonextendability_costs_tangent.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    rank(beta o mu) - dim_C Hom_R(J_R,A) <= 19.

  It does NOT close residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The active R2 obstruction is now the multiplication-reached quotient rank

    rank(beta o mu) - dim_C Hom_R(J_R,A),

  not the full dimension of im(beta).

MISSING_OBJECT:
  Prove

    rank(beta o mu) - dim_C Hom_R(J_R,A) <= 19,

  preferably using the two-generator Artinian-Gorenstein section

    R=B/(g),
    A=R/J_R,
    J_R=(u1,u2),

  and its Koszul homology.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, record the exact two-generator Koszul identity
       length H_1(u1,u2;R)=2N.
  3. Relate beta o mu to the conormal/Koszul boundary map rather than to all
     of Ext^1_R(J_R,A).
  4. Bound only the multiplication-reached quotient rank.
  5. Do not promote R2 before the <=19 inequality is proved.
