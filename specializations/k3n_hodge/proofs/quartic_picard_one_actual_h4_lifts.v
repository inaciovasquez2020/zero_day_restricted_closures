Standalone actual-H^4 lift calculation for the primitive U-plane generators in the
Picard-rank-one quartic K3^[n] quotient-Hodge lattice.

This file is deliberately independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S subset P^3 be a smooth Picard-rank-one quartic K3 surface,
    NS(S) = Z*H,
    H^2 = 4.

  Let X = S^[n] with n >= 4 and m := n - 1.

  Let E be the universal ideal sheaf over S x X and let

    u : K(S) -> K(X)

  be Markman's universal-sheaf transform

    u(x) = f_2! ( f_1!(-x^dual) cup [E] ).

  For x in K(S), define the actual integral degree-four class

    C_x := c2(u(x)) in H^4(X,Z).

  Let

    p := (1,0,0),
    q := (0,0,-1),
    v := p + m*q = (1,0,1-n),
    w := p - m*q = (1,0,n-1).

  Let

    A := phi4(p),
    B := phi4(q),
    gamma := phi4(v),
    xi := phi4(w)

  in

    Q4(X,Z) := H^4(X,Z) / Sym^2 H^2(X,Z).

ExternalResult MarkmanUniversalChernDegreeFour:
  Markman defines

    tilde_phi4(x) := c2(u(x))

  and phi4(x) as its projection to Q4(X,Z).

  Therefore

    [C_x] = phi4(x)

  for every x in K(S).

Source:
  Eyal Markman,
  Integral constraints on the monodromy group of the hyperkahler
  resolution of a symmetric product of a K3 surface,
  equations (9), (10), and (11).

Theorem quartic_picard_one_primitive_generators_have_actual_integral_lifts:
  The classes

    C_A := C_p = c2(u(p)),
    C_B := C_q = c2(u(q))

  are integral classes in H^4(X,Z) and satisfy

    [C_A] = A,
    [C_B] = B

  in Q4(X,Z).

Proof:
  Apply MarkmanUniversalChernDegreeFour to p and q.
Qed.

ExternalResult MarkmanDegreeFourLinearCombination:
  Define

    sigma_bar(x) := 2*c2(u(x)) - c1(u(x))^2
                  = 2*C_x - c1(u(x))^2.

  Markman Lemma 5.8 proves that sigma_bar is a linear homomorphism

    K(S) -> H^4(X,Z)

  and that its projection to Q4 is 2*phi4.

Source:
  Markman, section 5.4, equation (55), equation (56), Lemma 5.8.

ExternalResult MarkmanUniversalIdealFirstChernNormalization:
  Let y := (0,0,1), the skyscraper-sheaf class.
  For the universal ideal sheaf Markman computes

    c1(u(y)) = 0.

  Hence, since q = -y,

    c1(u(q)) = 0.

  Moreover

    v = p + m*q,
    w = p - m*q,

  so linearity of c1 o u gives

    c1(u(v)) = c1(u(p)) = c1(u(w)).

  Under the fixed Hilbert-Chow convention from
  quartic_picard_one_hilbert_chow_mukai_normalization.v,

    theta_v(w) = -delta_geom,

  where 2*delta_geom is the effective Hilbert-Chow exceptional divisor.
  Since w lies in v^perp and c1(u(w)) = theta_v(w),

    c1(u(v)) = c1(u(p)) = c1(u(w)) = -delta_geom.

Source:
  Markman Lemma 5.9 and its universal-ideal-sheaf calculation;
  the branch's pinned Hilbert-Chow Mukai normalization.

Theorem quartic_picard_one_actual_A_lift_average_identity:
  In actual integral H^4(X,Z),

    2*C_A = C_v + C_w.

Proof:
  In K(S),

    v + w = 2*p.

  Apply linearity of sigma_bar:

    sigma_bar(v) + sigma_bar(w) = 2*sigma_bar(p).

  Use

    c1(u(v)) = c1(u(w)) = c1(u(p)) = -delta_geom.

  Expanding gives

    (2*C_v - delta_geom^2)
    + (2*C_w - delta_geom^2)
      = 2*(2*C_A - delta_geom^2).

  The divisor-square terms cancel, leaving

    2*C_A = C_v + C_w.
Qed.

Theorem quartic_picard_one_actual_B_lift_difference_identity:
  In actual integral H^4(X,Z),

    2*m*C_B = C_v - C_w.

  Equivalently,

    2*(n-1)*C_B = C_v - C_w.

Proof:
  In K(S),

    v - w = 2*m*q.

  Apply linearity of sigma_bar:

    sigma_bar(v) - sigma_bar(w) = 2*m*sigma_bar(q).

  The left side is

    (2*C_v - delta_geom^2)
    - (2*C_w - delta_geom^2)
      = 2*(C_v - C_w).

  Since c1(u(q)) = 0,

    sigma_bar(q) = 2*C_B.

  Therefore

    2*(C_v - C_w) = 4*m*C_B,

  hence

    C_v - C_w = 2*m*C_B.
Qed.

Corollary quartic_picard_one_actual_primitive_U_lifts:
  The primitive quotient U-plane generators admit the actual integral lifts

    C_A = (C_v + C_w)/2,
    C_B = (C_v - C_w)/(2(n-1)),

  where the right-hand divisions are integral because the equalities above
  identify them with the Chern classes c2(u(p)) and c2(u(q)).

  Thus the divisibility visible in the quotient primitive closure is already
  realized at the level of actual integral H^4 by universal-sheaf Chern classes.
Qed.

Explicit universal-ideal description of the B input:
  Markman computes for y=(0,0,1)

    u(y) = - iota_s^! [E],

  where iota_s : X -> S x X is the slice at a fixed point s in S.
  Since q=-y,

    u(q) = iota_s^! [E].

  Consequently

    C_B = c2(iota_s^! [E]).

  This is an explicit algebraic universal-ideal-sheaf Chern class.

Boundary:
  iota_s^! [E] is used here as Markman's K-theory pullback class
  no claim is made here that it is literally an underived ideal sheaf of the
    fixed-point incidence locus without a separate Tor-independence argument
  no direct cycle equality for C_B is claimed in this file
  C_A and C_B are actual integral H^4 lifts, but they are not asserted unique:
    any two lifts of the same Q4 class may differ by Sym^2 H^2(X,Z)
  no ZeroDayClosure semantics are used
  no required-class index is used
  no unrestricted Hodge conjecture is claimed
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
