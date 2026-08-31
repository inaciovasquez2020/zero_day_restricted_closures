Standalone closure of the equal-degree higher-cut branch in the homogeneous q=4, height-three, multiplicity-six order-13 endpoint.

SCOPE:
  Work in the already established setup

    S := C[x1,x2,x3,x4],
    Q subset S generated minimally by four independent quadrics,
    ht(Q)=3,
    B:=S/Q one-dimensional Cohen--Macaulay,
    e(B)=6.

  The preceding files prove

    Hilb_B(t)=(1+3*t+2*t^2)/(1-t),

  and, for a general linear nonzerodivisor ell,

    B ~= C[ell]
         direct_sum C[ell](-1)^3
         direct_sum C[ell](-2)^2

  as a graded C[ell]-module.

  Let the two higher-degree cuts have the same degree d>=3.  After a constant
  GL_2(C) change of the pair, assume the first cut is regular.  The Noether-
  parameter factorization from order13_q4_e6_noether_parameter_factorization.v
  then gives

    r := d-2,
    f = ell^r*a,
    g = ell^r*b,

  with a,b in B_2, a a nonzerodivisor, and

    J:=(a,b)

  m-primary.  Put

    L:=(f,g)=ell^r*J,
    A:=B/L,
    N:=length_C(A).

  The same preceding file proves that the quadratic core B/J has one of the
  two Hilbert functions

    (1,4,4,1)
    or
    (1,4,4),

  hence length(B/J) is respectively 10 or 9.

  The order-13 tangent gate would require

    t(A):=dim_C Hom_S(Q+(f,g),A) <= N-20.

This file proves that this is impossible for every equal-degree pair.

This is pseudo-formal mathematical documentation.  It is not Coq and does not
assert generic F_13 algebraicity.

Theorem common_parameter_factor_does_not_change_the_B_module_shape_of_the_cut_ideal:
  Multiplication by ell^r gives a B-module isomorphism

    J --times ell^r--> L.

Proof:
  Surjectivity is the definition L=ell^r J.  Injectivity holds because ell is
  a nonzerodivisor on B, hence so is ell^r.
Qed.

Define the graded annihilator

  E := 0:_A J.

Equivalently,

  E = (ell^r J :_B J) / ell^r J.

Theorem low_degrees_of_E_vanish_below_r:
  For every n<r,

    E_n=0.

Proof:
  Let x in B_n represent a homogeneous class in E_n.  Since a belongs to J_2,

    x*a in (ell^r J)_(n+2).

  But J has no components in degrees below two.  Since n<r,

    n+2-r < 2,

  so

    (ell^r J)_(n+2)=ell^r J_(n+2-r)=0.

  Hence x*a=0 in B.  The element a is a nonzerodivisor, because ell^r*a=f is
  a nonzerodivisor.  Therefore x=0.
Qed.

Theorem middle_window_of_E_has_dimension_at_most_twelve:
  One has

    dim_C E_r <= 6,
    dim_C E_(r+1) <= 6.

Proof:
  Since ell^r J starts in degree r+2, the denominator has no degree-r or
  degree-(r+1) part.  Thus

    E_r subseteq B_r,
    E_(r+1) subseteq B_(r+1).

  The forced Hilbert series of B gives

    dim_C B_n <= 6

  for every n>=1, with equality for n>=2.  Hence the two displayed bounds.
Qed.

Theorem tail_of_E_is_exactly_the_shifted_quadratic_core_tail:
  For every n>=r+2 there is a natural vector-space isomorphism

    E_n ~= (B/J)_(n-r).

Proof:
  Put k:=n-r>=2.  The C[ell]-free normal form of B implies that multiplication
  by ell^r is a vector-space isomorphism

    B_k --times ell^r--> B_n.

  Indeed both sides identify with B_2 after removing the corresponding power
  of ell.

  Thus every x in B_n has a unique expression

    x=ell^r*y,
    y in B_k.

  For such an x,

    x*J=ell^r*(yJ) subseteq ell^r J,

  so every class of B_n lies in the colon (ell^r J:J)_n.  Therefore

    E_n = B_n / ell^r J_k.

  Dividing by the vector-space isomorphism multiplication by ell^r identifies
  this quotient with

    B_k/J_k=(B/J)_k.
Qed.

Corollary annihilator_E_has_length_at_most_seventeen:
  One has

    length_C(E) <= 17.

  More precisely,

    length_C(E) <= 17

  in the core Hilbert-function case (1,4,4,1), and

    length_C(E) <= 16

  in the core Hilbert-function case (1,4,4).

Proof:
  The degrees below r contribute zero.  The two middle degrees r,r+1
  contribute at most 6+6=12.

  By the preceding tail theorem, all degrees n>=r+2 contribute exactly the
  tail of B/J beginning in degree two.  For the two possible core Hilbert
  functions these tail lengths are

    4+1=5

  and

    4,

  respectively.  Hence the total bounds are 12+5=17 and 12+4=16.
Qed.

Theorem multiplication_maps_give_large_two_cut_conormal_space:
  There is a natural linear map

    A -> Hom_B(J,A),
    c |-> (j |-> c*j),

  whose kernel is exactly E=0:_A J.

  Consequently

    dim_C Hom_B(J,A) >= N-length(E) >= N-17.

Proof:
  The displayed map is B-linear in the argument j.  Its kernel consists
  exactly of those c in A annihilating every element of J, which is E.

  Hence its image has dimension

    N-length(E).

  Since the image is a subspace of Hom_B(J,A), the claimed lower bound follows
  from the preceding annihilator estimate.
Qed.

Corollary equal_degree_cut_conormal_has_deficit_at_most_seventeen:
  Using J ~= L from the common-factor isomorphism,

    dim_C Hom_B(L,A) >= N-17.
Qed.

Theorem equal_degree_e6_branch_cannot_pass_order13_tangent_gate:
  The equal-degree q=4, ht(Q)=3, e(B)=6 branch cannot satisfy

    t(A) <= N-20.

Proof:
  The earlier Koszul-annihilator reduction proves a natural injection

    Hom_B(L,A) -> Hom_S(Q+(f,g),A).

  Hence

    t(A) >= dim Hom_B(L,A) >= N-17.

  But

    N-17 > N-20.

  Therefore the necessary tangent gate t(A)<=N-20 is impossible.
Qed.

Corollary equal_degree_quadratic_core_types_are_both_closed:
  Neither residual quadratic-core type

    Hilbert function (1,4,4,1)

  nor

    Hilbert function (1,4,4)

  can produce an order-13 tangent deficit of twenty when the two original
  higher-degree cuts have equal degree.
Qed.

Corollary dangerous_equal_degree_candidates_do_not_exist:
  In particular, the large-length equal-degree possibilities isolated earlier,
  including the forced d>=6 range when N>=32, are all ruled out before any
  annihilator-Hom classification or semiregularity computation is needed.
Qed.

BOUNDARY:
  This closes only the equal-degree part of the homogeneous q=4, ht=3, e=6
  endpoint.

  It does NOT treat the unequal-degree factorization

    J_k=(a,ell^k*b),
    k=e-d>0,

  nor the e<=5 height-three torsion cases, the q=4 height-two branch,
  homogeneous q<=3, or the unrestricted nonhomogeneous local frontier.

  No statement about generic F_13 algebraicity is made.

NEXT_BOUNDED_OBJECT:
  attack the unequal-degree e=6 branch

    (a,ell^k*b), k>0,

  using the same multiplication-map method.  Compute

    0:_(B/ell^r(a,ell^k b)) (a,ell^k b)

  degree by degree.  If its length is uniformly <20, the entire homogeneous
  e=6 endpoint closes without any Artin annihilator-module classification.
