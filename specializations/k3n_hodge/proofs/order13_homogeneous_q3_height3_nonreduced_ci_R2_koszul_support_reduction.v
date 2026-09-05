Standalone Koszul-support refinement for the surviving residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_regular_escape_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_cyclic_quotient_graded_reduction.v.

  Retain

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    R=B/(g),
    J_R=(u1,u2) subset R,

  with

    deg(u1)=deg(u2)=d<e=deg(g),
    D=e-d>=2

  in the surviving branch.  Put

    H1:=H_1(u1,u2;R),
    Cbar:=((J:g)+L)/L=im(tau_bar),

  and let

    eta=q(tau_bar)

  be the cyclic obstruction class in

    Hom_A(H1,A)/image(lambda).

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE FIRST KOSZUL HOMOLOGY HAS A HARD UPPER DEGREE CUTOFF
--------------------------------------------------------------------------

The regular-escape reduction gives

  Hilb_R(t)=(1+t+...+t^(e-1))*(1+t)^3

and socle degree

  socdeg(R)=e+2.

Hence

  R_n=0

for n<0 and for n>e+2.

With the standard grading on the two-generator Koszul complex,

  K_1=R(-d)^2.

Therefore

  (K_1)_n=R_{n-d}^2=0

unless

  d<=n<=e+d+2.

Since H1 is a subquotient of K_1 degree by degree,

  H1_n=0

outside the same interval.  In particular,

  H1_n=0 for n>e+d+2.                              (1)

Theorem R2_Koszul_H1_vanishes_above_e_plus_d_plus_2:

  H_1(u1,u2;R)_n=0 for n>e+d+2.
Qed.

No self-duality identification H1~=Hom_A(H1,A) is used here.

--------------------------------------------------------------------------
2. THE COLON IMAGE IS SUPPORTED ONLY THROUGH DEGREE d+2
--------------------------------------------------------------------------

The graded cyclic-quotient reduction proved that

  tau_bar:H1->A

has graded-map degree -e.  Thus an output in ordinary A-degree j can only come
from

  H1_{j+e}.

By (1), this source is zero when

  j+e>e+d+2,

i.e. when

  j>d+2.

Since im(tau_bar)=Cbar,

  Cbar_j=0 for j>d+2.                               (2)

At the other end, Cbar_0=0.  Indeed B_0=C and a nonzero scalar c in
C=(J:g) would imply cg in J and hence g in J, contradicting minimality of the
homogeneous generating set (u1,u2,g).

Consequently every surviving nonzero colon image satisfies

  Cbar!=0,
  Supp_deg(Cbar) subset {1,...,d+2}.                (3)

Theorem R2_nonzero_colon_image_is_supported_in_degrees_1_through_d_plus_2:

  Cbar_j=0 unless 1<=j<=d+2.
Qed.

--------------------------------------------------------------------------
3. ALL MULTIPLIERS OF DEGREE AT LEAST d+3 KILL THE COLON IMAGE
--------------------------------------------------------------------------

Because Cbar is a homogeneous ideal of A, multiplication preserves Cbar.
Take homogeneous

  a in A_r,
  r>=d+3.

For every homogeneous c in Cbar_j, (3) gives j>=1 and j<=d+2, while

  a*c in Cbar_{r+j}.

But r+j>d+2, so (2) gives a*c=0.  Hence

  A_{>=d+3} subset Ann_A(Cbar).                     (4)

The earlier colon/Koszul identification gives

  Ann_A(Cbar) subset Ann_A(eta).

Therefore

  A_{>=d+3} subset Ann_A(eta),                      (5)

and the cyclic quotient A*eta has multiplier support only in

  0<=r<=d+2.

Equivalently,

  (A*eta)_{r-e}=0 for r>=d+3.                       (6)

Theorem R2_cyclic_obstruction_has_multiplier_support_at_most_d_plus_2:

  A_{>=d+3} annihilates eta.
Qed.

--------------------------------------------------------------------------
4. THE ONLY POSSIBLE KOSZUL-OVERLAP TAIL IS FINITE AND EXPLICIT
--------------------------------------------------------------------------

The preceding graded reduction proved that for multiplier degrees

  0<=r<D=e-d,

image(lambda) has no component capable of absorbing a nonzero multiple of
tau_bar.  Section 3 proves that for

  r>=d+3,

the multiple already vanishes.

Therefore every possible nonzero Koszul-overlap contribution is confined to

  D<=r<=d+2.                                        (7)

In graded-map degree s=r-e, the same interval is

  -d<=s<=2-D.                                       (8)

Thus the entire tail left after the first D multiplier degrees is not open
ended: it has at most

  max(0,d+3-D)

multiplier-degree layers.

Corollary R2_Koszul_overlap_is_confined_to_D_through_d_plus_2:

  ((A*tau_bar) intersect image(lambda))_{r-e}=0

  unless

  D<=r<=d+2.
Qed.

If

  D>=d+3,

the interval (7) is empty, and therefore

  (A*tau_bar) intersect image(lambda)=0,
  Ann_A(eta)=Ann_A(Cbar).                            (9)

Corollary R2_large_escape_gap_has_zero_Koszul_overlap:

  If e-d>=d+3, equivalently e>=2d+3, then the Koszul-overlap term vanishes
  identically.
Qed.

--------------------------------------------------------------------------
5. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_Koszul_H1_vanishes_above_e_plus_d_plus_2.
  R2_nonzero_colon_image_is_supported_in_degrees_1_through_d_plus_2.
  R2_cyclic_obstruction_has_multiplier_support_at_most_d_plus_2.
  R2_Koszul_overlap_is_confined_to_D_through_d_plus_2.
  R2_large_escape_gap_has_zero_Koszul_overlap.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19.

  It does NOT close the large-gap subcase merely from zero overlap.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The support bounds use only the
  graded Koszul complex, the already proved degree of tau_bar, the exact
  identification im(tau_bar)=Cbar, and the socle degree of the Artinian
  Gorenstein section R.  No identification A~=omega_A is used.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  In every surviving R2 candidate, the cyclic tangent-loss module A*eta is
  supported only by multiplier degrees 0,...,d+2.  The only degrees in which
  lambda-overlap can be nonzero are the finite interval

    D,...,d+2,

  which is empty when e>=2d+3.

MISSING_OBJECT:
  On the finite overlap interval

    D<=r<=d+2,

  prove enough degree-by-degree compensation with ker(lambda), together with
  the already forced annihilator outside that interval, to obtain

    length_C(A*eta)<=dim_C ker(lambda)+19.

NEXT_ACTIONS:
  1. Prove the canonical injection Soc(A)^2 -> ker(lambda) from minimality of
     the equal-degree generators u1,u2.
  2. Rebuild immediately before using that lower bound.
  3. Combine the socle lower bound with the finite support interval only after
     the rebuild is green.
  4. Do not promote R2 before the <=19 inequality is proved.
