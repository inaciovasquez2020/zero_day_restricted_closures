Standalone height reduction for the homogeneous q=4 order-13 deviation-two branch.

SCOPE:
  This file applies only to homogeneous six-generator ideals

    I=(q1,q2,q3,q4,f,g) subset S=C[x1,x2,x3,x4]

  where q1,...,q4 are quadrics, f,g have degree >=3, I is m-primary, and

    A=S/I

  has length N>=32.

  It does not shrink the unrestricted nonhomogeneous local mu(I)=6 frontier.

This is pseudo-formal mathematical documentation. It is not Coq and does not assert generic F_13 algebraicity.

Notation:
  Q:=(q1,q2,q3,q4).

Theorem homogeneous_q4_core_height_not_four:
  ht(Q) != 4.

Proof:
  If ht(Q)=4, then in the regular ring S the four homogeneous quadrics form a regular sequence. Hence S/Q is the zero-dimensional complete intersection of type (2,2,2,2), so

    length(S/Q)=2^4=16.

  Since I contains Q, A=S/I is a quotient of S/Q, and therefore

    N=length(A)<=16,

  contradicting N>=32.
Qed.

Theorem homogeneous_q4_core_height_at_least_two:
  ht(Q)>=2.

Proof:
  By Krull's principal ideal theorem applied successively to the two additional generators f and g,

    ht(I)<=ht(Q)+2.

  Since I is m-primary in the four-dimensional polynomial ring S,

    ht(I)=4.

  Therefore ht(Q)>=2.
Qed.

Corollary homogeneous_q4_core_height_split:
  Every homogeneous q=4 candidate in the length N>=32 frontier satisfies

    ht(Q) in {2,3}.
Qed.

Case A: ht(Q)=3.
  Then B=S/Q has dimension one and the two higher-degree generators f,g cut B to finite length.

Case B: ht(Q)=2.
  Then B=S/Q has dimension two and the two higher-degree generators must together provide the full remaining codimension-two cut.

No Cohen--Macaulayness, regular-sequence property for f,g, or tangent-space lower bound is asserted here.

HOMOGENEOUS_Q4_BOUNDARY:
  The q=4 homogeneous branch is reduced to two structural cases:

    (A) four-quadric core of height three, dimension-one quotient, followed by two higher-degree generators;
    (B) four-quadric core of height two, dimension-two quotient, followed by two higher-degree generators.

UNRESTRICTED_LOCAL_BOUNDARY:
  unchanged. An arbitrary nonhomogeneous local six-generator deviation-two algebra need not arise from this homogeneous q=4 decomposition.

NEXT_BOUNDED_OBJECT:
  analyze Case A first. If the height-three four-quadric core is Cohen--Macaulay, test whether variation of a regular parameter combination of f,g forces an N-dimensional tangent subspace; otherwise isolate the finite saturation defect as in the q=5 branch. Stop rather than assume every height-three four-quadric core is perfect.