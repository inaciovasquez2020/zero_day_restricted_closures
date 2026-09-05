Standalone low-equal-degree closure for the surviving residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_hilbert_symmetry_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_zero_boundary_class_closed.v.

  Retain

    R=B/(g),
    A=R/(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),
    D=e-d>=2,

  together with the nonzero cyclic obstruction

    eta=q(tau_bar).

  The exact remaining closure target is

    length_C(A*eta)<=dim_C ker(lambda)+19.           (1)

The preceding reductions proved

    A*eta is supported by multiplier degrees 0,...,d+1,

and, because A is non-Gorenstein,

    dim_C ker(lambda)>=4.                            (2)

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. INITIAL HILBERT FUNCTION OF THE ARTINIAN GORENSTEIN SECTION
--------------------------------------------------------------------------

The regular-escape reduction gives

  Hilb_R(t)=(1+t+...+t^(e-1))*(1+t)^3.

Since D>=2, one has e>=d+2.

For d=1 this gives e>=3, so in degrees 0,1,2,

  h_R=(1,4,7).                                      (3)

For d=2 this gives e>=4, so in degrees 0,1,2,3,

  h_R=(1,4,7,8).                                    (4)

Because A is a graded quotient of R,

  h_A(r)<=h_R(r)                                    (5)

in every degree.

Also A*eta is a quotient of A, up to the grading shift by e, so its degree-r
multiplier layer has dimension at most h_A(r).

--------------------------------------------------------------------------
2. THE CASE d=1 IS CLOSED
--------------------------------------------------------------------------

If d=1, the support theorem restricts A*eta to multiplier degrees 0,1,2.
Using (3) and (5),

  length_C(A*eta)
    <=1+4+7
    =12.                                            (6)

By (2),

  dim_C ker(lambda)+19>=4+19=23.

Therefore

  length_C(A*eta)<=12<=23<=dim_C ker(lambda)+19,

so (1) holds.

Theorem R2_equal_degree_one_is_closed:
  No surviving residual R2 candidate with d=1 satisfies the order-13 tangent
  deficit gate.
Qed.

--------------------------------------------------------------------------
3. THE CASE d=2 IS CLOSED
--------------------------------------------------------------------------

If d=2, the support theorem restricts A*eta to multiplier degrees 0,1,2,3.
Using (4) and (5),

  length_C(A*eta)
    <=1+4+7+8
    =20.                                            (7)

Again (2) gives

  dim_C ker(lambda)+19>=23.

Thus

  length_C(A*eta)<=20<=23<=dim_C ker(lambda)+19,

and (1) holds.

Theorem R2_equal_degree_two_is_closed:
  No surviving residual R2 candidate with d=2 satisfies the order-13 tangent
  deficit gate.
Qed.

--------------------------------------------------------------------------
4. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_equal_degree_one_is_closed.
  R2_equal_degree_two_is_closed.

CLOSED_SUBCASE:
  residual R2 with d<=2.

IMPORTANT_NONCONCLUSION:
  This file does NOT close d>=3.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The proof uses only the explicit
  Hilbert series of R, the verified finite multiplier support reduction, and
  the non-Gorenstein socle lower bound on ker(lambda).  The theorem statements
  are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every surviving residual R2 candidate now satisfies simultaneously

    A non-Gorenstein,
    d>=3,
    D=e-d>=2,
    Cbar!=0,
    eta!=0.

MISSING_OBJECT:
  For d>=3, improve the finite-window estimate on

    length_C(A*eta)-dim_C ker(lambda)

  by at least the amount needed to force it below or equal to 19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, test the first remaining case d=3 using the forced degree-d
     drop from the two independent generators u1,u2.
  3. Do not promote all R2 before the <=19 excess bound is proved for d>=3.
