Standalone structural exclusion of the final transverse rho_Q=2 leaf inside the
contained K-subset-J incidence of the r-in-P LK3-C2 carrier in the saturated H01
minimal-chain rank-two endpoint of the homogeneous q=4, height-two,
multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Retain the established R2 data

    sigma=3,

    0 -> S(-5)
      -> S(-3)^3 direct_sum S(-4)
      -> S(-2)^4
      -> S
      -> S/Q
      -> 0,

  and, for the complete 4-by-3 linear-syzygy matrix L,

    I_3(L)=(r)Q.

  Retain also the r-in-P contained carrier

    P=(r,p),
    K=(Q:r)=(a,b,F) subset J=(r,u,v),
    A:=K_1=span_C{a,b},

  with exactly two r-multiple quadrics and rho_Q=2.

The preceding incidence reduction proves

    P not_subset J => rho_Q=2,

and the preceding P-subset-J rho_Q=2 exclusion removes the complementary
P-subset-J rank-two leaf.  Hence the only remaining contained rank-two leaf is

    K subset J,
    P not_subset J,
    rho_Q=2.

Since r belongs to J, P not_subset J is equivalent to p notin J.

This file performs one bounded task only: exclude that transverse leaf using
the exact linear-syzygy count sigma=3 and the intrinsic maximal-minor factor r.
No tangent estimate is needed.

No r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. TRANSVERSE COORDINATES AND THE TWO A/R INCIDENCES
--------------------------------------------------------------------------

Because p notin J and dim_C S_1=4, choose coordinates so that

    S=C[r,u,v,p],
    J=(r,u,v),
    P=(r,p).

The two-dimensional plane

    A=K_1 subset J_1

has exactly two incidence types with the distinguished line C*r:

    (I)  r in A,
    (II) r notin A.

We treat them separately.

--------------------------------------------------------------------------
2. CASE I: r IN A FORCES THE REDUCED K TYPE
--------------------------------------------------------------------------

Assume r in A.  After a basis change inside J preserving r, write

    A=(r,u),
    J=(r,u,v).

The two non-r-multiple quadrics may simultaneously be rebased so that modulo r

    q3bar=pbar*ubar,
    q4bar=pbar*vbar.

Write

    K=(r,u,F).

Modulo A, one has

    S/A ~= C[v,p].

Since K subset J, Fbar is divisible by v.  The contained classification gives
only

    Fbar=v*ell

with either ell independent of v (the reduced type) or ell proportional to v
(the double type).

But q4 belongs to Q subset K and modulo A its class is p*v.  Since the
degree-two part of K/A is the one-dimensional span of Fbar, Fbar must be
proportional to p*v.  Therefore the double form v^2 is impossible and, after
scaling and changing F by an A-multiple,

    K=(r,u,p*v).

Choose the two r-multiple generators as

    q1=r^2,
    q2=r*u.

After subtracting q1,q2 multiples from q3,q4, every such transverse ideal has
form

    q1=r^2,
    q2=r*u,
    q3=p*u+r*(alpha*v+beta*p),
    q4=p*v+r*(gamma*v+delta*p),

for constants alpha,beta,gamma,delta in C.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_r_in_A_normal_form:
  Every transverse rho_Q=2 carrier with r in A has the displayed four-parameter
  reduced normal form.
Qed.

--------------------------------------------------------------------------
3. CASE I: sigma=3 FORCES alpha=0
--------------------------------------------------------------------------

Solve a general linear syzygy

    l1*q1+l2*q2+l3*q3+l4*q4=0,

with each li in S_1, by comparing the degree-three monomials in
C[r,u,v,p].

The coefficient system has:

    dim_C Syz_1(Q)=2  if alpha != 0,
    dim_C Syz_1(Q)=3  if alpha = 0.

The exact R2 Betti table requires

    sigma=dim_C Syz_1(Q)=3.

Hence every R2 survivor in Case I must satisfy

    alpha=0.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_r_in_A_alpha_zero:
  Under the R2 hypothesis sigma=3, alpha=0.
Qed.

--------------------------------------------------------------------------
4. CASE I: THE MAXIMAL-MINOR FACTOR IS u+beta*r, NOT r
--------------------------------------------------------------------------

Set alpha=0.  A basis of the complete three-dimensional linear-syzygy space is
then given by the columns of

        [ -u   -beta*p   -beta*gamma*v-beta*delta*p ]
    L = [  r      -p             -gamma*v-delta*p   ]
        [  0       r                     -v          ]
        [  0       0                  beta*r+u       ].

A direct check gives Q*L=0.  Its signed maximal minors are, up to one common
nonzero scalar and the conventional common sign,

    (beta*r+u)*
      (r^2,
       r*u,
       p*u+beta*r*p,
       p*v+r*(gamma*v+delta*p)).

Thus

    I_3(L)=(beta*r+u)Q.

Because r and u are independent linear forms, beta*r+u is not proportional to
r.  But the previously established R2 determinantal factorization requires the
intrinsic common maximal-minor factor to be exactly the line C*r:

    I_3(L)=(r)Q.

Contradiction.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_r_in_A_empty:
  The transverse rho_Q=2 leaf with r in A is empty.
Qed.

--------------------------------------------------------------------------
5. CASE II: r NOTIN A HAS REDUCED AND DOUBLE NORMAL FORMS
--------------------------------------------------------------------------

Assume r notin A.  Projection A -> J_1/C*r is an isomorphism, so choose a basis
u,v of A and write

    A=(u,v),
    J=(r,u,v),
    P=(r,p).

Choose

    q1=r*u,
    q2=r*v.

Modulo A,

    S/A ~= C[r,p].

Since K=(u,v,F) subset J, Fbar is divisible by r.  The contained two-type
classification therefore gives exactly:

  REDUCED:
    after replacing p by p+lambda*r, which preserves P and p notin J,

      K=(u,v,r*p);

  DOUBLE:

      K=(u,v,r^2).

Let

    F0=r*p  in the reduced type,
    F0=r^2  in the double type.

The conditions q3bar=p*ubar and q4bar=p*vbar modulo r, together with q3,q4 in
K, imply, after subtracting q1,q2 multiples,

    q3=p*u+alpha*F0,
    q4=p*v+beta*F0

for constants alpha,beta in C.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_r_notin_A_normal_forms:
  Every transverse carrier with r notin A has one of the two displayed forms,
  with F0=r*p or F0=r^2.
Qed.

--------------------------------------------------------------------------
6. ZERO LEAKAGE HAS FOUR LINEAR SYZYGIES
--------------------------------------------------------------------------

If

    alpha=beta=0,

then in either geometric type

    Q=(r*u,r*v,p*u,p*v)=(r,p)*(u,v).

It has four independent linear syzygies, for example

    (-v, u, 0, 0),
    (-p, 0, r, 0),
    (0, -p, 0, r),
    (0, 0, -v, u).

Hence

    dim_C Syz_1(Q)>=4,

contradicting the exact R2 value sigma=3.

Therefore every R2 survivor in Case II must satisfy

    (alpha,beta) != (0,0).

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_zero_leak_empty:
  The zero-leakage Case-II carrier is empty.
Qed.

--------------------------------------------------------------------------
7. NONZERO LEAKAGE NORMALIZES TO (alpha,beta)=(1,0)
--------------------------------------------------------------------------

A GL_2(C) basis change of A=(u,v), applied simultaneously to the pairs
(q1,q2) and (q3,q4), acts transitively on nonzero vectors (alpha,beta).
Thus normalize

    (alpha,beta)=(1,0).

The two remaining normal forms are therefore

  REDUCED:

    Q_R=(r*u,
         r*v,
         p*u+r*p,
         p*v),

  DOUBLE:

    Q_D=(r*u,
         r*v,
         p*u+r^2,
         p*v).

--------------------------------------------------------------------------
8. REDUCED NONZERO LEAKAGE HAS INTRINSIC FACTOR v
--------------------------------------------------------------------------

For Q_R, the complete three-dimensional linear-syzygy space has basis given by
the columns of

        [ -v    0    0 ]
    L_R=[  u   -p    p ]
        [  0    0   -v ]
        [  0    r    u ].

One checks directly that Q_R*L_R=0.  The signed maximal minors are, up to common
sign,

    v*(r*u,
       r*v,
       p*u+r*p,
       p*v).

Hence

    I_3(L_R)=(v)Q_R.

Since v and r are independent, this contradicts the required intrinsic factor
r.

Therefore the reduced nonzero-leakage transverse carrier is empty.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_reduced_empty:
  No reduced Case-II transverse rho_Q=2 carrier satisfies the full R2
  determinantal factorization.
Qed.

--------------------------------------------------------------------------
9. DOUBLE NONZERO LEAKAGE ALSO HAS INTRINSIC FACTOR v
--------------------------------------------------------------------------

For Q_D, the complete three-dimensional linear-syzygy space has basis given by
the columns of

        [ -v    0    0 ]
    L_D=[  u   -p    r ]
        [  0    0   -v ]
        [  0    r    u ].

Again Q_D*L_D=0, and the signed maximal minors are, up to common sign,

    v*(r*u,
       r*v,
       p*u+r^2,
       p*v).

Thus

    I_3(L_D)=(v)Q_D,

with v not proportional to r.  This again contradicts

    I_3(L)=(r)Q.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_transverse_double_empty:
  No double Case-II transverse rho_Q=2 carrier satisfies the full R2
  determinantal factorization.
Qed.

--------------------------------------------------------------------------
10. THE TRANSVERSE rho_Q=2 LEAF IS EMPTY
--------------------------------------------------------------------------

The cases r in A and r notin A exhaust all two-planes A=K_1 inside J_1.
Sections 4, 6, 8, and 9 exclude every possibility.

Therefore

    K subset J,
    P not_subset J,
    rho_Q=2

is empty under the exact R2 Betti and determinantal hypotheses.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_P_transverse_empty:
  The transverse contained rho_Q=2 leaf is empty.
Qed.

--------------------------------------------------------------------------
11. THE ENTIRE CONTAINED r-in-P INCIDENCE CLOSES
--------------------------------------------------------------------------

The contained incidence K subset J is now exhausted:

  rho_Q=0:
    previously tangent-closed;

  rho_Q=1:
    previously reduced to AP-D/AP-R and both tangent-closed;

  rho_Q=2 with P subset J:
    previously excluded by the sigma=3 syzygy obstruction;

  rho_Q=2 with P not_subset J:
    excluded in this file.

Hence every K-subset-J child is excluded at a necessary order-13 gate or is
structurally empty.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_closed:
  The contained K-subset-J incidence is CLOSED.
Qed.

The complementary K-not-subset-J incidence was already tangent-closed for every
admissible final degree.  Since K subset J and K not_subset J exhaust the
r-in-P LK3-C2 half, one obtains:

Corollary H01_m2_R2_LK3_C2_r_in_P_closed:
  The full r-in-P half of LK3-C2 is CLOSED at the necessary order-13 tangent or
  structural gates.
Qed.

--------------------------------------------------------------------------
12. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  transverse_rho_two_r_in_A_empty.
  transverse_rho_two_r_notin_A_reduced_empty.
  transverse_rho_two_r_notin_A_double_empty.
  contained_rho_two_P_not_subset_J_empty.
  contained_r_in_P_closed.
  r_in_P_LK3_C2_closed.

CLOSED:
  H01_m2_R2_LK3_C2 r-in-P half.

NOT_PROVED:
  r-not-in-P LK3-C2 tangent closure.
  full LK3-C2 closure.
  LK3-C3 closure.
  R2-LK2 closure.
  R2-QK closure.
  H01-M2-R2 closure.
  H01-M2-R1 closure.
  H01 closure.
  q4 height-two full closure.
  homogeneous q<=3 closure.
  Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_m2_R2_LK3_C2_r_in_P_closed.
  not H01_m2_R2_LK3_C2_r_notin_P_closed.
  not H01_m2_R2_LK3_C2_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in LK3-C2 and return to the already-classified r-not-in-P carrier.
  Derive its direct final-pair tangent carrier from the explicit 2-by-3
  Hilbert-Burch presentation over S/(r); do not enter LK3-C3, R2-LK2, R2-QK,
  or H01-M2-R1 until the r-not-in-P half is resolved.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
