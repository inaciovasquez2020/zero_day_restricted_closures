Standalone colon-image-zero tangent closure for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_tangent_compensation.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v.

  Retain the notation

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    N=length_C(A),
    C=(J :_B g),
    Cbar=(C+L)/L subset A,

  with

    deg(u1)=deg(u2)=d<e=deg(g)

  and g a homogeneous B-nonzerodivisor.

  The preceding files prove an injection

    Hom_R(J_R,A) direct_sum Ann_A(Cbar) -> Hom_B(L,A)

  and identify

    im(tau_bar)=Cbar.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. ZERO COLON IMAGE CLOSES THE TANGENT GATE
--------------------------------------------------------------------------

Assume

  Cbar=((J:g)+L)/L=0.                                  (1)

Equivalently, every colon relation coefficient becomes zero in A, i.e.

  C subset L.                                          (2)

Then

  Ann_A(Cbar)=Ann_A(0)=A,                              (3)

and hence

  length_C Ann_A(Cbar)=N.                              (4)

Substituting (4) into the colon-compensated tangent injection gives

  dim_C Hom_B(L,A)
    >= dim_C Hom_R(J_R,A)+N
    >= N.                                              (5)

In particular

  dim_C Hom_B(L,A)>N-20.                               (6)

The natural intrinsic-to-ambient tangent injection therefore excludes the
order-13 tangent-deficit gate.

Theorem R2_zero_colon_image_is_tangent_closed:
  In residual R2, if

    ((J:g)+L)/L=0,

  then

    dim_C Hom_B(L,A)>=N,

  so the order-13 tangent-deficit gate cannot hold.
Qed.

--------------------------------------------------------------------------
2. EXPLICIT MOVING-g FUNCTIONAL
--------------------------------------------------------------------------

Under (1), define

  phi:L -> A

by

  phi(j+b*g)=b mod L.                                  (7)

This is well-defined. If

  j+b*g=j'+b'*g,

then

  (b-b')g in J,

so

  b-b' in C=(J:g).

By Cbar=0, every element of C has zero image in A, hence b-b' lies in L modulo
the quotient map B->A. Therefore b and b' have the same image in A.

The map phi is B-linear, kills J, and satisfies

  phi(g)=1.                                            (8)

Multiplication defines an A-linear map

  A -> Hom_B(L,A),
  a |-> a*phi.                                         (9)

Evaluation at g sends a*phi to a, so (9) is injective. Thus Hom_B(L,A)
contains an N-dimensional copy of A, recovering (5).

Theorem R2_zero_colon_image_has_explicit_A_tangent_copy:
  If Cbar=0, then A injects into Hom_B(L,A) by multiplication of the functional
  phi with phi(g)=1 and phi(J)=0.
Qed.

--------------------------------------------------------------------------
3. COLON-REGULAR ESCAPE IS A SPECIAL CASE
--------------------------------------------------------------------------

If

  C=(J:g)=J,                                           (10)

then J subset L gives

  Cbar=(J+L)/L=0.

Hence (10) is a sufficient special case of the stronger zero-image criterion.
Therefore the previously identified colon-regular escape subcase is closed.

Corollary R2_colon_regular_escape_is_tangent_closed:
  If (J:g)=J, then dim_C Hom_B(L,A)>=N.
Qed.

Notice that the converse need not hold: C/J may be nonzero while all of its
classes die after passage to A. No implication

  C/J != 0  ==>  Cbar != 0

is asserted.

--------------------------------------------------------------------------
4. KOSZUL INTERPRETATION
--------------------------------------------------------------------------

The preceding colon/Koszul-image identification gives

  im(tau_bar)=Cbar.

Thus under (1),

  tau_bar=0.                                           (11)

The distinguished cyclic boundary class xi represented by tau_bar modulo
image(lambda) is therefore zero. Consequently

  Ann_A(xi)=A,

and the exact cyclic-boundary tangent formula gives

  dim_C Hom_B(L,A)
    =dim_C Hom_R(J_R,A)+N.                             (12)

So the colon-compensation and cyclic-boundary descriptions agree exactly in the
whole zero-colon-image subcase, not only when C=J.

--------------------------------------------------------------------------
5. SHARPENED SURVIVOR BOUNDARY
--------------------------------------------------------------------------

Every residual R2 candidate surviving the tangent gate must therefore satisfy

  Cbar=((J:g)+L)/L != 0.                               (13)

Since C=J would force Cbar=0, (13) also implies

  (J:g) properly contains J,
  (J:g)/J != 0.                                        (14)

Combining this with the already established R2 exclusions gives the current
surviving R2 region:

  * A is non-Gorenstein;
  * the adjacent escape gap e-d=1 is closed, so e-d>=2;
  * the colon image Cbar=im(tau_bar) is nonzero;
  * consequently the colon defect (J:g)/J is nonzero.

RESULT:
  R2_zero_colon_image_is_tangent_closed.
  R2_zero_colon_image_has_explicit_A_tangent_copy.
  R2_colon_regular_escape_is_tangent_closed.

CLOSED_SUBCASE:
  residual R2 with Cbar=0, including (J:g)=J.

IMPORTANT_NONCONCLUSION:
  This file does NOT close the nonzero-colon-image case Cbar!=0.
  It does NOT close all residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation. The explicit functional and tangent
  injection are elementary module arguments. The new theorem statements are not
  machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Any surviving non-Gorenstein R2 candidate now has

    e-d>=2

  and a nonzero colon/Koszul image

    Cbar=im(tau_bar) != 0.

MISSING_OBJECT:
  In the nonzero-colon-image, non-Gorenstein R2 case, prove

    dim_C ker(lambda)
      + length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda))
      >= N-19.

NEXT_ACTIONS:
  1. Run the exact terminal workflow on this commit.
  2. Use Koszul self-duality over R to identify the orthogonal of image(lambda).
  3. Relate that orthogonal to the now genuinely nonzero Cbar=im(tau_bar).
  4. Extract only the N-19 lower bound needed for surviving R2.
  5. Do not promote all R2 until that bound is proved.
