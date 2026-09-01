Standalone closure of the stable Bockstein compensation sector in the
homogeneous q=4, height-three, multiplicity-six order-13 zerodivisor
unequal-degree endpoint.

SCOPE:
  Continue from

    order13_q4_e6_zerodivisor_conormal_ext_reduction.v,
    order13_q4_e6_zerodivisor_stable_layer_reduction.v,
    order13_q4_e6_stable_layer_bockstein_classification.v,
    order13_q4_e6_zerodivisor_degree_gap_one_closed.v.

  Work in the established setup

    J_i := (a, ell^i*b),
    A   := B/(ell^r*J_k),
    0 <= i <= k,
    r>=1,
    k>=1,

  where ell is a homogeneous nonzerodivisor on the one-dimensional
  Cohen--Macaulay ring B, a is a nonzero quadratic zerodivisor, and J_k is
  m-primary.

  Put

    H    := (a:b),
    Hsat := H:ell^infinity.

  The preceding Bockstein classification proves

    Hsat=(a):ell^infinity,
    ell*(Hsat/H)=0,

  and, for every i>=2,

    W_i:=J_(i-1)/J_i ~= B/(Hsat,ell)

  up to grading shift.

  For the fixed final target A define

    Delta_i := dim_C Hom_B(J_(i-1),A)
               - dim_C Hom_B(J_i,A).

  The preceding stable-layer reduction gives

    Delta_i
      = dim_C Hom_B(W_i,A) - rho_i,

  where rho_i is the rank of the connecting map

    Hom_B(J_i,A) -> Ext^1_B(W_i,A)

  attached to

    0 -> J_i -> J_(i-1) -> W_i -> 0.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
does not assert generic F_13 algebraicity.

Lemma saturated_colon_is_reached_after_one_ell:
  For every n>=1,

    H:ell^n = Hsat.

Proof:
  Since Hsat/H is killed by ell,

    ell*Hsat subseteq H.

  Hence every x in Hsat belongs to H:ell, and therefore to H:ell^n for every
  n>=1.

  Conversely every H:ell^n is contained in the saturation Hsat by definition.
  Thus equality holds.
Qed.

Theorem stable_layer_has_exact_cyclic_annihilator:
  For every i>=2, the class

    t_i := ell^(i-1)*b mod J_i

  generates W_i and has annihilator

    Ann_B(t_i)=(Hsat,ell).

Proof:
  The class t_i generates because J_(i-1)=(a,ell^(i-1)*b) and a vanishes
  modulo J_i.

  If c*t_i=0 in W_i, then for some u,v in B,

    c*ell^(i-1)*b
      = u*a + v*ell^i*b.

  Therefore

    (c-v*ell)*ell^(i-1)*b belongs to (a),

  so

    c-v*ell belongs to (a:ell^(i-1)*b)
                    = ((a:b):ell^(i-1))
                    = Hsat

  by the preceding lemma.  Hence c belongs to (Hsat,ell).

  Conversely, ell kills t_i modulo J_i.  If h belongs to Hsat, then

    h belongs to H:ell^(i-1),

  so ell^(i-1)*h*b belongs to (a), hence h kills t_i modulo J_i.
  Thus (Hsat,ell) is exactly the annihilator.
Qed.

Put

  I := (Hsat,ell),
  N := 0:_A Hsat.

For every y in N define a B-linear map

  phi_y:J_i -> A

by

  phi_y(a)=0,
  phi_y(ell^i*b)=y.

Lemma phi_y_is_well_defined:
  For every i>=2 and every y in N, the displayed assignment defines a unique
  B-linear map J_i -> A.

Proof:
  Consider a relation

    u*a + v*ell^i*b=0

  in J_i.  Then

    v*ell^i*b belongs to (a),

  so

    v belongs to (a:ell^i*b)
      = H:ell^i
      = Hsat.

  Since y is annihilated by Hsat, one has v*y=0.  Hence every relation among
  the two displayed generators is respected by the assignment.
Qed.

Theorem stable_connecting_map_has_full_Hom_rank:
  For every i>=2, the connecting map

    partial_i:
      Hom_B(J_i,A) -> Ext^1_B(W_i,A)

  has rank at least

    dim_C Hom_B(W_i,A).

Proof:
  By the exact cyclic-annihilator theorem,

    W_i ~= B/I

  up to grading shift.  Use the standard cyclic presentation

    0 -> I -> B -> B/I -> 0.

  The extension

    0 -> J_i -> J_(i-1) -> W_i -> 0

  is the pushout of this cyclic presentation along

    sigma_i:I -> J_i,
    c |-> c*ell^(i-1)*b.

  Indeed B -> J_(i-1), 1 |-> ell^(i-1)*b, together with the inclusion
  J_i -> J_(i-1), gives the natural morphism of extensions, and J_i plus the
  displayed generator equals J_(i-1).

  For y in N, compose sigma_i with phi_y.  The resulting map

    f_y:I -> A

  satisfies

    f_y(ell)=y,
    f_y(h)=0  for every h in Hsat.

  The first identity is immediate from

    ell*ell^(i-1)*b=ell^i*b.

  For h in Hsat, the preceding lemma gives

    h in H:ell^(i-1),

  so h*ell^(i-1)*b belongs to (a), and phi_y kills (a).

  Under

    Ext^1_B(B/I,A)
      ~= coker( Hom_B(B,A) -> Hom_B(I,A) ),

  the connecting class partial_i(phi_y) is therefore represented by f_y.

  The class of f_y vanishes exactly when f_y extends to a B-linear map
  B -> A.  Such a map is multiplication by some z in A.  The required
  equalities are

    h*z=0  for every h in Hsat,
    ell*z=y.

  Equivalently,

    z belongs to N,
    y belongs to ell*N.

  Thus the linear map

    N -> Ext^1_B(W_i,A),
    y |-> partial_i(phi_y)

  has kernel exactly ell*N.  Its rank is therefore

    dim_C(N/ell*N).

  Multiplication by ell preserves N.  Since A, hence N, is finite-dimensional,
  rank-nullity for ell:N->N gives

    dim_C(N/ell*N)
      = dim_C ker(ell:N->N).

  But

    ker(ell:N->N)
      = 0:_A(Hsat,ell)
      ~= Hom_B(B/(Hsat,ell),A)
      ~= Hom_B(W_i,A),

  where grading shifts are irrelevant for the ungraded B-linear Hom dimension.

  Hence the image of partial_i already contains a subspace of dimension

    dim_C Hom_B(W_i,A),

  as claimed.
Qed.

Corollary every_stable_layer_has_nonpositive_defect:
  For every i>=2,

    Delta_i <= 0.

Proof:
  Exactness gives

    rho_i = rank(partial_i).

  The preceding theorem yields

    rho_i >= dim_C Hom_B(W_i,A).

  Therefore

    Delta_i
      = dim_C Hom_B(W_i,A)-rho_i
      <= 0.
Qed.

Corollary stable_sector_cannot_supply_positive_net_defect:
  For every k>=2,

    sum_(i=2)^k Delta_i <= 0.
Qed.

Corollary full_zerodivisor_unequal_degree_e6_endpoint_fails_tangent_gate:
  In the homogeneous q=4, height-three, multiplicity-six zerodivisor
  unequal-degree endpoint, for every k>=1,

    length_C(E_0)+delta_k <= 18.

  Consequently the necessary order-13 tangent gate

    dim_C Hom_S(I,A) <= N-20

  is impossible throughout this endpoint.

Proof:
  The preceding degree-gap-one file proves uniformly for the same family of
  targets A that

    length_C(E_0)<=12,
    Delta_1<=6.

  The stable-layer reduction proves

    delta_k=sum_(i=1)^k Delta_i.

  By the stable compensation inequality just proved,

    delta_k
      <= Delta_1
      <= 6.

  Hence

    length_C(E_0)+delta_k
      <=12+6
      =18.

  The conormal--Ext reduction proves that any candidate passing the necessary
  tangent gate must instead satisfy

    length_C(E_0)+delta_k>=20.

  Contradiction.
Qed.

Interpretation:
  The eight possible h-vector shapes of V do not need a separate first-syzygy
  census for the stable compensation inequality.  The decisive structure is
  the saturated colon identity together with ell*(Hsat/H)=0.

  Those facts make every stable quotient W_i cyclic with the same annihilator
  (Hsat,ell), and the full annihilator module N=0:_A Hsat supplies enough
  explicit maps J_i->A to force the connecting rank to dominate
  Hom_B(W_i,A).

IMPORTANT_NONCONCLUSION:
  This closes only the homogeneous q=4, height-three, multiplicity-six
  zerodivisor unequal-degree endpoint described above.

  It does not close the height-three e(B)<=5 branches, the height-two q=4
  branch, homogeneous q<=3, the unrestricted nonhomogeneous local frontier,
  or generic F_13 algebraicity.

BOUNDARY:
  The next unresolved order-13 local branch is outside this e(B)=6
  zerodivisor unequal-degree endpoint.

NEXT_BOUNDED_OBJECT:
  Return to the existing order-13 branch inventory and select the strongest
  still-open local branch after removing this endpoint.  Do not revisit the
  eight stable h-vector shapes unless an independent verifier finds an error
  in the saturated-colon connecting-rank argument above.
