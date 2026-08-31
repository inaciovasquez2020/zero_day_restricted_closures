Standalone geometric-cycle identification of the primitive B generator for K3^[n].

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a smooth projective K3 surface and X := S^[n].
  Let
    Z subset S x X
  be the universal family and
    I_Z
  its universal ideal sheaf.

  Fix a closed point s in S and let
    iota_s : X -> S x X
  denote the slice x |-> (s,x).

  Define the scheme-theoretic fixed-point incidence locus

    Z_s := Z x_S {s}
         = { xi in S^[n] : s belongs to the length-n subscheme xi }

  as the fiber of the projection Z -> S.

ExternalResult UniversalFamilyFlatOverSurface:
  For every smooth quasiprojective variety M and every n >= 1,
  the universal family over M^[n] is flat over M via the second projection.

  In particular Z -> S is flat.

Sources:
  Andreas Krug and Jorgen Vold Rennemo,
  Some ways to reconstruct a sheaf from its tautological image on a
  Hilbert scheme of points, Theorem 2.1.

  Fabian Reede and Ziyu Zhang,
  Stability of some vector bundles on Hilbert schemes of points on K3
  surfaces, Lemma 2.3 and Theorem 2.4.

Theorem universal_ideal_restriction_has_no_Tor_correction:
  The universal ideal sheaf I_Z is flat over S, and therefore

    L iota_s^* I_Z ~= iota_s^* I_Z.

  Moreover

    iota_s^* I_Z = I_{Z_s},

  the ordinary ideal sheaf of the closed subscheme Z_s subset X.

Proof:
  The exact sequence on S x X is

    0 -> I_Z -> O_{S x X} -> O_Z -> 0.

  The middle term is flat over S and O_Z is flat over S by
  UniversalFamilyFlatOverSurface. Since the quotient is flat, the kernel
  I_Z is flat over S as well. Hence derived base change to {s} has no
  higher Tor terms and agrees with ordinary restriction.

  Ordinary restriction of the universal ideal sequence is

    0 -> iota_s^* I_Z -> O_X -> O_{Z_s} -> 0,

  so iota_s^* I_Z is exactly I_{Z_s}.
Qed.

ExternalResult UniversalFamilyCohenMacaulay:
  For a smooth surface S, the universal family Z is Cohen-Macaulay.

Sources:
  Fogarty's universal-family result; see also Lei Song,
  On the universal family of Hilbert schemes of points on a surface.

Theorem fixed_point_incidence_has_codimension_two:
  Z_s has pure dimension 2n-2 and hence codimension two in X.

Proof:
  Z is finite flat of degree n over X, hence dim Z = dim X = 2n.
  The morphism Z -> S is flat and dim S = 2, so every fiber has
  dimension 2n-2. Cohen-Macaulayness of Z over the regular surface base
  gives Cohen-Macaulay fibers, hence Z_s is pure of that dimension.
Qed.

Recall from quartic_picard_one_actual_h4_lifts.v:
  Let y := (0,0,1) and q := -y = (0,0,-1).
  Markman's universal-sheaf transform satisfies

    u(y) = - L iota_s^* I_Z

  in K(X), and therefore

    u(q) = L iota_s^* I_Z.

  The primitive B lift is

    C_B := c2(u(q)) in H^4(X,Z).

Theorem primitive_B_lift_is_fixed_point_incidence_cycle:
  In integral degree-four cohomology,

    C_B = [Z_s].

  Equivalently,

    c2(u(q)) = cl(Z_s),

  where cl(Z_s) is the codimension-two cycle class with its
  scheme-theoretic multiplicities.

Proof:
  By universal_ideal_restriction_has_no_Tor_correction,

    u(q) = [I_{Z_s}]

  in K(X).

  Since Z_s has codimension two, I_{Z_s} is a rank-one ideal sheaf with

    c1(I_{Z_s}) = 0.

  From

    [I_{Z_s}] = [O_X] - [O_{Z_s}]

  one gets in codimension two

    ch_2(I_{Z_s}) = -[Z_s].

  For a rank-one class with c1=0,

    ch_2 = -c2.

  Hence

    c2(I_{Z_s}) = [Z_s].

  Therefore C_B = [Z_s].
Qed.

Corollary primitive_B_has_direct_geometric_interpretation:
  The primitive quotient generator

    B = phi4(q) in Q4(X,Z)

  is represented by the actual algebraic incidence cycle

    [Z_s] in H^4(X,Z).

  Thus

    [[Z_s]]_Q4 = B.

  In particular B is not merely a universal-Chern abstract class: it is
  the quotient class of the locus of length-n subschemes containing a
  fixed point of S.
Qed.

Corollary actual_difference_identity_is_incidence_divisibility:
  With m := n-1 and the notation of
  quartic_picard_one_actual_h4_lifts.v,

    C_v - C_w = 2m * [Z_s]
              = 2(n-1) * [Z_s]

  in actual integral H^4(X,Z).
Qed.

Boundary:
  this identifies the B lift geometrically; it does not yet give a
    similarly simple cycle interpretation of the A lift
  the cycle Z_s is a codimension-two incidence locus, not a divisor
  no ZeroDayClosure semantics are used
  no required-class index is used
  no unrestricted Hodge conjecture is claimed
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
