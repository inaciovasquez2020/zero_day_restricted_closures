Standalone final-cut/tangent reduction of the r-in-P half of the LK3-C2 carrier
in the saturated H01 minimal-chain rank-two endpoint of the homogeneous q=4,
height-two, multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_colon_filtration.v

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

The necessary order-13 tangent gate is

    t(A):=dim_C Hom_S(I,A) <= N-20.

This file performs one bounded task only: derive the repository-native cut
lengths of the K/J filtration, propagate the product annihilator to the first
Koszul homology, and obtain the exact remaining tangent criterion.  It does not
claim that the criterion holds for every degree pair.

No r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE LINE QUOTIENT IS REGULAR AND THE CORE H1 IS RESIDUAL H1
--------------------------------------------------------------------------

Put

    Rline:=S/P ~= C[s,t].

Because A is Artinian, the images f_R,g_R form an m-primary parameter pair on
Rline.  Hence they form a regular sequence and

    H_2(f,g;Rline)=0,
    H_1(f,g;Rline)=0,
    length_C Rline/(f_R,g_R)=d*e.

Apply the two-element Koszul complex to

    0 -> D -> B -> Rline -> 0.

Since Q=Qsat in H01-M2-R2, there is no saturation-torsion layer here.  The
outside Koszul groups vanish, so

    H_1(f,g;B) ~= H_1(f,g;D).

Moreover, putting

    L_D:=length_C D/(f,g)D,

one has the exact cut-length identity

    N=d*e+L_D.

Theorem H01_m2_R2_LK3_C2_r_in_P_core_cut_identity:
  In the standing final-pair setting,

    H_1(f,g;B) ~= H_1(f,g;D),
    N=d*e+L_D.
Qed.

--------------------------------------------------------------------------
2. THE LINEAR-PRIME CUT LENGTH
--------------------------------------------------------------------------

Define

    L_J:=length_C S/(J,f,g).

This is finite because Q subset J and A is Artinian.  Since

    S/J ~= C[t],

the nonzero restrictions of f,g are scalar multiples of t^d,t^e.  At least one
restriction is nonzero, and their ideal is

    (t^L_J).

Consequently

    3<=L_J<=M.

Also, since min(d,e)>=3,

    d*e>=3*M>=3*L_J.

Theorem H01_m2_R2_LK3_C2_r_in_P_J_cut_bound:
  The exact J-cut satisfies

    3<=L_J<=M,
    d*e>=3*L_J.
Qed.

--------------------------------------------------------------------------
3. THE (1,1,2) COLON CUT HAS LENGTH AT MOST 2M
--------------------------------------------------------------------------

Define

    L_K:=length_C S/(K,f,g).

Again this is finite because Q subset K and A is Artinian.

Modulo the two independent linear generators a,b,

    S/K ~= C[x,y]/(Fbar),

where Fbar is a nonzero binary quadratic.  Over C there are exactly two cases up
to linear coordinates.

REDUCED CASE:

    Fbar=x*y

with two distinct linear factors.  The ring is the equal-constant fiber product
of its two polynomial branches.  In every positive degree its graded piece has
dimension two, one coordinate on each branch.  Finite colength of (f,g) forces
each branch to be hit by at least one restriction.  The repaired degreewise
fiber-product argument already used in the H00 residual cut then gives

    L_K<=2*M.

DOUBLE-LINE CASE:

    Fbar=x^2.

If both restrictions of f,g were multiples of x, the quotient would still map
onto C[y] and would have infinite length.  Hence at least one restriction, say
h, is not in the unique associated prime (x).  Thus h is a homogeneous
nonzerodivisor on C[x,y]/(x^2).  If deg(h)=m<=M, then

    length_C (S/K)/(h)=e(S/K)*m=2*m<=2*M.

Quotienting further by the other final equation can only decrease length, so
again

    L_K<=2*M.

Therefore in both cases

    L_K<=2*M.

Since d*e>=3*M, one also has

    2*d*e>=3*L_K.

Theorem H01_m2_R2_LK3_C2_r_in_P_K_cut_bound:
  The multiplicity-two colon cut satisfies

    L_K<=2*M,
    2*d*e>=3*L_K.
Qed.

--------------------------------------------------------------------------
4. THE RESIDUAL CUT DOMINATES BOTH FILTRATION CUTS
--------------------------------------------------------------------------

Apply K(f,g;-) to

    0 -> S/K(-1) -> D -> S/J(-1) -> 0.

The H_0 tail gives

    H_1(f,g;S/J(-1))
      -> S/(K,f,g)(-1)
      -> D/(f,g)D
      -> S/(J,f,g)(-1)
      -> 0.

On the one-variable module S/J(-1), the first Koszul homology has the same
length as the quotient:

    length_C H_1(f,g;S/J(-1))=L_J.

Hence the kernel of the K-cut contribution has length at most L_J.  Therefore

    L_D
      >= L_J + max(0,L_K-L_J)
      = max(L_K,L_J).

Corollary H01_m2_R2_LK3_C2_r_in_P_final_length_floor:
  One has

    N=d*e+L_D
     >=d*e+max(L_K,L_J).
Qed.

--------------------------------------------------------------------------
5. KJ ANNIHILATES THE FULL FIRST KOSZUL HOMOLOGY
--------------------------------------------------------------------------

Put

    H:=H_1(f,g;B) ~= H_1(f,g;D).

Let

    U:=image(H_1(f,g;S/K(-1)) -> H_1(f,g;D)).

Because K annihilates S/K(-1), it annihilates U.

Exactness identifies H_1(f,g;D)/U with a submodule of
H_1(f,g;S/J(-1)).  Since J annihilates S/J(-1), J annihilates that quotient.
Thus

    K*J*H=0.

Let K_A,J_A be the images in A and put

    E:=Ann_A(H).

Then

    K_A*J_A subset E.

Theorem H01_m2_R2_LK3_C2_r_in_P_KJ_annihilates_full_H1:
  The product carrier K_A*J_A lies in the A-annihilator of the full first
  Koszul homology H_1(f,g;B).
Qed.

--------------------------------------------------------------------------
6. SYMMETRIC THREE-GENERATOR PRODUCT-CARRIER BOUND
--------------------------------------------------------------------------

Because

    A/K_A ~= S/(K,f,g),
    A/J_A ~= S/(J,f,g),

one has

    length_C(A/K_A)=L_K,
    length_C(A/J_A)=L_J.

The ideal J_A is generated by at most three elements.  Therefore

    length_C J_A/(K_A*J_A)<=3*L_K,

and the exact sequence

    0 -> J_A/(K_A*J_A)
      -> A/(K_A*J_A)
      -> A/J_A
      -> 0

gives

    length_C A/(K_A*J_A)<=L_J+3*L_K.

Symmetrically, K_A is also generated by at most three elements, so

    length_C A/(K_A*J_A)<=L_K+3*L_J.

Define

    C_KJ:=min(L_J+3*L_K, L_K+3*L_J).

Then

    length_C A/(K_A*J_A)<=C_KJ,
    dim_C(K_A*J_A)>=N-C_KJ.

Using L_K<=2*M and L_J<=M gives the uniform coarse bound

    C_KJ<=5*M.

Theorem H01_m2_R2_LK3_C2_r_in_P_product_carrier_codimension:
  One has

    dim_C(K_A*J_A)>=N-C_KJ>=N-5*M.
Qed.

--------------------------------------------------------------------------
7. TWO-COPY TANGENT CARRIER AND EXACT REMAINING CRITERION
--------------------------------------------------------------------------

The standard two-cut annihilator carrier applied to

    H=H_1(f,g;B),
    E=Ann_A(H)

gives a natural injection

    E direct_sum E -> Hom_B((f,g)B,A),

and the latter injects into Hom_S(I,A).  Since K_A*J_A subset E,

    t(A)>=2*dim_C(K_A*J_A)
        >=2*N-2*C_KJ.

In particular the coarse bound is

    t(A)>=2*N-10*M.

Therefore the order-13 tangent gate fails whenever

    C_KJ < (N+20)/2.

A weaker but convenient sufficient condition is

    N+20>10*M.

Using the standing N>=32, this criterion automatically holds whenever

    M<=5.

Theorem H01_m2_R2_LK3_C2_r_in_P_tangent_reduction:
  In the r-in-P carrier,

    t(A)>=2*N-2*C_KJ,

  where

    C_KJ=min(L_J+3*L_K, L_K+3*L_J),
    L_J<=M,
    L_K<=2*M.

  Hence this carrier is tangent-excluded whenever

    C_KJ < (N+20)/2.

  In particular every final-pair instance with

    max(d,e)<=5

  is tangent-excluded.
Qed.

No claim is made here for every M>=6.

--------------------------------------------------------------------------
8. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_K_cut_bound.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_J_cut_bound.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_residual_cut_floor.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_KJ_full_H1_annihilator.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_tangent_reduction.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_max_degree_le_five_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT close the r-in-P carrier for arbitrary final degrees.
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
  H01_m2_R2_LK3_C2_r_notin_P_CI_carrier.
  H01_m2_R2_LK3_C2_r_in_P_colon_filtration.
  H01_m2_R2_LK3_C2_r_in_P_final_cut_reduced.
  H01_m2_R2_LK3_C2_r_in_P_max_degree_le_five_tangent_closed.
  not H01_m2_R2_LK3_C2_r_in_P_all_degrees_closed.
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
  Stay only in the r-in-P LK3-C2 carrier.  The exact remaining numerical object
  is the product-cut codimension

    C_KJ=min(L_J+3*L_K, L_K+3*L_J).

  Improve the coarse 5*M bound by classifying the incidence between

    K=(a,b,F)

  and

    J=(r,u,v),

  or prove directly that

    C_KJ < (N+20)/2

  for every M>=6.  Do not enter any other carrier before this is resolved.

NEXT_ACTIONS:
  1. Classify the K/J incidence needed to sharpen C_KJ for M>=6.
