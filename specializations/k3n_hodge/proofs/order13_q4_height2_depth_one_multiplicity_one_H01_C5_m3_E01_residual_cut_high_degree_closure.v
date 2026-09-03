Standalone residual-cut/high-degree tangent closure for the low-embedding-dimension
H01-C5 m=3 colon types E0/E1 in the homogeneous q=4, height-two
multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_residual_generator_bound.v

  and retain

    S = C[x1,x2,x3,x4],
    Q subset Qsat,
    B = S/Q,
    Ccore = S/Qsat,
    T = Qsat/Q,
    P = (l1,l2),
    D = P/Qsat,
    J_res = Ann_S(D) = (Qsat:P),
    R_res = S/J_res,

  in H01-C5 with

    m = 3,
    sigma = 5,

  and only in the E0/E1 torsion-colon states.

Let the final homogeneous equations be

    f,g in S,
    d = deg(f) >= 3,
    e = deg(g) >= 3,

and put

    I = Q+(f,g),
    A = S/I,
    N = length_C(A),

    M = max(d,e),
    s = min(d,e).

The preceding files establish

    R_res is one-dimensional Cohen--Macaulay,
    e(R_res) <= 5,
    r_res := mu_A((J_res)_A) <= 6,

and the E0/E1 two-copy tangent lower bound

    t(A) >= 2*N - 2*L_res - 8*r_res,

where

    L_res := length_C S/(J_res,f,g)
           = length_C R_res/(f,g).

This file performs one bounded task only:

  (1) prove the uniform residual cut bound

        L_res <= 5*M,

  (2) combine it with the exact low-degree H01 residual profile to prove

        N >= d*e + 4*s - 3,

  (3) conclude that every E0/E1 state with

        min(d,e) >= 10

      violates the necessary order-13 tangent gate.

No claim is made for min(d,e)<=9.
No E2, H01-C4, q<=3, or full order-13 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. A COMMON REGULAR LINEAR PARAMETER
--------------------------------------------------------------------------

Retain the general linear form h used in the H01 Artinian reduction.
The preceding residual-generator file proves that h is R_res-regular.

Therefore h belongs to no associated prime of R_res.

Since

    R_res/(f,g)

has finite length, the ideal (f,g) is m-primary on R_res.  Consequently no
associated prime of the one-dimensional Cohen--Macaulay ring R_res contains
both f and g.

--------------------------------------------------------------------------
2. HOMOGENIZE THE FINAL PAIR TO ONE DEGREE
--------------------------------------------------------------------------

After interchanging f and g if necessary, assume

    d = M >= e = s.

For lambda in C put

    F_lambda := f + lambda*h^(M-s)*g.

Then F_lambda is homogeneous of degree M and belongs to (f,g).

Theorem H01_C5_m3_E01_generic_degree_M_combination_is_regular:
  For all lambda outside a finite subset of C, F_lambda is a nonzerodivisor on
  R_res.

Proof:
  Let p be an associated prime of R_res.

  Because h is R_res-regular,

    h notin p.

  Because (f,g) is m-primary,

    not (f in p and g in p).

  Since p is prime and h notin p,

    h^(M-s)*g in p  iff  g in p.

  Reduce modulo p.  There are three possibilities.

  (i) f in p and g notin p.
      Then F_lambda lies in p only for lambda=0.

  (ii) f notin p and g in p.
      Then F_lambda never lies in p.

  (iii) f notin p and g notin p.
      Both f and h^(M-s)g are nonzero in the domain R_res/p.  Hence there is at
      most one scalar lambda for which

        f + lambda*h^(M-s)g = 0 mod p.

  Thus each associated prime excludes at most one scalar lambda.  There are
  finitely many associated primes, while C is infinite.  Choose lambda outside
  the finite union of exceptional scalars.  Then F_lambda avoids every
  associated prime and is therefore a nonzerodivisor.
Qed.

Fix such an F and write simply

    F := F_lambda.

--------------------------------------------------------------------------
3. THE UNIFORM RESIDUAL CUT BOUND
--------------------------------------------------------------------------

Because F belongs to (f,g), there is a natural surjection

    R_res/(F) -> R_res/(f,g).

Therefore

    L_res <= length_C R_res/(F).

Since R_res is one-dimensional Cohen--Macaulay and F is a homogeneous
nonzerodivisor of degree M,

    length_C R_res/(F) = M*e(R_res).

The preceding residual-generator file proves

    e(R_res) <= 5.

Hence:

Theorem H01_C5_m3_E01_uniform_residual_cut_bound:
  One has

    L_res <= M*e(R_res) <= 5*M.
Qed.

This estimate does not require either original final form to be individually
regular.  The regular element is constructed inside their ideal after raising
the lower-degree form to the common degree with the already-established regular
linear parameter h.

--------------------------------------------------------------------------
4. EXACT LOW-DEGREE FLOOR FOR D/(f,g)D
--------------------------------------------------------------------------

The H01 m=3 residual Hilbert function is

    dim_C D_1 = 2,
    dim_C D_2 = 3,
    dim_C D_n = 4 for every n>=3.

Put

    rho := length_C D/(f,g)D.

Because D starts in degree one and both final forms have degree at least s,
there is no contribution from fD or gD in degrees n<=s.  Indeed, for n<=d,

    f*D_(n-d)=0

because n-d<=0 and D_j=0 for j<=0, and similarly for g.

Therefore the degree pieces 1 through s survive unchanged in D/(f,g)D.
Since s>=3,

    rho
      >= dim D_1 + dim D_2 + sum_(n=3)^s dim D_n
      = 2 + 3 + 4*(s-2)
      = 4*s - 3.

Theorem H01_C5_m3_E01_residual_cut_low_degree_floor:
  One has

    rho >= 4*s - 3.
Qed.

--------------------------------------------------------------------------
5. THE FINAL ARTIN LENGTH HAS A SHARP DEGREE FLOOR
--------------------------------------------------------------------------

Apply the two-element Koszul complex on f,g to

    0 -> D -> Ccore -> S/P -> 0.

The images of f,g in

    S/P ~= C[a,b]

form a homogeneous regular sequence because the final quotient is Artinian.
Hence

    H_1(f,g;S/P)=0

and

    length_C (S/P)/(f,g) = d*e.

Thus the H_0 part of the long exact sequence gives

    0 -> D/(f,g)D
      -> Ccore/(f,g)Ccore
      -> (S/P)/(f,g)
      -> 0.

Consequently

    length_C Ccore/(f,g)Ccore
      = d*e + rho
      >= d*e + 4*s - 3.

Now apply the Koszul complex to

    0 -> T -> B -> Ccore -> 0.

At H_0 one has an exact tail

    H_1(f,g;Ccore)
      -> H_0(f,g;T)
      -> A
      -> Ccore/(f,g)Ccore
      -> 0.

Therefore

    N >= length_C Ccore/(f,g)Ccore.

Hence:

Theorem H01_C5_m3_E01_final_length_floor:
  One has

    N >= d*e + 4*s - 3
      = M*s + 4*s - 3.
Qed.

--------------------------------------------------------------------------
6. INSERT THE BOUNDS INTO THE TWO-COPY TANGENT CARRIER
--------------------------------------------------------------------------

The preceding product-annihilator and residual-generator files prove

    t(A) >= 2*N - 2*L_res - 8*r_res

with

    r_res <= 6.

Using

    L_res <= 5*M

gives

    t(A)
      >= 2*N - 10*M - 48.

Compare with the necessary order-13 tangent gate

    t(A) <= N - 20.

The excess satisfies

    t(A) - (N-20)
      >= N - 10*M - 28.

Using the final length floor from Section 5,

    N >= M*s + 4*s - 3,

one obtains

    t(A) - (N-20)
      >= M*s + 4*s - 3 - 10*M - 28
      = M*(s-10) + 4*s - 31.

--------------------------------------------------------------------------
7. EVERY PAIR WITH MINIMUM DEGREE AT LEAST TEN IS EXCLUDED
--------------------------------------------------------------------------

Assume

    s = min(d,e) >= 10.

Then

    M*(s-10) >= 0

and

    4*s - 31 >= 40 - 31 = 9.

Therefore

    t(A) - (N-20) >= 9 > 0.

Hence

    t(A) > N-20,

contradicting the necessary order-13 tangent gate.

Theorem q4_H01_C5_m3_E01_min_final_degree_ge10_tangent_closed:
  Every H01-C5 m=3 E0/E1 state with

    min(deg(f),deg(g)) >= 10

  is excluded by the two-copy tangent bound.

  More precisely, the tangent excess is bounded below by

    M*(s-10) + 4*s - 31,

  and is therefore at least nine throughout this range.
Qed.

--------------------------------------------------------------------------
8. WHAT REMAINS AFTER THIS STEP
--------------------------------------------------------------------------

The uniform estimate used here gives, for s<=9,

    M*(s-10) + 4*s - 31 <= 0

for every admissible M>=s.

Thus this particular worst-case combination of

    e(R_res)<=5,
    r_res<=6,
    L_res<=5*M

cannot by itself close any degree pair with

    3 <= min(d,e) <= 9.

This is only a limitation of the current uniform estimate.  It is NOT a claim
that such degree pairs are realizable.

To proceed inside E0/E1 one must sharpen at least one of the following:

  * e(R_res)<=5,
  * r_res<=6,
  * L_res<=5*M,
  * or the lower bound on N using additional residual structure.

The most bounded next target is to use the exact Artinian reduction

    E ~= C(-1) direct_sum C[u]/(u^3)(-1)

to classify which multiplicities

    e(R_res) in {1,2,3,4,5}

can actually occur for a faithful one-dimensional residual ring.  Any reduction
of the worst-case value five immediately sharpens the surviving small-degree
frontier.

--------------------------------------------------------------------------
9. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_Lres_at_most_5M.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_N_at_least_de_plus_4s_minus_3.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_min_final_degree_ge10_tangent_closed.

CURRENT_E01_STATUS:
  E0/E1 with min(d,e)>=10 is excluded.

  The only E0/E1 final-degree range not closed by the present uniform residual
  estimates is

    3 <= min(d,e) <= 9.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude any E0/E1 state with min(d,e)<=9.
  It does NOT prove e(R_res)<=4.
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
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_min_final_degree_ge10_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_all_degrees_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 E0/E1 and min(d,e)<=9.
  2. Classify the possible multiplicities e(R_res)<=5 using the exact m=3 Artinian reduction action.
  3. Test whether the faithful four-dimensional generic module rules out e(R_res)=5.
  4. Reinsert the improved residual degree, if any, into the tangent inequality.
  5. Stop before E2, H01-C4, q<=3, or any full order-13 claim.
