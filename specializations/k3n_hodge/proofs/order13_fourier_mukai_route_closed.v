Standalone no-go certificate for the Fourier--Mukai / moduli-of-sheaves route
for the primitive degree-six F_13 real-multiplication generator.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let X be a very general member of the one-dimensional F_13-RM family
  through the order-13 CM point constructed in order13_cm_point_on_rm_curve.v.

  Let

    F := Q(zeta_13 + zeta_13^(-1)),
    alpha := zeta_13 + zeta_13^(-1).

  For the very general X,

    End_Hod(T(X)_Q) = F.

  The polarization q on T(X)_Q satisfies

    q(a*x,y) = q(x,a*y)

  for every a in F because F is totally real.

ExternalResult DerivedTorelliForK3:
  If X and Y are K3 surfaces, then a Fourier--Mukai equivalence

    D^b(X) ~= D^b(Y)

  induces a Hodge isometry

    T(X) ~= T(Y).

  Conversely, a Hodge isometry of transcendental lattices gives derived
  equivalence.

  This is the Mukai--Orlov derived Torelli theorem.

ExternalResult ModuliOfSheavesMukaiIsometry:
  Let M_H(v) be a smooth projective moduli space of stable sheaves on a K3
  surface X with primitive algebraic Mukai vector v.  The universal or
  quasi-universal sheaf induces Mukai's map

    theta_v : v^perp -> H^2(M_H(v),Q),

  which is a Hodge isometry onto its natural image, up to the harmless
  rational similitude coming from a quasi-universal family.

Theorem very_general_F13_hodge_isometries_are_only_plus_minus_identity:
  Let

    u in End_Hod(T(X)_Q) = F

  be a rational Hodge isometry of the transcendental lattice. Then

    u = +1 or u = -1.

Proof:
  Since F is totally real, every u in F is self-adjoint for q. Thus

    q(u*x,u*y) = q(x,u^2*y).

  If u is an isometry, then also

    q(u*x,u*y) = q(x,y)

  for all x,y. Nondegeneracy of q gives

    u^2 = 1

  as an element of the field F. Hence

    (u-1)(u+1)=0.

  Because F is a field,

    u=1 or u=-1.
Qed.

Corollary primitive_alpha13_is_not_a_Hodge_isometry:
  Multiplication by alpha on T(X)_Q is not a Hodge isometry.

Proof:
  The element alpha has degree 6 over Q, hence alpha is neither +1 nor -1.
  Apply the previous theorem.
Qed.

Theorem Fourier_Mukai_partner_route_cannot_realize_primitive_alpha13:
  No construction obtained solely by composing Fourier--Mukai equivalences
  between K3 surfaces and then returning to X can induce multiplication by
  alpha on T(X)_Q.

Proof:
  Each Fourier--Mukai equivalence induces a Hodge isometry on transcendental
  cohomology. A composition which starts and ends at X is therefore a Hodge
  isometry of T(X)_Q. By

    very_general_F13_hodge_isometries_are_only_plus_minus_identity,

  its action is only +Id or -Id. This is not alpha.
Qed.

Theorem standard_K3_moduli_kernel_and_transpose_route_cannot_realize_alpha13:
  Let M_H(v) be a smooth moduli space of stable sheaves on X, and use only
  the cohomological transform supplied by a universal/quasi-universal sheaf,
  its inverse or transpose on the Mukai-isometric summand, and compositions
  of such Mukai-lattice isometries.  Then the resulting endomorphism of
  T(X)_Q is a rational scalar times a Hodge isometry. In particular it cannot
  equal multiplication by the primitive element alpha.

Proof:
  The transcendental lattice lies in v^perp because v is algebraic.
  Mukai's theta_v restricts there to a Hodge isometry, up to the rational
  similitude introduced by a quasi-universal family. Returning through its
  inverse/transpose therefore gives a rational scalar times a Hodge
  isometry of T(X)_Q.

  By the first theorem the isometric factor is +Id or -Id, so every such
  operator lies in Q*Id. But alpha is not rational.
Qed.

Boundary:
  the standard Fourier--Mukai partner route is closed negatively
  the standard universal-sheaf plus inverse/transpose moduli route is closed
    negatively
  this does NOT rule out an arbitrary algebraic correspondence on a
    higher-dimensional moduli space or hyperkahler variety; allowing such an
    extra correspondence simply introduces a new algebraicity problem and is
    not supplied by the Fourier--Mukai formalism itself
  no claim is made that all possible correspondences factoring through
    moduli spaces are impossible
  the surviving weakest gap remains the family-specific invariant-cycle
    algebraicity implication for z_alpha,13(t)
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
  no ZeroDayClosure semantics are used
  no required-class index is used

Result:
  canonical Fourier--Mukai / moduli-of-sheaves realization of the primitive
  F_13 generator alpha is CLOSED NEGATIVELY.

Next action:
  do not pursue derived-equivalence kernels further; attack only a genuinely
  non-isometric algebraic correspondence or the family-specific
  invariant-cycle algebraicity boundary.