Standalone closure of the rational degree-four Hodge frontier for the explicit
order-11 degree-five real-multiplication K3 family of van Geemen--Schuett.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Notation warning:
  In van Geemen--Schuett, n=11 denotes the order of the non-symplectic
  automorphism / Dickson-polynomial construction.

  In this file, N denotes the Hilbert-scheme length, so

    X_N := S^[N]

  with N >= 4.

Setup:
  Let

    F_11 := Q(zeta_11 + zeta_11^(-1)),
    alpha_11 := zeta_11 + zeta_11^(-1).

  Since phi(11)=10,

    [F_11:Q] = 5.

Theorem alpha11_minimal_polynomial:
  alpha_11 satisfies

    alpha_11^5 + alpha_11^4 - 4*alpha_11^3
      - 3*alpha_11^2 + 3*alpha_11 + 1 = 0.

  Hence its minimal polynomial over Q is

    f_11(X) = X^5 + X^4 - 4*X^3 - 3*X^2 + 3*X + 1.

Proof:
  This is the standard minimal polynomial of zeta_11 + zeta_11^(-1).
  Its degree is phi(11)/2 = 5, so the displayed monic quintic is minimal.
Qed.

ExternalResult VanGeemenSchuettExplicitN11RMFamily:
  Van Geemen--Schuett construct an explicit 2-dimensional family of elliptic
  K3 surfaces whose very general member S has

    rho(S) = 2,
    Pic(S) = U,
    rank_Q T(S)_Q = 20,
    End_Hdg(T(S)_Q) = F_11.

  Their convention is that a family "has RM by F" precisely when the very
  general member has full Hodge endomorphism field equal to F.

  The family is obtained from the order-11 elliptic family

    y^2 = x^3 + b*x + (c_1*t^11 + c_0)

  by replacing t^11 with the Dickson polynomial p_{11,a}(t).

  The resulting RM family is maximal.

Sources:
  Bert van Geemen and Matthias Schuett,
  On families of K3 surfaces with real multiplication,
  Theorem 1.2(11), Sections 5.7--5.8, together with the convention in the
  Introduction that "has RM by F" means F = End_Hdg(T) very generally.

Theorem explicit_n11_family_is_maximal_degree5_RM:
  For a very general S in the explicit order-11 family,

    dim_{F_11} T(S)_Q = 20/5 = 4.

  Hence the expected real-multiplication deformation dimension is

    4 - 2 = 2,

  equal to the dimension of the explicit family.
Qed.

ExternalResult DihedralGraphCycleRealizesN11Generator:
  Proposition 4.6 applies to the prime order n=11 Dickson deformation.

  On the D_11 covering surface \tilde{E}_a let sigma be the order-11
  automorphism and define

    Gamma_k := Graph(sigma^k).

  Section 4.8 proves that the algebraic cycle

    Gamma_1 + Gamma_{-1}

  induces on H^2 the endomorphism

    sigma^* + (sigma^(-1))^*,

  and that this action realizes multiplication by

    alpha_11 = zeta_11 + zeta_11^(-1)

  on the transcendental K3 Hodge structure.

  The graph cycle induces a codimension-two algebraic correspondence

    C_alpha11 in CH^2(S x S)_Q

  defining the real multiplication on T(S)_Q.

Source:
  van Geemen--Schuett, Proposition 4.6, Section 4.8, Sections 5.7--5.8.

Theorem explicit_n11_degree5_generator_is_algebraic:
  For a very general S in the explicit order-11 family, multiplication by
  alpha_11 on T(S)_Q is induced by C_alpha11.
Qed.

Theorem explicit_n11_full_degree5_endomorphism_field_is_algebraic:
  Every element of

    End_Hdg(T(S)_Q) = F_11

  is induced by an algebraic correspondence on S x S.

Proof:
  Since alpha_11 has degree five,

    F_11 = Q[alpha_11]
         = Span_Q{1, alpha_11, alpha_11^2, alpha_11^3, alpha_11^4}.

  The identity is induced by the diagonal Delta_S.
  For j=1,2,3,4, the endomorphism alpha_11^j is induced by the j-fold
  composition of C_alpha11 with itself.

  Rational linear combinations and compositions of algebraic
  correspondences remain algebraic.
Qed.

Corollary explicit_n11_selfproduct_degree4_hodge_closure:
  For a very general S in this explicit family, every rational Hodge class in

    H^4(S x S,Q)

  is algebraic.

Proof:
  Divisor-product classes are algebraic. The transcendental Hodge
  correspondences are End_Hdg(T(S)_Q)=F_11, all of which are algebraic by the
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

      Since F_11 is totally real, the adjoint involution is the identity and
      this sector is exactly F_11.

Theorem explicit_n11_degree5_rm_hilbert_scheme_degree4_hodge_closure:
  Let S be a very general member of the van Geemen--Schuett explicit
  order-11 family, and let

    X_N := S^[N], N >= 4.

  Then every rational degree-four Hodge class on X_N is algebraic:

    Hdg^4(X_N,Q)
      = image( CH^2(X_N)_Q -> H^4(X_N,Q) ).

Proof:
  The quotient sector is algebraic by the standalone Q4 theorem.
  The Sym^2 NS sector is algebraic by divisor products.
  The mixed NS tensor T sector contains no rational Hodge classes.
  The remaining Sym^2 T sector is F_11, and all of F_11 is algebraic by the
  graph-cycle correspondence C_alpha11 and its powers.
Qed.

Corollary explicit_n11_is_maximal_degree5_rm_closure:
  The graph-cycle construction therefore closes rational degree-four Hodge
  algebraicity on a maximal 2-dimensional degree-five RM family with

    rho(S)=2,
    rank_Q T(S)_Q=20,
    dim_{F_11} T(S)_Q=4.
Qed.

Boundary:
  this proves rational degree-four algebraicity only for the explicit
    van Geemen--Schuett order-11 family and its very general members
  it does not prove the Hodge conjecture for arbitrary K3 surfaces with the
    same degree-five field F_11
  it does not prove an integral Hodge conjecture
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
