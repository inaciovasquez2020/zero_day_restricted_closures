Standalone cyclic-boundary and Koszul refinement for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_multiplication_quotient_reduction.v.

  Retain its notation

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    N=length_C(A),

  with

    deg(u1)=deg(u2)=d < e=deg(g),

  and g a homogeneous B-nonzerodivisor. Put

    C=(J:g),
    D=C/J,
    R=B/(g),
    J_R=(J+(g))/(g) subset R.

  The previous reduction gives

    0 -> D(-e) -> J/gJ -> J_R -> 0,

  together with

    mu : A -> Hom_A(D(-e),A)

  and the connecting map

    beta : Hom_A(D(-e),A) -> Ext^1_R(J_R,A),

  and proves

    dim_C Hom_B(L,A)
      = N + dim_C Hom_R(J_R,A) - rank(beta o mu).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE MULTIPLICATION-REACHED BOUNDARY IS CYCLIC
--------------------------------------------------------------------------

Let

  pi := mu(1) in Hom_A(D(-e),A),

so, under the shift convention inherited from the overlap construction,

  pi(c mod J)=c mod L.

Set

  xi := beta(pi) in Ext^1_R(J_R,A).

The target Ext group is an R-module through its second argument, and because
J_R annihilates A this action factors through A=R/J_R. The connecting map beta
is R-linear, hence A-linear on the multiplication family. Therefore, for every

a in A,

  (beta o mu)(a)
    = beta(a*pi)
    = a*beta(pi)
    = a*xi.

Thus

  im(beta o mu)=A*xi.

Theorem R2_multiplication_reached_boundary_is_cyclic:
  The multiplication-reached nonextendability space is the cyclic A-module

    A*xi.
Qed.

Its kernel is exactly

  Ann_A(xi)={a in A : a*xi=0}.

Hence

  rank(beta o mu)
    = length_C(A/Ann_A(xi))
    = N-length_C(Ann_A(xi)).

Theorem R2_boundary_rank_is_annihilator_colength:

  rank(beta o mu)=N-length_C(Ann_A(xi)).
Qed.

--------------------------------------------------------------------------
2. EXACT ANNIHILATOR TANGENT FORMULA
--------------------------------------------------------------------------

Substitute the preceding rank identity into the already established exact
multiplication-quotient formula:

  dim_C Hom_B(L,A)
    = N + dim_C Hom_R(J_R,A) - rank(beta o mu).

Then the N terms cancel and give

  dim_C Hom_B(L,A)
    = dim_C Hom_R(J_R,A)
      + length_C(Ann_A(xi)).

Theorem R2_exact_cyclic_boundary_tangent_formula:

  dim_C Hom_B(L,A)
    = dim_C Hom_R(J_R,A)
      + length_C(Ann_A(xi)).
Qed.

This is sharper than bounding the full image of beta: only the annihilator of
one distinguished boundary class xi, together with the two-generator tangent
space Hom_R(J_R,A), enters the exact R2 tangent count.

--------------------------------------------------------------------------
3. TWO-GENERATOR KOSZUL LENGTH IDENTITY
--------------------------------------------------------------------------

Because B is one-dimensional Gorenstein and g is B-regular, R=B/(g) is
Artinian Gorenstein. Consider the Koszul complex

  K=K_R(u1,u2).

Its homology satisfies

  H_0(K)=A,

so

  length_C H_0(K)=N.

Also

  H_2(K)=Ann_R(J_R)=Hom_R(A,R).

Since R is Artinian Gorenstein, Hom_R(-,R) is Matlis duality on finite-length
R-modules and preserves length. Therefore

  length_C H_2(K)=N.

The alternating sum of the lengths of the terms of the two-generator Koszul
complex is

  length(R)-2 length(R)+length(R)=0.

Euler characteristic therefore gives

  length_C H_0(K)
    - length_C H_1(K)
    + length_C H_2(K)
    =0.

Consequently

  length_C H_1(K)=2N.

Theorem R2_two_generator_koszul_H1_length:

  length_C H_1(u1,u2;R)=2N.
Qed.

IMPORTANT:
  This identity alone does not bound Ann_A(xi), nor does it prove the tangent
  inequality. A further structural map from the cyclic boundary class xi to
  the Koszul/conormal data is still required.

--------------------------------------------------------------------------
4. CORRECT SHARP CLOSURE TARGET
--------------------------------------------------------------------------

The order-13 tangent-deficit gate is excluded once

  dim_C Hom_B(L,A) > N-20,

because Hom_B(L,A) injects into the ambient tangent space used by the prior
reduction.

By the exact cyclic-boundary formula, it now suffices to prove

  dim_C Hom_R(J_R,A)
    + length_C(Ann_A(xi))
    > N-20.

Since all quantities are integers, an equivalent sufficient inequality is

  length_C(A/Ann_A(xi))
    - dim_C Hom_R(J_R,A)
    <=19.

Theorem R2_sharp_cyclic_boundary_closure_target:
  A sufficient remaining R2 inequality is

    dim_C Hom_R(J_R,A)
      + length_C(Ann_A(xi))
      >= N-19.
Qed.

--------------------------------------------------------------------------
5. BOUNDARY
--------------------------------------------------------------------------

RESULT:
  R2_multiplication_reached_boundary_is_cyclic.
  R2_exact_cyclic_boundary_tangent_formula.
  R2_two_generator_koszul_H1_length.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    dim_C Hom_R(J_R,A)+length_C(Ann_A(xi)) >= N-19.

  It does NOT close residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The active R2 obstruction is reduced to the annihilator size of the single
  distinguished class

    xi=beta(mu(1)),

  compensated by

    Hom_R(J_R,A).

MISSING_OBJECT:
  Prove

    dim_C Hom_R(J_R,A)+length_C(Ann_A(xi)) >= N-19,

  by relating xi to the two-generator Koszul/conormal structure of

    J_R=(u1,u2) subset R.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow for this commit.
  2. Identify the class xi inside the conormal/Koszul exact sequence.
  3. Determine the annihilator of xi, or a lower bound for its length.
  4. Combine that lower bound with dim_C Hom_R(J_R,A).
  5. Do not promote R2 until the >=N-19 inequality is proved.
