Standalone tangent closure of the canonical rho_Q=0 carrier inside the
P-subset-J contained rank-defect leaf of the r-in-P LK3-C2 carrier in the
saturated H01 minimal-chain rank-two endpoint of the homogeneous q=4,
height-two, multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_normal_form.v

  and retain the exact normal form

    S=C[r,p,c,t],
    P=(r,p),
    Q=(r^2, r*p, p^2+r*c, p*c),
    B:=S/Q,
    D:=P/Q.

Let the final homogeneous equations be

    f,g in S,
    d:=deg(f)>=3,
    e:=deg(g)>=3,

and put

    I:=Q+(f,g),
    A:=S/I=B/(f,g),
    N:=length_C(A)>=32.

The necessary order-13 tangent gate is

    t(A):=dim_C Hom_S(I,A) <= N-20.

This file performs one bounded task: use the explicit rho_Q=0 presentation to
compute a direct annihilator of the full final-pair Koszul defect and close this
single canonical carrier for all admissible final degrees.

No rho_Q=1 or rho_Q=2 leaf is entered.  No r-not-in-P, LK3-C3, R2-LK2,
R2-QK, H01-M2-R1, or q<=3 branch is entered.  No Oblivion Closure promotion is
made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE RESIDUAL MODULE IS A THREE-FOLD FREE LINE MODULE
--------------------------------------------------------------------------

The exact sequence

    0 -> D -> B -> S/P -> 0

has

    S/P ~= C[c,t].

Inside D the normal-form relations give

    r^2=0,
    r*p=0,
    p*c=0,
    p^2=-r*c,
    r*c^2=0.

Consequently every element of D is a C[t]-linear combination of

    r,
    p,
    r*c.

These three elements have degrees 1,1,2.  Their free C[t]-module Hilbert series
is

    (2*z+z^2)/(1-z),

which is exactly the already-proved H01 m=2 residual Hilbert series.  Hence

    D ~= C[t](-1) direct_sum C[t](-1) direct_sum C[t](-2)

as a graded C[t]-module.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_residual_line_free:
  The canonical rho_Q=0 residual module is C[t]-free of rank three, with basis

    r,p,r*c.
Qed.

--------------------------------------------------------------------------
2. AN EXPLICIT HEIGHT-THREE PRIMARY IDEAL ANNIHILATES D
--------------------------------------------------------------------------

Put

    H:=(r, p^2, p*c, c^2).

Then H annihilates D=P/Q.

Indeed:

    r*r=r^2 in Q,
    r*p=r*p in Q;

    p^2*r=r*p^2
      = r*(p^2+r*c)-r^2*c in Q,

    p^2*p=p^3
      = p*(p^2+r*c)-r*(p*c) in Q;

    p*c already belongs to Q, so it annihilates D;

    c^2*r=r*c^2
      = c*(p^2+r*c)-p*(p*c) in Q,

    c^2*p=p*c^2
      = c*(p*c) in Q.

Thus

    H*D=0.

Also Q subset H, because

    r^2,r*p in (r),
    p^2+r*c in (p^2,r),
    p*c in H.

The quotient is

    R_H:=S/H
      ~= C[t,p,c]/(p,c)^2.

As a C[t]-module it is free of rank three with basis

    1,p,c.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_explicit_annihilator:
  The ideal

    H=(r,p^2,p*c,c^2)

  annihilates D, contains Q, and S/H is C[t]-free of rank three.
Qed.

--------------------------------------------------------------------------
3. THE CORE KOSZUL H1 IS THE RESIDUAL KOSZUL H1
--------------------------------------------------------------------------

Since A is Artinian, the images of f,g in

    S/P ~= C[c,t]

form a homogeneous parameter pair.  The polynomial ring S/P is
Cohen--Macaulay of dimension two, so the pair is regular.  Therefore

    H_2(f,g;S/P)=0,
    H_1(f,g;S/P)=0,

and

    length_C S/(P,f,g)=d*e.

Apply the two-element Koszul complex to

    0 -> D -> B -> S/P -> 0.

The positive Koszul homology on S/P vanishes, hence

    H_1(f,g;B) ~= H_1(f,g;D).

Writing

    L_D:=length_C D/(f,g)D,

its H_0 tail also gives the exact sequence

    0 -> D/(f,g)D
      -> A
      -> S/(P,f,g)
      -> 0.

Consequently

    N=d*e+L_D.

Because H annihilates D, it annihilates every Koszul homology module of D.
Under the displayed B-linear isomorphism it therefore annihilates the full core
defect

    D1:=H_1(f,g;B).

Thus, if H_A denotes the image of H in A and

    E:=Ann_A(D1),

then

    H_A subset E.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_H_annihilates_core_H1:
  One has

    H_A subset Ann_A H_1(f,g;B)

  and

    N=d*e+L_D.
Qed.

--------------------------------------------------------------------------
4. THE H-CUT AND THE D-CUT HAVE EXACTLY THE SAME LENGTH
--------------------------------------------------------------------------

Put

    C_H:=length_C S/(H,f,g).

We prove

    C_H=L_D.

Because Q subset H and A is Artinian, at least one of f,g has nonzero
restriction to the reduced line

    S/(r,p,c) ~= C[t].

Choose one such final equation h.  If both restrictions are nonzero, choose h
with the smaller degree.  Put

    nu:=deg(h).

After scaling h, its image in R_H has the unique homogeneous form

    hbar=t^nu + u*t^(nu-1),

where

    u is in span_C{p,c}.

Let k be the other final equation and put mu:=deg(k).  Its image in R_H is

    alpha*t^mu + v*t^(mu-1)

with v in span_C{p,c}.

If alpha is nonzero, then by the choice of h one has mu>=nu.  Replacing k by

    k-alpha*t^(mu-nu)*h

preserves the ideal (f,g) and reduces the second image to

    w*t^(mu-1)

for some w in span_C{p,c}.  If alpha=0, it already has this form.  Thus after a
unimodular homogeneous generator change the final ideal on both R_H and D is
represented by

    hbar=t^nu+u*t^(nu-1),
    kbar=w*t^j,

where j=mu-1.

First consider R_H.  Since (p,c)^2=0, multiplication by hbar on the free
C[t]-basis 1,p,c is triangular with diagonal t^nu.  Hence hbar is a
nonzerodivisor and

    length_C R_H/hbar*R_H=3*nu.

Modulo hbar, the element kbar annihilates the square-zero subspace
span{p,c}; its image ideal is generated by the single vector

    w*t^j.

If w=0 or j>=nu, it contributes no further length loss.  Otherwise its
successive t-multiples

    w*t^j, ..., w*t^(nu-1)

are independent and remove exactly nu-j dimensions.  Hence, with

    delta:=0                      if w=0 or j>=nu,
    delta:=nu-j                   otherwise,

one has

    C_H=3*nu-delta.

Now consider D with C[t]-basis r,p,r*c.  The transverse actions are

    p*r=0,
    p*p=-r*c,
    p*(r*c)=0,

    c*r=r*c,
    c*p=0,
    c*(r*c)=0.

Thus every nonzero w in span_C{p,c} acts on D with rank one and image exactly
C[t]*(r*c).  Multiplication by hbar is again triangular with diagonal t^nu, so

    length_C D/hbar*D=3*nu.

Inside this quotient the C[t]-submodule generated by r*c is exactly

    C[t]/(t^nu)*(r*c).

Therefore the second generator w*t^j removes the same delta dimensions as it
does on R_H.  Consequently

    L_D=3*nu-delta=C_H.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_equal_cut_lengths:
  For every admissible homogeneous final pair,

    length_C S/(H,f,g)
      = length_C D/(f,g)D
      = L_D.
Qed.

--------------------------------------------------------------------------
5. THE EXPLICIT ANNIHILATOR HAS EXACT DIMENSION d*e
--------------------------------------------------------------------------

Since Q subset H,

    A/H_A ~= S/(H,f,g).

Hence the preceding theorem gives

    length_C(A/H_A)=C_H=L_D.

Therefore

    dim_C H_A
      = N-L_D
      = d*e.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_annihilator_dimension:
  The image H_A is a d*e-dimensional subspace of the full Koszul annihilator

    E=Ann_A H_1(f,g;B).
Qed.

--------------------------------------------------------------------------
6. TWO COPIES OF H_A GIVE A DIRECT TANGENT CARRIER
--------------------------------------------------------------------------

Put

    L:=(f,g)B.

Let

    Syz:=Syz_B(f,g).

Then

    D1=H_1(f,g;B)
      = Syz / B*(-g,f).

As in the repository's earlier double-line and Type-B tangent carriers, the
coordinate reductions on Syz factor through D1 because f=g=0 in A.  Therefore
any pair of elements of E=Ann_A(D1) kills every residual syzygy and defines a
B-linear map L->A.  This gives a natural C-linear injection

    E direct_sum E -> Hom_B(L,A).

Since H_A subset E,

    H_A direct_sum H_A -> Hom_B(L,A)

is injective.  Also maps I->A which vanish on Q are exactly B-linear maps
L->A, so

    Hom_B(L,A) -> Hom_S(I,A)

is injective.

Consequently

    t(A)
      >= 2*dim_C H_A
      = 2*d*e.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_tangent_lower_bound:
  The canonical rho_Q=0 carrier satisfies

    t(A)>=2*d*e.
Qed.

--------------------------------------------------------------------------
7. THE LOWER BOUND IS AT LEAST THE TOTAL LENGTH
--------------------------------------------------------------------------

Retain h of degree nu from Section 4.  Since h is one of f,g, the other final
equation has degree at least three.  Therefore

    d*e>=3*nu.

Also D/(f,g)D is a quotient of D/hD, so

    L_D<=3*nu<=d*e.

Using

    N=d*e+L_D,

we obtain

    N<=2*d*e.

Combine this with the tangent carrier:

    t(A)>=2*d*e>=N.

In particular

    t(A)-(N-20)>=20>0.

Therefore the necessary order-13 tangent condition

    t(A)<=N-20

is impossible for every admissible final pair on the canonical rho_Q=0
carrier.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_fails_order13_gate:
  Every canonical contained rho_Q=0 instance is tangent-excluded.
Qed.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_closed:
  The rho_Q=0 leaf of the contained r-in-P LK3-C2 carrier is CLOSED at the
  necessary order-13 tangent gate.
Qed.

--------------------------------------------------------------------------
8. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  canonical_rho_zero_explicit_H_annihilator.
  canonical_rho_zero_H_cut_equals_residual_cut.
  canonical_rho_zero_tangent_lower_bound_t_ge_2de.
  canonical_rho_zero_tangent_excluded_all_final_degrees.

CLOSED:
  contained r-in-P LK3-C2 rho_Q=0 leaf.

NOT_PROVED:
  rho_Q=1 impossible or tangent-closed.
  all rho_Q=2 final degrees tangent-closed.
  contained r-in-P LK3-C2 closure.
  LK3-C2 closure.
  R2-LK3 closure.
  H01-M2-R2 closure.
  H01-M2-R1 closure.
  H01 closure.
  q=4 height-two full closure.
  homogeneous q<=3 closure.
  Oblivion Closure.

BOUNDARY:
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_closed.
  not H01_m2_R2_LK3_C2_r_in_P_closed.
  not H01_m2_R2_LK3_C2_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

MISSING_OBJECT:
  Stay only in the contained P-subset-J incidence and classify rho_Q=1.  Reduce
  the rank-one conormal matrix to its unique nonzero column direction, split the
  reduced-point and double-point K types, and determine whether the surviving
  rank-one carrier is structurally impossible or tangent-excluded for all final
  degrees.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
