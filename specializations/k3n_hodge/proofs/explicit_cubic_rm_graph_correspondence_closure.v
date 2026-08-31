Standalone closure of the cubic real-multiplication degree-four Hodge frontier for an explicit family of K3 surfaces.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let F := Q(zeta_7 + zeta_7^{-1}), the totally real cubic subfield of Q(zeta_7).
  Put
    alpha := zeta_7 + zeta_7^{-1}.

  Then alpha has minimal polynomial

    f(X) = X^3 + X^2 - 2*X - 1,

  so Q(alpha)=F and [F:Q]=3.

ExternalResult VanGeemenSchuettExplicitCubicRMFamily:
  Van Geemen and Schuett construct an explicit 3-dimensional family of
  elliptic K3 surfaces whose very general member S has

    End_Hdg(T(S)_Q) = F.

  Their terminology "the family has RM by F" means exactly that the very
  general member has F as its full Hodge endomorphism field.

Source:
  Bert van Geemen and Matthias Schuett,
  On families of K3 surfaces with real multiplication,
  Theorem 1.1(7), together with the definition in the Introduction.

ExternalResult DihedralGraphCycleRealizesGenerator:
  In the dihedral-cover construction, let \tilde{E}_a be the covering
  elliptic surface and let sigma be the order-7 automorphism.

  For k in Z/7Z define the algebraic graph cycle

    Gamma_k := Graph(sigma^k)

  in CH^2(\tilde{E}_a x \tilde{E}_a).

  Van Geemen--Schuett prove that the correspondence

    Gamma_1 + Gamma_{-1}

  induces the Hodge endomorphism

    sigma^* + (sigma^{-1})^*,

  whose action on the transcendental K3 Hodge structure is multiplication by

    alpha = zeta_7 + zeta_7^{-1}.

  They further show that this cycle descends through the quotient/birational
  construction to an algebraic codimension-two correspondence

    C_alpha in CH^2(S x S)_Q

  inducing multiplication by alpha on T(S)_Q.

Source:
  van Geemen--Schuett, Section 4.8, especially the graph-cycle construction
  and the statement that Gamma_1 + Gamma_{-1} induces the real multiplication.

Theorem explicit_cubic_generator_is_algebraic:
  For a very general member S of the n=7 cubic-RM family,
  multiplication by alpha on T(S)_Q is induced by an algebraic
  codimension-two correspondence C_alpha on S x S.
Qed.

Theorem full_cubic_endomorphism_field_is_algebraic:
  Every element of

    End_Hdg(T(S)_Q) = F

  is induced by an algebraic correspondence on S x S.

Proof:
  Since alpha has degree three,

    F = Q[alpha] = Span_Q{1, alpha, alpha^2}.

  The identity endomorphism is induced by the diagonal Delta_S.
  The element alpha is induced by C_alpha.
  The element alpha^2 is induced by the composition

    C_alpha o C_alpha.

  Rational linear combinations and compositions of algebraic correspondences
  remain algebraic. Hence every element of F is algebraic.
Qed.

Corollary explicit_cubic_selfproduct_hodge_conjecture_degree4:
  For a very general member S of this explicit family, every rational Hodge
  class in H^4(S x S,Q) is algebraic.

Proof:
  The divisor-product classes are algebraic, and the only transcendental
  Hodge correspondences are End_Hdg(T(S)_Q)=F. Apply
  full_cubic_endomorphism_field_is_algebraic.
Qed.

Inputs from this standalone K3^[n] branch:

  (1) Every rational Hodge class in

        H^4(S^[n],Q) / Sym^2 H^2(S^[n],Q)

      has an algebraic lift.

  (2) Hodge classes in Sym^2 NS(S^[n])_Q are products of divisors.

  (3) The mixed NS tensor T sector contains no rational Hodge classes.

  (4) The remaining transcendental symmetric sector is canonically

        Hdg^4(Sym^2 T(S)_Q) ~= End_Hdg(T(S)_Q)^+.

      For totally real F, the adjoint involution is the identity, so this
      sector is exactly F.

Theorem explicit_cubic_rm_hilbert_scheme_degree4_hodge_closure:
  Let S be a very general member of the van Geemen--Schuett n=7 explicit
  cubic-RM family and let X := S^[n] with n >= 4.

  Then every rational degree-four Hodge class on X is algebraic:

    Hdg^4(X,Q)
      = image( CH^2(X)_Q -> H^4(X,Q) ).

Proof:
  The quotient sector is algebraic by the standalone quotient theorem.
  The Sym^2 NS sector is algebraic by divisor products.
  The mixed sector has no rational Hodge classes.
  The remaining Sym^2 T sector is F and every element of F is algebraic by
  full_cubic_endomorphism_field_is_algebraic.
Qed.

Corollary explicit_graph_cycle_closes_previous_missing_object:
  In the explicit n=7 cubic-RM family, the first missing object isolated in
  projective_k3_cubic_real_multiplication_exact_frontier.v is supplied by

    C_alpha = descent of (Gamma_1 + Gamma_{-1}).

  Thus the cubic frontier is not an absolute obstruction: it is closed on
  concrete cubic-RM families carrying the dihedral-cover geometry.
Qed.

Boundary:
  this does NOT prove the Hodge conjecture for every K3 surface with cubic RM
  the graph-cycle construction is special to the explicit dihedral family
  van Geemen--Schuett explicitly note that a general RM K3 need not admit such
    a simple two-component cycle
  this file concerns rational degree-four Hodge classes
  no integral Hodge conjecture is claimed
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
