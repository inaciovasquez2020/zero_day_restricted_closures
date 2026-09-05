Standalone nonextendable-colon-dual reduction for the residual R2 branch of
the nonreduced homogeneous q=3, height-three complete-intersection core in the
order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_tangent_fiber_product_reduction.v.

  Thus

    B=S/(q1,q2,q3)

  is the one-dimensional standard graded Gorenstein complete intersection of
  three quadrics and, after the regular-escape replacement,

    L=J+(g),
    J=(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),

  with g homogeneous and B-regular. Put

    R:=B/(g),
    A:=B/L=R/J_R,
    N:=length_C(A),
    C:=(J :_B g),
    D:=C/J=0:_{B/J}g.

  The preceding fiber-product reduction proved

    dim_C Hom_B(L,A)
      >= N + dim_C Hom_B(J,A)-dim_C Hom_B(C,A).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE COLON MODULE IS THE KERNEL AFTER MODDING J BY gJ
--------------------------------------------------------------------------

Because g is B-regular,

    J intersect (g)=gC.

The image of J in R=B/(g) is therefore

    J_R ~= J/gC.

Since gJ subset gC subset J, quotienting J by gJ gives a short exact sequence
of R-modules

    0 -> gC/gJ
      -> J/gJ
      -> J/gC
      -> 0.

Multiplication by g identifies

    C/J ~= gC/gJ

up to the homogeneous degree shift e. Thus

    0 -> D(-e)
      -> J/gJ
      -> J_R
      -> 0.                                      (1)

Moreover D is naturally an A-module. Indeed J annihilates C/J, while g also
annihilates C/J because gC subset J. Hence L=J+(g) annihilates D.

--------------------------------------------------------------------------
2. EVERY A-VALUED MAP ON J FACTORS THROUGH J/gJ
--------------------------------------------------------------------------

Since g annihilates A, every B-linear map

    psi:J -> A

kills gJ:

    psi(gj)=g psi(j)=0.

Therefore

    Hom_B(J,A) ~= Hom_R(J/gJ,A).

Apply Hom_R(-,A) to (1). The resulting left-exact sequence begins

    0 -> Hom_R(J_R,A)
      -> Hom_B(J,A)
      --res--> Hom_A(D(-e),A)
      --beta--> Ext^1_R(J_R,A).

Thus

    coker(res) ~= image(beta),

and, ignoring grading shifts when taking total C-dimensions,

    dim_C coker(res)=dim_C image(beta).            (2)

The map beta measures exactly which A-valued functionals on the colon module
D fail to extend to a B-linear map J->A.

--------------------------------------------------------------------------
3. MAPS C->A RESTRICT ONLY TO THE EXTENDABLE PART
--------------------------------------------------------------------------

Apply Hom_B(-,A) to

    0 -> J -> C -> D -> 0.

One obtains

    0 -> Hom_A(D,A)
      -> Hom_B(C,A)
      --rho--> Hom_B(J,A).

For every f in Hom_B(C,A), the restriction rho(f) lies in ker(res).
Indeed an element of D(-e) inside J/gJ is represented by

    g*c + gJ,

with c in C. Then

    rho(f)(g*c)=f(g*c)=g*f(c)=0

because g annihilates A.

Hence

    image(rho) subset ker(res).                    (3)

Put

    h_C:=dim_C Hom_B(C,A),
    h_J:=dim_C Hom_B(J,A),
    h_D:=dim_C Hom_A(D,A).

Exactness gives

    h_C=h_D+dim_C image(rho).

Using (3),

    h_C-h_J
      <= h_D+dim_C ker(res)-h_J
      =  h_D-dim_C image(res)
      =  dim_C coker(res).

The last equality uses that

    dim_C Hom_A(D(-e),A)=h_D

as an ungraded C-vector-space dimension. By (2),

    h_C-h_J <= dim_C image(beta).                  (4)

Theorem R2_colon_dual_loss_is_only_nonextendable_part:

    dim_C Hom_B(C,A)-dim_C Hom_B(J,A)
      <= dim_C image(
           Hom_A(D(-e),A) -> Ext^1_R(J_R,A)
         ).
Qed.

--------------------------------------------------------------------------
4. THE R2 TANGENT LOSS IS BOUNDED BY image(beta)
--------------------------------------------------------------------------

The fiber-product lower bound and (4) give

    dim_C Hom_B(L,A)
      >= N-(h_C-h_J)
      >= N-dim_C image(beta).

Theorem R2_tangent_lower_bound_by_nonextendable_colon_dual:

    dim_C Hom_B(L,A)
      >= N-dim_C image(beta).
Qed.

Consequently the order-13 tangent-deficit gate is excluded as soon as

    dim_C image(beta) <= 19.                       (5)

This is strictly weaker than bounding the full A-dual of D and strictly weaker
than bounding h_C-h_J by separately estimating h_C and h_J. Only colon-dual
functionals that do not extend across J/gJ can cause loss in the tangent lower
bound.

--------------------------------------------------------------------------
5. INTERPRETATION THROUGH SELF-Ext OF A
--------------------------------------------------------------------------

From

    0 -> J_R -> R -> A -> 0

and the fact that R is free over itself, there is a natural identification

    Ext^1_R(J_R,A) ~= Ext^2_R(A,A).

Thus beta may equivalently be viewed as a finite-dimensional subspace of the
second self-extension group of A:

    image(beta) subset Ext^2_R(A,A).

No numerical bound on Ext^2_R(A,A), or on image(beta), is asserted here.

--------------------------------------------------------------------------
6. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_colon_dual_loss_is_only_nonextendable_part.
  R2_tangent_lower_bound_by_nonextendable_colon_dual.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove dim_C image(beta)<=19.
  It does NOT close R2 or R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation. The argument uses only the exact
  sequences above, regularity of g, and left exactness/connecting morphisms for
  Hom. The new theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Residual R2 tangent loss is now controlled only by the nonextendable part of
  the A-dual of

    D=(J:g)/J.

MISSING_OBJECT:
  Prove

    dim_C image(beta)<=19,

  where

    beta:Hom_A(D(-e),A) -> Ext^1_R(J_R,A)

  is the connecting map from (1).

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, identify image(beta) degree-by-degree using the graded section
     sequence on X=Proj(B).
  3. Show that only the finite low-degree section defects can contribute to
     nonextendability.
  4. Bound their total contribution by at most 19.
  5. Rebuild immediately after that bounded lemma.
