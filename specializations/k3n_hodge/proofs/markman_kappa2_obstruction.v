Conditional

ExternalResult MarkmanK3nKappa2Relation(X,n) :=
  For n >= 2 and X of K3^[n]-type, Markman's rational Hodge class

    kappa2_X := kappa_2(X) in H^4(X,Q)

  is of Hodge type (2,2), is monodromy invariant, and satisfies

    qinv_X = c2(X) + 2 * kappa2_X

  in H^4(X,Q), where

    qinv_X in Sym^2 H^2(X,Q)

  is the inverse Beauville-Bogomolov class mapped into H^4 by cup product.

Source:
  Eyal Markman,
  The Beauville-Bogomolov class as a characteristic class,
  Lemma 1.4, equation (1.2), together with Proposition 1.2.
  arXiv:1105.3223.

Boundary:
  this is external mathematical input
  kappa2_X is not declared a Zero Day required class
  no required-class inventory index is constructed


Theorem k3_n_type_markman_kappa2_is_exact_negative_c2_half_quotient:
  For n >= 4 and X of K3^[n]-type, let

    K3nDegreeFourQuotient(X)
      := H^4(X,Q) / SH^4(X,Q)

  and

    gamma_X := (1/2) [c2(X)]
      in K3nDegreeFourQuotient(X).

  Then

    pi4_X(kappa2_X) = - gamma_X.

Proof:
  Apply MarkmanK3nKappa2Relation(X,n).

  Since

    qinv_X in Sym^2 H^2(X,Q)

  and Verbitsky gives

    SH^4(X,Q) = Sym^2 H^2(X,Q),

  the quotient projection satisfies

    pi4_X(qinv_X) = 0.

  Project Markman's identity

    qinv_X = c2(X) + 2 * kappa2_X

  to K3nDegreeFourQuotient(X).  This gives

    0
      =
    pi4_X(c2(X)) + 2 * pi4_X(kappa2_X).

  By definition

    gamma_X = (1/2) [c2(X)],

  so

    pi4_X(c2(X)) = 2 * gamma_X.

  Therefore

    0 = 2 * gamma_X + 2 * pi4_X(kappa2_X),

  and hence

    pi4_X(kappa2_X) = - gamma_X.
Qed.


Corollary k3_n_type_markman_kappa2_not_in_SH:
  For n >= 4 and X of K3^[n]-type,

    kappa2_X notin SH^4(X,Q).

Proof:
  Apply
    k3_n_type_markman_kappa2_is_exact_negative_c2_half_quotient.

  By MarkmanK3nDegreeFourQuotientLatticeStructure(X,n),

    gamma_X != 0.

  Hence

    pi4_X(kappa2_X) = - gamma_X != 0.

  Therefore kappa2_X is not in the kernel of the quotient projection,
  so it does not lie in SH^4(X,Q).
Qed.


Theorem k3_n_type_markman_kappa2_c2_scalar_obstruction_is_minus_one:
  For n >= 4 and X of K3^[n]-type,

    K3nDegreeFourC2ScalarObstruction(
      X,
      n,
      kappa2_X
    ) = -1.

Proof:
  By
    k3_n_type_markman_kappa2_is_exact_negative_c2_half_quotient,

    pi4_X(kappa2_X) = - gamma_X.

  By MarkmanK3nDegreeFourQuotientLatticeStructure(X,n),

    B_Q(gamma_X,gamma_X) = 2n - 2.

  Therefore

    B_Q(pi4_X(kappa2_X),gamma_X)
      =
    B_Q(-gamma_X,gamma_X)
      =
    -(2n - 2).

  Since n >= 4, 2n - 2 != 0.  Dividing by 2n - 2 gives

    K3nDegreeFourC2ScalarObstruction(X,n,kappa2_X)
      = -1.
Qed.


Corollary k3_n_type_markman_kappa2_has_finite_nonzero_quotient_orbit:
  For n >= 4 and X of K3^[n]-type,

    FiniteOrbit_Mon(X)(pi4_X(kappa2_X))

  and

    pi4_X(kappa2_X) != 0.

Proof:
  By
    k3_n_type_markman_kappa2_is_exact_negative_c2_half_quotient,

    pi4_X(kappa2_X) = - gamma_X.

  The class gamma_X is fixed by every monodromy operator, so its negative
  is also fixed.  Hence the quotient orbit is a singleton and therefore
  finite.

  Nonvanishing follows from gamma_X != 0.
Qed.


Boundary:
  this closes one natural candidate classification: Markman's canonical
  degree-four kappa2 class contributes no new quotient direction beyond
  the existing c2/2 line; its exact quotient coefficient is -1
  the class is a concrete Hodge (2,2) class outside SH^4 for n >= 4
  it is not asserted to be actually required by Zero Day
  therefore this does not prove or disprove ZeroDayClosure
  if a future independent requirement theorem makes kappa2_X actually
  required, then the current zero-c2-obstruction terminal route cannot
  discharge that class because its scalar obstruction is exactly -1
  no inventory element is manufactured
  no unconditional closure theorem is claimed
