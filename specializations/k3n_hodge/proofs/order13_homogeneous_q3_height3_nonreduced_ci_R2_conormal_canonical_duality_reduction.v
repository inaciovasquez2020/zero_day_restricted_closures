Standalone conormal/canonical-duality refinement for the residual nonreduced
homogeneous q=3, height-three complete-intersection R2 branch in the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_pushout_koszul_boundary_reduction.v.

  Retain its notation

    B=S/(q1,q2,q3),
    J=(u1,u2) subset B,
    L=J+(g),
    A=B/L,
    N=length_C(A),

  with

    deg(u1)=deg(u2)=d < e=deg(g),

  and g a homogeneous B-nonzerodivisor. Put

    R=B/(g),
    J_R=(J+(g))/(g),
    M=H_1(u1,u2;R).

  The preceding reductions prove

    length_C(M)=2N

  and construct the coefficient map and distinguished cocycle

    c:M -> A^2,
    tau_bar:M -> A.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE TWO-GENERATOR KOSZUL MODULE IS THE FULL THREE-GENERATOR H_1
--------------------------------------------------------------------------

Because g is B-regular, the Koszul complex K_B(g) is a free resolution of

  R=B/(g).

Tensoring the free complex K_B(u1,u2) with the quasi-isomorphism

  K_B(g) -> R

shows that

  K_B(u1,u2,g)

and

  K_R(u1,u2)

have the same homology. In particular

  H_1(u1,u2,g;B) ~= M

and therefore

  length_C H_1(u1,u2,g;B)=2N.                       (1)

Theorem R2_full_Koszul_H1_has_length_two_N:

  length_C H_1(u1,u2,g;B)=2N.
Qed.

--------------------------------------------------------------------------
2. IDENTIFY THE FULL CONORMAL SYZYGY MAP
--------------------------------------------------------------------------

For the three generators u1,u2,g of L, the standard conormal presentation is

  H_1(u1,u2,g;B)
      --rho--> A^3
      --> L/L^2
      --> 0,                                          (2)

where a syzygy

  a1*u1+a2*u2+a3*g=0

maps to

  (a1 mod L, a2 mod L, a3 mod L).

Under the identification in Section 1 with M=H_1(u1,u2;R), a class represented
by (r1,r2) admits lifts a1,a2 in B satisfying

  a1*u1+a2*u2=g*c.

The previous file defined

  c_coeff([r1,r2])=(r1 mod J_R,r2 mod J_R) in A^2

and

  tau_bar([r1,r2])=c mod L in A.

The corresponding full B-syzygy is

  (a1,a2,-c).

Hence the conormal map is exactly

  rho=(c_coeff,-tau_bar):M -> A^3.                   (3)

Theorem R2_pushout_pair_is_full_conormal_map:
  The coefficient pairing and the distinguished g-division cocycle from the
  preceding reduction are the three coordinates of the ordinary conormal
  syzygy map for L.
Qed.

Define the syzygetic kernel

  delta_L:=ker(rho).

No vanishing of delta_L is assumed or claimed.

--------------------------------------------------------------------------
3. EXACT CONORMAL LENGTH
--------------------------------------------------------------------------

From (1),

  length_C M=2N.

Therefore

  length_C im(rho)
    =2N-length_C(delta_L).

The middle term A^3 in (2) has length 3N. Exactness of (2) at A^3 gives

  length_C(L/L^2)
    =3N-length_C im(rho)
    =N+length_C(delta_L).                            (4)

Theorem R2_exact_conormal_length:

  length_C(L/L^2)=N+length_C(delta_L).
Qed.

In particular

  length_C(L/L^2)>=N.                               (5)

This is the deviation-two conormal length identity in the present R2 setup;
it is derived here directly from the already established Koszul length count.

--------------------------------------------------------------------------
4. CANONICAL DUALITY PRESERVES THE CONORMAL LENGTH
--------------------------------------------------------------------------

Since R is Artinian Gorenstein and A=R/J_R, the canonical A-module can be
written

  omega_A:=Hom_R(A,R)=Ann_R(J_R).

Equivalently, omega_A is the Matlis dual of A, up to the harmless grading
shift. For every finite A-module X, canonical Matlis duality preserves total
C-length:

  length_C Hom_A(X,omega_A)=length_C X.

Applying this to

  X=L/L^2

gives, using (4),

  length_C Hom_A(L/L^2,omega_A)
    =N+length_C(delta_L).                            (6)

Theorem R2_canonical_normal_length:

  length_C Hom_A(L/L^2,omega_A)
    =N+length_C(delta_L).
Qed.

--------------------------------------------------------------------------
5. THE GORENSTEIN-A SUBCASE CLOSES
--------------------------------------------------------------------------

Assume now that A itself is Artinian Gorenstein. Then, up to a grading shift,

  omega_A ~= A.

Consequently (6) becomes

  dim_C Hom_A(L/L^2,A)
    =N+length_C(delta_L)
    >=N.                                             (7)

Because L annihilates A, every B-linear map L->A kills L^2, so

  Hom_B(L,A) ~= Hom_A(L/L^2,A).

Thus

  dim_C Hom_B(L,A)>=N>N-20.

The established injection of this intrinsic tangent space into the ambient
order-13 tangent space excludes the tangent-deficit gate.

Theorem R2_Gorenstein_Artin_quotient_is_tangent_closed:
  In residual R2, if A is Gorenstein, then the order-13 tangent-deficit gate
  cannot hold.
Qed.

Corollary R2_residual_quotient_is_nonGorenstein:
  Every R2 candidate surviving this file must have non-Gorenstein Artinian
  quotient A.
Qed.

--------------------------------------------------------------------------
6. EXACT NON-GORENSTEIN DUALITY DEFECT
--------------------------------------------------------------------------

For the remaining non-Gorenstein A define the signed canonical-duality loss

  Gamma_A(L)
    := length_C Hom_A(L/L^2,omega_A)
       -dim_C Hom_A(L/L^2,A).

Using (6),

  dim_C Hom_B(L,A)
    =N+length_C(delta_L)-Gamma_A(L).                 (8)

Therefore the desired lower bound

  dim_C Hom_B(L,A)>=N-19

is equivalent to

  Gamma_A(L)<=length_C(delta_L)+19.                 (9)

No sign assumption on Gamma_A(L) is needed.

Theorem R2_exact_canonical_duality_defect_target:
  After the Gorenstein-A subcase is removed, residual R2 closes exactly if

    Gamma_A(L)<=length_C(delta_L)+19.
Qed.

This is equivalent to the preceding cyclic-boundary/Koszul target, but it
isolates the only reason the conormal length lower bound (5) does not already
finish the non-Gorenstein case: the tangent space uses the A-dual rather than
the canonical A-dual.

--------------------------------------------------------------------------
7. BOUNDARY
--------------------------------------------------------------------------

RESULT:
  R2_exact_conormal_length.
  R2_canonical_normal_length.
  R2_Gorenstein_Artin_quotient_is_tangent_closed.

CLOSED_SUBCASE:
  residual R2 with Artinian Gorenstein quotient A.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove (9) for non-Gorenstein A.
  It does NOT close all residual R2.
  It does NOT close residual R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  A surviving R2 quotient is necessarily non-Gorenstein, and its exact
  remaining tangent loss is the failure of A-valued duality to match canonical
  Matlis duality on the conormal module L/L^2.

MISSING_OBJECT:
  Prove for every surviving non-Gorenstein R2 quotient that

    Gamma_A(L)<=length_C(delta_L)+19,

  or return to the equivalent explicit Koszul criterion involving
  c_coeff and tau_bar.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow for this commit.
  2. Express Gamma_A(L) through omega_A/A comparison data or type(A).
  3. Bound that loss using the two-generator presentation A=R/(u1,u2).
  4. Compare with length_C(delta_L).
  5. Do not promote all R2 until inequality (9) is proved.
