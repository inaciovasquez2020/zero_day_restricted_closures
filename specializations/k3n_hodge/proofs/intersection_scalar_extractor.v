Conditional

Theorem k3_n_type_degree_four_intersection_scalar_extractor:
  For n >= 4 and X of K3^[n]-type, let c in H^4(X,Q) have finite
  full-monodromy orbit.  By

    k3_n_type_finite_degree_four_orbit_is_fixed

  there are unique a,s in Q with

    c = a * qinv_X + s * h_X,

  where

    h_X := (1/2)c2(X).

  Define F1(c), F2(c) by the Fujiki identities

    integral_X c * beta^(2n-2)
      = F1(c) * q_X(beta)^(n-1)

  and

    integral_X c * c2(X) * beta^(2n-4)
      = F2(c) * q_X(beta)^(n-2)

  for beta in H^2(X,Q).

  Put

    D_n := (2n-5)!!
         = (2n-4)! / (2^(n-2) * (n-2)!).

  Then

    F1(qinv_X)
      = (2n+21)(2n-3) D_n,

    F1(h_X)
      = 3(n+3)(2n-3) D_n,

    F2(qinv_X)
      = 6(n+3)(2n+19) D_n,

    F2(h_X)
      = 6(3n^2+16n+25) D_n.

  Consequently the determinant of the two-functionals matrix is

    12 (n-3)(n-2)(2n-3) D_n^2,

  which is nonzero for n >= 4, and the c2/2 coordinate is

    s
      =
    ((2n+21)(2n-3) F2(c)
       - 6(n+3)(2n+19) F1(c))
    /
    (12 (n-3)(n-2)(2n-3) D_n).

  In particular

    c in SH^4(X,Q)

  iff

    (2n+21)(2n-3) F2(c)
      =
    6(n+3)(2n+19) F1(c).

Proof:
  Step 1: basic K3^[n] Fujiki constants.

  For K3^[n]-type the ordinary Fujiki constant is

    C(1) = (2n)! / (n! 2^n).

  The closed generating formula for Fujiki constants of the Chern
  classes of S^[n], specialized to c2, gives

    C(c2)
      = 6(n+3) (2n-3)!!.

  Indeed, for k=n-1 the q^n coefficient is

    24 + 6(n-1) = 6(n+3).

  Therefore

    C(h_X)
      = 3(n+3)(2n-3)!!
      = 3(n+3)(2n-3)D_n.

  Step 2: the qinv insertion formula.

  For a deformation-invariant alpha in H^(4j), polarization of the
  Fujiki relation and contraction by the inverse Beauville-Bogomolov
  tensor gives

    C(qinv_X * alpha)
      =
    ((b2(X) + 2n - 2j - 2)/(2n - 2j - 1)) * C(alpha).

  Here b2(X)=23.

  Applying this with alpha=1 gives

    F1(qinv_X)
      = C(qinv_X)
      = (2n+21)(2n-3)D_n.

  Applying it with alpha=c2 (so j=1) gives

    F2(qinv_X)
      = C(qinv_X*c2)
      = ((2n+19)/(2n-3)) C(c2)
      = 6(n+3)(2n+19)D_n.

  Step 3: compute C(c2^2).

  The K3^[n] Riemann-Roch polynomial is

    RR_K3[n](t) = binomial(t/2+n+1,n).

  Since c1(X)=0, the degree-eight Todd component is

    td_4(X) = (3c2(X)^2 - c4(X))/720.

  The coefficient of t^(n-2) in RR_K3[n](t) is

    (3n^2+17n+26)
    /
    (24 (n-2)! 2^(n-2)).

  The same closed Chern-Fujiki generating formula, now specialized to
  c4, gives

    C(c4)
      = 6(3n^2+11n+20) D_n.

  Comparing the t^(n-2) coefficient in Hirzebruch-Riemann-Roch yields

    C(c2^2)
      = 12(3n^2+16n+25) D_n.

  Hence

    F2(h_X)
      = (1/2) C(c2^2)
      = 6(3n^2+16n+25)D_n.

  Step 4: solve the two-by-two system.

  From

    c = a*qinv_X + s*h_X

  the two Fujiki constants satisfy

    F1(c)
      = D_n * (
          (2n+21)(2n-3) a
          + 3(n+3)(2n-3) s
        )

  and

    F2(c)
      = D_n * (
          6(n+3)(2n+19) a
          + 6(3n^2+16n+25) s
        ).

  The determinant of the coefficient matrix before the common D_n
  factor is

    (2n+21)(2n-3) * 6(3n^2+16n+25)
      -
    3(n+3)(2n-3) * 6(n+3)(2n+19)

      = 12(n-3)(n-2)(2n-3).

  This is nonzero for n >= 4.

  Cramer's rule therefore gives the displayed formula for s.

  Finally, by

    k3_n_type_finite_degree_four_orbit_SH_criterion,

  c lies in SH^4 exactly when s=0.  Since the denominator is nonzero,
  s=0 is equivalent to the displayed cross-multiplied equality between
  F1(c) and F2(c).
Qed.


Corollary k3_n_type_stable_finite_inventory_intersection_SH_test:
  For n >= 4 and X of K3^[n]-type, assume a finite required-class
  inventory with full monodromy action on its finite index set, degree
  preservation, and class equivariance.

  For every degree-four inventory index i, let c_i=class(i) and define
  F1(c_i), F2(c_i) as above.  Then

    c_i in SH^4(X,Q)

  iff

    (2n+21)(2n-3) F2(c_i)
      =
    6(n+3)(2n+19) F1(c_i).

Proof:
  By k3_n_type_stable_finite_inventory_degree_four_coordinates,
  c_i has finite full-monodromy orbit.  Apply
  k3_n_type_degree_four_intersection_scalar_extractor.
Qed.


Sources:
  Fujiki generalized intersection relation for deformation-invariant
  Hodge classes.

  Ellingsrud-Goettsche-Lehn / Nieper-Wisskirchen K3^[n]
  Riemann-Roch polynomial

    RR_K3[n](t) = binomial(t/2+n+1,n).

  Closed Fujiki-constant formula for Chern classes of Hilbert schemes
  of points on a K3 surface, giving the stated C(c2) and C(c4).

  Standard polarized Fujiki contraction identity

    C(qinv*alpha)
      = ((b2+2n-2j-2)/(2n-2j-1)) C(alpha).

Boundary:
  the extractor is rational and applies here only after finite-orbit
  or full-monodromy-fixed reduction
  no inventory is constructed
  no inventory is proved to cover actual Zero Day requirements
  no ActuallyRequired predicate is defined
  no actual required class is asserted to satisfy the intersection
  equality
  F1 and F2 are computable targets but are not evaluated for an actual
  Zero Day class in this theorem
  the determinant vanishes at n=2 and n=3; no analogous two-functional
  separation is claimed there
  the file is pseudo-formal mathematical specialization text, not a
  Lean or Coq machine-check of the geometric theorem
  no semantic ZeroDayClosure theorem is proved
  no unconditional closure theorem is claimed
