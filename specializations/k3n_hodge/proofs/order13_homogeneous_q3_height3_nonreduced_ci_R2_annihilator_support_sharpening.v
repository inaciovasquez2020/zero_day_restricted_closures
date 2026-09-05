Standalone annihilator-support sharpening for the surviving residual
nonreduced homogeneous q=3, height-three complete-intersection R2 branch in
the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_hilbert_symmetry_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_regular_escape_reduction.v.

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
4. EQUAL DEGREE FOUR REDUCES TO LOW SOCLE TYPE WITH NONZERO LINEAR COLON
--------------------------------------------------------------------------

Assume now

  d=4.

The surviving R2 branch has D=e-d>=2, hence e>=6.  From

  Hilb_R(t)=(1+t+...+t^{e-1})(1+t)^3

and the fact that u1,u2 form a two-dimensional minimal degree-four slice, the
initial Hilbert function of A is

  h_A(0)=1,
  h_A(1)=4,
  h_A(2)=7,
  h_A(3)=8,
  h_A(4)=6.                                         (6)

By (4), only multiplier degrees 0,...,4 can contribute to A*eta.  Therefore

  length_C(A*eta)<=1+4+7+8+6=26.                   (7)

Let

  t=dim_C Soc(A).

The surviving branch is non-Gorenstein, so t>=2, and the established socle
square injection gives

  dim_C ker(lambda)>=2t.                            (8)

If t>=4, equations (7) and (8) give

  length_C(A*eta)<=26<=27<=dim_C ker(lambda)+19.

Thus equal degree four is closed whenever t>=4.

It remains to use the linear colon layer.  Suppose

  Cbar_1=0.

Then (1), with d=4, sharpens to

  Cbar_j=0 unless 2<=j<=5.

For a in A_4 and c in Cbar_j we have

  deg(a*c)=4+j>=6.

Because Cbar has no component above degree 5, a*c=0.  Hence

  A_4 subset Ann_A(Cbar) subset Ann_A(eta).         (9)

Consequently the degree-four multiplier layer contributes nothing to A*eta,
and

  length_C(A*eta)<=1+4+7+8=20.                     (10)

Using only t>=2 in (8),

  dim_C ker(lambda)+19>=4+19=23,

so (10) closes the sharp tangent inequality.

Theorem R2_equal_degree_four_reduces_to_low_type_nonzero_linear_colon:
  In the surviving d=4 branch, the sharp inequality

    length_C(A*eta)<=dim_C ker(lambda)+19

  holds if either

    t>=4

  or

    Cbar_1=0.

  Therefore every still-unresolved d=4 candidate satisfies

    t in {2,3},
    Cbar_1 != 0.
Qed.

--------------------------------------------------------------------------
5. A PRINCIPAL LINEAR COLON LAYER CLOSES EQUAL DEGREE FOUR
--------------------------------------------------------------------------

Continue with d=4 and suppose

  dim_C Cbar_1=1.

Choose a nonzero homogeneous generator

  c in Cbar_1.

For every j>=2 and every a in A_4, equation (1) gives

  a*Cbar_j subset Cbar_{4+j}=0,

because 4+j>=6 while Cbar has no component above degree 5.  Hence the only
part of Cbar seen by multiplication from A_4 is Cbar_1=C*c.  Therefore

  Ann_A(Cbar)_4
    =ker(m_c:A_4 -> Cbar_5),

where

  m_c(a)=a*c.                                       (11)

Also

  A_+*Cbar_5 subset Cbar_{>=6}=0.

Thus

  Cbar_5 subset Soc(A)_5,

and consequently

  dim_C Cbar_5<=t.                                  (12)

Since h_A(4)=6, equations (11) and (12) imply

  dim_C Ann_A(Cbar)_4>=6-t.                         (13)

Using Ann_A(Cbar) subset Ann_A(eta), the degree-four quotient layer of A*eta
has dimension at most t.  Together with (6),

  length_C(A*eta)
    <=1+4+7+8+t
    =20+t.                                          (14)

The socle-square kernel estimate (8) gives

  dim_C ker(lambda)+19>=2t+19.

Since t>=2,

  20+t<=19+2t.

Therefore

  length_C(A*eta)<=dim_C ker(lambda)+19.

Theorem R2_equal_degree_four_principal_linear_colon_closed:
  If d=4 and dim_C Cbar_1=1, the sharp R2 tangent inequality holds.
Qed.

Combining this with the preceding reduction, every still-unresolved d=4
candidate must satisfy

  t in {2,3},
  dim_C Cbar_1>=2.                                  (15)

--------------------------------------------------------------------------
6. ALL NONEXTREMAL DEGREE-FOUR MULTIPLICATION RANKS CLOSE
--------------------------------------------------------------------------

Continue with the surviving case (15).  Put

  U:=Cbar_1,
  V:=Cbar_5,

and define the multiplication map

  m_4:A_4 -> Hom_C(U,V),
  m_4(a)(c)=a*c.

Let

  rho:=rank_C(m_4).

For every j>=2, multiplication by A_4 sends Cbar_j into Cbar_{4+j}=0.
Therefore an element a in A_4 annihilates all of Cbar if and only if it
annihilates U.  Hence

  Ann_A(Cbar)_4=ker(m_4).                            (16)

Since Ann_A(Cbar) subset Ann_A(eta), the degree-four multiplier layer of the
cyclic quotient A*eta=A/Ann_A(eta) has dimension at most rho.  The lower
multiplier layers have total dimension

  h_A(0)+h_A(1)+h_A(2)+h_A(3)=1+4+7+8=20.

Thus

  length_C(A*eta)<=20+rho.                          (17)

If

  rho<=2t-1,

then equations (8) and (17) give

  length_C(A*eta)
    <=20+(2t-1)
    =2t+19
    <=dim_C ker(lambda)+19.

Therefore every multiplication rank rho<=2t-1 closes the sharp R2 tangent
inequality.

Theorem R2_equal_degree_four_nonextremal_multiplication_rank_closed:
  In the surviving d=4 branch, if

    rank_C(A_4 -> Hom_C(Cbar_1,Cbar_5))<=2t-1,

  then

    length_C(A*eta)<=dim_C ker(lambda)+19.
Qed.

Since dim_C A_4=6, a still-unresolved d=4 candidate must now satisfy exactly
one of

  t=2 and rho in {4,5,6},

or

  t=3 and rho=6.                                    (18)

No contradiction for the extremal ranks in (18) is asserted here.

--------------------------------------------------------------------------
7. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_cyclic_obstruction_is_annihilated_from_degree_d_plus_1.
  R2_cyclic_obstruction_multiplier_support_is_at_most_d.
  R2_Koszul_overlap_is_confined_to_D_through_d.
  R2_equal_degree_four_reduces_to_low_type_nonzero_linear_colon.
  R2_equal_degree_four_principal_linear_colon_closed.
  R2_equal_degree_four_nonextremal_multiplication_rank_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19

  for every surviving d=4 candidate.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The theorem statements in this
  file are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Equal degree d=3 is closed in the dedicated low-degree file.  The first
  unresolved equal-degree case is d=4.  After the linear-colon and
  multiplication-rank reductions, every still-unresolved d=4 candidate has

    dim_C Cbar_1>=2,

  and exactly one of

    t=2, rho in {4,5,6},
    t=3, rho=6,

  where

    rho=rank_C(A_4 -> Hom_C(Cbar_1,Cbar_5)).

MISSING_OBJECT:
  Exclude the extremal multiplication ranks

    t=2 with rho>=4,
    t=3 with rho=6,

  using the graded algebra structure of A and Cbar, or prove enough extra
  Koszul kernel beyond Soc(A)^2 to offset rho-(2t-1).

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, test whether rho=6 forces an injective multiplication map
     A_4 -> Hom_C(Cbar_1,Cbar_5) incompatible with the degree-five socle and
     the known Hilbert function.
  3. Treat t=2, rho=4 or 5 only after the rho=6 case is resolved.
  4. Do not continue past a failed rebuild.
