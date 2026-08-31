Standalone obstruction to the most direct semiregularity/spread strategy for the
order-13 F_13 real-multiplication correspondence.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let X := X_13 be Kondo's projective K3 surface with purely non-symplectic
  automorphism sigma of order 13.

  Put

    Y := X x X,
    G_plus  := Graph(sigma),
    G_minus := Graph(sigma^(-1)).

  The algebraic correspondence

    [G_plus] + [G_minus]

  acts on T(X)_Q by

    alpha_13 = zeta_13 + zeta_13^(-1).

  By order13_cm_point_on_rm_curve.v, this cohomology class is the special
  value of a flat rational Hodge endomorphism along a one-dimensional
  F_13-real-multiplication period curve.

ExternalResult Order13FixedLocus:
  Artebani--Sarti--Taki show that the fixed locus of sigma contains one smooth
  rational curve C and nine isolated points.

  In their elliptic model, seven fixed points and the rational fixed curve
  lie in the III* fiber, and two further fixed points lie in the II fiber.

Source:
  Michela Artebani, Alessandra Sarti, Shingo Taki,
  K3 surfaces with non-symplectic automorphisms of prime order,
  Example 8.1 / Theorem 8.4 / Table 5.

Theorem graph_intersection_is_fixed_locus:
  G_plus intersect G_minus is naturally identified with Fix(sigma).

Proof:
  A point (x,sigma(x)) on G_plus lies on G_minus exactly when

    sigma(x) = sigma^(-1)(x),

  equivalently sigma^2(x)=x.

  Since sigma has prime order 13, Fix(sigma^2)=Fix(sigma).
Qed.

Theorem graph_union_is_not_lci_at_isolated_fixed_points:
  The reduced union

    Z := G_plus union G_minus

  is not a local complete intersection at each isolated fixed point.

Proof:
  Let p be an isolated fixed point.  Since p is isolated, neither eigenvalue
  of d sigma_p is 1.  Since the order is 13, neither eigenvalue has square 1.

  The tangent spaces to G_plus and G_minus inside T_(p,p)Y are

    {(v, d sigma(v))}

  and

    {(v, d sigma^(-1)(v))}.

  Their intersection consists of v satisfying

    d sigma(v)=d sigma^(-1)(v),

  hence d sigma^2(v)=v.  There is no nonzero such v, so the two tangent
  2-planes are transverse in the 4-dimensional tangent space.

  After formal linear coordinates, their ideals are therefore equivalent to

    I_1=(x_1,x_2),
    I_2=(x_3,x_4).

  The union ideal is

    I_1 intersect I_2
      =(x_1*x_3, x_1*x_4, x_2*x_3, x_2*x_4).

  This height-two ideal needs four generators, so the union is not lci.
Qed.

Corollary classical_Bloch_lci_route_not_directly_applicable:
  Bloch's classical semiregularity criterion for lci codimension-two
  subvarieties cannot be applied directly to Z=G_plus union G_minus.
Qed.

Now package the two graph components as the coherent sheaf

  F := O_(G_plus) direct_sum O_(G_minus)

on the smooth fourfold Y.

ExternalResult BuchweitzFlennerSemiregularity:
  For a coherent sheaf/perfect complex F on a smooth complex space Y,
  Buchweitz--Flenner define

    sigma_F : Ext^2_Y(F,F)
              -> product_{q>=0} H^{q+2}(Y, Omega_Y^q)

  by

    c |-> Tr(exp(-At(F)) o c).

  Injectivity of this map is the semiregularity condition used to annihilate
  deformation obstructions when the Chern character remains Hodge.

Sources:
  Ragnar-Olaf Buchweitz, Hubert Flenner,
  A Semiregularity Map for Modules and Applications to Deformations,
  Compositio Mathematica 137 (2003), 135-210.

  Ananyo Dan, Inder Kaur,
  Semi-regular varieties and variational Hodge conjecture,
  Comptes Rendus Math. 354 (2016), 297-300.

Theorem local_cross_Ext2_along_fixed_curve:
  At the generic point of the rational fixed curve C,

    sheaf_Ext^2_Y(O_(G_plus), O_(G_minus)) |_C
      ~= O_C,

  and likewise with plus and minus interchanged.

Proof:
  Finite-order holomorphic actions are locally linearizable.  At a generic
  point of the fixed curve choose local coordinates (u,v) on X with

    C=(v=0),
    sigma(u,v)=(u, lambda*v),

  where lambda is a nontrivial 13th root of unity.

  In local coordinates on Y, after setting

    x := u' - u,
    y := v' - lambda*v,

  the graph ideals become

    I_plus  = (x,y),
    I_minus = (x, y + c*v),

  where

    c = lambda - lambda^(-1) != 0

  because lambda^2 != 1.

  Let R be the formal local ring and

    M := R/I_minus ~= C[[u,v]].

  Resolve R/I_plus by the Koszul complex on (x,y).  Applying Hom_R(-,M)
  gives the cochain complex

    0 -> M -> M^2 -> M -> 0

  in which x acts as 0 and y acts as a nonzero scalar multiple of v.

  Therefore

    Ext^1_R(R/I_plus,M) ~= M/(v),
    Ext^2_R(R/I_plus,M) ~= M/(v).

  Since M/(v) ~= C[[u]], the degree-two cross Ext sheaf is O_C generically.
Qed.

Corollary global_cross_Ext2_is_nonzero:
  Ext^2_Y(O_(G_plus), O_(G_minus)) != 0,
  and likewise in the reverse direction.

Proof:
  The local-to-global Ext spectral sequence contains

    H^0(C,O_C)

  from the sheaf_Ext^2 term.  The possible d_2 target lies in H^2 of a sheaf
  supported on the curve C and therefore vanishes.  Hence a nonzero cross
  Ext^2 class survives globally.
Qed.

Theorem off_diagonal_cross_Ext_is_killed_by_semiregularity_trace:
  Every off-diagonal class

    c in Ext^2_Y(O_(G_plus), O_(G_minus))

  viewed inside Ext^2_Y(F,F) lies in the kernel of sigma_F; likewise for the
  reverse cross term.

Proof:
  For the direct sum F, its Atiyah class and exp(-At(F)) are block diagonal.
  An off-diagonal Ext class remains off-diagonal after composition with every
  block-diagonal power of the Atiyah class.

  The Buchweitz--Flenner map then takes the categorical/matrix trace.  The
  trace of an off-diagonal endomorphism block is zero in every Hodge-degree
  component.

  Hence

    Tr(exp(-At(F)) o c)=0.
Qed.

Corollary natural_graph_sum_sheaf_is_not_semiregular:
  The Buchweitz--Flenner semiregularity map

    sigma_F : Ext^2_Y(F,F) -> product_q H^{q+2}(Y,Omega_Y^q)

  is not injective.

Proof:
  global_cross_Ext2_is_nonzero supplies a nonzero off-diagonal class, and
  off_diagonal_cross_Ext_is_killed_by_semiregularity_trace places it in the
  kernel.
Qed.

Corollary semiregularity_does_not_currently_spread_alpha13:
  The most direct semiregularity packages do not close the order-13 transport
  problem:

    (1) the reduced graph union is not lci at the nine isolated intersections,
        so Bloch's classical lci criterion is unavailable directly;

    (2) the natural coherent-sheaf package

          O_(G_plus) direct_sum O_(G_minus)

        is not Buchweitz--Flenner semiregular because of explicit nonzero
        trace-zero cross Ext^2 obstruction classes.

  Therefore the fact that

    [G_plus]+[G_minus]

  is a flat Hodge class along the F_13 RM curve does not, by these standard
  semiregularity mechanisms alone, produce a generic algebraic cycle.
Qed.

ExternalBoundary SchlickeweiDeformationReduction:
  Schlickewei's deformation-theoretic approach to Hodge classes on K3
  self-products constructs projective deformations on which a fixed real
  multiplication endomorphism is monodromy-equivariant and algebraic on a
  dense set of fibers, and reduces the general passage to Grothendieck's
  invariant-cycle conjecture rather than proving it unconditionally.

Source:
  Ulrich Schlickewei,
  Hodge classes on self-products of K3 surfaces,
  Bonner Mathematische Schriften 395 (2009), Part I.

First missing object after this obstruction:
  To continue the order-13 route one needs genuinely new input, for example

    (A) a different algebraic family/perfect complex representing the
        alpha_13 class whose semiregularity map is actually injective;

    (B) an unconditional invariant-cycle / variational-Hodge theorem applying
        to this relative K3 self-product;

    (C) a direct family-level algebraic correspondence realizing alpha_13.

Boundary:
  this file does NOT prove that no semiregular representative of the alpha_13
    class can exist
  it proves only that the two canonical packages supplied by the special
    graph geometry do not yield the needed direct semiregularity argument
  it does NOT assume Grothendieck's variational or invariant-cycle conjecture
  it does NOT close generic F_13 algebraicity
  the local Ext calculation is mathematical/source-checked but this .v file
    is pseudo-formal documentation, not a Coq proof
  no ZeroDayClosure semantics are used
  no required-class index is used
