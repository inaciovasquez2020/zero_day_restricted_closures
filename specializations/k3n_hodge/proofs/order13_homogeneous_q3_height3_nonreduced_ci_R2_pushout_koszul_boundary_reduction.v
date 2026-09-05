Standalone pushout/Koszul identification for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_cyclic_boundary_koszul_reduction.v.

  Retain its notation

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    N=length_C(A),

  with

    deg(u1)=deg(u2)=d < e=deg(g),

  and g a homogeneous B-nonzerodivisor. Put

    C=(J:g),
    D=C/J,
    R=B/(g),
    J_R=(J+(g))/(g) subset R.

  The preceding reduction defined

    xi=beta(mu(1)) in Ext^1_R(J_R,A)

  and proved

    dim_C Hom_B(L,A)
      = dim_C Hom_R(J_R,A)
        + length_C Ann_A(xi).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

Throughout this file, homogeneous shifts are suppressed whenever only total
C-vector-space dimensions or ungraded R-module extension classes are used.

--------------------------------------------------------------------------
1. THE DISTINGUISHED CLASS xi IS THE g-SLICE EXTENSION
--------------------------------------------------------------------------

The earlier colon sequence is

  0 -> D(-e)
    -> J/gJ
    -> J_R
    -> 0,                                             (1)

where c mod J in D is sent to gc mod gJ.

The multiplication functional defining xi is

  pi:D(-e)->A,
  pi(c mod J)=c mod L.

By definition, xi is the pushout of (1) along pi.

Now consider L/gL. Because gL is contained in gB, multiplication by g gives
an injective R-linear map, up to the displayed grading shift,

  A=B/L -> gB/gL subset L/gL,
  b mod L |-> gb mod gL.

Indeed gb lies in gL if and only if b lies in L, since g is B-regular.
Furthermore

  (L/gL)/(gB/gL)
    ~= L/gB
    ~= J/(J intersect gB)
    ~= J/gC
    ~= J_R,

using

  J intersect gB=gC.

Hence there is a short exact sequence of R-modules

  0 -> A
    -> L/gL
    -> J_R
    -> 0.                                             (2)

The square

        D(-e)  ----->  J/gJ
          |              |
         pi              |
          v              v
          A     ----->   L/gL

commutes: the top inclusion sends c mod J to gc mod gJ, while both routes to
L/gL give gc mod gL. The right vertical map sends j mod gJ to j mod gL.
The induced map from the pushout of (1) along pi to L/gL is an isomorphism,
because it is the identity on the kernel A and on the quotient J_R.

Theorem R2_xi_is_g_slice_extension:
  The distinguished class

    xi=beta(pi)

  is represented by the exact sequence

    0 -> A -> L/gL -> J_R -> 0,

  with the grading shift on the left understood through multiplication by g.
Qed.

--------------------------------------------------------------------------
2. A KOSZUL COCYCLE REPRESENTING xi
--------------------------------------------------------------------------

Let

  F=R^2 -> J_R,
  (r1,r2) |-> r1*u1+r2*u2,

and let

  Z_1=ker(F->J_R).

For z=(r1,r2) in Z_1, choose lifts a1,a2 in B. Since z is a relation after
modding out by g,

  a1*u1+a2*u2 lies in (g).

It also lies in J, so there is c in C=(J:g) with

  a1*u1+a2*u2=g*c.                                  (3)

Because g is B-regular, c is uniquely determined by the chosen lifts. Define

  tau(z):=c mod L in A.

This is independent of the chosen lifts. Replacing

  a1 by a1+g*b1,
  a2 by a2+g*b2

replaces c by

  c+b1*u1+b2*u2,

which has the same image in A because J annihilates A.
Thus tau is a well-defined R-linear map

  tau:Z_1 -> A.

For the Koszul boundary

  d_2(t)=(-t*u2,t*u1),

formula (3) has c=0 by commutativity. Hence tau kills all Koszul boundaries
and descends to an A-linear map

  tau_bar:H_1(u1,u2;R) -> A.                        (4)

The extension (2) is obtained from the free presentation F->J_R by lifting
the two generators u1,u2 to their classes in L/gL. For a relation z, the
failure of the lifted relation to vanish in L/gL is exactly

  a1*u1+a2*u2
    =g*c,

which corresponds, under A ~= gB/gL, to c mod L=tau(z).
Therefore tau is a cocycle representative of the extension class xi.

Theorem R2_xi_has_explicit_koszul_representative:
  Under the presentation of Ext^1_R(J_R,A) from

    0 -> Z_1 -> R^2 -> J_R -> 0,

  the class xi is represented by tau, and tau factors through the first
  Koszul homology as tau_bar in (4).
Qed.

--------------------------------------------------------------------------
3. THE SAME KOSZUL MAP CONTROLS Hom_R(J_R,A)
--------------------------------------------------------------------------

For (alpha1,alpha2) in A^2 define

  lambda(alpha1,alpha2):H_1(u1,u2;R) -> A

by

  lambda(alpha1,alpha2)([r1,r2])
    =r1*alpha1+r2*alpha2 in A.                      (5)

This is well-defined on Koszul homology because every boundary has the form

  (-t*u2,t*u1),

and u1,u2 vanish in A.

A pair (alpha1,alpha2) defines an R-linear map R^2->A. It descends to a map
J_R->A exactly when it kills every relation in Z_1. Since the restriction to
Z_1 already kills Koszul boundaries, this is equivalent to

  lambda(alpha1,alpha2)=0.

Hence

  Hom_R(J_R,A) ~= ker(lambda).                       (6)

Theorem R2_two_generator_tangent_is_koszul_kernel:

  dim_C Hom_R(J_R,A)=dim_C ker(lambda).
Qed.

--------------------------------------------------------------------------
4. EXACT ANNIHILATOR CRITERION FOR xi
--------------------------------------------------------------------------

The class xi is represented by tau_bar modulo the restrictions of maps
R^2->A, namely modulo image(lambda). Therefore for a in A,

  a*xi=0

if and only if

  a*tau_bar lies in image(lambda).

Thus

  Ann_A(xi)
    ={a in A : a*tau_bar in image(lambda)}.         (7)

Theorem R2_xi_annihilator_is_koszul_extension_locus:
  The annihilator of the distinguished boundary class is exactly the set in
  (7).
Qed.

Combining (6), (7), and the previous exact tangent formula gives the single
Koszul expression

  dim_C Hom_B(L,A)
    = dim_C ker(lambda)
      + length_C {a in A : a*tau_bar in image(lambda)}.   (8)

This identifies both terms in the R2 tangent count inside the same
first-Koszul-homology module.

--------------------------------------------------------------------------
5. SHARP REMAINING TARGET
--------------------------------------------------------------------------

The order-13 tangent-deficit gate is excluded once

  dim_C Hom_B(L,A) >= N-19.

By (8), the remaining R2 inequality is exactly

  dim_C ker(lambda)
    + length_C {a in A : a*tau_bar in image(lambda)}
    >= N-19.                                        (9)

The previously proved identity

  length_C H_1(u1,u2;R)=2N

is retained, but no numerical estimate is inferred from it here without an
additional structural argument on lambda and tau_bar.

--------------------------------------------------------------------------
6. BOUNDARY
--------------------------------------------------------------------------

RESULT:
  R2_xi_is_g_slice_extension.
  R2_xi_has_explicit_koszul_representative.
  R2_two_generator_tangent_is_koszul_kernel.
  R2_xi_annihilator_is_koszul_extension_locus.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove inequality (9).
  It does NOT close residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The distinguished obstruction class is no longer abstract. It is the
  extension class of

    0 -> A -> L/gL -> J_R -> 0

  and is represented on H_1(u1,u2;R) by the explicit relation-dividing map

    tau_bar([r1,r2])=(a1*u1+a2*u2)/g mod L.

MISSING_OBJECT:
  Prove (9), preferably by exploiting the equal total lengths

    length_C H_1(u1,u2;R)=2N=length_C A^2

  together with the concrete pair

    lambda:A^2->Hom_A(H_1,A),
    tau_bar:H_1->A.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow for this commit.
  2. Analyze the conormal map H_1 -> A^2 dual to the coefficient pairing.
  3. Determine whether tau_bar lies in a canonical dual summand or quotient.
  4. Use that structure to bound the locus in (7).
  5. Do not promote R2 until (9) is proved.
