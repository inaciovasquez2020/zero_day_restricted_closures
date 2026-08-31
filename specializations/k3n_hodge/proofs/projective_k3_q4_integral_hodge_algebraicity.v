Standalone quotient-level integral Hodge algebraicity theorem for Hilbert schemes of
points on an arbitrary projective K3 surface.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a smooth complex projective K3 surface and X := S^[n] with n >= 4.

  Define

    Q4(X,Z) := H^4(X,Z) / Sym^2 H^2(X,Z).

  Let K(S) be the Mukai lattice, with Mukai vector convention

    v(x) = (rank(x), c1(x), chi(x) - rank(x)).

ExternalResult MarkmanQ4MukaiHodgeIsometry:
  Markman's map

    phi4 : K(S) -> Q4(X,Z)

  is an integral Hodge-isometry for n >= 4.

  It is obtained by first defining the algebraic/topological universal-ideal
  transform

    u(x) = p_X! ( p_S^!(-x^dual) cup [I_Z] )

  and then

    tilde_phi4(x) := c2(u(x)) in H^4(X,Z),
    phi4(x)       := [tilde_phi4(x)] in Q4(X,Z).

  Markman defines the Hodge structure on K(S) so that its integral (1,1)
  classes are exactly those x with c1(x) of Hodge type (1,1).

Sources:
  Eyal Markman,
  Integral constraints on the monodromy group of the hyperkahler resolution
  of a symmetric product of a K3 surface,
  Definition 1.13, equations (8)--(13), Theorem 1.14.

  Markman also records compatibility of algebraic and topological Gysin maps
  in section 1.4.

Theorem projective_k3_integral_hodge_mukai_lattice:
  The integral Hodge lattice of Q4 is Hodge-isometric to

    K(S)^(1,1) = H^0(S,Z) direct_sum NS(S) direct_sum H^4(S,Z).

  Consequently

    Q4(X,Z)_Hdg ~= U direct_sum NS(S),

  and if rho(S) := rank NS(S), then

    rank Q4(X,Z)_Hdg = rho(S) + 2.

Proof:
  By MarkmanQ4MukaiHodgeIsometry, integral Hodge classes in Q4 correspond
  exactly to integral (1,1) Mukai classes.

  For an integral Mukai vector (r,D,s), being of type (1,1) means precisely
  that D is an integral (1,1) class. By the Lefschetz (1,1) theorem on the
  projective K3 surface, D lies in NS(S).

  The H^0 and H^4 summands form the standard hyperbolic plane U, and the
  middle algebraic summand is NS(S).
Qed.

Explicit algebraic Mukai representatives:
  Let z := [O_s] for any closed point s in S.

  Define

    p := [O_S] - z,
    q := -z.

  Their Mukai vectors are

    v(p) = (1,0,0),
    v(q) = (0,0,-1),

  and they span the U-plane.

  For any divisor class D in NS(S), define

    x_D := [O_S(D)] - [O_S] - (D^2/2) z.

  The K3 lattice is even, so D^2/2 is an integer, and

    v(x_D) = (0,D,0).

Theorem every_integral_hodge_mukai_class_is_algebraic:
  Every integral class x in K(S)^(1,1) is represented by an algebraic
  K-theory class.

Proof:
  Write its Mukai vector as

    v(x) = (r,D,s)

  with D in NS(S).

  Then the algebraic K-class

    x_alg := r*[O_S] + x_D + (s-r)*z

  has Mukai vector

    (r,0,r) + (0,D,0) + (0,0,s-r)
      = (r,D,s).

  Since the Mukai-vector map identifies the integral K3 K-lattice, x_alg=x.
Qed.

Theorem projective_k3_q4_integral_hodge_classes_have_algebraic_lifts:
  For every integral Hodge class

    alpha in Q4(X,Z)_Hdg,

  there exists an algebraic codimension-two cycle class

    C in H^4(X,Z)

  whose projection to Q4(X,Z) is alpha.

  Equivalently, the quotient map on algebraic cycle classes is surjective onto
  the integral Hodge lattice:

    image( CH^2(X) -> Q4(X,Z) )
      = Q4(X,Z)_Hdg.

Proof:
  By MarkmanQ4MukaiHodgeIsometry choose the unique

    x in K(S)^(1,1)

  with phi4(x)=alpha.

  By every_integral_hodge_mukai_class_is_algebraic, choose x as an algebraic
  K-theory class.

  For X=S^[n], the universal ideal sheaf I_Z on S x X is an honest algebraic
  coherent sheaf. Pullback, tensor product, and proper algebraic pushforward
  preserve algebraic K-theory classes. Hence u(x) is algebraic in K_alg(X).

  Therefore

    C := c2(u(x))

  is the cycle class of an algebraic codimension-two class on X.

  By Markman's definition,

    [C]_Q4 = phi4(x) = alpha.
Qed.

Explicit generators of the quotient Hodge lattice:
  If D_1,...,D_rho is an integral basis of NS(S), then

    phi4(p),
    phi4(q),
    phi4(x_D1), ... , phi4(x_Drho)

  form an integral basis of Q4(X,Z)_Hdg.

  Each has an explicit algebraic lift

    c2(u(p)),
    c2(u(q)),
    c2(u(x_D1)), ... , c2(u(x_Drho)).

  On the Hilbert scheme branch already developed here,

    c2(u(q)) = [Z_s]

  and

    c2(u(p)) = c2(O_S^[n]) + [Z_s].

Corollary projective_k3_non_SH_integral_hodge_quotient_is_algebraic:
  Every integral Hodge direction in

    H^4(S^[n],Z) / Sym^2 H^2(S^[n],Z)

  is represented by an algebraic codimension-two class.

  Thus any possible degree-four integral Hodge obstruction for S^[n] cannot
  come from the quotient merely failing to have algebraic representatives;
  any remaining Hodge problem must involve the Sym^2 H^2 sector or a finer
  integral/rational compatibility question.
Qed.

Boundary:
  this is a quotient-level integral Hodge algebraicity theorem for actual
  Hilbert schemes S^[n]
  it does NOT prove the full integral Hodge conjecture in H^4(S^[n],Z)
  it does NOT claim that every algebraic lift is unique
  two lifts may differ by Sym^2 H^2(X,Z)
  it does NOT extend automatically to arbitrary deformations of K3^[n]-type
  without an algebraic realization/transport argument
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
