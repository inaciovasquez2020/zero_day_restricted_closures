Standalone tangent closure of the exact H10 endpoint in the homogeneous q=4,
height-two multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H10_colon_quadratic_two_case.v

  and retain

    S := C[x1,x2,x3,x4],
    Q subset S,
    Q generated minimally by exactly four independent quadrics,
    ht(Q)=2,
    Qsat := saturation(Q),
    B := S/Q,
    Ccore := S/Qsat,
    T := Qsat/Q,

with the exact H10 structure

    P=(l1,l2),
    J:=(Qsat:l2),
    J a height-three linear prime,
    l1 in J,
    D:=P/Qsat ~= S/J(-1),
    Hilb_D(t)=t/(1-t),

and the cyclic saturation defect

    K:=(Q:l1),
    T ~= S/K(-1),
    K m-primary,
    length_C(S/K) in {3,4},
    m^3*T=0.

Let

    I:=Q+(f,g),
    deg(f)=d>=3,
    deg(g)=e>=3,
    A:=S/I=B/(f,g),
    N:=length_C(A)>=32.

The final pair is m-primary on Ccore because A is Artinian and Ccore is a
quotient of B.

This file performs one bounded task only: prove that every H10 endpoint violates
the necessary order-13 tangent gate

    t(A):=dim_C Hom_S(I,A) <= N-20.

The proof uses a product annihilator.  The colon K kills the torsion contribution
to the first Koszul homology, while the height-three point prime J kills the
residual contribution.  Hence K_A*J_A annihilates the full first Koszul homology.
Its codimension in A is at most r+12, where r is the one-variable order of the
final pair on D.  The line quotient forces N>=4r, making the two-copy Hom carrier
strictly larger than the order-13 tangent threshold.

No H00, H01, or H11 branch is entered.
No q<=3 branch is entered.
No full order-13 closure is claimed.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE FINAL PAIR ON THE SATURATED LINE QUOTIENT
--------------------------------------------------------------------------

Set

    R:=S/P ~= C[u,v].

Theorem H10_final_pair_is_regular_on_R:
  The images f_R,g_R of f,g in R form an m_R-primary homogeneous parameter pair.
  Consequently they form a regular sequence and

    length_C R/(f_R,g_R)=d*e.

Proof:
  Since Qsat subset P, there is a surjection

    Ccore=S/Qsat -> S/P=R.

  The quotient Ccore/(f,g)Ccore is Artinian because it is a quotient of the
  Artinian algebra A modulo the image of the finite-length kernel T.  Therefore
  its quotient

    R/(f_R,g_R)

  is Artinian.

  Thus f_R,g_R generate an m_R-primary ideal.  In the two-dimensional polynomial
  ring R they form a homogeneous system of parameters, hence a regular sequence.

  Neither image can vanish, because one homogeneous equation alone cannot cut
  the two-dimensional ring R to finite length.  Therefore their degrees remain
  d and e, and the complete-intersection length is d*e.
Qed.

Corollary H10_R_Koszul_H1_vanishes:
  One has

    H_1(f,g;R)=0.
Qed.

--------------------------------------------------------------------------
2. THE ONE-VARIABLE RESIDUAL ORDER r
--------------------------------------------------------------------------

Recall

    D=P/Qsat ~= S/J(-1)

and

    S/J ~= C[t].

At least one of f,g acts nontrivially on D.  Indeed, if both actions vanished,
then D/(f,g)D=D would inject into the Artinian module Ccore/(f,g)Ccore by the
Koszul sequence below, which is impossible because D has dimension one.

Define r>=1 by

    (f_D,g_D)=(t^r)

inside S/J ~= C[t], after forgetting the harmless grading shift of D.

Theorem H10_residual_order_is_at_least_three:
  One has

    r>=3.

Proof:
  Every nonzero homogeneous restriction of f or g to C[t] is a scalar multiple
  of t^d or t^e respectively.  Since d,e>=3 and at least one restriction is
  nonzero, their gcd has exponent at least three.
Qed.

Theorem H10_residual_order_is_controlled_by_the_cut_degrees:
  One has

    d*e >= 3*r.

Proof:
  If both restrictions are nonzero, then r=min(d,e), while the other degree is
  at least three.  Hence d*e>=3r.

  If exactly one restriction is nonzero, then r is the degree of that form and
  the other form still has degree at least three, again giving d*e>=3r.
Qed.

Theorem H10_residual_Koszul_H1_has_length_r_and_is_killed_by_J:
  One has

    length_C H_1(f,g;D)=r,

and

    J * H_1(f,g;D)=0.

Proof:
  Up to the grading shift D is the PID C[t].  For a two-element Koszul complex
  on two one-variable homogeneous elements whose gcd is t^r, the first Koszul
  homology is C[t]/(t^r), up to grading shift.  Hence its length is r.

  Since D itself is annihilated by J, every Koszul chain module and every Koszul
  homology module built from D is annihilated by J.
Qed.

--------------------------------------------------------------------------
3. THE SATURATED CORE CONTRIBUTES EXACTLY r EXTRA CUT LENGTH
--------------------------------------------------------------------------

Apply K(f,g;-) to

    0 -> D -> Ccore -> R -> 0.

Theorem H10_core_Koszul_H1_is_the_residual_H1:
  There is a natural isomorphism

    H_1(f,g;Ccore) ~= H_1(f,g;D).

In particular

    length_C H_1(f,g;Ccore)=r

and

    J * H_1(f,g;Ccore)=0.

Proof:
  The long exact Koszul sequence contains

    H_2(f,g;R)
      -> H_1(f,g;D)
      -> H_1(f,g;Ccore)
      -> H_1(f,g;R).

  Since f_R,g_R is a regular sequence on R,

    H_2(f,g;R)=0,
    H_1(f,g;R)=0.

  Hence the middle map is an isomorphism.  The length and J-annihilation follow
  from the preceding theorem.
Qed.

Theorem H10_core_cut_length_is_de_plus_r:
  One has

    length_C Ccore/(f,g)Ccore = d*e+r.

Proof:
  The same long exact sequence, together with H_1(f,g;R)=0, gives a short exact
  sequence

    0 -> D/(f,g)D
      -> Ccore/(f,g)Ccore
      -> R/(f_R,g_R)
      -> 0.

  The first term is C[t]/(t^r), up to shift, so it has length r.  The last term
  has length d*e.  Add lengths.
Qed.

--------------------------------------------------------------------------
4. THE FINAL ARTIN LENGTH SATISFIES N>=4r
--------------------------------------------------------------------------

Because m^3*T=0 and d,e>=3,

    f*T=0,
    g*T=0.

Apply K(f,g;-) to

    0 -> T -> B -> Ccore -> 0.

The degree-zero portion of the long exact sequence is

    H_1(f,g;Ccore) -> T -> A -> Ccore/(f,g)Ccore -> 0.

Theorem H10_final_length_dominates_the_core_cut_length:
  One has

    N >= d*e+r.

Proof:
  The displayed exact sequence gives

    N
      = length_C Ccore/(f,g)Ccore
        + length_C T
        - dim_C image(H_1(f,g;Ccore)->T).

  The image has dimension at most length(T), so

    N >= length_C Ccore/(f,g)Ccore=d*e+r.
Qed.

Corollary H10_final_length_dominates_four_r:
  One has

    N>=4*r.

Proof:
  Combine

    N>=d*e+r

with

    d*e>=3*r.
Qed.

--------------------------------------------------------------------------
5. A PRODUCT IDEAL ANNIHILATES THE FULL FIRST KOSZUL HOMOLOGY
--------------------------------------------------------------------------

Put

    H:=H_1(f,g;B).

As for every first Koszul homology module, f and g annihilate H, so H is
naturally an A-module.

Let

    U:=image(H_1(f,g;T) -> H).

Theorem H10_torsion_part_of_H_is_killed_by_K:
  One has

    K*U=0.

Proof:
  The cyclic torsion presentation gives

    T ~= S/K(-1),

so K*T=0.  Therefore K annihilates every Koszul chain module built from T and in
particular H_1(f,g;T).  It consequently annihilates its image U in H.
Qed.

Theorem H10_quotient_of_H_by_the_torsion_part_is_killed_by_J:
  One has

    J*(H/U)=0.

Proof:
  The long exact sequence contains

    H_1(f,g;T) -> H -> H_1(f,g;Ccore).

  Exactness identifies H/U with the image of H in H_1(f,g;Ccore).  The previous
  section proves that J annihilates H_1(f,g;Ccore), hence J annihilates this
  image and therefore H/U.
Qed.

Theorem H10_product_colon_annihilates_full_H1:
  One has

    K*J*H=0.

Proof:
  Let h in H and j in J.  Since J annihilates H/U, the element j*h lies in U.
  Since K annihilates U, every k in K satisfies

    k*j*h=0.

  Thus KJ annihilates H.
Qed.

Let K_A and J_A denote the images of K and J in A and put

    E:=Ann_A(H).

Corollary H10_product_carrier_lies_in_the_Koszul_annihilator:
  One has

    K_A*J_A subset E.
Qed.

--------------------------------------------------------------------------
6. THE PRODUCT CARRIER HAS CODIMENSION AT MOST r+12
--------------------------------------------------------------------------

Theorem H10_point_prime_quotient_has_length_r:
  One has

    length_C(A/J_A)=r.

Proof:
  The H10 saturation form

    Qsat=(l1)+l2*J

with l1 in J implies Qsat subset J, hence Q subset J.

  Therefore

    A/J_A
      ~= S/(J,f,g).

  Since S/J ~= C[t] and the images of f,g generate (t^r), this quotient is

    C[t]/(t^r),

so its length is r.
Qed.

Theorem H10_colon_quotient_has_length_at_most_four_after_the_final_cut:
  One has

    length_C(A/K_A)<=4.

Proof:
  The quotient A/K_A is a quotient of S/K.  The preceding H10 colon
  classification proves

    length_C(S/K) in {3,4}.

  Therefore length(A/K_A)<=4.
Qed.

Theorem H10_J_mod_KJ_has_length_at_most_twelve:
  One has

    length_C(J_A/(K_A*J_A))<=12.

Proof:
  The height-three linear prime J is generated by three independent linear forms.
  Hence J_A is generated as an A-ideal by at most three elements.

  Modulo K_A*J_A, the coefficients of those generators factor through A/K_A.
  Thus there is a surjection

    (A/K_A)^3 -> J_A/(K_A*J_A).

  The previous theorem bounds each copy by length four, giving the result.
Qed.

Theorem H10_product_carrier_codimension_bound:
  One has

    length_C(A/(K_A*J_A)) <= r+12.

Consequently

    dim_C(K_A*J_A) >= N-r-12.

Proof:
  Since K_A*J_A subset J_A, there is a short exact sequence

    0 -> J_A/(K_A*J_A)
      -> A/(K_A*J_A)
      -> A/J_A
      -> 0.

  The first term has length at most twelve and the last has length r.  Therefore
  the middle term has length at most r+12.

  Since A has length N, the dimension of the ideal K_A*J_A is at least

    N-(r+12).
Qed.

--------------------------------------------------------------------------
7. THE TWO-COPY HOM CARRIER
--------------------------------------------------------------------------

The standard two-cut carrier applies to

    H=H_1(f,g;B),
    E=Ann_A(H).

Theorem H10_two_copy_Koszul_annihilator_carrier:
  There is a natural C-linear injection

    E direct_sum E -> Hom_B((f,g)B,A).

Hence

    dim_C Hom_B((f,g)B,A) >= 2*dim_C E.

Proof:
  Let

    M:=Syz_B(f,g).

  Then

    H=M/B*(-g,f).

  A B-linear homomorphism (f,g)B->A corresponds to a pair (alpha,beta) in A^2
  whose functional on B^2 vanishes on M.

  Because f=g=0 in A, the coordinate maps on M descend to H.  If alpha,beta are
  in E=Ann_A(H), multiplication by either coefficient kills both coordinate maps
  on H.  Therefore every pair in E^2 gives a well-defined B-linear map

    (f,g)B -> A.

  Distinct pairs give distinct maps, yielding the injection.
Qed.

Corollary H10_product_ideal_gives_two_copy_carrier:
  One has

    dim_C Hom_B((f,g)B,A)
      >= 2*dim_C(K_A*J_A)
      >= 2*(N-r-12).
Qed.

Theorem H10_two_cut_maps_inject_into_the_full_tangent_space:
  There is a natural injection

    Hom_B((f,g)B,A) -> Hom_S(I,A).

Proof:
  The quotient I/Q is the B-ideal (f,g)B.  S-linear maps I->A that vanish on Q
  are exactly B-linear maps (f,g)B->A.  They form a linear subspace of
  Hom_S(I,A).
Qed.

Corollary universal_H10_tangent_lower_bound:
  One has

    t(A):=dim_C Hom_S(I,A)
      >= 2*N-2*r-24.
Qed.

--------------------------------------------------------------------------
8. H10 FAILS THE ORDER-13 TANGENT GATE
--------------------------------------------------------------------------

The necessary order-13 gate is

    t(A)<=N-20.

Theorem H10_tangent_excess_is_strictly_positive:
  One has

    t(A)-(N-20) >= N-2*r-4 >= 2*r-4 >=2.

Proof:
  The tangent lower bound gives

    t(A)-(N-20)
      >= (2*N-2*r-24)-(N-20)
      = N-2*r-4.

  The length estimate N>=4r gives

    N-2*r-4 >= 2*r-4.

  Finally r>=3 gives

    2*r-4>=2.
Qed.

Corollary H10_violates_the_order13_tangent_gate:
  One has

    t(A)>N-20.

Thus no H10 endpoint can satisfy the necessary order-13 tangent condition.
Qed.

--------------------------------------------------------------------------
9. SHARP BOUNDARY
--------------------------------------------------------------------------

The exact H10 state is now closed by the tangent gate, uniformly across

    H10-OFF,
    H10-ON,

and uniformly across both colon Hilbert possibilities

    Hilb_T=t+2*t^2,
    Hilb_T=t+2*t^2+t^3.

The proof did not require choosing an incidence or deciding which short/long
colon combinations occur.  It used only the already established structural
facts

    T ~= S/K(-1),
    length(S/K)<=4,
    J height-three linear,
    D ~= S/J(-1),
    d,e>=3.

NEWLY_CLOSED:
  q4_height2_multiplicity_one_depth_one_H10_tangent_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT close H00, H01, or H11.
  It does NOT close the full multiplicity-one depth-one branch.
  It does NOT close q=4 height two.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H10_tangent_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Return to the remaining multiplicity-one Hilbert states

    H00: (u1,u2)=(0,3), Hilb_D=2*t/(1-t),
    H01: (u1,u2)=(0,2), Hilb_D>=(2*t+t^2)/(1-t),
    H11: (u1,u2)=(1,3), Hilb_D>=(t+t^2)/(1-t),

and attack only the smallest exact state H00 next.

NEXT_ACTIONS:
  1. Leave H10; it is tangent-closed.
  2. Stay in q=4 height-two multiplicity one.
  3. Enter only H00.
  4. Classify its exact two-generator residual module D.
  5. Stop before H01, H11, or q<=3.
