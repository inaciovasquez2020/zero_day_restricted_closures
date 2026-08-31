Standalone no-go for producing the primitive degree-six F_13 correspondence from
finite-degree rational maps / geometric K3 isogenies.

This file is pseudo-formal mathematical documentation.  It does not assert the
Hodge conjecture, the invariant-cycle conjecture, or algebraicity of the generic
primitive F_13 generator.

Setup:
  Let X be a very general fiber of the one-dimensional F_13-RM family already
  constructed on this branch, with

    F_13 = Q(zeta_13 + zeta_13^(-1))

  and

    End_Hdg(T(X)_Q) = F_13.

  Let

    alpha = zeta_13 + zeta_13^(-1).

  Then [Q(alpha):Q] = 6.

ExternalResult FiniteDegreeK3MapGivesSimilarity:
  If gamma : X_1 -->> X_2 is a dominant rational map of finite degree d between
  complex projective K3 surfaces, then after resolving indeterminacies the
  induced pullback on rational transcendental lattices

    gamma_T^* : T(X_2)_Q -> T(X_1)_Q

  is a Hodge similarity of multiplier d:

    q_1(gamma_T^* x, gamma_T^* y) = d q_2(x,y).

  This is the dilation property used in the K3-isogeny literature; for prime
  degree it is stated explicitly by Boissiere-Sarti-Veniani, and the same
  projection-formula computation gives the finite-degree statement.

ExternalResult TotallyRealRosati:
  For a simple K3-type Hodge structure whose Hodge endomorphism field is totally
  real, the Rosati involution restricts to the identity on that field.  Hence if
  a in End_Hdg(T(X)_Q)=F_13 is a Hodge similarity of multiplier mu in Q^*, then

    a^2 = mu.

  This is the observation used in Varesco's Hodge-similarity analysis.

Lemma self_similarity_has_degree_at_most_two:
  Let

    a in End_Hdg(T(X)_Q) = F_13

  be induced by any finite composition of finite-degree rational K3 isogenies
  that starts and ends at X, allowing Hodge isometries between intermediate K3
  surfaces as additional factors.

  Then the composition is again a Hodge similarity, with multiplier equal to the
  product of the rational multipliers of the factors.  Therefore

    a^2 in Q^*.

  Consequently Q(a)/Q has degree at most two.
Qed.

Lemma quadratic_similarity_subfield_is_Qsqrt13:
  The extension F_13/Q is cyclic of degree six.  Hence it has a unique quadratic
  subfield.  For the real cyclotomic field of conductor 13 this subfield is

    Q(sqrt(13)).

  Therefore every self-similarity a above belongs to

    Q(sqrt(13)) subset F_13.
Qed.

Theorem rational_isogeny_loop_span_cannot_generate_alpha:
  Let S be the Q-vector subspace of End_Hdg(T(X)_Q) spanned by all endomorphisms
  obtained from finite compositions of finite-degree rational K3 isogenies that
  start and end at X, together with Hodge-isometric factors between intermediate
  K3 surfaces.

  Every generator of S lies in Q(sqrt(13)), hence

    S subseteq Q(sqrt(13)).

  But alpha has degree six over Q, so

    alpha notin Q(sqrt(13)).

  Therefore

    alpha notin S.

  In particular, neither a single dominant rational self-map, nor a finite chain
  of geometric K3 isogenies, nor a rational linear combination of such closed
  isogeny loops can realize the primitive F_13 generator on T(X)_Q.
Qed.

Important limitation:
  This theorem does NOT exclude an arbitrary algebraic codimension-two
  correspondence on X x X.  A general irreducible correspondence with both
  projections generically finite need not act as a Hodge similarity; its
  transpose-composition can contain residual correspondence terms.  Ruling such
  correspondences out would merely restate the open algebraicity problem and is
  not claimed here.

Boundary:
  canonical Fourier-Mukai/isometry routes are closed
  finite-degree rational self-map routes are closed
  finite chains and Q-spans of geometric K3 isogeny loops are closed
  arbitrary non-similarity codimension-two correspondences remain open
  family-specific invariant-cycle algebraicity remains the weakest missing bridge

First missing object:
  an algebraic codimension-two correspondence on a very general F_13-RM fiber
  whose action on T(X)_Q is the primitive element alpha and which is not generated
  by the similarity/isogeny mechanisms closed above.
