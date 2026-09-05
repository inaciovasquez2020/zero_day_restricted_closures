Standalone annihilator-support sharpening for the surviving residual
nonreduced homogeneous q=3, height-three complete-intersection R2 branch in
the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_hilbert_symmetry_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v.

  Retain

    A=R/(u1,u2),
    deg(u1)=deg(u2)=d,
    Cbar=im(tau_bar),
    eta=q(tau_bar).

  The preceding Hilbert-symmetry reduction proved

    Cbar_j=0 unless 1<=j<=d+1.                      (1)

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE ANNIHILATOR BEGINS IN DEGREE d+1, NOT d+2
--------------------------------------------------------------------------

Take a homogeneous element

  a in A_r,
  r>=d+1.

For every homogeneous c in Cbar_j, equation (1) gives j>=1.  Hence

  r+j>=d+2.

Because Cbar is a homogeneous ideal of A, a*c lies in Cbar_{r+j}; but (1)
shows every Cbar component in degree at least d+2 is zero.  Therefore

  a*c=0

for every c in Cbar.  Thus

  A_{>=d+1} subset Ann_A(Cbar).                     (2)

The exact colon/Koszul reduction gives

  Ann_A(Cbar) subset Ann_A(eta).

Consequently

  A_{>=d+1} subset Ann_A(eta).                      (3)

Theorem R2_cyclic_obstruction_is_annihilated_from_degree_d_plus_1:
  Every homogeneous multiplier of degree at least d+1 annihilates eta.
Qed.

--------------------------------------------------------------------------
2. SHARPENED MULTIPLIER SUPPORT
--------------------------------------------------------------------------

Since A*eta is the cyclic quotient A/Ann_A(eta), up to the grading shift by e,
equation (3) gives

  (A*eta)_{r-e}=0 for r>=d+1.

Hence A*eta is supported only by multiplier degrees

  0<=r<=d.                                          (4)

This improves the previous bound 0<=r<=d+1 by one full layer.

Theorem R2_cyclic_obstruction_multiplier_support_is_at_most_d:
  A*eta has no multiplier layer above degree d.
Qed.

--------------------------------------------------------------------------
3. THE POSSIBLE KOSZUL-OVERLAP WINDOW SHRINKS AGAIN
--------------------------------------------------------------------------

The graded cyclic-quotient reduction proved that lambda-overlap is impossible
for multiplier degrees

  0<=r<D=e-d.

Equation (3) shows the multiple already vanishes for r>=d+1.  Therefore the
only multiplier degrees in which nonzero overlap can occur are

  D<=r<=d.                                          (5)

In particular, if

  D>=d+1,

equivalently

  e>=2d+1,

then the interval (5) is empty and

  (A*tau_bar) intersect image(lambda)=0,
  Ann_A(eta)=Ann_A(Cbar).

Corollary R2_escape_gap_at_least_d_plus_1_has_zero_Koszul_overlap:
  If e>=2d+1, the Koszul-overlap term vanishes identically.
Qed.

--------------------------------------------------------------------------
4. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_cyclic_obstruction_is_annihilated_from_degree_d_plus_1.
  R2_cyclic_obstruction_multiplier_support_is_at_most_d.
  R2_Koszul_overlap_is_confined_to_D_through_d.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19

  for every d>=3.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The improvement is only the
  exact degree consequence of the already proved support
  Supp_deg(Cbar) subset {1,...,d+1}.  The theorem statements are not
  machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every surviving R2 cyclic loss A*eta is now supported only by multiplier
  degrees 0,...,d.  Nonzero lambda-overlap is possible only in D,...,d.

MISSING_OBJECT:
  Use the shortened support to close d=3, then isolate the first unresolved
  equal degree d=4.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, close d=3 using h_A(0..2)=(1,4,7), h_A(3)=6, and
     dim_C ker(lambda)>=4.
  3. Do not continue past a failed rebuild.
