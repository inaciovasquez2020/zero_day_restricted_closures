Standalone exclusion of the P-subset-J rho_Q=2 leaf inside the contained r-in-P LK3-C2 carrier in the saturated H01 minimal-chain rank-two endpoint of the homogeneous q=4, height-two, multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from the established contained-incidence classification and retain

    S=C[x1,x2,x3,x4],
    Q=Qsat subset P=(r,p),
    K=(Q:r)=(a,b,F) subset J,
    A:=K_1=span_C{a,b},
    dim_C Q_2=4,
    dim_C(Q_2 intersect r*S_1)=2,
    sigma=3,
    rho_Q=2.

  Enter only the additional incidence

    P subset J.

  The task is one bounded structural exclusion: show that the rank-two conormal state is incompatible with the exact three-dimensional linear-syzygy space.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. NORMALIZE THE THREE PLANE INCIDENCES
--------------------------------------------------------------------------

Since P and A are two-planes inside the three-space J_1 and P=(r,p), exactly the same three relative positions used in the rho_Q=1 classification occur:

  AP:  A=P;

  AR:  A!=P and r belongs to A;

  ANR: A!=P and r does not belong to A.

After admissible linear changes inside J:

  AP:
    J=(r,p,c), A=P=(r,p).

  AR:
    J=(r,p,c), A=(r,c), P=(r,p).

  ANR:
    J=(r,p,c), A=(p,c), P=(r,p).

--------------------------------------------------------------------------
2. AP CANNOT HAVE rho_Q=2
--------------------------------------------------------------------------

In AP one has K_1=A=P=(r,p). Modulo r, the two non-r-multiple quadrics span

    span_C{p^2,p*c}.

But both p and c belong to J and p belongs to K_1, hence both p^2 and p*c lie in

    (J*K)_2=J_1*K_1.

Therefore the only possible component of q3,q4 outside (J*K)_2 is an r*t term, where t completes J_1 to S_1. That leakage space is one-dimensional. Consequently the two conormal columns have generic rank at most one:

    rho_Q<=1.

Thus AP is incompatible with rho_Q=2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_AP_empty:
  Under P subset J, rho_Q=2 cannot occur with A=P.
Qed.

--------------------------------------------------------------------------
3. ANR CANNOT HAVE rho_Q=2
--------------------------------------------------------------------------

In ANR normalize

    J=(r,p,c),
    A=(p,c),
    K=(p,c,F).

Modulo r, q3,q4 span p^2,p*c, both already lying in J_1*A. Hence rank two would require two independent leakage directions outside (J*K)_2. Since q3,q4 belong to P=(r,p), the only such degree-two leakages are

    r^2,
    r*t.

Thus rho_Q=2 would force the images of q3 and q4 modulo A to span the two-dimensional space

    span_C{r^2,r*t}.

However q3,q4 belong to Q subset K. Modulo A=(p,c), the degree-two part of K is one-dimensional because K is a complete intersection of type (1,1,2):

    K/A ~= (Fbar) subset C[r,t],

with exactly one quadratic generator Fbar.

Hence the images of all quadrics in K_2 modulo A span at most one dimension. They cannot contain two independent classes r^2 and r*t.

Therefore ANR is incompatible with rho_Q=2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_ANR_empty:
  Under P subset J, rho_Q=2 cannot occur with A!=P and r notin A.
Qed.

--------------------------------------------------------------------------
4. AR HAS ONE CANONICAL rho_Q=2 NORMAL FORM
--------------------------------------------------------------------------

The only remaining incidence is AR. Normalize

    J=(r,p,c),
    A=(r,c),
    P=(r,p).

Choose the exact r-multiple generators

    q1=r^2,
    q2=r*c.

Modulo r, q3,q4 span p^2 and p*c. Here p*c lies in J_1*A while p^2 does not. Thus one conormal direction is represented by p^2. To obtain rho_Q=2, an independent r*t leakage must occur on the complementary generator. After generator changes and absorbing J*K terms, one obtains the unique normal form

    Q=(r^2,
       r*c,
       p^2,
       p*c+r*t).

Because Q subset K=(r,c,F), reduction modulo (r,c) shows Fbar is proportional to p^2. Hence

    K=(r,c,p^2),

so the AR rho-two state is necessarily the contained-double type.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_AR_normal_form:
  Every P-subset-J rho_Q=2 carrier is linearly equivalent to

    Q=(r^2,r*c,p^2,p*c+r*t),
    K=(r,c,p^2).
Qed.

--------------------------------------------------------------------------
5. THE CANONICAL AR FORM HAS ONLY TWO LINEAR SYZYGIES
--------------------------------------------------------------------------

Let

    q1=r^2,
    q2=r*c,
    q3=p^2,
    q4=p*c+r*t.

Two independent linear syzygies are

    s1=(-c, r, 0, 0),
    s2=(-t,-p,0,r).

Indeed

    -c*q1+r*q2=0,

and

    -t*q1-p*q2+r*q4=0.

Now solve a general linear syzygy

    L1*q1+L2*q2+L3*q3+L4*q4=0,

where each Li is a linear form in r,p,c,t. Comparing coefficients of the cubic monomials containing p^3, p^2*t, p^2*c, and then the remaining r,p,c,t monomials forces

    L3=0,

and leaves exactly the two-parameter family

    (L1,L2,L3,L4)
      =alpha*(-c,r,0,0)
       +beta*(-t,-p,0,r).

Therefore

    dim_C Syz_1(Q)=2.

But the exact H01-M2-R2 Betti table requires

    sigma=dim_C Syz_1(Q)=3.

This contradiction excludes the canonical AR rho-two form.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_AR_empty:
  The unique AR rho_Q=2 normal form is incompatible with the exact R2 Betti table.
Qed.

--------------------------------------------------------------------------
6. P-subset-J rho_Q=2 IS EMPTY
--------------------------------------------------------------------------

AP is rank at most one.
ANR contradicts the one-dimensional quadratic quotient K_2/A*S_1.
AR reduces to a unique normal form with only two independent linear syzygies, contradicting sigma=3.

Hence no P-subset-J contained rho_Q=2 carrier survives.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_two_P_subset_J_empty:
  In the contained K subset J incidence,

    P subset J and rho_Q=2

  is impossible.
Qed.

Combined with the earlier implication

    P not_subset J => rho_Q=2,

and the already-closed rho_Q=0 and rho_Q=1 leaves, the only still-open contained rank state is now

    K subset J,
    P not_subset J,
    rho_Q=2.

IMPORTANT_NONCONCLUSION:
  This file does NOT close that transverse P-not-subset-J rho_Q=2 carrier.
  It does NOT close the full contained incidence.
  It does NOT close the full r-in-P carrier.
  It does NOT enter r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  contained rho_Q=0 closed.
  contained rho_Q=1 closed.
  contained P-subset-J rho_Q=2 empty.
  not contained P-not-subset-J rho_Q=2 closed.
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

MISSING_OBJECT:
  Stay only in the transverse contained carrier

    K subset J,
    P not_subset J,
    rho_Q=2.

  Use p notin J together with the reduced/double K geometry and the exact rank-two conormal quotient to sharpen the product-cut defect for all final degrees.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
