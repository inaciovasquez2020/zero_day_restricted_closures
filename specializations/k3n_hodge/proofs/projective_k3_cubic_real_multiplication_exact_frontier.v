Standalone exact frontier for projective K3 surfaces with totally real cubic Hodge endomorphism field.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a smooth complex projective K3 surface and X := S^[n] with n >= 4.
  Let
    T := T(S)_Q,
    E := End_Hdg(T).

  Assume E/Q is totally real cubic:
    [E:Q] = 3.

Inputs already established on this branch:

  (Q4 algebraicity)
    Every rational Hodge class in
      H^4(X,Q) / Sym^2 H^2(X,Q)
    has an algebraic lift.

  (Sym2 reduction)
    Hdg^4(Sym^2 T) ~= E
    because E is totally real and the q-adjoint involution is the identity.

  (Similarity ceiling)
    The Q-span of scalar Hodge similarities is the compositum E_2 of the
    quadratic subfields of E.

Theorem cubic_field_has_no_quadratic_subfield:
  E contains no quadratic subfield.

Proof:
  If F were a quadratic intermediate field Q subset F subset E, then by the
  tower law

    [E:Q] = [E:F] * [F:Q]

  would be divisible by 2, contradicting [E:Q]=3.
Qed.

Corollary cubic_similarity_span_is_scalar:
  The scalar Hodge similarities span only

    E_sim = Q*id.

Proof:
  By cubic_field_has_no_quadratic_subfield, E_2=Q. Apply the similarity
  ceiling theorem already established on this branch.
Qed.

Theorem cubic_sym2_transcendental_hodge_dimension:
  The rational transcendental symmetric Hodge sector has dimension three:

    Hdg^4(Sym^2 T) ~= E,
    dim_Q Hdg^4(Sym^2 T) = 3.
Qed.

ExternalResult IdentityDirectionAlgebraic:
  The identity Hodge endomorphism of T is algebraic as the diagonal
  correspondence on S x S. Under the algebraic incidence/Nakajima transport
  used in the Sym2 reduction, its symmetric tensor direction gives an
  algebraic degree-four class on X.

Theorem cubic_exact_unresolved_dimension:
  After the quotient sector, divisor-product sector, and identity direction
  have been removed, the remaining possible rational degree-four Hodge
  obstruction on X is canonically the two-dimensional quotient

    E / Q*id.

  In particular

    dim_Q (remaining frontier) = 2.

Proof:
  The only non-already-algebraic sector is Hdg^4(Sym^2 T) ~= E.
  Its identity line Q*id is algebraic. Since dim_Q E=3, the quotient has
  dimension two.
Qed.

Theorem cubic_similarity_methods_cannot_reach_remaining_frontier:
  No nonzero class of

    E / Q*id

  can be represented by a scalar Hodge similarity.

Proof:
  cubic_similarity_span_is_scalar says every Q-linear combination of scalar
  Hodge similarities lies in Q*id. Hence its image in E/Q*id is zero.
Qed.

ExternalResult K3SelfProductReduction:
  For a projective K3 surface S, the only non-divisor rational Hodge classes
  in degree four on S x S are represented by

    End_Hdg(T(S)) = E.

  Thus the Hodge conjecture for S x S is equivalent to algebraicity of the
  Hodge endomorphism field E.

Source:
  Ulrich Schlickewei,
  The Hodge conjecture for self-products of certain K3 surfaces,
  Journal of Algebra 324 (2010), 507-529.

Theorem cubic_hilbert_degree4_frontier_equals_selfproduct_frontier:
  In the totally real cubic case, the unresolved rational degree-four Hodge
  problem for X=S^[n] and the unresolved Hodge problem for S x S are the same
  two non-scalar endomorphism directions

    E / Q*id.

  Consequently, after the branch's quotient/divisor/identity results,

    rational Hodge algebraicity in H^4(S^[n],Q)

  is equivalent to algebraicity of the two non-scalar cubic Hodge
  endomorphism directions on S x S.

Proof:
  On X, cubic_exact_unresolved_dimension identifies the frontier as E/Q*id.
  On S x S, K3SelfProductReduction identifies the non-divisor Hodge classes
  as E; the identity is the algebraic diagonal, leaving E/Q*id as the
  unresolved part. Therefore the remaining problems coincide.
Qed.

ExternalBoundary MotivatedAndAbsoluteDoNotImplyAlgebraic:
  Being an Andre-motivated or absolute-Hodge class does not by itself produce
  an algebraic cycle. These notions are strictly intermediate frameworks for
  the present purpose.

  In particular, Deligne's theorem that Hodge classes on abelian varieties
  are absolute Hodge does not prove the Hodge conjecture for arbitrary
  abelian varieties.

ExternalBoundary GeneralKugaSatakeHodgeConjectureUnknown:
  The algebraicity of the Kuga-Satake correspondence is not known for a
  general projective K3 surface. Known real-multiplication Hodge-conjecture
  results use special geometric families (for example Schlickewei's six-line
  double-cover families) rather than an arbitrary totally real cubic E.

Sources:
  Bert van Geemen,
  Real multiplication on K3 surfaces and Kuga-Satake varieties.

  Ulrich Schlickewei,
  The Hodge conjecture for self-products of certain K3 surfaces.

  Mauro Varesco,
  Hodge similarities, algebraic classes, and Kuga-Satake varieties.

Corollary cubic_real_multiplication_first_missing_object:
  The first genuinely missing mathematical object is:

    an algebraic codimension-two correspondence on S x S inducing one
    non-rational generator e of the totally real cubic field E.

  Once one primitive cubic generator e is algebraized, Q[e]=E because E/Q
  has prime degree three, so all of E becomes algebraic by taking Q-linear
  combinations and compositions of the correspondence.

Proof:
  Any e in E\Q generates an intermediate field Q(e) with degree dividing 3
  and greater than 1, hence Q(e)=E. Algebraic correspondences are closed under
  rational linear combinations and composition.
Qed.

Boundary:
  this file does NOT claim existence of the missing cubic correspondence
  it does NOT infer algebraicity from motivated or absolute-Hodge status
  it does NOT assume the general Kuga-Satake Hodge conjecture
  it identifies one concrete missing object whose construction would close
    the entire cubic real-multiplication degree-four frontier
  no ZeroDayClosure semantics are used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
