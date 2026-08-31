Standalone monomial exclusion for the order-13 local-Artin semiregularity route.

This file strengthens the earlier monomial almost-complete-intersection computation.  The local reduction requires a zero-dimensional local algebra A=P/I in embedding dimension four, of length N, to satisfy

  t(A) := dim_C Hom_P(I,A) <= N-20

in order to pass the necessary ideal-sheaf semiregularity dimension gate.

This is pseudo-formal mathematical documentation.  It is not Coq and does not assert generic F_13 algebraicity.

Setup:
  k := C,
  P is a regular local/analytic k-algebra of embedding dimension m,
  I subset P is m_P-primary,
  A := P/I is Artinian of length N.

Notation:
  T^0(A) := Der_k(A,A),
  T^1(A) is first cotangent cohomology.

ExternalResult FundamentalCotangentCohomologySequence:
  For A=P/I there is an exact sequence

    0 -> T^0(A)
      -> Hom_A(Omega^1_{P/k} tensor_P A,A)
      -> Hom_P(I,A)
      -> T^1(A)
      -> 0.

  Since P is regular of embedding dimension m,

    dim_k Hom_A(Omega^1_{P/k} tensor_P A,A) = m*N.

  Hence

    dim_k Hom_P(I,A)
      = m*N - dim_k T^0(A) + dim_k T^1(A).

ExternalResult AleksandrovMonomialInequalityBoundary:
  Aleksandrov, after the discussion of Proposition 9 and Remark 13 in the final section of

    A. G. Aleksandrov,
    Deformations of commutative Artinian algebras,
    Algebra i Analiz 34:6 (2022), 1-33;
    St. Petersburg Math. J. 34:6 (2023), 889-911,

  states that the opposite inequality

    dim_k T^1(A) < dim_k T^0(A)

  can occur only for zero-dimensional germs of embedding dimension greater than three which are neither Gorenstein nor monomial.

  Therefore, for every monomial Artinian algebra,

    dim_k T^1(A) >= dim_k T^0(A).

  This is used only in the displayed direction.  No equality is asserted for arbitrary monomial algebras.

Theorem every_monomial_artin_embedded_tangent_at_least_ambient_dimension:
  If A=P/I is monomial, then

    dim_k Hom_P(I,A) >= m*N.

Proof:
  By the fundamental exact sequence,

    dim Hom_P(I,A)
      = m*N - dim T^0(A) + dim T^1(A).

  AleksandrovMonomialInequalityBoundary gives

    dim T^1(A) - dim T^0(A) >= 0.

  Therefore

    dim Hom_P(I,A) >= m*N.
Qed.

Corollary embedding_dimension_four_monomial_repair_route_closed:
  If embedding dimension(A)=4 and A is monomial, then

    t(A) >= 4*N.

  Since N>0,

    4*N > N-20.

  Hence NO monomial local zero-dimensional decoration can satisfy the necessary order-13 tangent-deficit gate.
Qed.

Corollary monomial_deviation_two_mu6_case_closed:
  In particular, let

    P = C[[x1,x2,x3,x4]]

  be a minimal Cohen presentation and let I be an m-primary monomial ideal with

    mu(I)=6,
    deviation(I)=2.

  Then

    dim_C Hom_P(I,P/I) >= 4*length_C(P/I),

  so it cannot satisfy

    dim_C Hom_P(I,P/I) <= length_C(P/I)-20.
Qed.

Independent finite diagnostic:
  For the normalized cubic box

    I=(x1^3,x2^3,x3^3,x4^3,m5,m6),

  an exact multigraded lcm-syzygy enumeration over all 1737 minimal unordered pairs of mixed monomials m5,m6 inside the box found

    dim Hom_P(I,P/I) = 4*length(P/I)

  in every case.  This finite census is not used as the proof of the theorem above; it is only an independent consistency check.

Boundary:
  The monomial route is closed for every deviation and every number of minimal generators in embedding dimension four.

  The first live deviation-two class is therefore genuinely nonmonomial:

    embedding dimension = 4,
    deviation = 2,
    mu(I) = 6,
    non-Gorenstein,
    nonmonomial,
    socle dimension >= 2,
    length >= 32.

  No theorem here bounds t(A) strongly enough for every nonmonomial six-generator grade-four Artin ideal.

First missing object after this closure:
  either

    (A) prove for every nonmonomial, non-Gorenstein, embedding-dimension-four Artin algebra with mu(I)=6 that

          dim Hom(I,A) > length(A)-20,

  or

    (B) exhibit a concrete nonmonomial deviation-two algebra with

          dim Hom(I,A) <= length(A)-20

        and compute the actual Buchweitz--Flenner semiregularity map for the resulting decorated graph ideal.
