Standalone socle-kernel refinement for the surviving residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_pushout_koszul_boundary_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_support_reduction.v.

  Retain

    R=B/(g),
    A=R/J_R,
    J_R=(u1,u2),
    deg(u1)=deg(u2)=d,

  where u1,u2 are the two minimal homogeneous generators of J_R.  Let

    H1:=H_1(u1,u2;R)

  and

    lambda:A(d)^2 -> Hom_A(H1,A)

  be the coefficient-pairing map from the preceding Koszul reduction.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EVERY KOSZUL RELATION HAS POSITIVE-DEGREE COEFFICIENTS
--------------------------------------------------------------------------

Let

  z=(r1,r2)

be a homogeneous cycle in K_1=R(-d)^2 of total internal degree n.  Thus

  r1,r2 in R_{n-d}

and

  r1*u1+r2*u2=0.                                    (1)

If n<d, then R_{n-d}=0 and z=0.

If n=d, then r1,r2 lie in R_0=C.  A nonzero pair of scalars satisfying (1)
would be a C-linear relation between u1 and u2.  That would make one of the two
degree-d generators redundant, contradicting minimality of the homogeneous
generating set of J_R.  Hence r1=r2=0 also in degree n=d.

Therefore every nonzero homogeneous Koszul cycle has

  n>d,

so both coefficient classes lie in the homogeneous maximal ideal

  m_R=R_{>0}.

After passage to A, every coefficient occurring in a Koszul relation lies in

  m_A=A_{>0}.                                       (2)

Theorem R2_nonzero_Koszul_relations_have_maximal_ideal_coefficients:
  Every coefficient of every class in H1 maps into m_A.
Qed.

--------------------------------------------------------------------------
2. TWO COPIES OF THE SOCLE LIE IN ker(lambda)
--------------------------------------------------------------------------

Let

  Soc(A):=0:_A m_A.

Take

  alpha1,alpha2 in Soc(A).

For every Koszul class represented by (r1,r2), equation (2) gives

  r1*alpha1=0,
  r2*alpha2=0

in A.  Hence

  lambda(alpha1,alpha2)([r1,r2])
    =r1*alpha1+r2*alpha2
    =0.

Thus there is a canonical C-linear inclusion

  Soc(A)^2 -> ker(lambda).                           (3)

Theorem R2_socle_square_injects_into_Koszul_kernel:

  Soc(A)^2 subset ker(lambda).
Qed.

Consequently, writing

  type(A):=dim_C Soc(A),

we obtain

  dim_C ker(lambda)>=2*type(A).                     (4)

--------------------------------------------------------------------------
3. THE SURVIVING NON-GORENSTEIN BRANCH HAS A FOUR-DIMENSIONAL KERNEL FLOOR
--------------------------------------------------------------------------

For a standard graded Artinian C-algebra, Gorenstein is equivalent to having
one-dimensional socle.  The surviving R2 branch has already excluded the
Gorenstein case.  Therefore

  type(A)>=2.

Substituting into (4) yields

  dim_C ker(lambda)>=4.                             (5)

Corollary R2_nonGorenstein_Koszul_kernel_has_dimension_at_least_four:
  In the surviving non-Gorenstein R2 branch,

    dim_C ker(lambda)>=4.
Qed.

--------------------------------------------------------------------------
4. COMBINATION WITH THE CYCLIC-SUPPORT REDUCTION
--------------------------------------------------------------------------

The preceding support reduction proved

  A_{>=d+3} subset Ann_A(eta)

for the cyclic obstruction eta=q(tau_bar).  Therefore

  length_C(A*eta)
    <= sum_{r=0}^{d+2} dim_C A_r.                   (6)

Together with (5), the exact R2 closure target

  length_C(A*eta)<=dim_C ker(lambda)+19

will follow from the weaker numerical estimate

  sum_{r=0}^{d+2} dim_C A_r<=23.                    (7)

No claim that (7) always holds is made here.  Its purpose is to isolate a
concrete small-Hilbert-window subcase which would close immediately from the
socle floor.

More generally, the unresolved excess is now bounded by

  length_C(A*eta)-dim_C ker(lambda)
    <= sum_{r=0}^{d+2} dim_C A_r - 2*type(A).        (8)

--------------------------------------------------------------------------
5. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_nonzero_Koszul_relations_have_maximal_ideal_coefficients.
  R2_socle_square_injects_into_Koszul_kernel.
  R2_nonGorenstein_Koszul_kernel_has_dimension_at_least_four.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19

  for every surviving R2 candidate.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The kernel inclusion uses only
  minimality of the two equal-degree generators and the definition of the
  Artinian socle.  The theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every surviving non-Gorenstein R2 candidate has

    dim_C ker(lambda)>=4,

  while A*eta is supported only by multiplier degrees 0,...,d+2.

MISSING_OBJECT:
  Improve the crude support-length bound in (6) using the fact that A is the
  quotient of the explicit Artinian Gorenstein ring

    R with Hilb_R(t)=(1+t+...+t^(e-1))*(1+t)^3

  by two independent degree-d generators, strongly enough to prove

    length_C(A*eta)-dim_C ker(lambda)<=19.

NEXT_ACTIONS:
  1. Compute the exact forced drop in the Hilbert function of A beginning in
     degree d from the two independent generators u1,u2.
  2. Rebuild immediately before using any such Hilbert-function estimate.
  3. Compare only the surviving multiplier interval 0,...,d+2.
  4. Do not promote R2 before the <=19 excess bound is proved.
