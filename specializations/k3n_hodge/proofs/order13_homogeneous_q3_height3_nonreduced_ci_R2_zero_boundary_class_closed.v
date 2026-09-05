Standalone zero-boundary-class closure for the surviving residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_cyclic_quotient_graded_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v.

  Retain

    B=S/(q1,q2,q3),
    L=(u1,u2,g) subset B,
    A=B/L,
    N=length_C(A),
    R=B/(g),
    J_R=(u1,u2) subset R,
    H1=H_1(u1,u2;R),

  together with

    lambda:A(d)^2 -> Hom_A(H1,A),
    eta=q(tau_bar) in Hom_A(H1,A)/image(lambda).

  The exact cyclic-quotient tangent identity is

    dim_C Hom_B(L,A)
      =N+dim_C ker(lambda)-length_C(A*eta).          (1)

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. ZERO BOUNDARY CLASS HAS NO CYCLIC TANGENT LOSS
--------------------------------------------------------------------------

Assume

  eta=0.

Then

  A*eta=0,

so

  length_C(A*eta)=0.

Substitution into (1) gives the exact identity

  dim_C Hom_B(L,A)
    =N+dim_C ker(lambda)
    >=N.                                            (2)

The prior ambient tangent injection gives

  Hom_B(L,A) -> Hom_S(I,A).

Hence

  dim_C Hom_S(I,A)>=N.                              (3)

But every order-13 candidate in this branch must satisfy the necessary tangent
deficit gate

  dim_C Hom_S(I,A)<=N-20.

Equations (3) and the gate are incompatible.

Theorem R2_zero_boundary_class_is_closed:
  No residual R2 candidate with eta=0 satisfies the order-13 tangent-deficit
  requirement.
Qed.

--------------------------------------------------------------------------
2. THIS IS STRICTLY STRONGER THAN THE PREVIOUS ZERO-COLON-IMAGE CLOSURE
--------------------------------------------------------------------------

The earlier zero-colon-image closure treated

  Cbar=im(tau_bar)=0.

That condition implies tau_bar=0 and therefore eta=0.  The converse need not
hold: eta may vanish because

  tau_bar in image(lambda)

while tau_bar itself, and hence Cbar, is nonzero.

Therefore the present closure removes the entire boundary-zero locus, not only
the zero-colon-image locus.

--------------------------------------------------------------------------
3. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_zero_boundary_class_is_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT close cases with eta!=0.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The argument is an immediate
  specialization of the exact cyclic-quotient tangent identity already
  established in the preceding reductions.  The theorem statement is not
  machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every surviving residual R2 candidate now satisfies simultaneously

    A non-Gorenstein,
    e-d>=2,
    Cbar!=0,
    eta!=0.

MISSING_OBJECT:
  For the remaining eta!=0 branch, prove

    length_C(A*eta)-dim_C ker(lambda)<=19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, close the equal-degree cases d<=2 from the finite multiplier
     support and the non-Gorenstein socle floor.
  3. Do not promote all R2 before the <=19 excess bound is proved for d>=3.
