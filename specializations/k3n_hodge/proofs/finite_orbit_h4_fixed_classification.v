Conditional

ExternalResult MarkmanK3nMonodromyArithmeticDensity(X,n) :=
  For n >= 2 and X of K3^[n]-type, the image Mon^2(X) of the
  monodromy group on H^2(X,Z) is an arithmetic subgroup of the
  Beauville-Bogomolov orthogonal group. In particular, every finite-index
  subgroup of Mon^2(X) has Zariski closure containing the identity
  component SO(H^2(X,Q),q_X).

Sources:
  Eyal Markman,
  Integral constraints on the monodromy group of the hyperkahler
  resolution of a symmetric product of a K3 surface,
  arXiv:math/0601304.

  See also the standard K3^[n]-type formulation identifying Mon^2(X)
  with the orientation-preserving arithmetic subgroup acting by +/-1
  on the discriminant, and Markman's Zariski-closure results for the
  monodromy representation.

Boundary:
  this is external mathematical input
  no Zero Day requirement is inferred from arithmeticity


ExternalResult OrthogonalSymmetricSquareFixedLine(V,q) :=
  For a nondegenerate rational quadratic space (V,q) of dimension >= 3,

    (Sym^2 V)^{SO(V,q)} = Q * qinv,

  where qinv is the inverse quadratic form viewed in Sym^2 V.

Boundary:
  standard orthogonal representation theory


Theorem k3_n_type_finite_degree_four_orbit_is_fixed:
  For n >= 4 and X of K3^[n]-type, let c in H^4(X,Q).

  If the full monodromy orbit

    Mon(X) * c

  is finite, then c is fixed by every monodromy operator.

  Consequently there exist unique a,s in Q such that

    c = a * qinv_X + s * ((1/2)c2(X)),

  and

    pi4_X(c) = s * gamma_X

  and

    K3nDegreeFourC2ScalarObstruction(X,n,c) = s.

Proof:
  Assume the full monodromy orbit of c is finite.

  Since the quotient projection

    pi4_X : H^4(X,Q) -> H^4(X,Q)/SH^4(X,Q)

  is monodromy-equivariant, the orbit of pi4_X(c) is finite.

  By k3_n_type_degree_four_finite_monodromy_orbit_classification,
  the only finite-orbit vectors in the degree-four quotient form the
  line Q * gamma_X. Therefore there exists s in Q such that

    pi4_X(c) = s * gamma_X.

  Put

    h_X := (1/2)c2(X)

  and

    d := c - s * h_X.

  The class h_X is fixed by monodromy, so d still has finite monodromy
  orbit. Moreover

    pi4_X(d) = 0,

  hence

    d in SH^4(X,Q) = Sym^2 H^2(X,Q).

  Because d has finite orbit, its stabilizer in Mon(X) has finite index.
  Project this stabilizer to Mon^2(X). Its image still has finite index
  in the arithmetic H^2-monodromy group, up to the finite kernel of the
  restriction representation.

  By MarkmanK3nMonodromyArithmeticDensity(X,n), the Zariski closure of
  this finite-index subgroup contains SO(H^2(X,Q),q_X).

  The condition that an element of Sym^2 H^2 fixes d is Zariski closed.
  Since the finite-index stabilizer fixes d, its Zariski closure fixes d.
  Thus d is SO(H^2,q_X)-invariant.

  Apply OrthogonalSymmetricSquareFixedLine. There exists a in Q with

    d = a * qinv_X.

  Therefore

    c = a * qinv_X + s * h_X.

  Both qinv_X and h_X are fixed by the full monodromy group, so c is
  fixed by the full monodromy group.

  Now apply
    k3_n_type_full_degree_four_monodromy_fixed_classification.
  The decomposition is unique, the quotient is s * gamma_X, and the
  c2/2 scalar obstruction is exactly s.
Qed.


Corollary k3_n_type_finite_degree_four_orbit_SH_criterion:
  For n >= 4 and X of K3^[n]-type and c in H^4(X,Q), if c has finite
  full-monodromy orbit, write uniquely

    c = a * qinv_X + s * ((1/2)c2(X)).

  Then

    c in SH^4(X,Q)
      iff
    s = 0.

Proof:
  Apply k3_n_type_finite_degree_four_orbit_is_fixed and then
  k3_n_type_fixed_degree_four_SH_criterion.
Qed.


Theorem k3_n_type_stable_finite_inventory_degree_four_coordinates:
  For n >= 4 and X of K3^[n]-type, assume a finite required-class
  inventory equipped with a full monodromy action on its finite index
  set, degree preservation, and class equivariance.

  Then for every inventory index i with degree(i) = 2, the represented
  class

    c_i := class(i) in H^4(X,Q)

  has finite full-monodromy orbit and therefore has unique coordinates

    c_i = a_i * qinv_X + s_i * ((1/2)c2(X)).

  Moreover

    K3nDegreeFourC2ScalarObstruction(X,n,c_i) = s_i,

  and

    c_i in SH^4(X,Q)
      iff
    s_i = 0.

Proof:
  The inventory index set is finite and preserved by monodromy.
  Therefore the orbit of i is finite.

  By class equivariance, the monodromy orbit of class(i) is the image
  of the finite orbit of i. Hence class(i) has finite full-monodromy
  orbit.

  Apply k3_n_type_finite_degree_four_orbit_is_fixed and its SH criterion.
Qed.


Boundary:
  this removes finite-orbit behavior as an independent degree-four
  obligation once a genuinely finite monodromy-stable inventory exists
  it does not construct such an inventory
  it does not prove that the inventory covers actual requirements
  it does not define ActuallyRequired
  it does not prove any actual required class exists
  it does not prove any scalar coefficient s_i vanishes
  it does not define or prove semantic ZeroDayClosure
  no unconditional closure theorem is claimed
