Standalone residual/product-annihilator reduction for the low-embedding-dimension
H01-C5 m=3 colon types E0/E1 in the homogeneous q=4, height-two
multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_torsion_koszul_profile.v

  and retain

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

  and only in the low-colon types E0/E1.

Let the final homogeneous equations be

    f,g in S,
    d = deg(f) >= 3,
    e = deg(g) >= 3,

and put

    I = Q+(f,g),
    A = S/I = B/(f,g),
    N = length_C(A).

The preceding E0/E1 torsion-Koszul file proves that for

    H := H_1(f,g;B)

there is an exact sequence

    0 -> U -> H -> V -> 0

where

    U = H_1(f,g;T),

    V subset H_1(f,g;Ccore),

and U is annihilated by a homogeneous m-primary ideal K_T satisfying

    length_C(S/K_T) <= 4.

This file performs one bounded task only: identify the exact repository-native
residual annihilator

    J_res := Ann_S(D) = (Qsat:P),

prove the product containment

    K_T*J_res subset Ann_S H,

and reduce the two-copy tangent estimate to two explicit numerical invariants of
J_res.  No unsupported small generator count or cut-length bound for J_res is
asserted.

No E2, H01-C4, q<=3, or full order-13 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE FINAL PAIR IS REGULAR ON THE LINE QUOTIENT
--------------------------------------------------------------------------

Put

    Rline := S/P ~= C[s,t].

Since A is Artinian, its quotient

    Rline/(f_R,g_R)

is Artinian, where f_R,g_R are the images of f,g in Rline.  Hence f_R,g_R
form a homogeneous system of parameters in the two-dimensional polynomial ring
Rline, and therefore a regular sequence.

Theorem H01_C5_m3_E01_line_Koszul_vanishing:
  One has

    H_2(f,g;Rline)=0,
    H_1(f,g;Rline)=0.
Qed.

--------------------------------------------------------------------------
2. THE CORE FIRST KOSZUL HOMOLOGY IS THE RESIDUAL ONE
--------------------------------------------------------------------------

Apply the two-element Koszul complex on f,g to

    0 -> D -> Ccore -> Rline -> 0.

The relevant long exact segment is

    H_2(f,g;Rline)
      -> H_1(f,g;D)
      -> H_1(f,g;Ccore)
      -> H_1(f,g;Rline).

Both outside terms vanish by Section 1.

Theorem H01_C5_m3_E01_core_H1_is_residual_H1:
  There is a natural graded isomorphism

    H_1(f,g;Ccore) ~= H_1(f,g;D).
Qed.

This step uses only the canonical line quotient and does not require a normal
form for D beyond its established H01 profile.

--------------------------------------------------------------------------
3. THE EXACT RESIDUAL ANNIHILATOR IS A COLON IDEAL
--------------------------------------------------------------------------

Define

    J_res := Ann_S(D).

Because

    D = P/Qsat,

an element a in S annihilates D exactly when

    a*P subset Qsat.

Therefore:

Theorem H01_C5_m3_E01_residual_annihilator_colon_identity:
  One has

    J_res = (Qsat:P).
Qed.

In particular J_res is homogeneous and contains Qsat, hence also Q.

Corollary H01_C5_m3_E01_Jres_kills_core_H1:
  One has

    J_res * H_1(f,g;Ccore) = 0.

Proof:
  J_res annihilates D, hence it annihilates every Koszul chain module and every
  Koszul homology module built from D.  Transfer through the isomorphism of
  Section 2.
Qed.

Thus J_res also annihilates every submodule

    V subset H_1(f,g;Ccore).

--------------------------------------------------------------------------
4. PRODUCT ANNIHILATOR FOR THE FULL B-KOSZUL DEFECT
--------------------------------------------------------------------------

Retain from the preceding E0/E1 torsion-Koszul file the exact sequence

    0 -> U -> H -> V -> 0

with

    K_T*U = 0,
    J_res*V = 0.

Theorem H01_C5_m3_E01_product_annihilator:
  One has

    K_T*J_res*H = 0.

Equivalently,

    K_T*J_res subset Ann_S H.

Proof:
  Let xi in H and j in J_res.  Since J_res kills V=H/U, the element j*xi lies
  in U.  Since K_T kills U, every k in K_T satisfies

    k*j*xi=0.

  Thus K_T*J_res annihilates H.
Qed.

Pass to A and write

    K_A := image(K_T in A),
    J_A := image(J_res in A),
    E := Ann_A(H).

Corollary H01_C5_m3_E01_product_carrier:
  One has

    K_A*J_A subset E.
Qed.

This is the exact E0/E1 analogue of the product-annihilator carrier used in the
already closed H00 branch, but with K_T replacing the maximal ideal and with
J_res not yet geometrically classified.

--------------------------------------------------------------------------
5. EXACT RESIDUAL CUT INVARIANT
--------------------------------------------------------------------------

Define

    L_res := length_C S/(J_res,f,g).

This is finite because it is a quotient of the Artinian ring A.

Since

    Q subset J_res,

one has an exact identification

    A/J_A
      ~= S/(Q,f,g,J_res)
      ~= S/(J_res,f,g).

Theorem H01_C5_m3_E01_residual_cut_exact:
  One has

    length_C(A/J_A) = L_res.
Qed.

No numerical upper bound for L_res is asserted here.

--------------------------------------------------------------------------
6. PRODUCT-CARRIER CODIMENSION REDUCES TO L_res AND r_res
--------------------------------------------------------------------------

Put

    r_res := dim_C J_A/(m_A*J_A),

where m_A is the homogeneous maximal ideal of A.  Thus r_res is the minimal
number of A-generators of J_A.

The quotient

    J_A/(K_A*J_A)

is naturally an A/K_A-module.  A minimal generating set of J_A over A maps to
a generating set of this quotient, so

    length_C J_A/(K_A*J_A)
      <= r_res * length_C(A/K_A).

The E0/E1 torsion-Koszul classification gives

    length_C(S/K_T) <= 4.

Since A/K_A is a quotient of S/K_T,

    length_C(A/K_A) <= 4.

Therefore:

Theorem H01_C5_m3_E01_product_layer_bound:
  One has

    length_C J_A/(K_A*J_A) <= 4*r_res.
Qed.

Use the exact sequence

    0 -> J_A/(K_A*J_A)
      -> A/(K_A*J_A)
      -> A/J_A
      -> 0.

Combining with Section 5 gives:

Theorem H01_C5_m3_E01_product_carrier_codimension:
  One has

    length_C A/(K_A*J_A) <= L_res + 4*r_res.

Consequently

    dim_C(K_A*J_A) >= N - L_res - 4*r_res.
Qed.

This is the strongest numerical carrier bound justified without an additional
classification of J_res.

--------------------------------------------------------------------------
7. TWO-COPY TANGENT REDUCTION
--------------------------------------------------------------------------

The repository-native two-copy annihilator carrier applies to

    H = H_1(f,g;B),
    E = Ann_A(H).

Since

    K_A*J_A subset E,

one obtains

    t(A) = dim_C Hom_S(I,A)
      >= 2*dim_C(E)
      >= 2*dim_C(K_A*J_A).

Therefore:

Theorem H01_C5_m3_E01_tangent_lower_bound_in_terms_of_residual_invariants:
  One has

    t(A) >= 2*N - 2*L_res - 8*r_res.
Qed.

Against the necessary order-13 tangent gate

    t(A) <= N-20,

the E0/E1 state is excluded whenever

    2*N - 2*L_res - 8*r_res > N-20,

or equivalently whenever

    L_res + 4*r_res < (N+20)/2.

Corollary H01_C5_m3_E01_exact_remaining_tangent_criterion:
  To close E0/E1 by this product-carrier route, it is enough to prove

    L_res + 4*r_res < (N+20)/2.
Qed.

No claim is made here that the inequality already follows from the current
H01-C5 data.

--------------------------------------------------------------------------
8. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_core_H1_is_residual_H1.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_Jres_equals_Qsat_colon_P.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_KT_Jres_annihilates_full_H1.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_product_carrier_codimension_reduction.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_tangent_bound_reduced_to_Lres_rres.

CURRENT_E01_STATUS:
  The full first Koszul defect has the exact product annihilator

    K_T*(Qsat:P).

  Its tangent contribution is bounded below by

    t(A) >= 2*N - 2*L_res - 8*r_res,

  with

    L_res = length_C S/((Qsat:P),f,g),
    r_res = mu_A((Qsat:P)_A).

IMPORTANT_NONCONCLUSION:
  This file does NOT bound L_res numerically.
  It does NOT bound r_res by a small absolute constant.
  It does NOT classify Ann_S(D) beyond the exact colon identity.
  It does NOT prove the tangent gate fails in E0/E1.
  It does NOT close H01-C5 m=3.
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
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_tangent_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in H01-C5 m=3 and E0/E1.  Classify enough of

    J_res = (Qsat:P)

  to bound the two exact invariants

    L_res = length_C S/(J_res,f,g),
    r_res = mu_A((J_res)_A).

  The weakest sufficient target is

    L_res + 4*r_res < (N+20)/2.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 and E0/E1.
  2. Use the m=3 Artinian reduction normal form of D to constrain (Qsat:P).
  3. Bound r_res before attempting a full geometric classification.
  4. Bound L_res only as sharply as needed for the displayed tangent criterion.
  5. Stop before E2, H01-C4, q<=3, or any full order-13 claim.
