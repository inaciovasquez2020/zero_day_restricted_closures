Standalone exact boundary for the order-13 / degree-six real-multiplication route.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let

    F_13 := Q(zeta_13 + zeta_13^(-1)),
    alpha_13 := zeta_13 + zeta_13^(-1).

  Since phi(13)=12,

    [F_13:Q] = 6.

Theorem alpha13_minimal_polynomial:
  alpha_13 has minimal polynomial

    f_13(X)
      = X^6 + X^5 - 5*X^4 - 4*X^3 + 6*X^2 + 3*X - 1.

  In particular

    F_13 = Q[alpha_13]

  and one algebraic correspondence inducing alpha_13 would algebraize the
  full field by taking powers through alpha_13^5.
Qed.

ExternalResult VanGeemenSchuettAbstractDegree6Family:
  Van Geemen--Schuett, Theorem 3.19, construct for degree m=6 and l=3 a
  one-dimensional family of projective K3 surfaces whose very general member
  S has real multiplication by the degree-six field F_6 from their table.

  Their proof identifies F_6 with

    Q(zeta_13 + zeta_13^(-1)) = F_13.

  In the degree-six case they take

    Pic(S) = U direct_sum <-4*r^2>^2,

  so

    rho(S) = 4,
    rank_Q T(S)_Q = 18,
    dim_F13 T(S)_Q = 3.

  The RM deformation dimension is therefore

    3 - 2 = 1,

  so this family is maximal for degree-six RM.

Source:
  Bert van Geemen and Matthias Schuett,
  On families of K3 surfaces with real multiplication,
  Theorem 3.19 / proof 3.20.

Theorem degree6_rank_data_is_forced:
  Any projective K3 surface with full RM field F_13 and maximal l=3 has

    rank_Q T = 6*3 = 18,
    rho = 22-18 = 4,

  and lies in a one-dimensional RM deformation space.
Qed.

ExternalResult ExplicitDicksonFamiliesStopBefore13:
  Van Geemen--Schuett's explicit Dickson/dihedral Proposition 4.6 is stated
  only for

    n in {5,7,11}.

  A separate modification treats n=9.

  Their explicit-family Theorem 1.2 lists precisely the orders

    5, 7, 9, 11,

  and does not include order 13.

  Section 4.8 proves that, when the Proposition 4.6 geometric construction is
  available, the graph cycle

    Gamma_1 + Gamma_{-1}

  induces multiplication by zeta_n + zeta_n^(-1).

  However, the paper does not construct an order-13 K3 family satisfying the
  hypotheses needed to apply this graph-cycle mechanism.

Source:
  van Geemen--Schuett, Theorem 1.2, Proposition 4.6, Section 4.8.

Theorem order13_graph_cycle_closure_not_supplied_by_explicit_construction:
  The abstract existence of the maximal F_13-RM family does not supply an
  algebraic correspondence inducing alpha_13.

  In particular, one may not transfer the n=7,9,11 conclusion

    alpha_n is induced by Gamma_1 + Gamma_{-1}

  to the abstract order-13 family without a new geometric construction.
Qed.

Theorem F13_has_unique_quadratic_subfield:
  The Galois group

    Gal(F_13/Q)
      ~= (Z/13Z)^x / {+1,-1}
      ~= C_6

  is cyclic of order six.

  Hence F_13 has a unique quadratic subfield. It is

    Q(sqrt(13)).
Qed.

Recall from projective_k3_real_multiplication_similarity_ceiling.v:
  For a totally real Hodge endomorphism field E, the Q-span of scalar Hodge
  similarities equals the compositum E_2 of all quadratic subfields of E.

Corollary order13_similarity_span:
  For E = F_13,

    E_sim = Q(sqrt(13)).

  Therefore

    dim_Q E_sim = 2,
    dim_Q (F_13 / E_sim) = 4.
Qed.

Corollary perfect_similarity_theorem_would_still_leave_four_directions:
  Even under a hypothetical theorem proving every scalar Hodge similarity on
  T(S) algebraic, similarity methods alone could algebraize at most

    Q(sqrt(13)) subset F_13.

  Four Q-linearly independent directions of F_13 would remain outside the
  similarity span.

  Thus order 13 cannot be closed merely by strengthening Buskin/Varesco from
  isometries to all scalar similarities.
Qed.

Corollary current_degree4_hodge_frontier_for_abstract_F13_family:
  Let S be a very general member of the abstract maximal F_13-RM family and
  X_N := S^[N] with N>=4.

  The standalone branch already closes:

    the quotient H^4 / Sym^2 H^2 sector,
    Sym^2 NS by divisor products,
    the mixed NS tensor T sector (which has no rational Hodge classes).

  The remaining transcendental symmetric sector is

    Hdg^4(Sym^2 T(S)_Q) ~= F_13.

  The identity line is algebraic via the diagonal, but no algebraic
  correspondence generating F_13 is supplied by the abstract existence
  theorem.

  Hence the rational degree-four Hodge problem is not closed on this abstract
  order-13 family by the present route.
Qed.

Theorem prime_order_full_real_cyclotomic_escalation_terminates_at_13:
  For an odd prime p, the maximal totally real cyclotomic field

    Q(zeta_p + zeta_p^(-1))

  has degree

    (p-1)/2.

  A totally real Hodge endomorphism field of a projective K3 surface has
  degree at most seven.

  Therefore, for prime p>=17,

    (p-1)/2 >= 8,

  so the full maximal-real cyclotomic field cannot be the Hodge endomorphism
  field of a projective K3 surface.

  Thus p=13 is the last prime-order case in the direct full-real-cyclotomic
  escalation 5,7,11,13.
Qed.

First missing object:
  To close the abstract F_13 family by the same philosophy as n=7,9,11, one
  needs a genuinely new algebraic codimension-two correspondence

    C_alpha13 in CH^2(S x S)_Q

  inducing multiplication by alpha_13 (or by any primitive generator of
  F_13) on T(S)_Q.

  Once such a single generator exists, its powers and rational linear
  combinations algebraize all of F_13, and the branch's prior decomposition
  closes rational degree-four Hodge algebraicity on S^[N].

Boundary:
  no order-13 graph correspondence is claimed
  abstract RM existence is not treated as algebraicity of the RM action
  no full rational Hodge conjecture is claimed for the abstract F_13 family
  no integral Hodge conjecture is claimed
  prime-order full-real-cyclotomic escalation is stopped here by degree
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
