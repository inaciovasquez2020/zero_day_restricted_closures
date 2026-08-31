Standalone nonsmoothability and derivation-excess reduction for the remaining order-13 deviation-two local-Artin route.

The preceding reductions leave only local Artin algebras A=P/I in embedding dimension four with

  mu(I)=6,
  deviation(I)=2,
  A non-Gorenstein,
  A nonmonomial,
  socle dimension >=2,
  length(A)=N>=32,

as possible candidates for the necessary order-13 local tangent-deficit gate

  t(A) := dim_C Hom_P(I,A) <= N-20.

This file proves two additional necessary conditions: every dangerous candidate is nonsmoothable, and its derivation space must exceed first cotangent cohomology by at least 3N+20.

This is pseudo-formal mathematical documentation.  It is not Coq and does not assert generic F_13 algebraicity.

Setup:
  k := C,
  P is a regular local/analytic k-algebra with embedding dimension 4,
  I subset P is m_P-primary,
  A := P/I is Artinian of length N>0.

Notation:
  t(A) := dim_k Hom_P(I,A),
  T^0(A) := Der_k(A,A),
  T^1(A) := first cotangent cohomology.

ExternalResult FundamentalCotangentCohomologySequence:
  For A=P/I there is an exact sequence

    0 -> T^0(A)
      -> Hom_A(Omega^1_{P/k} tensor_P A,A)
      -> Hom_P(I,A)
      -> T^1(A)
      -> 0.

  Since P is regular of embedding dimension four,

    Hom_A(Omega^1_{P/k} tensor_P A,A) ~= A^4,

  and therefore

    t(A) = 4N - dim_k T^0(A) + dim_k T^1(A).

ExternalResult SmoothableComponentDimension:
  The locus of N distinct reduced points in Hilb^N(A^4) is irreducible of dimension 4N.  Its closure is the smoothable component.  Hence every smoothable point [A] lies on an irreducible component of dimension 4N, and the Zariski tangent space at [A] has dimension at least 4N.

  Under a local presentation A=P/I, the Hilbert-scheme tangent space is canonically

    T_[A] Hilb^N(A^4) ~= Hom_P(I,A).

Theorem any_order13_tangent_deficit_candidate_is_nonsmoothable:
  If

    t(A) <= N-20,

  then A is not smoothable.

Proof:
  If A were smoothable, SmoothableComponentDimension would give

    t(A) >= 4N.

  But for N>0,

    4N > N-20.

  This contradicts the assumed necessary tangent-deficit gate.  Therefore A is nonsmoothable.
Qed.

Theorem order13_tangent_gate_is_huge_derivation_excess:
  The inequality

    t(A) <= N-20

  is equivalent to

    dim_k T^0(A) - dim_k T^1(A) >= 3N+20.

Proof:
  Substitute

    t(A)=4N-dim T^0(A)+dim T^1(A)

  into the tangent gate:

    4N-dim T^0(A)+dim T^1(A) <= N-20

  iff

    dim T^0(A)-dim T^1(A) >= 3N+20.
Qed.

Corollary deviation_two_frontier_after_smoothability_reduction:
  Combine this file with the preceding Gorenstein, almost-complete-intersection, monomial, socle-generator, and deviation reductions.

  Any local Artin algebra capable of passing the necessary order-13 tangent gate must now satisfy simultaneously

    embedding dimension(A) = 4,
    mu(I) = 6,
    deviation(I) = 2,
    A is non-Gorenstein,
    A is nonmonomial,
    A is nonsmoothable,
    socle dimension(A) >= 2,
    length(A)=N >= 32,

  and the quantitative cotangent condition

    dim T^0(A)-dim T^1(A) >= 3N+20.
Qed.

Comparison with known small elementary components:
  Known elementary components of Hilbert schemes of points in A^4 can have tangent/component dimension substantially below 4N, so nonsmoothability alone does not force t(A)>=4N.

  However, the Satriano--Staal family

    I = <x,y>^n1 + <z,w>^n2 + <xz-yw>

  has

    mu(I)=n1+n2+3 >= 7

  for n1,n2>=2.  Thus that standard small-component family does not enter the present six-generator frontier.

  No general lower bound from that literature is used here.

Boundary:
  Smoothable deviation-two algebras are excluded completely.

  The remaining object is a genuinely nonsmoothable, nonmonomial, non-Gorenstein six-generator Artin algebra in embedding dimension four whose derivation excess is at least 3N+20.

  No theorem located here proves that such an algebra cannot exist, and no concrete example satisfying the inequality is claimed.

First missing object after this reduction:
  either

    (A) prove that every nonsmoothable, nonmonomial, non-Gorenstein embedding-dimension-four Artin algebra with mu(I)=6 satisfies

          dim T^0(A)-dim T^1(A) < 3N+20,

        equivalently

          dim Hom_P(I,A) > N-20,

  or

    (B) construct a concrete six-generator deviation-two algebra satisfying

          dim T^0(A)-dim T^1(A) >= 3N+20

        and then compute the actual Buchweitz--Flenner semiregularity map for the decorated graph ideal.
