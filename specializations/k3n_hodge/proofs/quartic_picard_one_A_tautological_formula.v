Standalone tautological-bundle formula for the primitive A generator in H^4(S^[n],Z).

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a smooth projective K3 surface and X := S^[n].
  Let
    Z subset S x X
  be the universal family, with projections
    p_S : S x X -> S,
    p_X : S x X -> X.

  Let
    I_Z
  be the universal ideal sheaf and define the rank-n tautological algebra bundle

    T := p_X* O_Z.

  The map Z -> X is finite flat of degree n, so T is locally free of rank n.

  Fix a closed point s in S and let

    Z_s := { xi in S^[n] : s belongs to xi }

  be the codimension-two fixed-point incidence locus.

  Recall from quartic_picard_one_fixed_point_incidence_cycle.v that

    C_B = [Z_s]

  is the actual integral H^4 lift of the primitive quotient generator B.

Mukai classes:
  Let
    y := [O_s] with Mukai vector (0,0,1),
    q := -y = (0,0,-1),
    p := [O_S] - y with Mukai vector (1,0,0).

  Let u : K(S) -> K(X) be Markman's universal-ideal-sheaf transform

    u(x) = p_X! ( p_S!(-x^dual) cup [I_Z] ).

ExternalResult MarkmanPointSliceFormula:
  Markman computes

    u(y) = - L iota_s^* I_Z.

  By the flatness/Tor calculation already established on this branch,

    L iota_s^* I_Z = I_{Z_s}.

  Hence

    u(y) = - I_{Z_s}.

Source:
  Eyal Markman,
  Integral constraints on the monodromy group of the hyperkahler
  resolution of a symmetric product of a K3 surface,
  Lemma 5.9 and equation (9).

Theorem universal_ideal_pushforward_K_class:
  In K(X),

    R p_X* I_Z = 2*O_X - T.

Proof:
  Use the universal ideal sequence

    0 -> I_Z -> O_{S x X} -> O_Z -> 0.

  Since S is a K3 surface,

    H^0(S,O_S) = C,
    H^1(S,O_S) = 0,
    H^2(S,O_S) = C.

  Therefore

    [R p_X* O_{S x X}]
      = [O_X] + [O_X]
      = 2[O_X]

  in K(X), because the nonzero cohomology occurs in even degrees 0 and 2.

  Since Z -> X is finite flat,

    R p_X* O_Z = p_X* O_Z = T.

  Taking K-classes in the universal ideal sequence gives

    [R p_X* I_Z] = 2[O_X] - [T].
Qed.

Theorem primitive_A_universal_transform_formula:
  In K(X),

    u(p) = T - 2*O_X + I_{Z_s}.

  Equivalently,

    u(p) = T - O_X - O_{Z_s}.

Proof:
  By definition of Markman's transform for x=O_S,

    u([O_S]) = - R p_X* I_Z
             = T - 2*O_X.

  Since p=[O_S]-y and u is additive,

    u(p)
      = u([O_S]) - u(y)
      = T - 2*O_X + I_{Z_s}.

  Finally

    [I_{Z_s}] = [O_X] - [O_{Z_s}].
Qed.

Define

  C_A := c2(u(p)) in H^4(X,Z).

Theorem primitive_A_tautological_H4_formula:
  In actual integral H^4(X,Z),

    C_A = c2(T) + [Z_s].

Proof:
  From

    u(p) = T - O_X - O_{Z_s},

  compute the degree-four Chern character.

  Since Z_s has codimension two,

    ch_0(O_{Z_s}) = 0,
    ch_1(O_{Z_s}) = 0,
    ch_2(O_{Z_s}) = [Z_s].

  Hence

    ch_2(u(p)) = ch_2(T) - [Z_s].

  The first Chern class of u(p) equals c1(T), since the other two
  summands have zero first Chern class.

  Using

    ch_2(E) = (c1(E)^2 - 2*c2(E))/2

  for both u(p) and T, the equal first Chern classes cancel and give

    c2(u(p)) = c2(T) + [Z_s].

  Therefore

    C_A = c2(T) + [Z_s].
Qed.

Corollary tautological_c2_represents_A_minus_B:
  In Q4(X,Z) := H^4(X,Z) / Sym^2 H^2(X,Z),

    [c2(T)] = A - B.

Proof:
  Project

    C_A = c2(T) + C_B

  to Q4 and use

    [C_A] = A,
    [C_B] = B.
Qed.

Corollary primitive_A_has_tautological_geometric_description:
  The primitive quotient generator A has the actual integral representative

    c2(T) + [Z_s].

  Thus A is the sum of

    the second Chern class of the rank-n tautological algebra bundle O_S^[n]

  and

    the fixed-point incidence cycle.
Qed.

Additional structural observation:
  The unit section O_X -> T splits canonically over characteristic zero via
  (1/n) times the trace map T -> O_X.

  Hence

    T ~= O_X direct_sum T_0

  as vector bundles, where T_0 is the trace-zero rank-(n-1) subbundle, and

    c2(T) = c2(T_0).

  This gives a canonical vector-bundle interpretation of the remaining
  A-B direction, though not yet a canonical codimension-two subvariety whose
  cycle class is c2(T).

Boundary:
  C_A is now reduced to standard tautological geometry
  no simpler canonical effective cycle representing c2(T) is claimed
  a generic degeneracy-locus realization of c2(T) would depend on choices and
    would not improve the canonical geometric interpretation
  no ZeroDayClosure semantics are used
  no required-class index is used
  no unrestricted Hodge conjecture is claimed
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
