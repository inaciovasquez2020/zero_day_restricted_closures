Standalone tangent closure of the noncontained K/J incidence inside the r-in-P
half of the LK3-C2 carrier in the saturated H01 minimal-chain rank-two endpoint
of the homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_final_cut_tangent_reduction.v

  and retain

    S := C[x1,x2,x3,x4],
    Q=Qsat subset P,
    B:=S/Q,
    D:=P/Q,

with the exact r-in-P filtration

    0 -> S/K(-1) -> D -> S/J(-1) -> 0,

where

    K=(a,b,F)

is a saturated complete intersection of type (1,1,2),

    J=(r,u,v)

is a height-three linear prime, and

    K*J*D=0.

Let the final homogeneous equations be

    f,g in S,
    d:=deg(f)>=3,
    e:=deg(g)>=3,
    M:=max(d,e),

and put

    I:=Q+(f,g),
    A:=S/I=B/(f,g),
    N:=length_C(A)>=32.

Retain the established cut invariants

    L_K:=length_C S/(K,f,g),
    L_J:=length_C S/(J,f,g),

with

    L_K<=2*M,
    L_J<=M,
    d*e>=3*M.

This file enters only the incidence subcase

    K not subset J.

It performs one bounded task: classify the restriction of the (1,1,2)
complete intersection K to the one-variable quotient S/J, compute the finite
Tor defect between K and J, use it to replace the coarse three-generator
product bound by a sum-plus-constant bound, and close the tangent gate in this
noncontained incidence for every final degree pair d,e>=3.

The contained incidence K subset J is not treated.
No r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EXACT K/J INCIDENCE TYPES WHEN K IS NOT CONTAINED IN J
--------------------------------------------------------------------------

Put

    R_J:=S/J ~= C[t].

The images of the linear generators a,b are each either zero or scalar
multiples of t, while the image of F is either zero or a scalar multiple of
t^2.

Because K is not contained in J, not all three images vanish. There are exactly
two incidence types.

TYPE L (linear incidence):
  At least one of a,b has nonzero image in R_J.

  After a GL_2 change among a,b, scale so that

    abar=t,
    bbar=0.

  Write Fbar=c*t^2. Choose a linear form ell in S whose image in R_J is c*t and
  replace F by

    F':=F-ell*a.

  This does not change K, and now the restrictions of a,b,F' are

    (t,0,0).

  Hence

    (K+J)/J=(t),
    S/(K+J) ~= C,
    h:=length_C S/(K+J)=1.

TYPE Q (quadratic incidence):
  Both a,b belong to J, but F does not.

  After scaling F, the restrictions are

    (0,0,t^2).

  Hence

    (K+J)/J=(t^2),
    S/(K+J) ~= C[t]/(t^2),
    h:=length_C S/(K+J)=2.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_incidence_classification:
  If K is not contained in J, then exactly one of TYPE L or TYPE Q occurs and

    h=length_C S/(K+J) in {1,2}.
Qed.

--------------------------------------------------------------------------
2. THE TOR DEFECT HAS LENGTH TWO OR FOUR
--------------------------------------------------------------------------

Since K=(a,b,F) is a complete intersection of degrees (1,1,2), its Koszul
complex is a free resolution of S/K. Tensor this resolution with

    R_J=S/J ~= C[t].

The standard ideal-intersection identity gives

    Tor_1^S(S/K,S/J) ~= (K intersect J)/(K*J).

Put

    G:=(K intersect J)/(K*J).

TYPE L:
  The restricted Koszul sequence is (t,0,0). Since t is regular on C[t], the
  first homology is contributed exactly by the two zero generators. Therefore

    G ~= C(-1) direct_sum C(-2)

  up to the harmless choice of normalized shifts, and in particular

    length_C(G)=2.

  Moreover the homogeneous maximal ideal annihilates G.

TYPE Q:
  The restricted Koszul sequence is (0,0,t^2). Since t^2 is regular on C[t],
  the first homology is contributed by the two zero linear generators:

    G ~= (C[t]/(t^2))(-1) direct_sum (C[t]/(t^2))(-1),

  and hence

    length_C(G)=4.

  In particular J+(t^2) annihilates G.

Since d,e>=3, the final forms f,g annihilate G in both types.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_Tor_defect:
  For K not subset J,

    lambda:=length_C((K intersect J)/(K*J))

  equals 2 in TYPE L and 4 in TYPE Q. In either type f*G=g*G=0.
Qed.

--------------------------------------------------------------------------
3. THE UNION CUT HAS LENGTH AT MOST L_K+L_J+h
--------------------------------------------------------------------------

Set

    R_union:=S/(K intersect J),
    E_0:=S/(K+J).

There is the standard exact sequence

    0 -> R_union
      -> S/K direct_sum S/J
      -> E_0
      -> 0.

In TYPE L, E_0=C; in TYPE Q, E_0=C[t]/(t^2). Thus h=length(E_0) is 1 or 2.
Because d,e>=3, both f and g annihilate E_0. Therefore the two-element Koszul
complex on E_0 has zero differentials and

    length_C H_0(f,g;E_0)=h,
    length_C H_1(f,g;E_0)=2*h.

Apply K(f,g;-) to the displayed exact sequence. The relevant segment is

    H_1(f,g;S/K direct_sum S/J)
      -> H_1(f,g;E_0)
      -> H_0(f,g;R_union)
      -> H_0(f,g;S/K direct_sum S/J)
      -> H_0(f,g;E_0)
      -> 0.

The last map is surjective by exactness. Hence its kernel has length

    L_K+L_J-h.

The image entering H_0(f,g;R_union) from H_1(f,g;E_0) has length at most 2h.
Consequently

    length_C H_0(f,g;R_union)
      <= (L_K+L_J-h)+2h
      = L_K+L_J+h.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_union_cut_bound:
  One has

    length_C S/(K intersect J,f,g) <= L_K+L_J+h.
Qed.

--------------------------------------------------------------------------
4. THE PRODUCT CUT HAS ONLY A CONSTANT EXTRA DEFECT
--------------------------------------------------------------------------

There is an exact sequence

    0 -> G
      -> S/(K*J)
      -> S/(K intersect J)
      -> 0.

Since f and g annihilate G, applying H_0(f,g;-) gives

    length_C S/(K*J,f,g)
      <= length_C(G)
         + length_C S/(K intersect J,f,g).

Therefore:

TYPE L:
    h=1,
    lambda=2,

so

    length_C S/(K*J,f,g) <= L_K+L_J+3.

TYPE Q:
    h=2,
    lambda=4,

so

    length_C S/(K*J,f,g) <= L_K+L_J+6.

Uniformly,

    length_C S/(K*J,f,g) <= L_K+L_J+6.

Now pass to A. The product ideal in A is the image K_A*J_A, and

    A/(K_A*J_A)
      ~= S/(Q+K*J,f,g).

Adding Q can only decrease length. Thus, writing

    C_A:=length_C A/(K_A*J_A),

one has

    C_A<=L_K+L_J+6.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_product_cut_bound:
  If K not subset J, then

    length_C A/(K_A*J_A) <= L_K+L_J+6.
Qed.

This is the required replacement for the previous coarse bound C_KJ<=5*M.

--------------------------------------------------------------------------
5. THE CONNECTING DEFECT IN THE D-CUT IS AT MOST TWO
--------------------------------------------------------------------------

Apply K(f,g;-) to

    0 -> S/K(-1) -> D -> S/J(-1) -> 0.

Let delta be the length of the image of the connecting map

    H_1(f,g;S/J(-1)) -> S/(K,f,g)(-1).

The H_0 tail gives the exact length identity

    L_D=L_K+L_J-delta.

On S/J=C[t], the restrictions of f,g generate (t^L_J), and the first Koszul
homology is cyclic of length L_J, isomorphic up to shift to

    C[t]/(t^L_J).

Hence the connecting image is cyclic. It is killed by J because its source is,
and it is killed by K because its target is an S/K-module. Therefore K+J
annihilates the connecting image.

Thus the image is a cyclic quotient module over S/(K+J), so

    delta<=h<=2.

Consequently

    L_D>=L_K+L_J-2.

Retaining the established exact identity

    N=d*e+L_D,

one gets

    N>=d*e+L_K+L_J-2.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_residual_cut_floor:
  If K not subset J, then

    N>=d*e+L_K+L_J-2.
Qed.

--------------------------------------------------------------------------
6. UNIFORM TANGENT EXCESS
--------------------------------------------------------------------------

Retain from the preceding file the product-annihilator theorem

    K_A*J_A subset Ann_A H_1(f,g;B).

The standard two-copy Koszul-annihilator carrier therefore gives

    t(A):=dim_C Hom_S(I,A)
      >=2*dim_C(K_A*J_A)
      =2*(N-C_A).

Against the necessary order-13 gate

    t(A)<=N-20,

we obtain

    t(A)-(N-20)
      >= N-2*C_A+20.

Use

    N>=d*e+L_K+L_J-2

and

    C_A<=L_K+L_J+6.

Then

    t(A)-(N-20)
      >= d*e+L_K+L_J-2
         -2*(L_K+L_J+6)+20
      = d*e-(L_K+L_J)+6.

The previous cut bounds give

    L_K+L_J<=2*M+M=3*M.

Since min(d,e)>=3,

    d*e>=3*M.

Therefore

    d*e-(L_K+L_J)+6>=6.

Hence

    t(A)>N-20.

Theorem H01_m2_R2_LK3_C2_r_in_P_noncontained_tangent_closed:
  Every r-in-P LK3-C2 endpoint satisfying

    K not subset J

  violates the necessary order-13 tangent gate for every homogeneous final
  degree pair d,e>=3.
Qed.

In particular there is no remaining M>=6 obstruction in the noncontained
incidence.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_incidence_two_types.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_Tor_defect_len_2_or_4.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_product_cut_sum_plus_6.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_residual_connecting_defect_at_most_2.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_all_degrees_tangent_closed.

CURRENT_R_IN_P_STATUS:
  The previous degree-bound closure max(d,e)<=5 is subsumed on the noncontained
  incidence by the all-degree theorem above.

  The only r-in-P K/J incidence not treated here is

    K subset J.

IMPORTANT_NONCONCLUSION:
  This file does NOT close the contained incidence K subset J.
  It does NOT close the full r-in-P carrier.
  It does NOT close LK3-C2 or R2-LK3.
  It does NOT treat the r-not-in-P carrier.
  It does NOT treat LK3-C3, R2-LK2, or R2-QK.
  It does NOT treat H01-M2-R1.
  It does NOT close H01.
  It does NOT enter q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_mge3_closed.
  H01_m2_tau3_two_empty.
  H01_m2_R2_exact_Betti_table.
  H01_m2_R2_determinantal_factorization.
  H01_m2_R2_LK3_coefficient_rank_one_empty.
  H01_m2_R2_LK3_C2_r_in_P_colon_filtration.
  H01_m2_R2_LK3_C2_r_in_P_final_cut_reduced.
  H01_m2_R2_LK3_C2_r_in_P_noncontained_incidence_closed_all_degrees.
  not H01_m2_R2_LK3_C2_r_in_P_contained_incidence_closed.
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
  Stay only in the r-in-P LK3-C2 carrier and enter the sole remaining incidence

    K subset J,

  where

    K=(a,b,F)

  is the (1,1,2) complete intersection and

    J=(r,u,v)

  is the height-three linear prime. Classify the resulting length-two K-scheme
  supported through the J-point strongly enough to obtain the final-pair product
  cut bound. Do not enter any other carrier before resolving this contained
  incidence.

NEXT_ACTIONS:
  1. Classify the contained incidence K subset J into reduced-point and double-point forms.
