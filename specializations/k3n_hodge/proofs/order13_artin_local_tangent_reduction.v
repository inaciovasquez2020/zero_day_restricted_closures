Standalone local-Artin reduction for the nonreduced zero-dimensional decoration
branch in the order-13 F_13 semiregularity problem.

This file follows order13_explicit_A4_hilbert_candidate_census.v.  The previous
reduction showed that a disjoint zero-dimensional decoration Q of length N can
only repair the graph-union ideal-sheaf semiregularity numerically if

  t(Q) := dim_C Hom(I_Q,O_Q) <= N - 20.

The present file does NOT prove a universal Hilbert tangent lower bound.  It
closes two large structural classes and reduces every possible positive tangent
deficit to local Artin algebras that are simultaneously non-Gorenstein and of
embedding dimension exactly four.

This is pseudo-formal mathematical documentation.  It is not Coq and does not
assert generic F_13 algebraicity.

Setup:
  Y is a smooth complex fourfold,
  q in Y,
  Q subset Y is a finite local subscheme supported at q,
  R := completed local ring O^_Y,q ~= C[[x1,x2,x3,x4]],
  A := R/I_Q,
  N := length_C(A),
  e := embdim(A) = dim_C(m_A/m_A^2),
  t(A) := dim_C Hom_R(I_Q,A).

Theorem cotangent_exact_sequence_for_local_Hilbert_tangent:
  There is an exact sequence

    0 -> Der_C(A,A)
      -> A^4
      -> Hom_R(I_Q,A)
      -> T^1(A)
      -> 0.

  In particular

    t(A) >= 4*N - dim Der_C(A,A)

  and

    t(A) >= dim T^1(A).

Proof:
  This is the standard conormal/cotangent-cohomology exact sequence for the
  quotient R -> A, using that R is smooth of dimension four and hence
  Der_C(R,A) ~= A^4 and T^1(R,A)=0.
Qed.

Theorem low_embedding_dimension_has_large_tangent_space:
  If e <= 3, then

    t(A) >= 4*N - e*(N-1)
         = (4-e)*N + e.

  Hence, for every e<=3 and N>=1,

    t(A) > N - 20.

Proof:
  Choose a minimal Cohen presentation

    C[[y1,...,ye]] -> A.

  A derivation of A is determined by its values on y1,...,ye.  Every
  derivation preserves the maximal ideal of the local Artin algebra, so these
  e values lie in m_A, whose C-dimension is N-1.  Therefore

    dim Der_C(A,A) <= e*(N-1).

  Insert this in the cotangent exact-sequence bound.  The weakest case is
  e=3, where t(A)>=N+3.
Qed.

ExternalResult AleksandrovGorensteinTjurinaBound:
  Let A be a local complex Artinian Gorenstein algebra of length N and
  embedding dimension e.  Then

    dim_C T^1(A) >= N + e - 2.

  Source:
    Alexandre Aleksandrov,
    Sur certains invariants des algebres artiniennes commutatives,
    Comptes Rendus Mathematique 362 (2024), 751-759,
    Theorem 5.

  The theorem is stated for the corresponding zero-dimensional Gorenstein
  germ X_0 as

    tau(X_0) >= length(A_0) + e(X_0) - 2,

  with tau(X_0)=dim_C T^1(A_0).

Theorem local_Gorenstein_decorations_fail_order13_gate:
  If A is Gorenstein, then

    t(A) > N - 20.

Proof:
  If e<=3, use low_embedding_dimension_has_large_tangent_space.
  If e=4, the Aleksandrov bound and the cotangent surjection give

    t(A) >= dim T^1(A) >= N+2 > N-20.

  The reduced length-one case is also immediate: a point on a smooth
  fourfold has Hilbert tangent dimension four.
Qed.

Theorem socle_generator_lower_bound_for_tangent_space:
  Let

    s := dim_C Soc(A),
    mu := minimal number of generators of I_Q as an R-ideal.

  Then

    t(A) >= mu*s.

Proof:
  Put M:=I_Q/I_Q^2.  Then

    Hom_R(I_Q,A) ~= Hom_A(M,A).

  The vector space M/m_A*M has dimension mu.  Every C-linear map

    M/m_A*M -> Soc(A)

  lifts by composition with the quotient M -> M/m_A*M to an A-linear map
  M -> A, because m_A annihilates Soc(A).  Therefore

    Hom_C(M/m_A*M,Soc(A))

  injects into Hom_A(M,A), giving dimension at least mu*s.
Qed.

Corollary dangerous_local_component_has_length_at_least_30:
  Suppose A itself satisfies the order-13 necessary gate

    t(A) <= N - 20.

  Then A must satisfy all of the following:

    e = 4,
    A is non-Gorenstein,
    s >= 2,
    mu >= 5,
    N >= mu*s + 20 >= 30.

Proof:
  The first two assertions follow from the previous no-go theorems.
  Non-Gorenstein gives s>=2.

  Since R is regular local of dimension four and A has finite length,
  height(I_Q)=4, hence mu>=4.  Equality mu=4 would make I_Q a complete
  intersection in the Cohen-Macaulay regular local ring R; then A would be
  Artinian complete-intersection and therefore Gorenstein, contradiction.
  Thus mu>=5.

  Finally t(A)>=mu*s and t(A)<=N-20 imply

    N >= mu*s + 20 >= 5*2+20 = 30.
Qed.

Theorem support_decomposition_of_tangent_defect:
  Let an arbitrary finite decoration split into its disjoint local support
  components

    Q = disjoint_union_j Q_j,

  with lengths N_j and tangent dimensions t_j.  Then

    length(Q) = sum_j N_j,
    t(Q)      = sum_j t_j.

  Hence the tangent deficit

    delta(Q) := length(Q) - t(Q)

  is additive:

    delta(Q) = sum_j (N_j-t_j).

  Every component of embedding dimension <=3 has negative deficit, and every
  Gorenstein component has negative deficit.  Therefore if

    t(Q) <= length(Q)-20,

  so delta(Q)>=20, all positive deficit must be supplied by local components
  that are non-Gorenstein of embedding dimension four.  In particular at
  least one such local component must occur.
Qed.

Important limitation:
  The argument does NOT prove that every non-Gorenstein embedding-dimension
  four Artin algebra has t(A)>=N.  The socle/minimal-generator estimate

    t(A)>=mu*s

  can be much smaller than N for long algebras and therefore does not close
  the remaining case by itself.

Boundary:
  The zero-dimensional repair problem is reduced to local complex Artin
  algebras A of embedding dimension four, non-Gorenstein type s>=2, with at
  least five defining generators.  A local component which itself meets the
  order-13 tangent gate must have length at least 30 and satisfy

    dim Hom(I_A,A) <= length(A)-20.

First missing object after this reduction:
  prove a tangent lower bound for non-Gorenstein embedding-dimension-four
  Artin algebras strong enough to rule out a total tangent deficit of 20, or
  exhibit a concrete local algebra of this class with positive deficit and
  test it directly.

  No universal fourfold Hilbert tangent inequality is assumed.
