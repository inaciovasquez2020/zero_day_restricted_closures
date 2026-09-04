Standalone residual-scope promotion closure for the H01-C5 chain value m=3 in
the homogeneous q=4, height-two multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,
    Qsat = Q^sat,
    Ccore = S/Qsat,
    T = Qsat/Q,
    P = (l1,l2),
    D = P/Qsat,

  in H01-C5 with

    m = 3,
    sigma = 5,
    tau_3 = 1,
    ht(Q) = 2,
    e(S/Q) = 1,
    Qsat subset P,
    Q_2 = (Qsat)_2 =: W,
    dim_C W = 4.

Define the residual annihilator and residual ring by

    J_res := Ann_S(D) = (Qsat:P),
    R_res := S/J_res.

Earlier files developed the residual-ring route while carrying the additional
label E0/E1 for the cyclic saturation colon K=(Q:gamma).  This file performs
one bounded task only: audit the actual dependencies of the residual
classification and its three residual-cut exclusions, remove that artificial
E0/E1 restriction, and apply the same residual contradiction to every H01-C5
m=3 colon type, including E2.

No classification of the E2 binary colon ideal I(u,v) beyond the previously
proved I_2 != 0 is used here.  No H01-C4, q<=3, or full order-13 statement is
entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE RESIDUAL OBJECTS DO NOT DEPEND ON THE CYCLIC-COLON TYPE
--------------------------------------------------------------------------

The H01 m=3 Artinian-chain classification gives

    Hilb_D(t) = (2*t+t^2+t^3)/(1-t).

For a general D-regular linear form h,

    E := D/hD

has the exact normal form

    E ~= C(-1) direct_sum C[u]/(u^3)(-1).

After coordinates in

    Sbar := S/(h) ~= C[u,v,w],

its annihilator is

    Ann_Sbar(E) = (v,w,u^3).

These objects are defined entirely from

    D = P/Qsat.

Likewise

    J_res = Ann_S(D) = (Qsat:P)

and

    R_res = S/J_res

depend only on D and Qsat.  They do not depend on the embedding dimension of

    S/(Q:gamma),

and therefore do not distinguish E0, E1, or E2.

Theorem H01_C5_m3_residual_objects_colon_independent:
  The residual module D, residual annihilator J_res, residual ring R_res,
  regular cut h, and Artinian residual module E are common to every H01-C5
  m=3 cyclic-colon type.
Qed.

--------------------------------------------------------------------------
2. THE RESIDUAL RING HAS MULTIPLICITY AT MOST FOUR
--------------------------------------------------------------------------

Because J_res=Ann_S(D), the module D is faithful over R_res.

The general linear form h is D-regular.  If a class r in R_res satisfies

    h*r = 0,

then h*(rD)=0.  D-regularity gives rD=0, and faithfulness gives r=0.
Therefore h is R_res-regular.

Since

    Hilb_D(t) = (2*t+t^2+t^3)/(1-t),

D is a finite free C[h]-module of rank four.  Put

    K0 := C(h),
    D_gen := D tensor_(C[h]) K0,
    A_gen := R_res tensor_(C[h]) K0.

Then

    dim_K0 D_gen = 4,

and the faithful residual action gives an injection

    A_gen -> End_K0(D_gen) ~= M_4(K0).

The standard Schur--Jacobson bound for commutative matrix algebras yields

    dim_K0 A_gen <= floor(4^2/4)+1 = 5.

Thus

    e(R_res) <= 5.

We now exclude equality five without using the cyclic-colon type.
Choose linear coordinates h,z1,z2,z3 on S_1.  After extending C[h] to K0,

    A_gen

is a quotient of

    K0[z1,z2,z3],

so it is generated as a unital K0-algebra by at most three elements.

Assume e(R_res)=5.  Then A_gen is a maximum-dimensional commutative subalgebra
of M_4(K0).  After scalar extension to an algebraic closure, the standard
Jacobson equality characterization for n=4 identifies such a maximum algebra,
up to conjugacy, with

    k*1 direct_sum N,

where

    dim_k N = 4,
    N^2 = 0.

But a unital algebra k*1 direct_sum N with N^2=0 and dim N=4 requires at least
four algebra generators: if three elements lambda_i*1+n_i generate it, every
polynomial in them lies in

    k*1 + span(n_1,n_2,n_3),

which has dimension at most four, not five.

Contradiction.  Hence

    e(R_res) <= 4.

Theorem H01_C5_m3_residual_multiplicity_at_most_four_colon_independent:
  Every H01-C5 m=3 residual ring satisfies

    e(R_res) <= 4.
Qed.

--------------------------------------------------------------------------
3. THE REGULAR RESIDUAL CUT HAS EXACTLY THREE EXHAUSTIVE TYPES
--------------------------------------------------------------------------

Put

    Jbar := (J_res+(h))/(h) subset Sbar.

Because every element of J_res annihilates D, reduction modulo h gives

    Jbar subset Ann_Sbar(E) = (v,w,u^3).

Thus there is a graded surjection

    Sbar/Jbar -> Sbar/(v,w,u^3) ~= C[u]/(u^3),

whose target has length three.  Since h is R_res-regular,

    length_C(Sbar/Jbar) = e(R_res).

Section 2 gives e(R_res)<=4, while the displayed surjection gives e(R_res)>=3.
Therefore

    e(R_res) in {3,4}.

If e(R_res)=3, the surjection is between length-three algebras and hence is an
isomorphism:

    Jbar = (v,w,u^3).

Call this residual type R3.

Now suppose e(R_res)=4.  Put

    K_ann := (v,w,u^3).

Then

    Jbar subset K_ann,
    length_C(K_ann/Jbar)=1.

The quotient K_ann/Jbar is homogeneous of length one, so the homogeneous
maximal ideal kills it.  Hence Jbar is obtained by removing one homogeneous
minimal-generator direction from

    K_ann/(mbar*K_ann),

whose homogeneous generator degrees are

    v,w  in degree one,
    u^3  in degree three.

There are exactly two homogeneous possibilities.

If the missing direction is u^3, then

    Jbar = (v,w,u^4).

Call this R4U.

If the missing direction is linear, change the basis of span(v,w) so the
missing class is represented by v.  Then

    Jbar = (w,u^3,u*v,v^2).

Call this R4S.

Theorem H01_C5_m3_residual_cut_trichotomy_colon_independent:
  Every H01-C5 m=3 residual ring has exactly one of the three regular-cut types

    R3:  (v,w,u^3),
    R4U: (v,w,u^4),
    R4S: (w,u^3,u*v,v^2).

  This trichotomy uses no E0/E1/E2 cyclic-colon hypothesis.
Qed.

--------------------------------------------------------------------------
4. R3 AND R4U ARE IMPOSSIBLE WITHOUT ANY CYCLIC-COLON ASSUMPTION
--------------------------------------------------------------------------

In R3 and R4U the degree-one part of Jbar has dimension two.  Since h is
R_res-regular,

    (J_res:h)=J_res

and the degree-one map

    (J_res)_1 -> (Jbar)_1

is an isomorphism.  Therefore

    Z := (J_res)_1

is a two-dimensional subspace of S_1.

By

    J_res=(Qsat:P),

one has

    Z*P subset Qsat.

Taking degree two and using

    Q_2=(Qsat)_2=W

gives

    P_1*Z subset W.

Both P_1 and Z have dimension two.

First assume Z != P_1.  If their intersection has dimension zero or one, direct
coordinates show

    dim_C(P_1*Z)=4.

Since dim W=4,

    W=P_1*Z,

and because Q is generated by W,

    Q=P*Z.

If P_1 and Z are disjoint, P*Z=P intersect Z is saturated.  If their
intersection has dimension one, choose coordinates

    P=(x,y),
    Z=(x,z).

Then

    P*Z=(x^2,x*y,x*z,y*z)

is extended from C[x,y,z], while multiplication by the fourth variable w is
injective on its quotient.  This directly implies saturation.  Thus in every
distinct-plane case

    Qsat=Q,

so

    T=0,

contradicting

    tau_3=dim_C T_3=1.

It remains to assume

    Z=P_1.

Then

    P_1^2 subset W.

Since dim P_1^2=3 and dim W=4, write

    W=P_1^2 direct_sum C*q

with

    q in P minus P^2.

Thus

    Q=(P^2,q).

Localize at the height-two linear prime P.  In the regular local ring S_P, the
class of q is a nonzero cotangent direction.  Therefore

    length_(S_P)(S_P/Q_P)=2.

Since P is a minimal height-two prime of Q, the multiplicity associativity
formula gives

    e(S/Q) >= 2*e(S/P)=2,

contradicting the standing multiplicity-one value

    e(S/Q)=1.

Hence both R3 and R4U are impossible.

Theorem H01_C5_m3_R3_R4U_excluded_colon_independent:
  No H01-C5 m=3 state of any cyclic-colon type has residual cut R3 or R4U.
Qed.

--------------------------------------------------------------------------
5. R4S IS IMPOSSIBLE WITHOUT ANY CYCLIC-COLON ASSUMPTION
--------------------------------------------------------------------------

Only R4S remains.  In this type

    dim_C (J_res)_1 = 1.

Choose nonzero

    z in (J_res)_1.

Then

    z*P subset Qsat,

so in degree two

    z*P_1 subset W.

Also

    Qsat subset P

implies

    W subset P_1*S_1.

Thus

    z*P_1 subset W subset P_1*S_1.

Because Q is generated by W,

    Q_3=S_1*W.

The multiplication map

    S_1 tensor W -> S_1*W

has source dimension sixteen.  Therefore the C5 value

    sigma=5

is equivalent to

    dim_C(S_1*W)=11.

We show instead that every height-two configuration satisfying the quadratic
sandwich has cubic shadow dimension at least twelve.

CASE 1: z notin P_1.

Then

    (z*S_1) intersect (P_1*S_1)=z*P_1,

so W modulo z has dimension two.  The subspace

    S_1*(z*P_1)=z*(P_1*S_1)

has dimension seven.  In the three-variable quotient S/(z), two independent
quadrics have linear shadow dimension at least five.  Therefore

    dim_C(S_1*W) >= 7+5 = 12.

CASE 2: z in P_1.

Put

    r := dim_C(W intersect z*S_1).

Since z*P_1 is contained in this intersection,

    r in {2,3,4}.

If r=2, the kernel shadow contributes seven dimensions and the two-dimensional
image modulo z is y times two independent linear forms in three variables,
whose shadow has dimension five.  Hence

    dim_C(S_1*W)>=12.

If r=3, write

    W intersect z*S_1=z*L

with dim L=3.  Then

    dim_C S_1*(zL)=9,

while the one-dimensional nonzero image of W modulo z contributes three cubic
dimensions.  Hence again

    dim_C(S_1*W)>=12.

If r=4, then

    W=z*S_1,

so

    Q=z*(x1,x2,x3,x4)

has height one, contradicting ht(Q)=2.

Every height-two R4S case therefore has

    dim_C(S_1*W)>=12,

so

    sigma<=4,

contrary to the standing C5 value sigma=5.

Theorem H01_C5_m3_R4S_excluded_colon_independent:
  No H01-C5 m=3 state of any cyclic-colon type has residual cut R4S.
Qed.

--------------------------------------------------------------------------
6. H01-C5 m=3 IS EMPTY
--------------------------------------------------------------------------

Section 3 gives an exhaustive residual trichotomy

    R3, R4U, R4S.

Section 4 excludes R3 and R4U, and Section 5 excludes R4S.  These arguments use
only the common H01-C5 m=3 residual data and not the cyclic-colon embedding
dimension.

Therefore there is no H01-C5 m=3 state at all.

In particular the E2 branch is excluded without any further split of

    dim_C C[u,v]/I |_2.

The preceding E2 theorem forcing I_2 != 0 remains a valid conditional
consequence inside E2, but the present residual contradiction shows that no E2
state satisfying the full H01-C5 m=3 hypotheses survives.

Theorem q4_H01_C5_m3_residual_scope_promoted:
  The residual trichotomy and residual exclusions apply uniformly to E0, E1,
  and E2.
Qed.

Theorem q4_H01_C5_m3_closed:
  The H01-C5 m=3 state is empty.
Qed.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_residual_scope_promoted.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.

DEPENDENCY_AUDIT:
  The promoted residual argument uses

    D=P/Qsat,
    Hilb_D=(2*t+t^2+t^3)/(1-t),
    J_res=(Qsat:P)=Ann(D),
    the exact m=3 regular Artinian reduction of D,
    Qsat subset P,
    Q_2=(Qsat)_2,
    dim Q_2=4,
    tau_3=1,
    sigma=5,
    ht(Q)=2,
    e(S/Q)=1,

  together with the standard Schur--Jacobson dimension bound and its n=4
  maximum-dimension equality characterization.

  It does not use the E0/E1 presentation of S/(Q:gamma), the length of T in
  E0/E1, the E0/E1 final-form action, or the E0/E1 tangent carrier.

IMPORTANT_NONCONCLUSION:
  This file does NOT itself combine the already-established H01-C5 m>=4 closure
  with the new m=3 closure into a separate global C5 theorem.
  It does NOT close H01-C4.
  It does NOT close all H01.
  It does NOT close every q=4 height-two branch.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Combine the already-established H01-C5 m>=4 closure with this m=3 closure and
  verify that the C5 chain is exhausted before entering the distinct H01-C4
  branch.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
