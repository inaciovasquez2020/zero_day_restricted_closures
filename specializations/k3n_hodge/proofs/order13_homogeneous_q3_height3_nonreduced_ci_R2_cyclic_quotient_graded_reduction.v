Standalone graded refinement of the cyclic-quotient obstruction for the
residual nonreduced homogeneous q=3, height-three complete-intersection R2
branch in the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_pushout_koszul_boundary_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v.

  Retain

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    R=B/(g),
    J_R=(u1,u2) subset R,

  with

    deg(u1)=deg(u2)=d < e=deg(g),
    D=e-d>0.

  Let

    H1 := H_1(u1,u2;R),
    V  := Hom_A(H1,A),

  and let

    lambda : A(d)^2 -> V

  be the graded restriction map induced from the homogeneous presentation

    R(-d)^2 -> J_R.

  The preceding pushout reduction constructed the homogeneous Koszul division
  class

    tau_bar : H1 -> A

  and identified its image with

    Cbar=((J:g)+L)/L subset A.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EXACT DEGREE OF tau_bar
--------------------------------------------------------------------------

Use the standard grading on the two-generator Koszul complex

  K_1=R(-d)^2.

Let h in H1 be represented by a homogeneous cycle of total internal degree n.
Thus its two coefficient lifts a1,a2 in B have degree n-d.  By definition of
tau_bar,

  a1*u1+a2*u2=g*c

for a homogeneous c.  The left side has degree n, while deg(g)=e.  Therefore

  deg(c)=n-e.

Since tau_bar(h)=c mod L, tau_bar is homogeneous of graded-map degree

  deg(tau_bar)=-e.

Theorem R2_tau_bar_has_degree_minus_e:

  tau_bar lies in Hom_A(H1,A)_{-e}.
Qed.

--------------------------------------------------------------------------
2. EXACT GRADING OF image(lambda)
--------------------------------------------------------------------------

A homogeneous map

  R(-d)^2 -> A

of graded-map degree s is determined by the images of the two basis vectors,
which lie in

  A_{d+s}.

Consequently the degree-s source of lambda is

  A_{d+s}^2,

and hence

  image(lambda)_s = lambda_s(A_{d+s}^2).

Now multiply tau_bar by a homogeneous element

  a in A_r.

Then

  a*tau_bar

has graded-map degree

  r-e.

At that degree, the only possible lambda correction comes from

  A_{d+r-e}^2=A_{r-D}^2.

Therefore

  image(lambda)_{r-e}
    =lambda_{r-e}(A_{r-D}^2).                       (1)

Theorem R2_lambda_correction_for_degree_r_multiplier_comes_from_A_r_minus_D:

  For homogeneous a in A_r, the condition

    a*tau_bar in image(lambda)

  can involve only source coefficients in A_{r-D}^2.
Qed.

--------------------------------------------------------------------------
3. LOW-DEGREE OVERLAP VANISHES
--------------------------------------------------------------------------

Because A is a standard nonnegatively graded Artinian quotient,

  A_m=0 for m<0.

Hence for every

  0<=r<D,

we have

  A_{r-D}=0.

By (1),

  image(lambda)_{r-e}=0.

Thus, for homogeneous a in A_r with 0<=r<D,

  a*tau_bar in image(lambda)

if and only if

  a*tau_bar=0.

Since im(tau_bar)=Cbar, this is equivalent to

  a*Cbar=0.

Therefore the degree-r part of the exact boundary annihilator agrees with the
ordinary colon annihilator throughout the whole initial D-degree window:

  Ann_A(xi)_r = Ann_A(Cbar)_r

for every 0<=r<D.

Equivalently, the Koszul-overlap correction satisfies

  ((A*tau_bar) intersect image(lambda))_{r-e}=0

for every 0<=r<D.

Theorem R2_first_D_multiplier_degrees_have_zero_Koszul_overlap:

  For 0<=r<D=e-d,

    Ann_A(xi)_r=Ann_A(Cbar)_r,

  and no nonzero degree-r multiple of tau_bar can be absorbed by image(lambda).
Qed.

--------------------------------------------------------------------------
4. CYCLIC QUOTIENT FORMULATION WITH GRADING RESTORED
--------------------------------------------------------------------------

Let

  Q:=V/image(lambda),
  q:V->Q,
  eta:=q(tau_bar).

Then eta is homogeneous of degree -e and

  Ann_A(eta)=Ann_A(xi).

Multiplication gives a graded surjection

  A(e) -> A*eta,
  a |-> a*eta,

whose kernel is Ann_A(eta)(e).  Thus, forgetting shifts only after the graded
identification is made,

  length_C(A*eta)
    =N-length_C Ann_A(xi).

Together with

  Hom_R(J_R,A) ~= ker(lambda),

this recovers the exact tangent identity

  dim_C Hom_B(L,A)
    =N+dim_C ker(lambda)-length_C(A*eta).

Therefore the remaining R2 closure target is exactly

  length_C(A*eta) <= dim_C ker(lambda)+19.          (2)

The new graded information is that the first D multiplier degrees of A*eta
cannot be shortened by lambda-overlap: in those degrees the only kernel comes
from Ann_A(Cbar).

--------------------------------------------------------------------------
5. BOUNDARY
--------------------------------------------------------------------------

RESULT:
  R2_tau_bar_has_degree_minus_e.
  R2_lambda_correction_for_degree_r_multiplier_comes_from_A_r_minus_D.
  R2_first_D_multiplier_degrees_have_zero_Koszul_overlap.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove (2).
  It does NOT bound length_C(A*eta) by dim_C ker(lambda)+19.
  It does NOT close residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The argument is only the exact
  restoration of the homogeneous shifts in the already constructed Koszul and
  cyclic-boundary maps.  The theorem statements above are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The surviving R2 obstruction is a graded cyclic class eta of degree -e.
  Lambda-overlap is impossible for multipliers of degrees 0,...,D-1, where
  D=e-d>=2 in the surviving branch.

MISSING_OBJECT:
  Control the tail r>=D by proving enough homogeneous multiples of eta are
  absorbed by image(lambda), or vanish, to obtain

    length_C(A*eta) <= dim_C ker(lambda)+19.

NEXT_ACTIONS:
  1. Compute the graded support of H1 using Artinian-Gorenstein Koszul
     self-duality with socdeg(R)=e+2.
  2. From that support, determine the largest multiplier degree r for which
     (A*eta)_{r-e} can be nonzero.
  3. Compare the resulting finite tail r>=D with ker(lambda), degree by degree.
  4. Prove only the <=19 excess bound.
  5. Do not promote R2 before that bound is proved.
