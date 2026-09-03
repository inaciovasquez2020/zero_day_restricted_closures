Standalone tangent closure for the exact minimal-deficiency skew-line endpoint in
the homogeneous q=4, height-two DEPTH-ONE saturated-core branch of the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_minimal_deficiency_profile.v

  and retain

    S := C[x1,x2,x3,x4],
    P1 := (x1,x2),
    P2 := (x3,x4),
    Q0 := P1 intersect P2
        = (x1*x3,x1*x4,x2*x3,x2*x4),
    B0 := S/Q0.

The preceding file proves

    Q0sat=Q0,
    ht(Q0)=2,
    depth(B0)=1,
    H^1_m(B0) ~= C

with the deficiency concentrated in degree zero.

Let

    I := Q0+(f,g)

be homogeneous and m-primary, with

    deg(f),deg(g)>=3,

and put

    A := S/I = B0/(f,g),
    N := length_C(A)>=32.

The order-13 repair route requires the necessary tangent gate

    t(A) := dim_C Hom_S(I,A) <= N-20.

This file proves that the exact skew-line minimal-deficiency endpoint cannot
satisfy that gate.

It does NOT classify all depth-one saturated cores.

This file is pseudo-formal mathematical documentation.  It is not Coq or Lean
and MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. FIBER-PRODUCT PRESENTATION
--------------------------------------------------------------------------

Put

    R1 := S/P1 ~= C[x3,x4],
    R2 := S/P2 ~= C[x1,x2].

There is a standard exact sequence

    0 -> B0
      -> R1 direct_sum R2
      -> C
      -> 0,

where the last map is the difference of the two residue maps at the homogeneous
maximal ideals.

Theorem final_pair_restricts_to_regular_pairs_on_both_lines:
  Let

    f_i,g_i

  denote the images of f,g in Ri.  Then for i=1,2,

    Ri/(f_i,g_i)

  has finite length, and f_i,g_i form a regular sequence in Ri.

Proof:
  The quotient map B0 -> Ri is surjective.  After quotienting by (f,g), this
  gives a surjection

    A -> Ri/(f_i,g_i).

  Since A has finite length, so does Ri/(f_i,g_i).  Therefore (f_i,g_i) is an
  m_i-primary homogeneous ideal in the two-dimensional polynomial ring Ri.

  Hence f_i,g_i form a homogeneous system of parameters.  Each Ri is
  Cohen--Macaulay of dimension two, so every system of parameters is a regular
  sequence.
Qed.

Corollary component_Koszul_homology_vanishes_above_degree_zero:
  For

    R := R1 direct_sum R2,

  one has

    H_2(f,g;R)=0,
    H_1(f,g;R)=0.

Proof:
  Koszul homology commutes with finite direct sums, and the restricted pair is
  regular on each component by the preceding theorem.
Qed.

--------------------------------------------------------------------------
2. EXACT FIRST KOSZUL HOMOLOGY
--------------------------------------------------------------------------

Define

    D1 := H_1(f,g;B0).

Theorem minimal_deficiency_becomes_exactly_one_Koszul_H1_class:
  There is a natural graded B0-module isomorphism

    D1 ~= C(-deg(f)-deg(g)).

  In particular D1 is one-dimensional over C.

Proof:
  Apply the two-element Koszul complex K(f,g;-) to

    0 -> B0
      -> R1 direct_sum R2
      -> C
      -> 0.

  Since the Koszul chain modules are finite free tensor factors, this remains a
  short exact sequence of complexes.

  The elements f and g have positive degree, hence their images in the residue
  field C are zero.  Therefore the Koszul differential on K(f,g;C) is zero and

    H_2(f,g;C) ~= C(-deg(f)-deg(g)).

  By the preceding component calculation,

    H_2(f,g;R1 direct_sum R2)=0,
    H_1(f,g;R1 direct_sum R2)=0.

  The relevant part of the long exact homology sequence is thus

    0
      -> H_2(f,g;C)
      -> H_1(f,g;B0)
      -> 0.

  Hence

    D1 ~= C(-deg(f)-deg(g)).
Qed.

Corollary the_Koszul_defect_is_the_residue_field_as_an_A_module:
  The B0-action on D1 factors through A, and as an A-module

    D1 ~= A/m_A

  up to grading shift.

Proof:
  Every first Koszul homology module is annihilated by f and g, so the B0-action
  factors through A=B0/(f,g).

  The preceding theorem identifies D1 B0-linearly with the residue field C.
  The induced A-action is therefore the standard residue action through

    A -> A/m_A ~= C.
Qed.

Corollary exact_annihilator_of_the_skew_line_Koszul_defect:
  One has

    Ann_A(D1)=m_A.

Proof:
  Since D1 is the nonzero residue-field module A/m_A, its annihilator is exactly
  m_A.
Qed.

--------------------------------------------------------------------------
3. TWO-COORDINATE HOM CARRIER
--------------------------------------------------------------------------

Put

    L := (f,g)B0.

Let

    M := Syz_B0(f,g)
       = { (a,b) in B0^2 : a*f+b*g=0 }.

Then

    D1 = M / B0*(-g,f).

Theorem square_of_the_Koszul_annihilator_injects_into_the_two_cut_Hom_space:
  Put

    E := Ann_A(D1).

  There is a natural C-linear injection

    E direct_sum E -> Hom_B0(L,A).

Proof:
  The presentation

    B0^2 -> L,
    (u,v) |-> u*f+v*g

  has kernel M.  Hence Hom_B0(L,A) identifies with pairs

    (alpha,beta) in A^2

  such that

    a*alpha+b*beta=0

  for every (a,b) in M.

  Since f=g=0 in A, every A-valued coordinate functional already kills the
  Koszul submodule B0*(-g,f), so its restriction to M factors through D1.

  The coordinate maps

    rho_1,rho_2 : D1 -> A,
    rho_1([a,b])=a mod (f,g),
    rho_2([a,b])=b mod (f,g)

  are well-defined and A-linear.

  If alpha belongs to E, then for every x in D1,

    alpha*rho_i(x)
      = rho_i(alpha*x)
      = 0.

  The same holds for beta in E.  Thus every pair (alpha,beta) in E^2 kills all
  syzygies and defines a B0-linear map L->A.

  Distinct pairs remain distinct in A^2, so the construction is injective.
Qed.

Corollary the_full_maximal_ideal_is_a_forced_two_copy_carrier:
  There is an injection

    m_A direct_sum m_A -> Hom_B0(L,A).

  Consequently

    dim_C Hom_B0(L,A) >= 2*(N-1).

Proof:
  The exact annihilator calculation gives E=m_A.  Since A is local Artinian of
  length N with residue field C,

    dim_C m_A=N-1.

  Apply the preceding theorem.
Qed.

--------------------------------------------------------------------------
4. PASSAGE TO THE FULL HILBERT TANGENT SPACE
--------------------------------------------------------------------------

Theorem maps_killing_Q0_form_a_subspace_of_the_full_tangent_space:
  There is a natural injection

    Hom_B0(L,A) -> Hom_S(I,A).

Proof:
  Since I=Q0+(f,g), one has

    I/Q0 = L

  as a B0-module.  S-linear maps I->A which vanish on Q0 are exactly B0-linear
  maps L->A.  These form a C-linear subspace of Hom_S(I,A).
Qed.

Theorem skew_line_endpoint_tangent_lower_bound:
  One has

    t(A) := dim_C Hom_S(I,A) >= 2*N-2.

Proof:
  Combine the previous two results:

    t(A)
      >= dim_C Hom_B0(L,A)
      >= 2*(N-1)
      = 2*N-2.
Qed.

Theorem skew_line_minimal_deficiency_endpoint_fails_the_order13_tangent_gate:
  Under the standing length hypothesis N>=32,

    t(A) > N-20.

  Therefore the necessary order-13 tangent condition

    t(A) <= N-20

  is impossible for the exact skew-line minimal-deficiency endpoint.

Proof:
  The tangent lower bound gives

    t(A)>=2*N-2.

  Compare with the gate:

    (2*N-2)-(N-20)=N+18.

  This is positive for every positive N, and in particular for N>=32.
  Hence

    t(A)>N-20.
Qed.

Corollary q4_height2_depth_one_skew_line_endpoint_is_closed:
  No homogeneous order-13 deviation-two candidate whose saturated height-two
  core is exactly

    (x1,x2) intersect (x3,x4)

  can pass the necessary tangent-deficit gate.
Qed.

--------------------------------------------------------------------------
5. WHAT THIS DOES AND DOES NOT CLOSE
--------------------------------------------------------------------------

The key structural mechanism is now explicit:

    depth-one deficiency C in degree zero
      -> one residue-field Koszul H1 class
      -> Ann_A(H1)=m_A
      -> two copies of m_A in the tangent carrier
      -> t(A)>=2*N-2.

Thus the smallest possible depth-one deficiency is not a dangerous endpoint;
it creates an even larger tangent carrier than the short saturation-torsion
mechanism used in the Cohen--Macaulay line core.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove that every q=4 height-two depth-one saturated core
  is a union of two skew lines.

  It does NOT classify larger or differently graded deficiency modules.

  Therefore the parent truth state remains

    q4_height2_depth_one_core : UNKNOWN.

  No conclusion is asserted for homogeneous q<=3 or for the unrestricted
  nonhomogeneous local deviation-two frontier.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_CM_conic_core_closed.
  q4_height2_CM_line_core_tangent_closed.
  q4_height2_depth_one_minimal_deficiency_isolated.
  q4_height2_depth_one_skew_line_endpoint_closed.
  not q4_height2_depth_one_core_closed.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Determine whether every remaining q=4 height-two depth-one saturated core
  either

    (a) contains a residue-field Koszul H1 quotient producing an annihilator of
        codimension at most one, or

    (b) has a larger deficiency module whose annihilator still yields a tangent
        carrier strong enough to violate the order-13 gate.

NEXT_ACTIONS:
  1. Stay inside q=4 height-two depth-one saturated cores.
  2. Classify the next-smallest possible graded H^1_m(C) profile beyond C[0].
  3. Relate that profile to H_1(f,g;C) for the final parameter pair.
  4. Bound Ann_A(H_1) from the deficiency grading.
  5. Do not enter q<=3.
