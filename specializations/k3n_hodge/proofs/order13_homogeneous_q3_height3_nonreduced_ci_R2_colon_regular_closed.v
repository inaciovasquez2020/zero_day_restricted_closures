Standalone colon-regular tangent closure for the residual nonreduced homogeneous
q=3, height-three complete-intersection R2 branch in the order-13 deviation-two
program.

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
1. COLON-REGULAR ESCAPE
--------------------------------------------------------------------------

Assume

  C=(J:g)=J.                                           (1)

Equivalently,

  C/J=0:_{B/J} g=0,

so g is a nonzerodivisor on B/J.

Since J is contained in L, (1) gives

  Cbar=(C+L)/L=(J+L)/L=0.                              (2)

Therefore

  Ann_A(Cbar)=Ann_A(0)=A,                              (3)

and hence

  length_C Ann_A(Cbar)=N.                              (4)

Substituting (4) into the colon-compensated tangent injection yields

  dim_C Hom_B(L,A)
    >= dim_C Hom_R(J_R,A)+N
    >= N.                                              (5)

In particular

  dim_C Hom_B(L,A)>N-20.                               (6)

The natural intrinsic-to-ambient tangent injection then excludes the order-13
tangent-deficit gate.

Theorem R2_colon_regular_escape_is_tangent_closed:
  In residual R2, if

    (J:g)=J,

  then

    dim_C Hom_B(L,A)>=N,

  so the order-13 tangent-deficit gate cannot hold.
Qed.

--------------------------------------------------------------------------
2. EXPLICIT MOVING-g FUNCTIONAL
--------------------------------------------------------------------------

The same conclusion can be seen without any dimension bookkeeping.

Under (1), define

  phi:L -> A

by

  phi(j+b*g)=b mod L.                                  (7)

This is well-defined. If

  j+b*g=j'+b'*g,

then

  (b-b')g in J,

so

  b-b' in (J:g)=J subset L.

Thus b and b' have the same image in A. The map phi is B-linear, kills J, and
satisfies

  phi(g)=1.                                            (8)

Multiplication therefore defines an A-linear map

  A -> Hom_B(L,A),
  a |-> a*phi.                                         (9)

Evaluation at g sends a*phi to a, so (9) is injective. Hence Hom_B(L,A)
contains an N-dimensional copy of A, recovering (5).

Theorem R2_colon_regular_explicit_A_tangent_copy:
  If (J:g)=J, then A injects into Hom_B(L,A) by multiplication of the
  functional phi with phi(g)=1 and phi(J)=0.
Qed.

--------------------------------------------------------------------------
3. KOSZUL INTERPRETATION
--------------------------------------------------------------------------

The preceding colon/Koszul-image identification gives

  im(tau_bar)=Cbar.

Under (1), Cbar=0, hence

  tau_bar=0.                                           (10)

Thus the distinguished cyclic boundary class xi represented by tau_bar modulo
image(lambda) is zero. Consequently

  Ann_A(xi)=A,

and the exact cyclic-boundary tangent formula also gives

  dim_C Hom_B(L,A)
    =dim_C Hom_R(J_R,A)+N.                             (11)

So the colon-compensation and cyclic-boundary descriptions agree exactly in the
colon-regular subcase.

--------------------------------------------------------------------------
4. SHARPENED SURVIVOR BOUNDARY
--------------------------------------------------------------------------

Therefore every residual R2 candidate surviving the tangent gate must satisfy

  (J:g) properly contains J,                           (12)

or equivalently

  D_colon:=(J:g)/J is nonzero.                         (13)

Combining this with the already established R2 exclusions gives the current
surviving R2 region:

  * A is non-Gorenstein;
  * the adjacent escape gap e-d=1 is closed, so e-d>=2;
  * the colon defect D_colon is nonzero.

RESULT:
  R2_colon_regular_escape_is_tangent_closed.
  R2_colon_regular_explicit_A_tangent_copy.

CLOSED_SUBCASE:
  residual R2 with (J:g)=J.

IMPORTANT_NONCONCLUSION:
  This file does NOT close the strict-colon-defect case (J:g)>J.
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

  and a nonzero colon defect

    (J:g)/J != 0.

MISSING_OBJECT:
  In the strict-colon-defect, non-Gorenstein R2 case, prove

    dim_C ker(lambda)
      + length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda))
      >= N-19,

  using Cbar=im(tau_bar) and Cbar != 0.

NEXT_ACTIONS:
  1. Run the exact terminal workflow on this commit.
  2. Use Koszul self-duality over R to identify the orthogonal of image(lambda).
  3. Relate that orthogonal to the nonzero colon image Cbar=im(tau_bar).
  4. Extract only the N-19 bound needed for strict-colon survivors.
  5. Do not promote all R2 until that bound is proved.
