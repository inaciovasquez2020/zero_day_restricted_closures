Standalone equal-degree-three closure for the surviving residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_annihilator_support_sharpening.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v.

  Retain

    R=B/(g),
    A=R/(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),
    D=e-d>=2,

  together with the cyclic obstruction

    eta=q(tau_bar).

  The exact remaining closure target is

    length_C(A*eta)<=dim_C ker(lambda)+19.           (1)

  The preceding reductions proved

    A*eta is supported by multiplier degrees 0,...,d,

  and, because A is non-Gorenstein,

    dim_C ker(lambda)>=4.                            (2)

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE INITIAL HILBERT FUNCTION WHEN d=3
--------------------------------------------------------------------------

Assume

  d=3.

Since D>=2,

  e>=5.

The regular-escape reduction gives

  Hilb_R(t)=(1+t+...+t^(e-1))*(1+t)^3.

For e>=5 its degrees 0,1,2,3 are

  h_R(0)=1,
  h_R(1)=4,
  h_R(2)=7,
  h_R(3)=8.                                         (3)

Because J_R=(u1,u2) has no elements below degree d=3,

  A_r=R_r for r=0,1,2.                              (4)

In degree 3, J_R,3 is exactly the C-span of u1,u2.  Minimality of the two
homogeneous degree-three generators makes them C-linearly independent, so

  dim_C (J_R)_3=2.

Thus

  h_A(3)=h_R(3)-2=6.                                (5)

Combining (3)--(5),

  (h_A(0),h_A(1),h_A(2),h_A(3))=(1,4,7,6).          (6)

--------------------------------------------------------------------------
2. THE CYCLIC LOSS IS AT MOST EIGHTEEN
--------------------------------------------------------------------------

The annihilator-support sharpening confines A*eta to multiplier degrees

  0<=r<=d=3.

Since A*eta is a graded quotient of A, up to the fixed shift by e, equations
(6) give

  length_C(A*eta)
    <=1+4+7+6
    =18.                                            (7)

The non-Gorenstein socle-kernel reduction gives

  dim_C ker(lambda)>=4,

hence

  dim_C ker(lambda)+19>=23.                         (8)

From (7) and (8),

  length_C(A*eta)
    <=18
    <=dim_C ker(lambda)+19.

Therefore the closure target (1) holds.

Theorem R2_equal_degree_three_is_closed:
  No surviving residual R2 candidate with d=3 satisfies the order-13 tangent
  deficit gate.
Qed.

--------------------------------------------------------------------------
3. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_equal_degree_three_is_closed.

CLOSED_SUBCASE:
  residual R2 with d=3.

IMPORTANT_NONCONCLUSION:
  This file does NOT close d>=4.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The proof uses only the explicit
  Hilbert series of R, minimality of the two degree-three generators, the
  finite multiplier-support reduction, and the non-Gorenstein socle lower
  bound on ker(lambda).  The theorem statement is not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every surviving residual R2 candidate now satisfies

    A non-Gorenstein,
    d>=4,
    D=e-d>=2,
    Cbar!=0,
    eta!=0.

MISSING_OBJECT:
  In the first remaining case d=4, recover at least three dimensions beyond
  the crude estimates

    length_C(A*eta)<=26,
    dim_C ker(lambda)>=4,

  so that

    length_C(A*eta)-dim_C ker(lambda)<=19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, isolate the weakest three-dimensional compensation lemma for
     d=4 from the finite overlap window D<=r<=4.
  3. Do not promote all R2 before that compensation is proved.
