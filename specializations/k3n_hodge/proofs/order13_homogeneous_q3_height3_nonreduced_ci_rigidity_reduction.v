Standalone rigidity reduction for the nonreduced homogeneous q=3, height-three
complete-intersection core in the order-13 deviation-two branch.

SCOPE:
  Continue from order13_homogeneous_q3_height_split.v and
  order13_homogeneous_q3_height3_reduced_ci_tangent_closed.v.

  Let

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3),
    B := S/Q,
    I := Q+(f1,f2,f3),
    L := I/Q=(fbar1,fbar2,fbar3) subset B,
    A := B/L,
    N := length_C(A)>=32,

  where q1,q2,q3 form a regular sequence of quadrics. Thus B is a
  one-dimensional graded Gorenstein complete intersection with multiplicity

    e(B)=2*2*2=8.

  This file treats only the remaining nonreduced H3-CI child. It proves one
  bounded fact: the self-extension defect of L is nonzero.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

ExternalResult rigidity_tensor_equivalence_in_dimension_one_Gorenstein:
  Let R be a one-dimensional Gorenstein local ring and M a finitely generated
  torsionfree R-module. Then

    Ext^1_R(M,M)=0

  if and only if

    M tensor_R M* 

  is torsionfree.

  Source: Huneke--Iyengar--Wiegand, Rigid ideals in Gorenstein rings of
  dimension one, Acta Math. Vietnam. 44 (2019), Proposition 5.1.

ExternalResult multiplicity_eight_rigid_ideal_is_principal:
  Let R be a one-dimensional Cohen--Macaulay local ring and J an m-primary
  reflexive ideal. If

    J tensor_R J*

  is torsionfree and e(R)<=8, then J is principal.

  Source: Huneke--Iyengar--Wiegand, Rigid ideals in Gorenstein rings of
  dimension one, Acta Math. Vietnam. 44 (2019), Theorem 1.3(2), proved via
  their small-multiplicity estimates.

--------------------------------------------------------------------------
1. L IS AN m-PRIMARY REFLEXIVE IDEAL WITH THREE MINIMAL GENERATORS
--------------------------------------------------------------------------

Because A=B/L has finite length, L is m-primary. Since B is one-dimensional
Cohen--Macaulay, every m-primary ideal contains a B-regular element. Since B is
Gorenstein, L is maximal Cohen--Macaulay and reflexive.

The six minimal generators of I consist of the three independent quadrics
q1,q2,q3 and three higher-degree generators f1,f2,f3. Passing modulo Q preserves
minimality of the latter three, hence

  mu_B(L)=3.

In particular L is not principal.

--------------------------------------------------------------------------
2. THE SELF-EXTENSION DEFECT IS NONZERO
--------------------------------------------------------------------------

Put

  epsilon_L := length_C Ext^1_B(L,L).

Theorem nonreduced_H3_CI_self_extension_defect_is_positive:

  epsilon_L >= 1.

Proof:
  Suppose instead that

    Ext^1_B(L,L)=0.

  By rigidity_tensor_equivalence_in_dimension_one_Gorenstein,

    L tensor_B L*

  is torsionfree.

  The ring B has multiplicity eight. Therefore
  multiplicity_eight_rigid_ideal_is_principal applies and forces L to be
  principal.

  But mu_B(L)=3. Contradiction.

  Hence Ext^1_B(L,L) is nonzero. It has finite length because L is locally free
  away from the homogeneous maximal ideal, so

    epsilon_L >=1.
Qed.

--------------------------------------------------------------------------
3. UPDATED NUMERICAL BOUNDARY
--------------------------------------------------------------------------

Let

  E := End_B(L),
  delta_nonneg := sum_{n>=0} dim_C (E/B)_n,
  delta_neg    := sum_{n<0}  dim_C E_n.

The punctured-section count used in the reduced H3-CI file does not require
reducedness for nonnegative degrees. Since Proj(B) is a zero-dimensional scheme
of length eight,

  delta_nonneg <= (8-1)+(8-4)+(8-7)=12.

The intrinsic tangent formula remains

  length_C Hom_B(L,A)
    = N - delta_nonneg - delta_neg + epsilon_L.

Using epsilon_L>=1 gives

  length_C Hom_B(L,A)
    >= N - 11 - delta_neg.

Therefore the remaining nonreduced H3-CI child is tangent-closed as soon as

  delta_neg <= 8,

because then

  dim_C Hom_S(I,A)
    >= dim_C Hom_B(L,A)
    >= N-19
    > N-20.

RESULT:
  nonreduced_H3_CI_self_extension_defect_is_positive.

IMPORTANT_NONCONCLUSION:
  This does not prove delta_neg<=8.
  It does not close the nonreduced H3-CI child.
  It does not close H2-CM or H2-NCM.
  It does not close homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  epsilon_L>=1 is established in the stated H3-CI scope.
  not homogeneous_q3_height3_nonreduced_CI_closed.

MISSING_OBJECT:
  Prove

    delta_neg <= 8,

  or more sharply

    delta_neg - epsilon_L <= 7,

  for the finite graded overring End_B(L) attached to the three-generated
  m-primary ideal L in the multiplicity-eight one-dimensional quadratic
  complete intersection B.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, analyze negative-degree elements of End_B(L) through the
     nilpotent graded part of the punctured section ring.
  3. Do not promote the H3-CI parent before the negative-degree bound is proved.
