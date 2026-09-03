Standalone residual-multiplicity sharpening for the low-embedding-dimension
H01-C5 m=3 colon types E0/E1 in the homogeneous q=4, height-two
multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_residual_cut_high_degree_closure.v

  and retain

    S = C[x1,x2,x3,x4],
    Q subset Qsat,
    D = P/Qsat,
    J_res = Ann_S(D) = (Qsat:P),
    R_res = S/J_res,

  in H01-C5 with

    m = 3,
    sigma = 5,

  and only in the E0/E1 torsion-colon states.

The preceding files establish

    R_res is a one-dimensional Cohen--Macaulay standard graded C-algebra,
    D is faithful over R_res,
    h is a homogeneous degree-one nonzerodivisor on both R_res and D,
    D is free of rank four over C[h],
    e(R_res) <= 5,
    r_res <= 6,
    L_res <= e(R_res)*M,

where

    M = max(d,e),
    s = min(d,e).

They also establish

    N >= M*s + 4*s - 3

and

    t(A) >= 2*N - 2*L_res - 48.

The previous worst-case multiplicity-five estimate closes only s>=10.

This file performs one bounded task only:

  prove that the extremal possibility

    e(R_res)=5

  is incompatible with the fact that R_res is standard graded in four degree-one
  variables with one degree-one parameter h already inverted to the identity in
  the generic fiber.

The result is

    e(R_res) <= 4.

Reinserting this bound into the existing tangent estimate closes every E0/E1
state with

    min(d,e) >= 8.

No claim is made for min(d,e)<=7.
No E2, H01-C4, q<=3, or full order-13 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE GENERIC RESIDUAL ALGEBRA
--------------------------------------------------------------------------

Put

    H := C[h],
    K := Frac(H) = C(h).

Because h is R_res-regular and R_res is one-dimensional Cohen--Macaulay,
R_res is a finite torsion-free H-module and therefore a finite free H-module.
Its H-rank is its multiplicity:

    rank_H(R_res) = e(R_res).

Define the generic residual algebra

    G := R_res tensor_H K.

Then G is a finite-dimensional commutative K-algebra with

    dim_K G = e(R_res).

Since D is faithful over R_res and is H-free, localization preserves
faithfulness.  Therefore

    V := D tensor_H K

is a faithful G-module.

The exact H01 m=3 Artinian numerator has total length four, so

    dim_K V = 4.

Thus G embeds as a commutative K-subalgebra of

    End_K(V) ~= M_4(K).

--------------------------------------------------------------------------
2. THE EXTREMAL SCHUR--JACOBSON CASE
--------------------------------------------------------------------------

Assume for contradiction that

    e(R_res)=5.

Then

    dim_K G = 5.

Extend scalars from K to an algebraic closure Kbar.  Put

    Gbar := G tensor_K Kbar,
    Vbar := V tensor_K Kbar.

Then

    dim_Kbar Gbar = 5,
    dim_Kbar Vbar = 4,

and Gbar acts faithfully and commutatively on Vbar.

The classical Schur--Jacobson theorem gives five as the maximum possible
dimension of a commutative subalgebra of M_4(Kbar).  Its equality case in even
dimension is, after a change of basis, the algebra consisting of the scalar
matrices together with one full 2-by-2 off-diagonal block.

Equivalently there is a decomposition

    Gbar = Kbar*1 direct_sum N

with

    dim_Kbar N = 4,
    N^2 = 0.

Only this square-zero consequence of the equality classification is used below.

--------------------------------------------------------------------------
3. STANDARD GRADING GENERATES THE GENERIC FIBER FROM DEGREE ONE
--------------------------------------------------------------------------

Because R_res is a standard graded quotient of S, it is generated as a
C-algebra by the image of S_1.

After inverting h and taking degree zero, the generic fiber G is generated as a
K-algebra by the degree-zero ratios

    ell/h

with ell in S_1.

After extending scalars, Gbar is therefore generated as a Kbar-algebra by the
image of the four-dimensional vector space

    S_1 tensor_C Kbar.

Let

    phi : S_1 tensor_C Kbar -> Gbar

be the Kbar-linear map

    phi(ell) = ell/h.

The distinguished degree-one form h satisfies

    phi(h)=1.

--------------------------------------------------------------------------
4. THE SQUARE-ZERO EQUALITY ALGEBRA CANNOT BE GENERATED THIS WAY
--------------------------------------------------------------------------

Retain the decomposition

    Gbar = Kbar*1 direct_sum N,
    N^2=0,
    dim N=4.

Let

    pi_N : Gbar -> N

be projection along the scalar summand, and define

    psi := pi_N o phi.

Since

    phi(h)=1,

one has

    psi(h)=0.

The domain S_1 tensor Kbar has dimension four.  Therefore

    rank(psi) <= 3.

Put

    W := image(psi) subset N.

Then

    dim W <= 3.

Every degree-one generator phi(ell) lies in

    Kbar*1 + W.

Because N^2=0, one also has

    W^2=0.

Hence the unital Kbar-subalgebra generated by all degree-one ratios is contained
in

    Kbar*1 direct_sum W.

Therefore its dimension is at most

    1 + dim W <= 4.

But Section 3 says those same degree-one ratios generate all of Gbar, while the
contradiction assumption gives

    dim Gbar = 5.

Contradiction.

Theorem q4_H01_C5_m3_E01_residual_multiplicity_five_impossible:
  The case

    e(R_res)=5

  cannot occur.
Qed.

Corollary q4_H01_C5_m3_E01_residual_multiplicity_at_most_four:
  One has

    e(R_res) <= 4.
Qed.

--------------------------------------------------------------------------
5. IMPROVED RESIDUAL CUT BOUND
--------------------------------------------------------------------------

The preceding residual-cut argument constructs a homogeneous nonzerodivisor of
degree

    M=max(d,e)

inside the ideal (f,g) of R_res.  For a one-dimensional Cohen--Macaulay graded
ring, quotienting by a degree-M homogeneous nonzerodivisor has length

    M*e(R_res).

Since adding the second generator can only decrease length,

    L_res <= M*e(R_res).

Using the new multiplicity bound gives

Theorem H01_C5_m3_E01_improved_residual_cut_bound:
  One has

    L_res <= 4*M.
Qed.

--------------------------------------------------------------------------
6. REINSERT INTO THE TWO-COPY TANGENT ESTIMATE
--------------------------------------------------------------------------

Retain

    r_res <= 6,

so the established product-annihilator carrier gives

    t(A) >= 2*N - 2*L_res - 48.

Using

    L_res <= 4*M

and

    N >= M*s + 4*s - 3,

one gets

    t(A) - (N-20)
      >= N - 2*L_res - 28
      >= (M*s + 4*s - 3) - 8*M - 28
      = M*(s-8) + 4*s - 31.

Thus:

Theorem H01_C5_m3_E01_improved_tangent_gap:
  One has

    t(A) - (N-20)
      >= M*(s-8) + 4*s - 31.
Qed.

--------------------------------------------------------------------------
7. ALL E0/E1 FINAL DEGREE PAIRS WITH s>=8 ARE EXCLUDED
--------------------------------------------------------------------------

Assume

    s=min(d,e) >= 8.

Since M>=s:

  if s=8, then

    M*(s-8)+4*s-31 = 1;

  if s>8, both the M*(s-8) term and the increase in 4*s-31 are nonnegative,
  with strict positive total.

Therefore

    t(A) - (N-20) >= 1 > 0.

Hence

    t(A) > N-20,

contradicting the necessary order-13 tangent gate.

Theorem q4_H01_C5_m3_E01_min_final_degree_ge8_tangent_closed:
  Every H01-C5 m=3 E0/E1 state satisfying

    min(d,e) >= 8

  is excluded by the two-copy tangent carrier.
Qed.

This strictly improves the previous threshold min(d,e)>=10.

--------------------------------------------------------------------------
8. SURVIVING E0/E1 DEGREE RANGE
--------------------------------------------------------------------------

After this step, the only E0/E1 final-degree range not excluded by the present
uniform residual estimates is

    3 <= min(d,e) <= 7.

The same inequality gives for s<=7

    M*(s-8)+4*s-31 < 0

for every M>=s, so the present worst-case combination

    e(R_res)<=4,
    r_res<=6,
    L_res<=4*M

cannot by itself close those remaining small-degree pairs.

This is a limitation of the uniform estimate only.  It is not a realizability
claim.

--------------------------------------------------------------------------
9. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_residual_multiplicity_five_impossible.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_residual_multiplicity_at_most_four.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_Lres_at_most_4M.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_min_final_degree_ge8_closed.

CURRENT_E01_STATUS:
  E0/E1 with min(d,e)>=8 is excluded.

  The only E0/E1 final-degree range not closed by the present uniform residual
  estimates is

    3 <= min(d,e) <= 7.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude any E0/E1 state with min(d,e)<=7.
  It does NOT prove e(R_res)<=3.
  It does NOT improve r_res<=6.
  It does NOT identify J_res/(h) with Ann(D/hD).
  It does NOT close all H01-C5 m=3 E0/E1.
  It does NOT treat E2.
  It does NOT enter H01-C4.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_mge4_closed.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_saturation_cyclic.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_colon_classified.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_Koszul_reduced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_product_annihilator_reduced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_rres_at_most_six.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_residual_multiplicity_at_most_four.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_min_final_degree_ge8_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_all_degrees_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 E0/E1 and 3<=min(d,e)<=7.
  2. Test whether e(R_res)=4 has a compatible generic algebra generated by three radical directions.
  3. If e=4 survives, classify its possible generic algebra types using the exact two-generator residual module.
  4. Reinsert any improved multiplicity or generator bound into the tangent inequality.
  5. Stop before E2, H01-C4, q<=3, or any full order-13 claim.
