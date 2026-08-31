Standalone K3^[n] quotient-Hodge lattice calculation.

This file is deliberately independent of ZeroDayClosure,
required_classes.I, ActuallyRequired, and all inventory semantics.
It records an arithmetic consequence of Markman's integral
Hodge-isometry for Q^4 together with the standard Mukai lattice
of a Picard-rank-one quartic K3 surface.

Setup:
  Let S subset P^3 be a smooth quartic K3 surface with
    NS(S) = Z * H
  and
    H^2 = 4.

  Let X = S^[n] with n >= 4, and put m := n - 1.

  Let
    Q4(X,Z) := H^4(X,Z) / Sym^2 H^2(X,Z).

  On the Mukai lattice K(S), use
    <(r,c,s),(r',c',s')> = c.c' - r*s' - r'*s.

  Define the integral Mukai vectors
    p := (1,0,0),
    q := (0,0,-1),
    h := (0,H,0).

  Then
    p^2 = 0,
    q^2 = 0,
    <p,q> = 1,
    h^2 = 4,
    p perpendicular h,
    q perpendicular h.

  Thus
    K(S)^(1,1) = Z*p direct_sum Z*q direct_sum Z*h
  and its Gram lattice is
    U direct_sum <4>.

  Let
    v := p + m*q = (1,0,1-n),
    w := p - m*q = (1,0,n-1).

  Then
    v^2 = 2m,
    w^2 = -2m,
    <v,w> = 0,
    <v,h> = 0,
    <w,h> = 0.

ExternalResult MarkmanQ4MukaiHodgeIsometry:
  There is an integral Hodge-isometry
    phi4 : K(S) ~= Q4(X,Z)
  satisfying
    phi4(2*v) = bar_c2(X),
  where bar_c2(X) is the image of c2(X) in Q4(X,Z).

  On v^perp, phi4 agrees, up to the global sign ambiguity in
  Markman's primitive embedding, with
    e_X o theta_v.

Source:
  Eyal Markman,
  Integral constraints on the monodromy group of the hyperkahler
  resolution of a symmetric product of a K3 surface,
  Theorem 1.14, equations (12) and (13).

Define in Q4(X,Z):
  gamma := phi4(v) = bar_c2(X)/2,
  xi    := phi4(w),
  eta_H := phi4(h).

Then, up to the harmless sign choices in e_X,
  xi    = +/- e_X(delta),
  eta_H = +/- e_X(theta(H)),
where 2*delta is the Hilbert-Chow exceptional divisor class.

Theorem quartic_picard_one_natural_three_class_gram:
  The lattice
    N := Z*gamma direct_sum Z*xi direct_sum Z*eta_H
  has Gram matrix

    diag(2m, -2m, 4).

  Hence
    disc(N) = -16*m^2.

Proof:
  phi4 is an isometry.
  Apply the Mukai-pairing calculations for v,w,h above.
Qed.

Theorem quartic_picard_one_full_q4_hodge_lattice:
  The full integral Hodge lattice of Q4 is

    Q4(X,Z)_Hdg
      = Z*phi4(p) direct_sum Z*phi4(q) direct_sum Z*eta_H
      ~= U direct_sum <4>.

  In particular
    disc(Q4(X,Z)_Hdg) = -4.

Proof:
  Because NS(S)=Z*H,
    K(S)^(1,1)=H^0(S,Z) direct_sum NS(S) direct_sum H^4(S,Z)
              =Z*p direct_sum Z*q direct_sum Z*h.
  MarkmanQ4MukaiHodgeIsometry is a Hodge-isometry.
Qed.

Theorem quartic_picard_one_natural_lattice_index:
  The natural lattice N has exact index

    [Q4(X,Z)_Hdg : N] = 2m = 2(n-1).

Proof:
  Compare discriminants:

    index^2
      = |disc(N)| / |disc(Q4(X,Z)_Hdg)|
      = (16*m^2) / 4
      = 4*m^2.

  Since the index is positive,
    index = 2m.
Qed.

Theorem quartic_picard_one_primitive_closure_basis:
  Define

    A := (gamma + xi)/2,
    B := (gamma - xi)/(2m).

  Then A and B are integral classes in Q4(X,Z), because

    A = phi4(p),
    B = phi4(q).

  They satisfy

    A^2 = 0,
    B^2 = 0,
    <A,B> = 1,
    A perpendicular eta_H,
    B perpendicular eta_H,
    eta_H^2 = 4.

  Consequently

    Q4(X,Z)_Hdg
      = Z*A direct_sum Z*B direct_sum Z*eta_H
      ~= U direct_sum <4>,

  and this is the primitive closure of N.

Proof:
  From
    gamma = phi4(v) = phi4(p + m*q) = A + m*B,
    xi    = phi4(w) = phi4(p - m*q) = A - m*B,
  solve for A and B.

  The Gram identities follow from the isometry phi4.
Qed.

Theorem quartic_picard_one_natural_lattice_cokernel:
  The finite quotient is cyclic:

    Q4(X,Z)_Hdg / N ~= Z / (2(n-1))Z.

Proof:
  In the basis (A,B,eta_H), the generators
    (gamma,xi,eta_H)
  are the columns

    gamma = A + m B,
    xi    = A - m B,
    eta_H = eta_H.

  The corresponding integer matrix is

    [ 1   1   0 ]
    [ m  -m   0 ]
    [ 0   0   1 ].

  Its determinant has absolute value 2m.
  A 2x2 minor has absolute value 1, so the Smith normal form is
    diag(1,1,2m).
  Therefore the cokernel is cyclic of order 2m.
Qed.

Explicit K-theory representatives:
  Under the Mukai-vector convention
    v(E) = (rk(E), c1(E), chi(E)-rk(E)),
  one may take

    x_A := [O_S] - [O_p],
    x_B := -[O_p],
    x_H := [O_S(H)] - [O_S] - 2[O_p].

  Their Mukai vectors are respectively
    p,
    q,
    h.

  Hence their degree-four Markman quotient classes are
    A     = phi4(x_A),
    B     = phi4(x_B),
    eta_H = phi4(x_H).

  In Markman's construction phi4(x) is represented in Q4 by the
  degree-four universal-sheaf Chern-class transform; therefore these
  three integral Hodge directions admit explicit algebraic Chern-class
  lifts on the projective Hilbert scheme X.

Corollary quartic_picard_one_hyperplane_direction_is_primitive:
  eta_H is primitive in Q4(X,Z)_Hdg and
    eta_H^2 = 4.

Proof:
  eta_H = phi4(h), h=(0,H,0), and H is primitive in NS(S)=Z*H.
  Since phi4 is an integral lattice isomorphism, primitivity is preserved.
Qed.

Boundary:
  this is a standalone K3^[n] quotient-Hodge lattice theorem
  no ZeroDayClosure semantics are used
  no required-class index is used
  no claim is made that gamma, xi, eta_H, A, or B is Zero-Day-required
  no unrestricted Hodge conjecture is claimed
  no statement about all H^4 Hodge classes is inferred from the quotient alone
  the sign ambiguity in Markman's primitive embedding does not affect
    Gram matrices, index, discriminant, Smith normal form, or primitive closure
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
