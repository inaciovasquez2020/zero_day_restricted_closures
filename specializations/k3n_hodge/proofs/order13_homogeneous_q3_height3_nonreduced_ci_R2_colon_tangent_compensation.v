Standalone colon-compensation tangent reduction for the residual R2 branch of
the nonreduced homogeneous q=3, height-three complete-intersection core in the
order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_regular_escape_reduction.v.

  Thus

    B=S/(q1,q2,q3)

  is the one-dimensional standard graded Gorenstein complete intersection of
  three quadrics and, after the regular-escape replacement, the residual R2
  ideal has the form

    L=(u1,u2,g)=J+(g),
    J=(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),

  where g is homogeneous and B-regular. Put

    R:=B/(g),
    J_R:=image(J in R),
    A:=B/L=R/J_R,
    N:=length_C(A).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE COLON DEFECT OF THE REGULAR ESCAPE
--------------------------------------------------------------------------

Define

  C:=(J :_B g)={ b in B : b*g in J }.

Since J is an ideal, J subset C. Modulo J this is precisely the kernel of
multiplication by g on B/J:

  C/J = 0:_{B/J} g.

Let

  Cbar:=(C+L)/L subset A

be the image of C in A.

The module C/J measures the failure of g to remain regular after passing from B
to B/J. It is therefore the intrinsic colon defect created by the two trapped
minimal-degree generators.

--------------------------------------------------------------------------
2. MAPS THAT KILL g
--------------------------------------------------------------------------

The quotient map

  pi:L -> J_R=L/(g)

is B-linear, and J_R and A are naturally R-modules. Pullback along pi gives an
injective C-linear map

  iota:
    Hom_R(J_R,A) -> Hom_B(L,A).

Every map in the image of iota kills g.

This is the injection already recorded in the regular-escape reduction.

--------------------------------------------------------------------------
3. MAPS THAT KILL J AND MOVE ONLY g
--------------------------------------------------------------------------

Take

  a in Ann_A(Cbar).

Define

  phi_a:L -> A

by

  phi_a(j+b*g):=b*a,

for j in J and b in B.

This is well-defined. Indeed, if

  j+b*g=j'+b'*g,

then

  (b-b')*g in J,

so b-b' lies in C. Its image in A lies in Cbar and therefore annihilates a.
Hence

  b*a=b'*a.

The map phi_a is B-linear, kills J, and satisfies

  phi_a(g)=a.

Consequently

  a |-> phi_a

defines an injective C-linear map

  kappa:
    Ann_A(Cbar) -> Hom_B(L,A).

Its image consists of maps that kill J and move only the regular escape
generator.

--------------------------------------------------------------------------
4. THE TWO FAMILIES ARE INDEPENDENT
--------------------------------------------------------------------------

A map in image(iota) kills g.
A map phi_a in image(kappa) satisfies phi_a(g)=a.

Therefore

  image(iota) intersect image(kappa)=0.

Hence there is a natural C-linear injection

  Hom_R(J_R,A) direct_sum Ann_A(Cbar)
      -> Hom_B(L,A).

Theorem R2_colon_compensated_tangent_injection:

  dim_C Hom_B(L,A)
    >= dim_C Hom_R(J_R,A)
       + length_C Ann_A(Cbar).
Qed.

This strengthens the preceding regular-section estimate, which retained only
the first summand.

--------------------------------------------------------------------------
5. UPDATED NUMERICAL TARGET
--------------------------------------------------------------------------

The order-13 tangent exclusion follows once

  dim_C Hom_B(L,A) >= N-19.

By the compensated injection it is therefore enough to prove

  dim_C Hom_R(J_R,A)
    + length_C Ann_A(Cbar)
    >= N-19.

This is weaker than demanding

  dim_C Hom_R(J_R,A) >= N-19

by itself. It also has the expected compensation behavior: when the regular
escape acquires many relations modulo J, the colon defect Cbar grows and creates
additional tangent maps supported on g.

IMPORTANT_NONCONCLUSION:
  No universal lower bound for either summand separately is asserted.
  No equality with Hom_B(L,A) is asserted; there may be further mixed maps.
  This file does NOT close R2 or R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation. The colon construction and the two
  explicit tangent injections are elementary module arguments. The new theorem
  statement is not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Residual R2 now has two independent, explicit tangent sources:

    (1) Hom_R(J_R,A), from deformations of the two-generator Artin-Gorenstein
        section while fixing g;

    (2) Ann_A(Cbar), from deformations that kill J and move only g, where
        C=(J:g).

MISSING_OBJECT:
  Prove the compensated R2 inequality

    dim_C Hom_R(J_R,A)
      + length_C Ann_A(Cbar)
      >= N-19.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, identify C/J=0:_{B/J}g inside the two-generator Koszul homology.
  3. Use Artinian-Gorenstein duality in R=B/(g) to relate a small first summand
     to a large annihilator summand.
  4. Prove only the compensated N-19 inequality.
  5. Rebuild immediately after that bounded lemma.
