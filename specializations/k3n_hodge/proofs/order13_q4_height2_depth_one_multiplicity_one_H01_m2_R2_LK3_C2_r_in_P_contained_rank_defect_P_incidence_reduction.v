Standalone P/J-incidence reduction for the contained rank-defect leaf inside the
r-in-P half of the LK3-C2 carrier in the saturated H01 minimal-chain rank-two
endpoint of the homogeneous q=4, height-two, multiplicity-one, depth-one
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rank_defect_reduction.v

  and retain

    S := C[x1,x2,x3,x4],
    Q=Qsat subset P,
    P=(r,p),
    K=(Q:r)=(a,b,F) subset J=(r,u,v),

with

    q1=r*a,
    q2=r*b,
    q3 mod (r) = pbar*ubar,
    q4 mod (r) = pbar*vbar,

where ubar,vbar are independent in

    R:=S/(r).

Retain also

    dim_C(Q_2 intersect r*S_1)=2

and the contained-incidence rank formula

    rho_Q = 4 - dim_C(Q_2 intersect (J*K)_2).

This file performs one bounded task: prove that any extra quadratic in

    (Q_2 intersect (J*K)_2) / span_C(r*a,r*b)

forces

    P subset J.

Equivalently, if P is not contained in J, then rho_Q=2 automatically.

No classification of the remaining P-subset-J leaf is claimed.
No reduced-point or double-point leaf is closed.
No all-degree tangent closure is claimed.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. DEGREE-TWO PART OF J*K MODULO r
--------------------------------------------------------------------------

Because K subset J and

    K_1=span_C{a,b},

the degree-two part of the product ideal J*K is generated only by products of
linear forms:

    (J*K)_2 = J_1*K_1.

Pass modulo r. Put

    Jbar_1:=J_1/span_C{r}=span_C{ubar,vbar}

inside R_1. Since K subset J,

    Kbar_1 subset Jbar_1.

Therefore

    ((J*K)+(r))/(r) |_degree2
      = Jbar_1*Kbar_1
      subset Sym^2(Jbar_1).

The quadratic generator F of K does not contribute to degree two of J*K,
because every generator of J has positive degree.

--------------------------------------------------------------------------
2. IF p IS NOT IN J, THE pbar*Jbar SUMMAND IS DISJOINT
--------------------------------------------------------------------------

Assume

    p notin J.

Since r belongs to J, this is equivalent to

    pbar notin Jbar_1.

Because R_1 has dimension three and Jbar_1 has dimension two, one has a direct
sum

    R_1 = Jbar_1 direct_sum C*pbar.

Consequently the symmetric square decomposes as

    Sym^2(R_1)
      = Sym^2(Jbar_1)
        direct_sum pbar*Jbar_1
        direct_sum C*pbar^2.

In particular

    Sym^2(Jbar_1) intersect pbar*Jbar_1 = 0.

Now let

    w=lambda_3*ubar + lambda_4*vbar

with lambda_3,lambda_4 in C not both zero. Since ubar,vbar are independent,

    w != 0.

The corresponding nonzero combination of the two non-r-multiple quadrics has
reduction

    lambda_3*q3bar + lambda_4*q4bar
      = pbar*w,

which lies in the nonzero summand

    pbar*Jbar_1.

Therefore it cannot lie in the degree-two reduction of J*K, which is contained
in Sym^2(Jbar_1).

Thus no nonzero constant combination of q3 and q4 can belong to (J*K)_2 modulo
span_C(q1,q2).

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_P_notin_J_rank_two:
  If

    P=(r,p) is not contained in J,

  then

    Q_2 intersect (J*K)_2 = span_C(r*a,r*b)

  and hence

    rho_Q=2.
Qed.

--------------------------------------------------------------------------
3. EVERY RANK DEFECT FORCES P subset J
--------------------------------------------------------------------------

Suppose rho_Q<=1. By the preceding rank-defect intersection formula, there is a
quadratic

    q in Q_2 intersect (J*K)_2

independent of q1,q2. Subtracting its q1,q2 component gives a nonzero constant
combination

    q'=lambda_3*q3 + lambda_4*q4

which still belongs to (J*K)_2.

If P were not contained in J, Section 2 would make this impossible. Therefore

    P subset J.

Since P=(r,p) and r already belongs to J, this is equivalently

    p in J.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rank_defect_forces_P_subset_J:
  One has

    rho_Q<=1  =>  P subset J.
Qed.

This implication applies uniformly to both contained geometric types

    K=(a,b,c*ell)

and

    K=(a,b,c^2).

The reduced-point/double-point split therefore becomes relevant only after the
additional incidence P subset J has been imposed.

--------------------------------------------------------------------------
4. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  P not_subset J => rho_Q=2.
  rho_Q<=1 => P subset J.

EXACT_REMAINING_RANK_DEFECT_LEAF:
  P subset J,
  together with either the reduced-point or double-point contained K type.

NOT_PROVED:
  rho_Q=2 universally.
  rho_Q=1 impossible when P subset J.
  rho_Q=0 impossible when P subset J.
  contained r-in-P all-degree tangent closure.
  H01_m2_R2_LK3_C2 closure.
  H01 closure.
  q=4 height-two full closure.
  homogeneous q<=3 closure.
  Oblivion Closure.

BOUNDARY:
  not H01_m2_R2_LK3_C2_r_in_P_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in the remaining incidence

    P subset J.

  Normalize P=(r,p) inside J=(r,u,v), then classify the extra quadratic defect
  separately for

    K=(a,b,c*ell)

  and

    K=(a,b,c^2).

  Determine whether rho_Q=0 or rho_Q=1 survives the exact H01 m=2 Hilbert and
  saturation constraints.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
