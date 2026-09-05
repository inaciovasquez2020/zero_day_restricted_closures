Standalone graded-Koszul Hilbert-symmetry refinement for the surviving
residual nonreduced homogeneous q=3, height-three complete-intersection R2
branch in the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_regular_escape_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_support_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v.

  Retain

    R=B/(g),
    A=R/(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),
    s:=socdeg(R)=e+2,

  and

    H1:=H_1(u1,u2;R).

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. GRADED H2 IS THE REFLECTED HILBERT FUNCTION OF A
--------------------------------------------------------------------------

Use the standard graded two-generator Koszul complex

  0 -> R(-2d) -> R(-d)^2 -> R -> 0.

Its second homology in internal degree n is

  (H2)_n=Ann_R(u1,u2)_{n-2d}.

Because R is Artinian graded Gorenstein of socle degree s, the perfect socle
pairing identifies, degree by degree,

  Ann_R(u1,u2)_m
    ~= Hom_C(A_{s-m},C).

Therefore

  h_H2(n)=h_A(s+2d-n),                              (1)

where h_M(n):=dim_C M_n.

No identification A~=omega_A is used: (1) is only the graded vector-space
reflection supplied by the Gorenstein pairing of R.

--------------------------------------------------------------------------
2. DEGREEWISE EULER CHARACTERISTIC GIVES THE EXACT H1 FORMULA
--------------------------------------------------------------------------

Taking dimensions in each internal degree of the Koszul complex gives

  h_R(n)-2h_R(n-d)+h_R(n-2d)
    =h_A(n)-h_H1(n)+h_H2(n).

Using (1),

  h_H1(n)
    = h_A(n)+h_A(s+2d-n)
      -h_R(n)+2h_R(n-d)-h_R(n-2d).                 (2)

The Hilbert function of R is symmetric about s because R is Artinian graded
Gorenstein:

  h_R(k)=h_R(s-k).

Hence the last three terms in (2) are invariant under

  n |-> s+2d-n,

while the first two A-terms are exchanged.  Consequently

  h_H1(n)=h_H1(s+2d-n).                             (3)

Theorem R2_Koszul_H1_Hilbert_function_is_symmetric:

  h_{H_1(u1,u2;R)}(n)
    =h_{H_1(u1,u2;R)}(e+2+2d-n)

  for every integer n.
Qed.

--------------------------------------------------------------------------
3. THE TOP POSSIBLE H1 DEGREE ACTUALLY VANISHES
--------------------------------------------------------------------------

The socle-kernel reduction proved from minimality of u1,u2 that there is no
nonzero Koszul cycle in total degree d: a degree-d cycle would have scalar
coefficients and would be a C-linear dependence between the two minimal
generators.  Thus

  H1_d=0.                                           (4)

Reflecting (4) by (3) gives

  H1_{s+2d-d}=H1_{s+d}=0.

Since s=e+2,

  H1_{e+d+2}=0.                                     (5)

Combined with the previous support bound H1_n=0 for n>e+d+2, this sharpens the
upper cutoff to

  H1_n=0 for n>=e+d+2.                              (6)

Theorem R2_Koszul_H1_vanishes_from_e_plus_d_plus_2_onward:

  H_1(u1,u2;R)_n=0 for n>=e+d+2.
Qed.

--------------------------------------------------------------------------
4. THE COLON IMAGE LOSES ITS PREVIOUS TOP DEGREE
--------------------------------------------------------------------------

The graded cyclic reduction proved

  deg(tau_bar)=-e,
  im(tau_bar)=Cbar.

An output in A-degree j therefore comes from H1_{j+e}.  By (6), this source is
zero whenever

  j+e>=e+d+2,

i.e. whenever

  j>=d+2.

Thus

  Cbar_j=0 for j>=d+2.                              (7)

Together with the already proved Cbar_0=0, every surviving nonzero colon image
is supported in the strictly smaller interval

  Supp_deg(Cbar) subset {1,...,d+1}.                (8)

Because Cbar is a homogeneous ideal of A, (8) implies

  A_{>=d+2} subset Ann_A(Cbar) subset Ann_A(eta).   (9)

Hence the cyclic tangent-loss module A*eta has multiplier support only in

  0<=r<=d+1.                                        (10)

--------------------------------------------------------------------------
5. THE POSSIBLE KOSZUL-OVERLAP INTERVAL SHRINKS BY ONE LAYER
--------------------------------------------------------------------------

The graded cyclic-quotient reduction already showed that lambda-overlap is
impossible for multiplier degrees

  0<=r<D=e-d.

Equation (9) shows that every multiplier of degree r>=d+2 already kills eta.
Therefore the only degrees in which a nonzero Koszul-overlap can occur are

  D<=r<=d+1.                                        (11)

In particular, if

  D>=d+2,

equivalently

  e>=2d+2,

then (11) is empty and

  (A*tau_bar) intersect image(lambda)=0,
  Ann_A(eta)=Ann_A(Cbar).                            (12)

This improves the previous zero-overlap threshold e>=2d+3 by one full degree.

--------------------------------------------------------------------------
6. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_Koszul_H1_Hilbert_function_is_symmetric.
  R2_Koszul_H1_vanishes_from_e_plus_d_plus_2_onward.
  R2_colon_image_is_supported_in_degrees_1_through_d_plus_1.
  R2_cyclic_obstruction_multiplier_support_is_at_most_d_plus_1.
  R2_Koszul_overlap_is_confined_to_D_through_d_plus_1.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19.

  It does NOT close all residual R2.
  It does NOT identify A with its canonical module.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The new symmetry is a
  degree-by-degree Euler-characteristic consequence of the graded Gorenstein
  pairing on R.  No A-Gorenstein assumption is introduced.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  In every surviving R2 candidate,

    A*eta

  is supported only by multiplier degrees 0,...,d+1, and the only possible
  nonzero lambda-overlap is confined to

    D,...,d+1.

MISSING_OBJECT:
  Bound the A-valued dual loss on this finite interval strongly enough to prove

    length_C(A*eta)-dim_C ker(lambda)<=19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, close the eta=0 subcase separately using the exact tangent
     formula.
  3. Then isolate the remaining eta!=0 non-Gorenstein finite-window duality
     defect.
  4. Do not promote all R2 before the <=19 bound is proved.
