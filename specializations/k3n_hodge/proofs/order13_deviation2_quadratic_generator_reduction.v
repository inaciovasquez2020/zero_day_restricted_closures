Standalone quadratic-generator reduction for the remaining order-13 deviation-two local-Artin route.

This file sharpens the six-generator frontier by excluding any candidate whose six minimal generators are all quadratic.

This is pseudo-formal mathematical documentation.  It is not Coq and does not assert generic F_13 algebraicity.

Setup:
  k := C,
  P := k[x1,x2,x3,x4] localized/completed at the homogeneous maximal ideal m,
  I subset P is m-primary,
  A := P/I is Artinian,
  embedding dimension(A)=4,
  mu(I)=6,
  length(A)=N>=32.

Notation:
  q := dim_k I_2,
  equivalently the number of minimal quadratic generators because embedding dimension four implies I has no linear generators.

ExternalResult GenericQuadraticReduction:
  Let J be an m-primary homogeneous ideal in k[x1,x2,x3,x4] generated in degree two.  Since k is infinite and the polynomial ring is Cohen--Macaulay of dimension four, four sufficiently general k-linear combinations of the quadratic generators form a homogeneous system of parameters, hence a regular sequence of four quadrics.

  Therefore there exists a complete-intersection ideal

    K=(q1,q2,q3,q4) subseteq J

  with deg(qi)=2, and

    length(P/J) <= length(P/K)=2^4=16.

Theorem six_quadratic_generators_cannot_reach_order13_length_frontier:
  Assume all six minimal generators of I are quadratic.

  Then I itself is generated in degree two.  Since A=P/I is Artinian, I is m-primary.  Apply GenericQuadraticReduction to obtain four quadratic linear combinations q1,...,q4 in I forming a regular sequence.

  Hence

    N=length(P/I) <= length(P/(q1,q2,q3,q4))=16,

  contradicting N>=32.

  Therefore not all six minimal generators can be quadratic.
Qed.

Corollary at_most_five_quadratic_generators:
  q <= 5.
Qed.

Corollary second_Hilbert_value_at_least_five:
  Since dim_k P_2=10 and dim_k I_2=q,

    h_2(A)=dim_k A_2=10-q >= 5.
Qed.

Corollary classical_H143_elementary_component_cannot_compress_to_mu6:
  A homogeneous Artin algebra with Hilbert function

    (1,4,3)

  has

    dim I_2 = 10-3 = 7.

  Because there are no degree-one generators, all seven independent quadrics are minimal.  Hence every such algebra has mu(I)>=7.

  In particular, the classical nonsmoothable/elementary H=(1,4,3) component cannot specialize inside the same Hilbert stratum to the present mu(I)=6 frontier.  Any putative six-generator degeneration must leave that stratum, and the preceding corollary forces h_2>=5 once N>=32 is also imposed.
Qed.

Literature context:
  Cartwright--Erman--Velasco--Viray, Hilbert schemes of 8 points, Algebra Number Theory 3 (2009), identify the second component of Hilb^8(A^4) as the local homogeneous Hilbert-function (1,4,3) locus.

  This source is used only for the historical/nonsmoothable-component context.  The seven-quadrics count itself is elementary dimension arithmetic and does not depend on that classification theorem.

Frontier after this reduction:
  A dangerous order-13 six-generator algebra must satisfy

    embedding dimension(A)=4,
    mu(I)=6,
    A non-Gorenstein,
    A nonmonomial,
    A nonsmoothable,
    length(A)=N>=32,
    dim Hom_P(I,A) <= N-20,

  and now additionally

    number of minimal quadratic generators <=5,
    h_2(A)>=5.

  The first maximal-quadratic-count shape to test is therefore five quadratic generators plus one generator of degree >=3.

Boundary:
  This does not rule out five-quadratic-plus-one-higher-generator deviation-two ideals, nor any lower quadratic count.

Next bounded object:
  construct an explicit nonmonomial, non-Gorenstein five-quadratic-plus-one-higher-generator Artin family with N>=32 and compute Hom_P(I,A) exactly.