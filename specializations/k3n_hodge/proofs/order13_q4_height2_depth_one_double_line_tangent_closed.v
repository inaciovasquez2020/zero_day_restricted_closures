Standalone tangent closure for the saturated Type-A2 double-line endpoint in
the homogeneous q=4, height-two DEPTH-ONE saturated-core branch of the
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_length2_deficiency_empty.v
    order13_q4_height2_depth_one_skew_line_tangent_closed.v

  and retain

    S := C[x,y,z,w],
    Q := (x^2, x*y, y^2, x*z+y*w),
    B := S/Q.

The preceding finite-Rao classification proves for this exact endpoint that

    Qsat=Q,
    ht(Q)=2,
    depth_m(B)=1,
    H^1_m(B) ~= C

with the Rao module concentrated in degree zero.

Let

    I := Q+(f,g)

be homogeneous and m-primary, with

    deg(f),deg(g)>=3,

and put

    A := S/I = B/(f,g),
    N := length_C(A)>=32.

The order-13 repair route requires the necessary tangent gate

    t(A) := dim_C Hom_S(I,A) <= N-20.

This file proves that the exact saturated double-line endpoint cannot satisfy
that gate.

It does NOT treat the remaining non-finite-Rao depth-one profiles.

This file is pseudo-formal mathematical documentation.  It is not Coq or Lean
and MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE SATURATED DOUBLE LINE HAS NO SATURATION TRANSGRESSION
--------------------------------------------------------------------------

Theorem double_line_has_zero_saturation_torsion:
  Put

    T := Qsat/Q.

  Then

    T=0.

Proof:
  The preceding Type-A2 classification proves Qsat=Q for

    Q=(x^2,xy,y^2,xz+yw).

  Therefore Qsat/Q=0.
Qed.

Corollary the_double_line_Rao_class_cannot_be_absorbed_by_saturation_torsion:
  There is no saturation-torsion target through which the degree-zero Rao
  module can transgress.
Qed.

--------------------------------------------------------------------------
2. MACAULAYFICATION AND THE EXACT KOSZUL H1 CLASS
--------------------------------------------------------------------------

Put

    M := H^1_m(B).

The preceding file proves

    M ~= C

concentrated in degree zero.

ExternalResult dimension_two_ideal_transform_macaulayfication:
  If R is a finitely generated standard graded C-algebra of dimension two with

    H^0_m(R)=0

  and finite-length H^1_m(R), then its homogeneous ideal transform D=D_m(R)
  is finite over R and fits into a graded exact sequence

    0 -> R -> D -> H^1_m(R) -> 0.

  Moreover

    H^0_m(D)=H^1_m(D)=0,

  so D is Cohen--Macaulay of dimension two.

Apply this result to B.  Since B is saturated,

    H^0_m(B)=0,

and since M~=C has finite length, there is an exact sequence

    0 -> B -> D -> C -> 0

with D Cohen--Macaulay of dimension two.

Theorem the_final_pair_is_regular_on_the_double_line_macaulayfication:
  The images of f,g in D form a regular sequence.

Proof:
  Since A=B/(f,g) has finite length, the pair f,g is an m-primary homogeneous
  parameter pair on the two-dimensional ring B.

  The module/ring D is finite over B.  Hence

    D/(f,g)D

  is finite over B/(f,g) and therefore has finite length.  Thus f,g form a
  homogeneous system of parameters on D.

  Because D is Cohen--Macaulay of dimension two, every parameter pair is a
  regular sequence.
Qed.

Define

    D1 := H_1(f,g;B).

Theorem the_double_line_has_exactly_one_residue_field_Koszul_H1_class:
  There is a natural graded B-module isomorphism

    D1 ~= C(-deg(f)-deg(g)).

Proof:
  Apply the two-element Koszul complex K(f,g;-) to

    0 -> B -> D -> C -> 0.

  The Koszul chain modules are finite free tensor factors, so this gives a short
  exact sequence of complexes.

  The preceding theorem gives

    H_2(f,g;D)=0,
    H_1(f,g;D)=0.

  Since f and g have positive degree, their images in the residue field C are
  zero.  Hence the Koszul differential on K(f,g;C) vanishes and

    H_2(f,g;C) ~= C(-deg(f)-deg(g)).

  The relevant long exact homology segment is therefore

    0
      -> H_2(f,g;C)
      -> H_1(f,g;B)
      -> 0.

  This proves the claimed isomorphism.
Qed.

Corollary the_double_line_Koszul_defect_is_the_residue_field_as_an_A_module:
  The B-action on D1 factors through A, and as an A-module

    D1 ~= A/m_A

  up to grading shift.

Proof:
  Every first Koszul homology module is annihilated by f and g, so the B-action
  factors through A=B/(f,g).

  The preceding theorem identifies D1 B-linearly with the residue field C,
  giving the standard residue action of A.
Qed.

Corollary exact_annihilator_of_the_double_line_Koszul_defect:
  One has

    Ann_A(D1)=m_A.

Proof:
  D1 is the nonzero residue-field module A/m_A, whose annihilator is exactly
  m_A.
Qed.

--------------------------------------------------------------------------
3. TWO-COPY MAXIMAL-IDEAL HOM CARRIER
--------------------------------------------------------------------------

Put

    L := (f,g)B.

Let

    Syz := Syz_B(f,g)
         = { (a,b) in B^2 : a*f+b*g=0 }.

Then

    D1 = Syz / B*(-g,f).

Theorem square_of_the_Koszul_annihilator_injects_into_the_two_cut_Hom_space:
  Put

    E := Ann_A(D1).

  There is a natural C-linear injection

    E direct_sum E -> Hom_B(L,A).

Proof:
  The presentation

    B^2 -> L,
    (u,v) |-> u*f+v*g

  has kernel Syz.  Therefore Hom_B(L,A) identifies with pairs

    (alpha,beta) in A^2

  such that

    a*alpha+b*beta=0

  for every (a,b) in Syz.

  Since f=g=0 in A, every coordinate functional on B^2 with values in A kills
  the Koszul submodule B*(-g,f).  Restriction to Syz therefore factors through

    D1=Syz/B*(-g,f).

  The coordinate maps

    rho_1,rho_2 : D1 -> A,
    rho_1([a,b])=a mod (f,g),
    rho_2([a,b])=b mod (f,g)

  are well-defined and A-linear.

  If alpha belongs to E=Ann_A(D1), then for every xi in D1,

    alpha*rho_i(xi)=rho_i(alpha*xi)=0

  for i=1,2.  The same holds for beta in E.  Thus every pair

    (alpha,beta) in E direct_sum E

  kills every syzygy and defines a B-linear map L->A.

  Distinct pairs remain distinct inside A^2, so the construction is injective.
Qed.

Corollary the_full_maximal_ideal_is_a_forced_two_copy_carrier:
  There is a natural injection

    m_A direct_sum m_A -> Hom_B(L,A).

  Consequently

    dim_C Hom_B(L,A) >= 2*(N-1).

Proof:
  The exact annihilator result gives E=m_A.

  Since I is m-primary, A is a local Artinian C-algebra with residue field C.
  Therefore

    dim_C m_A = length_C(A)-1 = N-1.

  Apply the preceding carrier theorem.
Qed.

--------------------------------------------------------------------------
4. PASSAGE TO THE FULL HILBERT TANGENT SPACE
--------------------------------------------------------------------------

Theorem maps_killing_Q_form_a_subspace_of_the_full_tangent_space:
  There is a natural injection

    Hom_B(L,A) -> Hom_S(I,A).

Proof:
  Since I=Q+(f,g), one has

    I/Q = L

  as a B-module.  S-linear maps I->A which vanish on Q are exactly B-linear
  maps L->A.  They form a C-linear subspace of Hom_S(I,A).
Qed.

Theorem double_line_endpoint_tangent_lower_bound:
  One has

    t(A) := dim_C Hom_S(I,A) >= 2*N-2.

Proof:
  Combine the preceding two results:

    t(A)
      >= dim_C Hom_B(L,A)
      >= 2*(N-1)
      = 2*N-2.
Qed.

Theorem saturated_double_line_endpoint_fails_the_order13_tangent_gate:
  Under the standing order-13 length hypothesis N>=32,

    t(A) > N-20.

  Therefore the necessary order-13 tangent condition

    t(A) <= N-20

  is impossible for the exact saturated Type-A2 double-line endpoint.

Proof:
  The tangent lower bound gives

    t(A)>=2*N-2.

  Compare with the gate:

    (2*N-2)-(N-20)=N+18.

  This is positive for every positive N, in particular for N>=32.
  Hence

    t(A)>N-20.
Qed.

Corollary q4_height2_depth_one_double_line_endpoint_is_closed:
  No homogeneous order-13 deviation-two candidate whose height-two saturated
  core is

    (x^2,xy,y^2,xz+yw)

  can pass the necessary tangent-deficit gate.
Qed.

--------------------------------------------------------------------------
5. SHARP REMAINING DEPTH-ONE BOUNDARY
--------------------------------------------------------------------------

The finite-Rao multiplicity-two classification has now closed both finite-Rao
length-one depth-one endpoints:

  TYPE A1:
    (x,y) intersect (z,w),
    closed by order13_q4_height2_depth_one_skew_line_tangent_closed.v.

  TYPE A2:
    ((x,y)^2,xz+yw),
    closed in this file.

The hypothetical finite-Rao length-two stratum was proved empty in the preceding
file.

The remaining q=4 height-two depth-one frontier is therefore not another small
finite-Rao endpoint.  It is the non-finite-Rao / punctured-spectrum-defective
side represented by Type B in the multiplicity-two classification, together
with any issue required to justify that this classification exhausts the
standing branch exactly as used.

IMPORTANT_NONCONCLUSION:
  This file does NOT close every q=4 height-two depth-one core.

  It does NOT prove that the Type-B non-finite-Rao side violates the order-13
  tangent gate.

  It does NOT enter homogeneous q<=3 or the unrestricted nonhomogeneous local
  deviation-two frontier.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_CM_conic_core_closed.
  q4_height2_CM_line_core_tangent_closed.
  q4_height2_depth_one_skew_line_endpoint_closed.
  q4_height2_depth_one_length2_deficiency_empty.
  q4_height2_depth_one_double_line_endpoint_closed.
  not q4_height2_depth_one_nonfinite_Rao_closed.
  not q4_height2_depth_one_core_closed.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

NEXT_ACTIONS:
  1. Stay inside q=4 height-two depth one.
  2. Enter only the remaining Type-B non-finite-Rao profile from the exact
     multiplicity-two four-quadric classification.
  3. Use its explicit colon/associated-prime structure to compute a tangent
     carrier after the final parameter pair.
  4. Stop if the projective embedded component can genuinely survive the
     order-13 tangent gate.
  5. Do not enter q<=3.
