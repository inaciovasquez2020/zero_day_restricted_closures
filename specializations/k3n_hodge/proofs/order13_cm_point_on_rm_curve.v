Standalone proof that the isolated order-13 CM K3 is compatible with a maximal F_13 real-multiplication deformation at the rational Hodge/lattice level.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  F := Q(zeta_13 + zeta_13^(-1)),
  alpha := zeta_13 + zeta_13^(-1).

  Let X_13 be Kondo's unique K3 surface with a purely non-symplectic
  automorphism sigma of order 13.

ExternalResult Order13CMLattices:
  Artebani--Sarti--Taki give

    NS(X_13) ~= H_13 direct_sum E8(-1),
    T(X_13)  ~= U direct_sum H_13 direct_sum E8(-1),

  where

    H_13 = [[6,1],[1,-2]].

  They also exhibit a primitive sublattice

    U direct_sum E7(-1)  subset  NS(X_13).

  Source:
    Michela Artebani, Alessandra Sarti, Shingo Taki,
    K3 surfaces with non-symplectic automorphisms of prime order,
    Table 5 and the proof of Theorem 8.4.

Define

  L1 := U direct_sum <-4> direct_sum <-4>.

Theorem primitive_L1_specialization_embedding:
  There is a primitive embedding

    L1 -> NS(X_13).

Proof:
  Use the primitive U direct_sum E7(-1) exhibited by Artebani--Sarti--Taki.

  In the standard positive E8 coordinate model

    E8 = {x in Z^8 : sum(x_i) even}
         union
         {x in (Z+1/2)^8 : sum(x_i) even},

  choose the root

    f = e1-e2.

  Then E7 = f^perp.

  Inside E7 choose

    a = 2 e3,
    b = e4+e5+e6+e7.

  Both lie in E8, are orthogonal to f, and satisfy

    a^2 = b^2 = 4,
    a.b = 0.

  In E7(-1) their Gram matrix is diag(-4,-4).

  The rank-two lattice Z*a + Z*b is primitive in E7:
  if (m*a+n*b)/k belongs to E7, its first two coordinates are zero, so it
  cannot lie in the half-integral coset of E8. Hence it is integral.
  Integrality forces k|n and k|2m; the even-coordinate-sum condition then
  forces k|m. Thus the vector already lies in Z*a+Z*b.

  Therefore U direct_sum Z*a direct_sum Z*b is primitive in
  U direct_sum E7(-1), hence primitive in NS(X_13).
Qed.

Define

  K := L1^perp inside NS(X_13).

Theorem specialization_rank_jump:
  K is negative definite of rank 6, and rationally

    L1^perp in H^2(X_13,Q)
      = T(X_13)_Q direct_sum K_Q.

Proof:
  NS(X_13) has signature (1,9), while L1 has signature (1,3), so K has
  signature (0,6). Since L1 is primitive in NS(X_13), T(X_13)_Q and K_Q
  are orthogonal inside L1^perp and their dimensions 12+6 sum to 18.
Qed.

Exact lattice arithmetic for the above embedding:
  In a standard integral basis of H_13 direct_sum E8(-1), the orthogonal
  complement K has determinant

    det(K) = 208 = 16*13.

  The index of L1 direct_sum K in NS(X_13) is 16.

  One rational diagonalization of K_Q is

    <-26, -2, -13, -10/13, -7/10, -4/7>.

Now consider the one-dimensional F-quadratic space

  W_F := (F, h),
  h(x,y) := -x*y.

Its transfer to Q is

  Tr_F/Q(W_F)
    = (F, q_F),
  q_F(x,y) := -Tr_F/Q(x*y).

Theorem negative_trace_form_matches_rank_jump:
  There is a Q-isometry

    K_Q ~= (F, -Tr_F/Q(x*y)).

Proof:
  The minimal polynomial of alpha is

    x^6+x^5-5*x^4-4*x^3+6*x^2+3*x-1.

  In the power basis 1,alpha,...,alpha^5, the Gram matrix of
  -Tr_F/Q(x*y) is

    [ -6,   1, -11,   4,  -31,    16 ]
    [  1, -11,   4, -31,   16,   -98 ]
    [-11,   4, -31,  16,  -98,    64 ]
    [  4, -31,  16, -98,   64,  -327 ]
    [-31,  16, -98,  64, -327,   256 ]
    [ 16, -98,  64,-327,  256, -1126 ].

  Its determinant is 13^5.

  A rational diagonalization is

    <-6, -65/6, -52/5, -39/4, -26/3, -13/2>.

  Compare with the diagonalization of K_Q above.

  Both forms have:

    dimension = 6,
    signature = (0,6),
    determinant square-class = 13.

  Their local Hasse invariants agree:

    p=2  : +1,
    p=3  : +1,
    p=5  : +1,
    p=7  : +1,
    p=13 : -1,
    infinity : -1.

  At every other prime the displayed diagonal coefficients are p-adic
  units, so the local invariant is trivial.

  By the Hasse--Minkowski classification of rational quadratic forms,

    K_Q ~= (F,-Tr_F/Q(x*y)).
Qed.

Corollary rank_jump_carries_self_adjoint_F_action:
  K_Q admits a faithful F-action by multiplication, self-adjoint for its
  quadratic form.

Proof:
  On the negative trace form,

    q_F(a*x,y) = -Tr(a*x*y) = q_F(x,a*y)

  for every a in F because F is totally real and commutative.
  Transfer this action through negative_trace_form_matches_rank_jump.
Qed.

ExternalResult CMFActionOnSpecialTranscendental:
  The order-13 automorphism gives

    Q(zeta_13) subset End_Hdg(T(X_13)_Q).

  Restricting to the maximal totally real subfield F gives a self-adjoint
  F-action on T(X_13)_Q.  As an F-vector space,

    dim_F T(X_13)_Q = 12/6 = 2.

Theorem extend_F_action_to_rank18_deformation_lattice:
  The rational quadratic space

    T_L1,Q := L1^perp in H^2(K3,Q)

  admits a self-adjoint F-action extending the known F-action on
  T(X_13)_Q, with

    dim_F T_L1,Q = 3.

Proof:
  At the CM point,

    T_L1,Q = T(X_13)_Q direct_sum K_Q.

  Use the cyclotomic F-action on T(X_13)_Q and the negative-trace F-action
  on K_Q.  Both are self-adjoint and the sum is orthogonal.

  The dimensions over F are 2 and 1, respectively, hence total dimension 3.
Qed.

Theorem order13_CM_point_lies_on_an_F13_RM_period_curve:
  There is a one-dimensional local period family through X_13, preserving
  L1 as algebraic lattice and preserving the above F-action on T_L1,Q,
  whose very general member has real multiplication by F.

Proof:
  The F-vector dimension is 3.  At the distinguished real embedding of F,
  the CM transcendental summand supplies the positive oriented 2-plane and
  the added negative trace line supplies one negative direction; hence the
  distinguished F-real component has signature (2,1).

  At the other five real embeddings, both the CM part and the added trace
  line are negative definite, giving signature (0,3).

  Thus the F-action satisfies the standard K3 real-multiplication signature
  condition.  Vary the Hodge line in the corresponding F-linear period
  domain.  Its dimension is

    dim_F(T_L1,Q)-2 = 1.

  By the local Torelli/period theorem for marked K3 surfaces, these nearby
  periods are realized by K3 surfaces.  Since L1 remains of type (1,1) and
  contains U, they are projective.  For a very general period, the Hodge
  endomorphism field is exactly F rather than a larger field.
Qed.

Corollary alpha13_is_a_flat_Hodge_endomorphism_along_the_RM_curve:
  The element alpha in F defines a single flat rational endomorphism of the
  rank-18 local system T_L1,Q along this RM curve.

  At the special CM point X_13, its restriction to T(X_13)_Q is induced by

    Graph(sigma) + Graph(sigma^(-1)).

  Thus the order-13 transport problem is now a genuine variational-Hodge
  problem with a compatible special fiber, not merely a comparison of two
  unrelated K3 surfaces.
Qed.

Theorem corrected_special_fiber_alpha13_correspondence_is_algebraic:
  There is an algebraic rational codimension-two cycle

    Z_alpha,13 in CH^2(X_13 x X_13)_Q

  whose action on

    T_L1,Q = T(X_13)_Q direct_sum K_Q

  is multiplication by alpha.

Proof:
  Put

    G := Graph(sigma) + Graph(sigma^(-1)).

  For the unique order-13 surface, the rank-10 invariant lattice of sigma is
  NS(X_13). Hence sigma acts trivially on NS(X_13), so G acts as 2*Id on K_Q.
  On T(X_13)_Q, G acts as

    sigma^* + (sigma^*)^(-1) = alpha.

  Let alpha_K denote multiplication by alpha on K_Q through the isometry

    K_Q ~= (F,-Tr_F/Q(x*y))

  above, and set

    Delta := alpha_K - 2*Id_K.

  The operator Delta is self-adjoint for the intersection form on K_Q.

  Choose divisor classes D_1,...,D_6 forming a Q-basis of K_Q.  Their
  intersection matrix Q_K is nonsingular because K_Q is negative definite.
  If A is the matrix of Delta in this basis, choose rational coefficients
  c_ij satisfying

    C^T Q_K = A,

  where C=(c_ij).  This is possible because Q_K is invertible.

  Define the divisor-product correspondence

    C_K := sum_(i,j) c_ij (D_i x D_j)
           in CH^2(X_13 x X_13)_Q.

  By the standard action of divisor-product correspondences on H^2,
  C_K acts as Delta on K_Q.  It acts trivially on T(X_13)_Q because
  transcendental classes are orthogonal to NS(X_13), and trivially on L1_Q
  because every D_i lies in K_Q=L1_Q^perp inside NS(X_13)_Q.

  Therefore the algebraic cycle

    Z_alpha,13 := G + C_K

  acts on the orthogonal decomposition

    T_L1,Q = T(X_13)_Q direct_sum K_Q

  as alpha on both summands. Hence its action on all of T_L1,Q is
  multiplication by alpha.
Qed.

ExternalResult AndreDeformationPrincipleForMotivatedCycles:
  Let pi:Y->B be a smooth projective morphism with B connected and
  quasi-projective, and let

    nu in Gamma(B,R^(2p) pi_* Q(p))

  be a flat rational cohomology class.  If nu is a motivated cohomology
  class on one fiber, then it is motivated on every fiber.

Source:
  Yves Andre,
  Pour une theorie inconditionnelle des motifs,
  Publications Mathematiques de l'IHES 83 (1996), Theorem 0.5.

Corollary transported_alpha13_is_motivated_on_every_RM_fiber:
  After restricting the one-dimensional F_13-RM period family to a connected
  quasi-projective curve carrying the marked local system, the cohomology
  class of Z_alpha,13 has a flat continuation

    z_alpha,13(t) in H^4(X_t x X_t,Q(2)).

  For every t on this connected RM curve, z_alpha,13(t) is an Andre-motivated
  cohomology class.  In particular it is an absolute Hodge class.

Proof:
  The preserved F-action gives the flat alpha endomorphism on T_L1,Q.
  Extend it on the fixed algebraic subsystem L1_Q by the action 2*Id supplied
  by the graph sum at the CM fiber; the H^0 and H^4 graph components are also
  flat.  Via Kunneth and the polarization, these pieces define a single flat
  degree-four class z_alpha,13(t) on the relative self-product.

  At the special point t=0 this flat class is the cohomology class of the
  algebraic cycle Z_alpha,13, hence is motivated.  Apply Andre's deformation
  principle to the relative self-product.  Therefore z_alpha,13(t) is
  motivated for every t.  Motivated classes are absolute Hodge.
Qed.

Boundary:
  this file proves a compatible maximal F_13 RM period deformation through
    the isolated CM surface at the rational Hodge/lattice level
  it proves an algebraic corrected alpha_13 correspondence on the full
    rank-18 deformation lattice at the special CM fiber
  it does NOT prove that this corrected special-fiber alpha cycle spreads as
    an algebraic Chow cycle over the family
  it does NOT prove the generic F_13 endomorphism alpha is algebraic
  that remaining step is precisely a codimension-two variational-Hodge/spread
    problem on the relative self-product
  the local Hasse comparison above is arithmetic/source-checked but this .v
    file is pseudo-formal mathematical documentation, not a Coq proof
  no ZeroDayClosure semantics are used
  no required-class index is used
