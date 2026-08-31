Standalone global fixed-part reduction for the order-13 / degree-six RM correspondence.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let

    pi : X -> C

  be the connected one-dimensional smooth projective F_13-RM family through
  the order-13 CM K3 surface X_13 constructed in

    order13_cm_point_on_rm_curve.v.

  Let

    f : Y := X x_C X -> C

  be the relative self-product.

  Let

    z_alpha,13 in H^0(C,R^4 f_* Q(2))

  be the flat degree-four class whose CM-fiber value is the algebraic class
  of the corrected correspondence Z_alpha,13 and whose action on the
  rank-18 deformation lattice is multiplication by

    alpha = zeta_13 + zeta_13^(-1).

ExternalResult DeligneFixedPart:
  Let f:V->S be a smooth projective morphism over a connected
  quasi-projective complex variety, and let Vbar be any smooth projective
  compactification of V.  Then the natural map

    H^k(Vbar,Q) -> H^0(S,R^k f_* Q)

  is surjective.

  The target is the monodromy-invariant part of the fiber cohomology and
  carries its natural polarizable rational Hodge structure; the displayed
  map is a morphism of Hodge structures.

Source:
  Pierre Deligne,
  Theorie de Hodge II / theorem of the fixed part,
  and standard expositions of the Global Invariant Cycle Theorem.

Theorem order13_alpha_has_global_hodge_fixed_part_lift:
  Choose a smooth projective compactification

    Ybar superset Y.

  Then there exists

    Zeta_alpha,13 in H^4(Ybar,Q(2))

  of Hodge type (0,0), equivalently a rational (2,2)-class before the Tate
  twist, whose restriction to every fiber X_t x X_t equals

    z_alpha,13(t).

Proof:
  The flat section z_alpha,13 is monodromy invariant, hence lies in

    H^0(C,R^4 f_* Q(2)).

  Deligne's fixed-part theorem gives a surjection

    H^4(Ybar,Q(2)) -> H^0(C,R^4 f_* Q(2)).

  Both sides are polarizable pure rational Hodge structures of weight zero,
  and the map is a morphism of Hodge structures.  The category of
  polarizable rational Hodge structures is semisimple, so this surjection
  admits a Hodge-theoretic splitting.  Since z_alpha,13 has type (0,0), its
  image under such a splitting is a rational type-(0,0) class

    Zeta_alpha,13 in H^4(Ybar,Q(2)).

  By construction its restriction to every fiber is z_alpha,13(t).
Qed.

Corollary algebraic_global_lift_closes_order13_RM_correspondence:
  If one can choose the fixed-part lift Zeta_alpha,13 above to be algebraic,
  i.e. if there exists

    Gamma_alpha,13 in CH^2(Ybar)_Q

  with

    cl(Gamma_alpha,13) = Zeta_alpha,13,

  then for every t in C the restriction

    Gamma_alpha,13 | (X_t x X_t)

  is an algebraic codimension-two correspondence inducing multiplication by
  alpha on T(X_t)_Q.  Hence a single algebraic global lift closes the
  primitive F_13 generator on every fiber of the RM curve.
Qed.

Theorem surface_only_Lefschetz_standard_route_is_insufficient:
  The fact that the Lefschetz standard conjecture is known for surfaces and
  for controlled products of varieties satisfying it does not by itself
  algebraize the Andre-motivated class z_alpha,13(t).

Reason:
  By definition, a motivated cycle on a smooth projective variety W may be
  written using algebraic cycles on W x A and the Lefschetz involution on
  W x A for an arbitrary auxiliary smooth projective variety A.  Andre's
  deformation principle proves existence of a motivated presentation after
  transport but does not constrain A to be a K3 surface or a product of K3
  surfaces.  Therefore known Lefschetz-standard results for the fiber alone
  do not remove the auxiliary inverse-Lefschetz operation.
Qed.

Boundary:
  the flat primitive F_13 class has an unconditional rational Hodge lift on a
    smooth projective compactification of the relative self-product
  the transported class is Andre-motivated on every RM fiber
  no algebraic global lift Gamma_alpha,13 is presently proved
  algebraicity of Zeta_alpha,13 is sufficient but is not claimed
  no general standard conjecture or variational Hodge conjecture is assumed
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
  no ZeroDayClosure semantics are used
  no required-class index is used

First missing object:
  an algebraic codimension-two class

    Gamma_alpha,13 in CH^2(Ybar)_Q

  whose cohomology class maps to the flat fixed-part section

    z_alpha,13 in H^0(C,R^4 f_* Q(2)).
