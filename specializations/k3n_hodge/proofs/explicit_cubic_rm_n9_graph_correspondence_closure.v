Standalone closure of the rational degree-four Hodge frontier for the explicit
order-9 cubic real-multiplication K3 family of van Geemen--Schuett.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Notation warning:
  In van Geemen--Schuett, n=9 denotes the order of the non-symplectic
  automorphism / Dickson-polynomial construction.

  In this file, N denotes the Hilbert-scheme length, so

    X_N := S^[N]

  with N >= 4.

Setup:
  Let

    F_9 := Q(zeta_9 + zeta_9^(-1)),
    alpha_9 := zeta_9 + zeta_9^(-1).

  Since phi(9)=6,

    [F_9:Q] = 3.

Theorem alpha9_minimal_polynomial:
  alpha_9 satisfies

    alpha_9^3 - 3*alpha_9 + 1 = 0,

  and hence its minimal polynomial over Q is

    f_9(X) = X^3 - 3*X + 1.

Proof:
  Let z := zeta_9. Then

    (z+z^(-1))^3 - 3*(z+z^(-1))
      = z^3 + z^(-3).

  Since z^3 is a primitive cube root of unity,

    z^3 + z^(-3) = -1.

  Thus alpha_9^3 - 3*alpha_9 + 1 = 0.

  The field Q(zeta_9 + zeta_9^(-1)) has degree phi(9)/2=3, so this cubic is
  the minimal polynomial.
Qed.

ExternalResult VanGeemenSchuettExplicitN9RMFamily:
  Van Geemen--Schuett construct an explicit 2-dimensional family of elliptic
  K3 surfaces whose very general member S has

    rho(S) = 10,
    rank_Q T(S)_Q = 12,
    End_Hdg(T(S)_Q) = F_9.

  Their convention is that a family "has RM by F" precisely when the very
  general member has full Hodge endomorphism field equal to F.

  The family is obtained by deforming the order-9 non-symplectic family

    y^2 = x^3 + b*x + c_1*t^9 + c_0

  by replacing t^9 with the Dickson polynomial p_{9,a}(t).

  The Picard lattice is preserved and the resulting RM family is maximal.

Sources:
  Bert van Geemen and Matthias Schuett,
  On families of K3 surfaces with real multiplication,
  Theorem 1.2(9), Sections 5.5--5.6.

ExternalResult DihedralGraphCycleRealizesN9Generator:
  In the D_9-cover construction, let sigma be the order-9 automorphism of the
  covering surface and let

    Gamma_k := Graph(sigma^k).

  The algebraic cycle

    Gamma_1 + Gamma_{-1}

  induces on H^2 the endomorphism

    sigma^* + (sigma^(-1))^*.

  On the primitive ninth-root summand containing T(S)_Q, this action is
  multiplication by

    alpha_9 = zeta_9 + zeta_9^(-1).

  The cycle induces/descends to an algebraic codimension-two correspondence

    C_alpha9 in CH^2(S x S)_Q

  defining the real multiplication on T(S)_Q.

  The n=9 proof modifies Proposition 4.6 only by splitting the D_9
  representation into the eigenvalue sectors 1, primitive cube roots, and
  primitive ninth roots; the graph-cycle correspondence itself is the same
  Section 4.8 construction.

Source:
  van Geemen--Schuett, Section 4.8 and Sections 5.5--5.6.

Theorem explicit_n9_cubic_generator_is_algebraic:
  For a very general S in the explicit n=9 family, multiplication by alpha_9
  on T(S)_Q is induced by the algebraic correspondence C_alpha9.
Qed.

Theorem explicit_n9_full_cubic_endomorphism_field_is_algebraic:
  Every element of

    End_Hdg(T(S)_Q) = F_9

  is induced by an algebraic correspondence on S x S.

Proof:
  By alpha9_minimal_polynomial,

    F_9 = Q[alpha_9]
        = Span_Q{1, alpha_9, alpha_9^2}.

  The identity is induced by the diagonal Delta_S.
  The element alpha_9 is induced by C_alpha9.
  The element alpha_9^2 is induced by

    C_alpha9 o C_alpha9.

  Rational linear combinations and compositions of algebraic
  correspondences are algebraic.
Qed.

Corollary explicit_n9_selfproduct_degree4_hodge_closure:
  For a very general S in this explicit family, every rational Hodge class in

    H^4(S x S,Q)

  is algebraic.

Proof:
  Divisor-product classes are algebraic. The transcendental Hodge
  correspondences are End_Hdg(T(S)_Q)=F_9, all of which are algebraic by the
  preceding theorem.
Qed.

Inputs from this standalone K3^[N] branch:

  (1) Every rational Hodge class in

        H^4(S^[N],Q) / Sym^2 H^2(S^[N],Q)

      has an algebraic lift for N >= 4.

  (2) Sym^2 NS(S^[N])_Q is algebraic by divisor products.

  (3) NS tensor T contains no rational Hodge classes.

  (4) The remaining transcendental symmetric sector is

        Hdg^4(Sym^2 T(S)_Q)
          ~= End_Hdg(T(S)_Q)^+.

      Since F_9 is totally real, the adjoint involution is the identity and
      this sector is exactly F_9.

Theorem explicit_n9_cubic_rm_hilbert_scheme_degree4_hodge_closure:
  Let S be a very general member of the van Geemen--Schuett explicit n=9
  family, and let

    X_N := S^[N], N >= 4.

  Then every rational degree-four Hodge class on X_N is algebraic:

    Hdg^4(X_N,Q)
      = image( CH^2(X_N)_Q -> H^4(X_N,Q) ).

Proof:
  The quotient sector is algebraic by the standalone Q4 theorem.
  The Sym^2 NS sector is algebraic by divisor products.
  The mixed NS tensor T sector contains no rational Hodge classes.
  The remaining Sym^2 T sector is F_9 and all of F_9 is algebraic by the
  graph-cycle correspondence C_alpha9 and its square.
Qed.

Corollary explicit_n9_is_maximal_cubic_rm_closure:
  The very general member has

    rho(S)=10,
    rank_Q T(S)_Q=12,
    dim_{F_9} T(S)_Q=4.

  Therefore the cubic-RM deformation-space dimension is

    4 - 2 = 2,

  exactly the dimension of the explicit family.

  Hence this graph-cycle construction closes rational degree-four Hodge
  algebraicity on a maximal 2-dimensional cubic-RM family, not merely on a
  lower-dimensional special subfamily.
Qed.

Boundary:
  this proves rational degree-four algebraicity only for the explicit
    van Geemen--Schuett order-9 family and its very general members
  it does not prove the Hodge conjecture for arbitrary K3 surfaces with the
    same cubic field F_9
  it does not prove an integral Hodge conjecture
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
