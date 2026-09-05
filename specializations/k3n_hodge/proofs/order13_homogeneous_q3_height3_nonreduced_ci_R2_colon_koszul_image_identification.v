Standalone colon/Koszul-image identification for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_pushout_koszul_boundary_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_tangent_compensation.v.

  Retain the notation

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    R=B/(g),
    J_R=(J+(g))/(g),
    C=(J :_B g),
    Cbar=(C+L)/L subset A,

  with deg(u1)=deg(u2)=d<e=deg(g) and g a homogeneous B-nonzerodivisor.

  The pushout/Koszul reduction constructed

    tau_bar:H_1(u1,u2;R) -> A

  by lifting a cycle (r1,r2) to a1,a2 in B, writing

    a1*u1+a2*u2=g*c,

  and setting tau_bar([r1,r2])=c mod L.  It also proved that the distinguished
  extension class xi is represented by tau_bar modulo image(lambda), where

    lambda:A^2 -> Hom_A(H_1(u1,u2;R),A).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE KOSZUL DIVISION MAP HAS EXACTLY THE COLON IMAGE
--------------------------------------------------------------------------

For every Koszul class h represented by a cycle (r1,r2), choose lifts a1,a2.
By construction

  a1*u1+a2*u2=g*c

for some c in B.  The left side lies in J, so gc lies in J.  Hence

  c in (J:g)=C.

Therefore every value tau_bar(h)=c mod L lies in Cbar, and

  im(tau_bar) subset Cbar.                            (1)

Conversely, take any class in Cbar and represent it by c in C.  Since c lies
in (J:g),

  g*c in J=(u1,u2).

Choose a1,a2 in B such that

  a1*u1+a2*u2=g*c.

Reducing a1,a2 modulo g gives a Koszul cycle in R^2, because its dot product
with (u1,u2) vanishes in R=B/(g).  Let h be its class in
H_1(u1,u2;R).  The defining formula for tau_bar gives

  tau_bar(h)=c mod L.

Thus every class of Cbar occurs in the image, so

  Cbar subset im(tau_bar).                            (2)

Combining (1) and (2) yields the exact identification

  im(tau_bar)=Cbar.                                   (3)

Theorem R2_Koszul_division_image_equals_colon_image:

  im(tau_bar)=((J:g)+L)/L subset A.
Qed.

--------------------------------------------------------------------------
2. THE COLON ANNIHILATOR IS A CANONICAL SUBIDEAL OF Ann_A(xi)
--------------------------------------------------------------------------

The pushout/Koszul reduction proved

  Ann_A(xi)
    ={a in A : a*tau_bar lies in image(lambda)}.

If a lies in Ann_A(Cbar), then by (3) it kills every value of tau_bar.  Hence

  a*tau_bar=0,

and zero lies in image(lambda).  Therefore

  Ann_A(Cbar) subset Ann_A(xi).                       (4)

Theorem R2_colon_annihilator_injects_into_boundary_annihilator:

  Ann_A(((J:g)+L)/L) subset Ann_A(xi).
Qed.

This shows that the explicit tangent maps which move only g in the earlier
colon-compensation reduction are not an independent ad hoc source: their
parameter ideal is canonically contained in the annihilator term appearing in
the exact cyclic-boundary tangent formula.

--------------------------------------------------------------------------
3. EXACT EXCESS BEYOND THE COLON-SUPPORTED FAMILY
--------------------------------------------------------------------------

Multiplication gives a map

  m_tau:A -> Hom_A(H_1(u1,u2;R),A),
  m_tau(a)=a*tau_bar.

By (3),

  ker(m_tau)=Ann_A(Cbar).

Let Q_tau be the image A*tau_bar.  The distinguished extension is the class of
tau_bar modulo image(lambda).  Hence the additional elements which annihilate
xi but do not already annihilate Cbar are exactly those whose nonzero multiple
of tau_bar lands in image(lambda).  Therefore there is a natural short exact
sequence of C-vector spaces

  0 -> Ann_A(Cbar)
    -> Ann_A(xi)
    -> (A*tau_bar) intersect image(lambda)
    -> 0.                                             (5)

Consequently

  length_C Ann_A(xi)
    = length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda)).   (6)

Theorem R2_boundary_annihilator_splits_into_colon_plus_Koszul_overlap:

  length_C Ann_A(xi)
    = length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda)).
Qed.

Substituting (6) into the exact cyclic-boundary tangent formula gives

  dim_C Hom_B(L,A)
    = dim_C ker(lambda)
      + length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda)).   (7)

Thus the earlier colon-compensated lower bound is exactly the part of the full
tangent space obtained by discarding one nonnegative, explicitly identified
Koszul-overlap term.

--------------------------------------------------------------------------
4. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_Koszul_division_image_equals_colon_image.
  R2_colon_annihilator_injects_into_boundary_annihilator.
  R2_boundary_annihilator_splits_into_colon_plus_Koszul_overlap.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    dim_C Hom_B(L,A)>=N-19.

  It does NOT close all residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The equalities above are module
  identifications derived from the already constructed colon and Koszul maps;
  the new theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The colon defect and the distinguished Koszul boundary are now the same
  object on the image side:

    im(tau_bar)=Cbar.

  The exact tangent count differs from the earlier colon-compensated bound by
  only the explicit nonnegative overlap

    (A*tau_bar) intersect image(lambda).

MISSING_OBJECT:
  Prove in the surviving non-Gorenstein R2 case that

    dim_C ker(lambda)
      + length_C Ann_A(Cbar)
      + dim_C((A*tau_bar) intersect image(lambda))
      >= N-19.

  Equivalently, bound the remaining loss after accounting for the exact colon
  image and the Koszul overlap.

NEXT_ACTIONS:
  1. Run the exact terminal workflow on this commit.
  2. Use Koszul self-duality over the Artinian Gorenstein ring R to identify
     the orthogonal of image(lambda).
  3. Relate that orthogonal to Cbar=im(tau_bar).
  4. Extract the weakest numerical lower bound needed for >=N-19.
  5. Do not promote all R2 before that inequality is proved.
