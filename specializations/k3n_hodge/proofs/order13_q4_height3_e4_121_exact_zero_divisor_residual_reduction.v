Standalone exact-zero-divisor residual reduction for the multiplicity-four
h=(1,2,1) subbranch of the homogeneous q=4, height-three order-13
low-multiplicity problem.

SCOPE:
  Continue from

    order13_q4_height3_e345_exact_saturation_linkage_table.v
    order13_q4_height3_degree3_hvector_linkage_impossible.v
    order13_q4_height3_e4_121_residual_linear_pair_reduction.v

  Work only with

    S := C[x1,x2,x3,x4],
    R := S/(q1,q2,q3),

  where q1,q2,q3 are a homogeneous regular sequence of quadrics, and with

    q := image of q4 in R,
    J := q*R,
    U := saturation(J),
    K := 0:_R q,
    B := R/J,
    T := U/J,

  the selected saturated-core row is

    e(B)=4,
    h(Cbar/ell*Cbar)=(1,2,1),
    Cbar=R/U.

The preceding residual-linear-pair reduction proves

    Hilb_K(t)=Hilb_U(t)=(t+2*t^2+t^3)/(1-t),
    dim_C K_1=dim_C U_1=1,

and chooses nonzero linear classes

    u in K_1,
    v in U_1

with

    u*v=0 in R.

It then leaves a formal PRINCIPAL_U versus NONPRINCIPAL_U split.

This file proves that the NONPRINCIPAL_U alternative cannot occur.  The key
point is specific to the three-quadric complete intersection: two nonzero
linear zero divisors whose product vanishes can be used to rebase one of the
three quadratic equations as their product.  The resulting complete-
intersection colon computation makes u and v an exact zero-divisor pair.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

Theorem uv_can_be_chosen_as_one_complete_intersection_quadric:
  There exist homogeneous quadrics p2,p3 in S such that, after choosing linear
  lifts of u and v to S_1,

    (q1,q2,q3)=(u*v,p2,p3),

  and

    u*v, p2, p3

  is a homogeneous regular sequence.

Proof:
  The equality u*v=0 in R means that the nonzero quadratic polynomial u*v lies
  in the degree-two part of (q1,q2,q3).  Since the original three quadrics are
  linearly independent, their degree-two span is three-dimensional.  Extend
  u*v to a basis

    u*v, p2, p3

  of that span.  This invertible constant change of generators preserves the
  ideal.

  The ideal has height three and is generated minimally by three elements in
  the regular ring S.  Hence it is a complete intersection, and the displayed
  minimal homogeneous generators form a regular sequence.
Qed.

Theorem u_and_v_are_regular_modulo_the_other_two_quadrics:
  Put

    D := S/(p2,p3).

  Then multiplication by u and by v are both injective on D.

Proof:
  Regular sequences in the polynomial ring may be permuted, so

    p2,p3,u*v

  is regular.  Therefore u*v is a nonzerodivisor on D.

  If u*x=0 in D, then

    (u*v)*x=v*(u*x)=0.

  Since u*v is a nonzerodivisor, x=0.  Thus u is a nonzerodivisor.  The same
  argument with u and v interchanged proves that v is a nonzerodivisor.
Qed.

Theorem exact_complete_intersection_colons:
  In S one has

    ((u*v,p2,p3):v)=(u,p2,p3),
    ((u*v,p2,p3):u)=(v,p2,p3).

Proof:
  We prove the first identity.  Let f satisfy

    f*v in (u*v,p2,p3).

  Modulo (p2,p3) this says in D that

    f*v=a*u*v

  for some a.  Hence

    v*(f-a*u)=0.

  The preceding theorem makes v a nonzerodivisor on D, so

    f-a*u=0 mod (p2,p3).

  Thus f belongs to (u,p2,p3).  The reverse inclusion is immediate.  The
  second equality is symmetric.
Qed.

Corollary u_and_v_form_an_exact_zero_divisor_pair_in_R:
  One has

    0:_R v=u*R,
    0:_R u=v*R.

Proof:
  Pass the preceding colon identities to

    R=S/(u*v,p2,p3).
Qed.

Theorem the_residual_pair_is_forced_principal:
  One has exactly

    K=u*R,
    U=v*R.

  Consequently the NONPRINCIPAL_U case of

    order13_q4_height3_e4_121_residual_linear_pair_reduction.v

  is empty.

Proof:
  Because v belongs to U and K=0:_R U,

    K subseteq 0:_R v=uR.

  Since u belongs to K, the reverse inclusion uR subseteq K is automatic.
  Hence K=uR.

  The linkage identity U=0:_R K now gives

    U=0:_R u=vR.
Qed.

Corollary the_strict_linear_annihilator_defect_vanishes:
  With

    H_v:=(0:_R v)/K,

  one has

    H_v=0.

  Thus no residual-annihilator profile beginning in degree one, two, three, or
  later survives: the entire nonprincipal profile is impossible.
Qed.

Theorem the_residual_ring_is_a_linear_two_quadric_complete_intersection:
  Put

    C0:=R/K=R/uR.

  Then

    C0 ~= S/(u,p2,p3),

  so C0 is a one-dimensional complete intersection of degrees

    (1,2,2).

  In particular C0 is Cohen--Macaulay and Gorenstein and

    Hilb_C0(t)=(1+2*t+t^2)/(1-t).

Proof:
  Since R=S/(u*v,p2,p3) and K=uR, quotienting by u makes the equation u*v
  redundant and gives the displayed presentation.

  From the preceding regularity theorem, p2,p3,u is a regular sequence.
  Hence the quotient is a complete intersection.  The Hilbert series is

    ((1-t)*(1-t^2)^2)/(1-t)^4
      =(1+t)^2/(1-t)
      =(1+2*t+t^2)/(1-t).
Qed.

Theorem the_fourth_quadric_has_forced_linear_factorization:
  There exists a homogeneous linear form c in R_1 such that

    q=v*c.

  Its image in C0 is a nonzerodivisor.

Proof:
  The ideal qR is contained in U=vR, while q has degree two and v degree one.
  Therefore q=v*c for a homogeneous linear c.

  Multiplication by v identifies

    C0(-1) ~= vR=U,

  because 0:_R v=uR=K.  Hence

    T=U/qR ~= (C0/c*C0)(-1).

  The established torsion Hilbert series

    Hilb_T=t+2*t^2+t^3

  makes C0/c*C0 finite-dimensional.  Since C0 is one-dimensional
  Cohen--Macaulay, c is a parameter and therefore a nonzerodivisor.
Qed.

Put

  Z:=C0/c*C0.

Corollary the_length_four_action_ring_is_artin_complete_intersection:
  One has

    T ~= Z(-1),

  and Z is a standard graded Artin complete intersection with

    Hilb_Z(t)=1+2*t+t^2,
    length_C(Z)=4.

  In particular Z is Gorenstein with one-dimensional socle Z_2.

Proof:
  The module identification is the preceding theorem.  Since

    C0~=S/(u,p2,p3)

  is the complete intersection (1,2,2) and c is C0-regular, one has

    Z~=S/(u,c,p2,p3),

  a zero-dimensional complete intersection of degrees (1,1,2,2).  Its Hilbert
  series is 1+2*t+t^2, and every complete intersection is Gorenstein.
Qed.

Corollary exact_torsion_annihilator_quotient:
  In B=R/(v*c),

    Ann_B(T)=(uR+cR)/(v*cR),

    B/Ann_B(T) ~= Z,

  and

    length_C(B/Ann_B(T))=4.

Proof:
  This is the principal-U annihilator computation from the preceding file,
  now unconditional because U=vR and K=uR have been proved.
Qed.

We can now sharpen the possible self-action of the embedded torsion.

Let

  pi:T -> B/Ann_B(T) ~= Z

be the map induced by the inclusion T subset B followed by the annihilator
quotient.

Theorem exact_length_four_torsion_self_action_dichotomy:
  Under the identification

    T~=Z(-1),

  the map pi is a degree-zero Z-linear map

    Z(-1) -> Z.

  It is multiplication by a unique linear class

    lambda in Z_1.

  Exactly one of the following occurs.

  ZERO_SELF_ACTION:
    lambda=0,
    pi=0,
    Ann_B(T) intersect T=T,
    T^2=0.

  NONZERO_SELF_ACTION:
    lambda!=0,
    Hilb_(Ann_B(T) intersect T)(t)=t^2+t^3,
    length_C(Ann_B(T) intersect T)=2.

Proof:
  Both source and target are Z-modules, and the quotient map is B-linear, hence
  Z-linear.  A degree-zero map Z(-1)->Z is determined by the image of the
  shifted degree-zero generator, which lies in Z_1.  Call it lambda.

  If lambda=0, the map vanishes.  Its kernel is all of T, and the kernel of the
  inclusion-quotient map is exactly Ann_B(T) intersect T.  The equality
  T subseteq Ann_B(T) is equivalent to T^2=0.

  Suppose lambda!=0.  Because Z is Artin Gorenstein with Hilbert function
  (1,2,1), multiplication gives a perfect pairing

    Z_1 x Z_1 -> Z_2.

  Therefore multiplication by lambda has ranks

    Z_0 -> Z_1 : 1,
    Z_1 -> Z_2 : 1,
    Z_2 -> Z_3 : 0.

  After the shift T~=Z(-1), the kernel has one dimension in degree two and one
  dimension in degree three, and none in degree one.  Hence its Hilbert series
  is t^2+t^3 and its length is two.
Qed.

Finally record the exact regular-cubic section sizes of the torsion
annihilator.  Put

  J_T:=Ann_B(T).

Theorem regular_cubic_annihilator_sections_have_only_two_lengths:
  Let r in B_3 be homogeneous with image rbar a nonzerodivisor on Cbar.
  Then

    0:_B r=T,
    0:_(J_T) r=J_T intersect T.

  Consequently

    ZERO_SELF_ACTION  => length_C(J_T/r*J_T)=16,
    NONZERO_SELF_ACTION => length_C(J_T/r*J_T)=14.

Proof:
  Since m_B^3*T=0, every cubic kills T.  If r*x=0 in B, projection to Cbar
  gives rbar*xbar=0.  Regularity of rbar forces xbar=0, so x belongs to T.
  Thus 0:_B r=T.

  Intersecting with J_T gives

    0:_(J_T) r=J_T intersect T.

  The quotient B/J_T has finite length four, so J_T and B have the same
  one-dimensional multiplicity four.  The multiplication exact sequence by
  the cubic r gives

    length(J_T/rJ_T)
      =3*e(J_T)+length(0:_(J_T) r)
      =12+length(J_T intersect T).

  Apply the self-action dichotomy, whose kernel lengths are four and two.
Qed.

Interpretation:
  The apparent residual alternative in the preceding e=4, h=(1,2,1) file is
  eliminated by the complete-intersection colon calculation.  The saturation
  hull is forced principal, and the residual linear classes form an exact
  zero-divisor pair

    0:_R u=vR,
    0:_R v=uR.

  Thus the length-four torsion is not an arbitrary module with Hilbert function
  (1,2,1) shifted by one.  It is the shifted regular linear section of the
  complete intersection C0=S/(u,p2,p3), and its faithful action quotient is an
  Artin Gorenstein complete intersection of length four.

  The only remaining torsion-action distinction is whether the class lambda of
  v in Z vanishes.  A nonzero self-action leaves exactly a two-dimensional
  annihilator intersection; zero self-action makes T square-zero.  The
  corresponding regular-cubic sections of Ann_B(T) have exact lengths fourteen
  and sixteen.

IMPORTANT_NONCONCLUSION:
  This file does NOT close the full e=4, h=(1,2,1) height-three branch.

  In particular it does not yet pass the final-cut pair to its degree-two
  saturated-core predecessors, and it does not prove that every relevant
  connecting carrier has excess at most fifteen.

  It makes no claim for the remaining e=3 rows, q=4 height two, homogeneous
  q<=3, the unrestricted nonhomogeneous frontier, or generic F_13 algebraicity.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  not e4_h121_height3_closed.
  not q4_height3_low_multiplicity_tangent_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Pass the final-cut pair to the degree-two predecessors

    K_i=(a,ell^i*b)

  forced by stabilization of Cbar in degree two.  Use the exact action split
  above to bound the first delayed carrier: the NONZERO_SELF_ACTION cubic
  section has length fourteen, while the ZERO_SELF_ACTION cubic section has
  length sixteen.

NEXT_BOUNDED_OBJECT:
  Derive the quadratic predecessor factorization for e=4, h=(1,2,1).  Split the
  first delayed layer by ZERO_SELF_ACTION versus NONZERO_SELF_ACTION.  Close
  the nonzero case if the length-fourteen section forces connecting excess at
  most fifteen; otherwise stop at the first explicit quadratic colon that can
  still reach sixteen.