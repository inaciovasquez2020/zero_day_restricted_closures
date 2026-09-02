Standalone linkage exclusion of the degree-three Artin-reduction h-polynomials
in the homogeneous q=4, height-three order-13 low-multiplicity problem.

SCOPE:
  Continue from

    order13_q4_height3_e345_exact_saturation_linkage_table.v
    order13_q4_height3_e5_122_square_zero_equality_contradiction_closed.v

  Work only with

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3,q4),

  where q1,q2,q3,q4 are four linearly independent homogeneous quadrics and

    ht(Q)=3.

  Put

    R := S/(q1,q2,q3),
    q := image of q4 in R,
    K := 0:_R q,
    U := saturation(q*R),
    Cbar := R/U.

  The exact saturation-linkage table proves

    R is one-dimensional graded Gorenstein,
    omega_R ~= R(2),
    K(2) ~= omega_Cbar.

  It also uses graded canonical-module reciprocity

    Hilb_omega_Cbar(t)
      = t*h(t^(-1))/(1-t)

  whenever

    Hilb_Cbar(t)=h(t)/(1-t).

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

The purpose of this file is one structural exclusion.  If the Artin-reduction
h-polynomial h has degree three, then the linkage formula forces K to have a
nonzero degree-zero part.  But a nonzero degree-zero annihilator of q contains
1 and therefore forces q=0 in R.  This contradicts minimal independence of the
four quadratic generators.  Consequently the two table rows whose h-polynomial
has degree three cannot actually occur in the four-independent-quadric,
height-three model.

Theorem the_fourth_quadric_is_nonzero_in_the_three_quadric_section:
  One has

    q != 0 in R.

Proof:
  If q=0 in R, then

    q4 belongs to (q1,q2,q3) in S.

  All four displayed generators are homogeneous of degree two.  Therefore the
  degree-two part of the ideal (q1,q2,q3) is exactly the C-linear span of

    q1,q2,q3.

  Hence q4 would be a constant linear combination of q1,q2,q3, contradicting
  the assumed linear independence of the four quadrics.
Qed.

Theorem degree_three_h_polynomial_forces_degree_zero_annihilator:
  Assume

    Hilb_Cbar(t)=h(t)/(1-t)

  with

    h(t)=h0+h1*t+h2*t^2+h3*t^3

  and h3>0.

  Then

    dim_C K_0=h3>0.

Proof:
  The exact saturation-linkage table gives

    K(2) ~= omega_Cbar.

  With the grading convention used there, this means

    Hilb_K(t)=t^2*Hilb_omega_Cbar(t).

  Canonical-module reciprocity gives

    Hilb_omega_Cbar(t)
      =t*h(t^(-1))/(1-t).

  Therefore

    Hilb_K(t)
      =t^3*h(t^(-1))/(1-t)
      =(h3+h2*t+h1*t^2+h0*t^3)/(1-t).

  The numerator has constant coefficient h3, while

    1/(1-t)=1+t+t^2+...

  has constant coefficient one.  Thus the degree-zero coefficient of Hilb_K is
  exactly h3.  Hence

    dim_C K_0=h3>0.
Qed.

Theorem no_degree_three_h_polynomial_occurs_for_four_independent_quadrics:
  Under the standing four-independent-quadric hypotheses, the h-polynomial of
  Cbar cannot have degree three with positive top coefficient.

Proof:
  Suppose it did.  The preceding theorem gives

    K_0 != 0.

  Since K is a homogeneous ideal of the standard graded ring R and

    R_0=C,

  every nonzero degree-zero element of K is a nonzero scalar, hence a unit.
  Therefore

    1 belongs to K.

  But K=0:_R q, so 1 in K gives

    q=0 in R,

  contradicting the theorem that the fourth quadric remains nonzero in the
  three-quadric section.
Qed.

Corollary e5_h1211_height3_row_is_impossible:
  The exact saturation-table row

    e(B)=5,
    h=(1,2,1,1)

  cannot occur for four linearly independent quadratic generators with
  ht(Q)=3.

Proof:
  Here

    h(t)=1+2*t+t^2+t^3

  has degree three and top coefficient one.  Apply the preceding theorem.
Qed.

Corollary e4_h1111_height3_row_is_impossible:
  The exact saturation-table row

    e(B)=4,
    h=(1,1,1,1)

  cannot occur for four linearly independent quadratic generators with
  ht(Q)=3.

Proof:
  Here

    h(t)=1+t+t^2+t^3

  has degree three and top coefficient one.  Apply the preceding theorem.
Qed.

Remark conditional_torsion_rows_remain_consistent:
  The preceding exact saturation-linkage table computed the torsion Hilbert
  series conditionally for every numerically allowed h-vector.  The present
  argument adds a realizability constraint coming from the nonzero fourth
  quadratic generator.  Thus excluding the two degree-three rows does not
  contradict the conditional Hilbert-series computations in that table.

Corollary exact_remaining_q4_height3_low_multiplicity_rows:
  After combining the established height-three closures and the present
  linkage exclusion, the still-open low-multiplicity rows are only

    e=4, h=(1,2,1),
    e=3, h=(1,2),
    e=3, h=(1,1,1).

Proof:
  Previously established files close

    e=1,
    e=2,
    e=4, h=(1,3),
    e=5, h=(1,3,1),
    e=5, h=(1,2,2),
    e=6.

  The present file excludes

    e=5, h=(1,2,1,1),
    e=4, h=(1,1,1,1).

  Comparing with the exact h-vector table leaves precisely the three displayed
  rows.
Qed.

Interpretation:
  The degree-three h-vector rows do not require a conormal or connecting-rank
  calculation.  Canonical linkage already makes them incompatible with the
  fourth quadric being genuinely new modulo the first three quadrics.

  In particular the next smallest still-open height-three torsion profile is

    e=4,
    h=(1,2,1),
    Hilb_T=t+2*t^2+t^3,
    length_C(T)=4.

IMPORTANT_NONCONCLUSION:
  This file does NOT close

    e=4, h=(1,2,1),
    e=3, h=(1,2),
    e=3, h=(1,1,1),

  and therefore does NOT close the full q=4 height-three low-multiplicity
  tangent problem.

  It makes no claim for q=4 height two, homogeneous q<=3, the unrestricted
  nonhomogeneous local deviation-two frontier, or generic F_13 algebraicity.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  not q4_height3_low_multiplicity_tangent_closure.
  not full_order13_closure.

NEXT_BOUNDED_OBJECT:
  Treat only

    e=4,
    h=(1,2,1),
    Hilb_T=t+2*t^2+t^3.

  Recompute its residual linkage module and Ann_B(T), then derive the smallest
  regular-versus-zerodivisor predecessor split.  Do not import the e=5 h=(1,2,2)
  cyclic-torsion argument unless the length-four torsion module is independently
  identified.