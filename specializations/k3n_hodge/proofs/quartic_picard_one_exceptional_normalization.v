Standalone sign normalization for the Picard-rank-one quartic K3^[n] quotient-Hodge lattice.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a projective K3 surface and X := S^[n], n >= 2.
  Let
    v := (1,0,1-n)
  be the Mukai vector of the ideal sheaves parametrized by X.

  Let
    theta_v : v^perp -> H^2(X,Z)
  be the standard Mukai/Donaldson Hodge isometry associated to the
  universal ideal sheaf.

Geometric conventions:
  Let Delta be the effective Hilbert-Chow exceptional divisor on X and define

    delta_geom := Delta/2.

  Thus
    q_BB(delta_geom) = -2(n-1).

  If H is a divisor class on S, let H_n denote the induced divisor class on X
  coming from the symmetric-product/Hilbert-scheme construction.

Mukai vectors:
  w := (1,0,n-1),
  h := (0,H,0).

ExternalResult HilbertSchemeMukaiNormalization:
  With the above geometric convention,

    theta_v(w)  = -delta_geom,
    theta_v(-h) = H_n,

  and hence

    theta_v(h) = -H_n.

Sources:
  Bayer-Macri, Projectivity and Birational Geometry of Bridgeland Moduli Spaces,
  where theta_v(1,0,n-1) = -B and B is the half-boundary class,
  and theta_v(0,-H,0) is the induced Hilbert-scheme divisor.

  Debarre et al., Complete Curves of Polarized K3 Surfaces and Hyper-Kahler
  Manifolds, which writes the Mukai vector representing the geometric half
  exceptional divisor as -(1,0,n-1).

Remark on Markman sign conventions:
  Markman's 2008/2010 paper uses equivalent identifications with a harmless
  sign choice in different local discussions. For example, one passage writes
  the half-diagonal class as -(1,0,n-1), while another identifies the abstract
  negative-square generator with (1,0,n-1). Therefore the geometric sign must
  be fixed by explicitly declaring the universal-sheaf/Mukai convention above.

Now assume n >= 4 and let

  phi4 : K(S) ~= Q4(X,Z)

be Markman's integral Hodge isometry.
Choose the global sign of the primitive embedding e_X so that on v^perp

  phi4 = e_X o theta_v.

Define
  gamma := phi4(v),
  xi    := phi4(w),
  eta_H := phi4(h).

Theorem quartic_picard_one_exceptional_sign_normalization:
  Under the fixed convention,

    xi = -e_X(delta_geom).

Proof:
  xi
    = phi4(w)
    = e_X(theta_v(w))
    = e_X(-delta_geom)
    = -e_X(delta_geom).
Qed.

Theorem quartic_picard_one_hyperplane_sign_normalization:
  Under the same convention,

    eta_H = -e_X(H_n).

Proof:
  eta_H
    = phi4(h)
    = e_X(theta_v(h))
    = e_X(-H_n)
    = -e_X(H_n).
Qed.

Corollary quartic_picard_one_primitive_basis_with_geometric_signs:
  Put m := n-1 and retain

    A := (gamma + xi)/2,
    B := (gamma - xi)/(2m).

  Then

    A = (gamma - e_X(delta_geom))/2,
    B = (gamma + e_X(delta_geom))/(2m),
    eta_H = -e_X(H_n).

  These are the sign-refined versions of the primitive-closure formulas.

Boundary:
  the sign is fixed only after choosing the standard universal-ideal-sheaf
  Mukai convention and the global sign of e_X by phi4|v^perp = e_X o theta_v
  changing the global sign of e_X changes both displayed e_X signs coherently
  Gram matrices, discriminants, gluing, and index calculations are unchanged
  no ZeroDayClosure semantics are used
  no historical payload is identified
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
