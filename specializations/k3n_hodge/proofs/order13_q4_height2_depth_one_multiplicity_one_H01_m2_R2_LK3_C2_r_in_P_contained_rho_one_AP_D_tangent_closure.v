Standalone tangent closure of the AP-D carrier inside the rho_Q=1 contained
P-subset-J leaf of the r-in-P LK3-C2 carrier in the saturated H01 minimal-chain
rank-two endpoint of the homogeneous q=4, height-two, multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_determinantal_alignment.v

  and retain the exact AP-D normal form

    S=C[r,p,c,t],
    P=(r,p),
    Q=(r^2, r*p, p^2+r*c, p*c+r*t),
    B:=S/Q,
    D:=P/Q,
    K=(Q:r)=(r,p,c^2),
    J=(r,p,c).

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

This file performs one bounded task only: close AP-D at that tangent gate for
all admissible final degrees by constructing an explicit annihilator of the
full first Koszul defect and proving that its final-pair cut has exactly the
same length as the residual D-cut.

No AP-R, rho_Q=2, r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3
branch is entered.  No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. AP-D RESIDUAL MODULE IS FREE OF RANK THREE OVER THE SURVIVING LINE
--------------------------------------------------------------------------

Inside D=P/Q the AP-D relations give

    r^2=0,
    r*p=0,
    p^2=-r*c,
    p*c=-r*t.

Also

    c*(p^2+r*c)-p*(p*c+r*t)
      =r*c^2-r*p*t
      =r*c^2,

so

    r*c^2=0.

Hence every element of D is a C[t]-linear combination of

    r,
    p,
    r*c.

These generators have degrees 1,1,2.  Their free C[t]-module Hilbert series is

    (2*z+z^2)/(1-z),

which is exactly the already-established H01 m=2 residual Hilbert series.
Therefore

    D ~= C[t](-1) direct_sum C[t](-1) direct_sum C[t](-2)

as a graded C[t]-module, with basis r,p,r*c.

The transverse multiplication rules are

    p*r=0,
    p*p=-r*c,
    p*(r*c)=0,

    c*r=r*c,
    c*p=-r*t,
    c*(r*c)=0.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_residual_line_free:
  The AP-D residual module D is C[t]-free of rank three with basis

    r,p,r*c.
Qed.

--------------------------------------------------------------------------
2. AN EXPLICIT HEIGHT-THREE IDEAL ANNIHILATES D
--------------------------------------------------------------------------

Put

    H_D:=(r, p^2, p*c, c^2-p*t).

Then H_D annihilates D.

For the generator r of D:

    r*r=r^2 in Q,
    p^2*r=r*(p^2+r*c)-r^2*c in Q,
    p*c*r=r*(p*c+r*t)-r^2*t in Q,
    (c^2-p*t)*r=r*c^2-r*p*t in Q.

For the generator p of D:

    r*p in Q,

    p^2*p=p^3
      =p*(p^2+r*c)-r*(p*c)
      and r*(p*c)=r*(p*c+r*t)-r^2*t,
      hence p^3 in Q,

    p*c*p=p^2*c
      =c*(p^2+r*c)-r*c^2 in Q,

    (c^2-p*t)*p
      =p*c^2-p^2*t
      =c*(p*c+r*t)-t*(p^2+r*c)
      in Q.

Thus H_D*D=0.

Also Q subset H_D:

    r^2,r*p in (r),
    p^2+r*c in (p^2,r),
    p*c+r*t in (p*c,r).

The quotient is

    R_D:=S/H_D
       ~= C[t,p,c]/(p^2,p*c,c^2-p*t).

As a C[t]-module it is free of rank three with basis

    1,c,p.

Indeed c^2=p*t and p^2=p*c=0 reduce every element to that basis, and no
C[t]-relation among 1,c,p is compatible with the Hilbert series

    Hilb(R_D)=(1+2*z)/(1-z).

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_explicit_annihilator:
  H_D=(r,p^2,p*c,c^2-p*t) contains Q, annihilates D, and S/H_D is C[t]-free
  of rank three.
Qed.

--------------------------------------------------------------------------
3. THE FULL CORE KOSZUL H1 IS CONTROLLED BY H_D
--------------------------------------------------------------------------

The exact sequence

    0 -> D -> B -> S/P -> 0

has

    S/P ~= C[c,t].

Because A is Artinian, the images of f,g in S/P form a homogeneous parameter
pair.  Since S/P is a two-dimensional polynomial ring, that pair is regular.
Therefore

    H_2(f,g;S/P)=0,
    H_1(f,g;S/P)=0,
    length_C S/(P,f,g)=d*e.

Applying the two-element Koszul complex to the displayed short exact sequence
gives

    H_1(f,g;B) ~= H_1(f,g;D).

Writing

    L_D:=length_C D/(f,g)D,

its H_0 tail gives

    N=d*e+L_D.

Since H_D annihilates D, it annihilates every Koszul homology module of D.
Thus, if H_{D,A} is the image of H_D in A and

    E:=Ann_A H_1(f,g;B),

then

    H_{D,A} subset E.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_H_annihilates_core_H1:
  One has

    H_{D,A} subset Ann_A H_1(f,g;B)

  and

    N=d*e+L_D.
Qed.

--------------------------------------------------------------------------
4. THE H_D-CUT AND D-CUT HAVE THE SAME LENGTH
--------------------------------------------------------------------------

Put

    C_D:=length_C S/(H_D,f,g).

We prove

    C_D=L_D.

Because Q subset H_D and A is Artinian, at least one of f,g has nonzero
restriction to the reduced support line

    S/J ~= C[t].

Choose one such equation h.  If both restrictions are nonzero, choose h with
the smaller degree.  Put

    nu:=deg(h).

After scaling h, its image in both C[t]-free carriers has the homogeneous form

    hbar=t^(nu-1)*(t+beta*p+gamma*c)

for constants beta,gamma.

Let k be the other final equation, of degree mu.  If its restriction to C[t]
is nonzero then mu>=nu, and subtracting the corresponding scalar multiple

    t^(mu-nu)*h

preserves the ideal (f,g) and kills that restriction.  Hence after a unimodular
homogeneous generator change the second image has the form

    kbar=t^j*(B*p+C*c),

where j=mu-1 and B,C are constants.  The zero second image is allowed.

Now use the C[t]-bases

    R_D:  (1,c,p),
    D:    (r,p,r*c).

For a linear homogeneous factor

    l=a*t+b*p+g*c,

multiplication on R_D is represented by

        [ a*t    0      0   ]
    M_R=[  g    a*t     0   ]
        [  b     g*t   a*t  ],

where c^2=p*t.

Multiplication on D is represented by

        [ a*t   -g*t    0   ]
    M_D=[  0     a*t    0   ]
        [  g      -b   a*t  ],

using p*p=-r*c and c*p=-r*t.

The final quotients are therefore presented over the PID C[t] by the two
3-by-6 matrices

    [ t^(nu-1) M_R(1,beta,gamma) |
      t^j      M_R(0,B,C) ]

and

    [ t^(nu-1) M_D(1,beta,gamma) |
      t^j      M_D(0,B,C) ].

A direct maximal-minor calculation gives the same zeroth Fitting ideal in
C[t] for both matrices.  Equivalently, their finite cokernels have equal
length.  More explicitly:

  if B=C=0, both lengths equal

    3*nu;

  if C=0 and B!=0, both lengths equal

    min(3*nu, 2*nu+j);

  if C!=0, both lengths equal

    min(3*nu,
        2*nu+j,
        nu+2*j+1).

Therefore

    C_D=L_D

for every admissible homogeneous final pair.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_equal_cut_lengths:
  For every admissible f,g,

    length_C S/(H_D,f,g)
      =length_C D/(f,g)D
      =L_D.
Qed.

--------------------------------------------------------------------------
5. THE EXPLICIT ANNIHILATOR HAS DIMENSION d*e
--------------------------------------------------------------------------

Since Q subset H_D,

    A/H_{D,A} ~= S/(H_D,f,g).

Hence

    length_C(A/H_{D,A})=C_D=L_D.

Using N=d*e+L_D gives

    dim_C H_{D,A}
      =N-L_D
      =d*e.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_annihilator_dimension:
  H_{D,A} is a d*e-dimensional subspace of

    Ann_A H_1(f,g;B).
Qed.

--------------------------------------------------------------------------
6. TWO COPIES GIVE THE DIRECT TANGENT CARRIER
--------------------------------------------------------------------------

Put

    L:=(f,g)B.

As in the already-established rho_Q=0, double-line, and Type-B tangent
carriers, if

    E=Ann_A H_1(f,g;B),

then coordinate reduction on the syzygy quotient gives a natural injection

    E direct_sum E -> Hom_B(L,A).

Since H_{D,A} subset E,

    H_{D,A} direct_sum H_{D,A} -> Hom_B(L,A)

is injective.  Maps I->A vanishing on Q identify with B-linear maps L->A, so

    Hom_B(L,A) -> Hom_S(I,A)

is injective as well.  Consequently

    t(A)
      >=2*dim_C H_{D,A}
      =2*d*e.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_tangent_lower_bound:
  Every AP-D final pair satisfies

    t(A)>=2*d*e.
Qed.

--------------------------------------------------------------------------
7. THE AP-D TANGENT LOWER BOUND EXCEEDS THE ORDER-13 GATE
--------------------------------------------------------------------------

Retain h of degree nu from Section 4.  Multiplication by h on D has determinant

    t^(3*nu)

up to a nonzero scalar in the displayed C[t]-basis, so h is D-regular and

    length_C D/hD=3*nu.

Therefore

    L_D<=3*nu.

The other final equation has degree at least three, so

    d*e>=3*nu.

Hence

    L_D<=d*e,

and therefore

    N=d*e+L_D<=2*d*e.

Combining with the tangent carrier gives

    t(A)>=2*d*e>=N.

In particular

    t(A)-(N-20)>=20>0.

Thus the necessary order-13 tangent inequality

    t(A)<=N-20

fails for every admissible final pair in AP-D.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_fails_order13_gate:
  Every AP-D instance is tangent-excluded.
Qed.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_closed:
  The AP-D leaf is CLOSED at the necessary order-13 tangent gate.
Qed.

--------------------------------------------------------------------------
8. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  AP_D_explicit_annihilator_H_D.
  AP_D_H_cut_equals_residual_cut.
  AP_D_tangent_lower_bound_t_ge_2de.
  AP_D_tangent_excluded_all_final_degrees.

CLOSED:
  contained rho_Q=0 leaf.
  contained rho_Q=1 AP-D leaf.

REMAINING rho_Q=1 LEAF:
  AP-R only:

    K=(r,p,c*t),
    Q=(r^2,r*p,p^2+r*t,p*c).

IMPORTANT_NONCONCLUSION:
  This file does NOT close AP-R.
  It does NOT close rho_Q=1 completely.
  It does NOT enter rho_Q=2.
  It does NOT close the contained r-in-P carrier.
  It does NOT close LK3-C2 or R2-LK3.
  It does NOT close H01-M2-R2 or H01.
  It does NOT enter q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_closed.
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
  Stay only in AP-R:

    Q=(r^2,r*p,p^2+r*t,p*c),
    K=(r,p,c*t).

  Compute an explicit annihilator of D=P/Q and compare its final-pair cut with
  the residual D-cut.  Close AP-R only if a strict all-degree tangent inequality
  follows.

NEXT_ACTIONS:
  1. Re-read the exact terminal run for this commit.
