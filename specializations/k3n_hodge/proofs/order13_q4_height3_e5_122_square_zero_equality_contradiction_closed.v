Standalone closure of the final square-zero equality configuration in the
multiplicity-five h=(1,2,2), homogeneous q=4, height-three order-13
low-multiplicity problem.

SCOPE:
  Continue only from

    order13_q4_height3_e5_122_square_zero_socle_map_reduction.v

  in its unique remaining dangerous equality configuration.

Retain

  C:=Cbar=B/T,
  X:=J/L,
  K_1:=(a,ell*b) subset C,
  A_1:=0:_X K_1,

and the homogeneous cubic

  q:=ell*(a+lambda*b)
    =ell*a+lambda*ell*b
  in K_1.

The preceding equality reduction proves that any surviving tangent-gate
candidate has

  dim_C A_1=18,
  dim_C(0:_X q)=18,

and produces x in X_1 such that

  a*x spans T_3 subset X,
  ell*b*x=0.

It also works in the square-zero case with L intersect T=0, so the full torsion
string T embeds in X.  In particular T_3 is nonzero in X.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

Theorem the_two_eighteen_dimensional_kernels_are_equal:
  One has

    A_1=0:_X q.

Proof:
  Since q belongs to K_1, every element annihilated by K_1 is annihilated by q.
  Hence

    A_1 subseteq 0:_X q.

  The preceding equality reduction gives dimension eighteen for both finite
  dimensional C-vector spaces.  Therefore the inclusion is equality.
Qed.

Theorem the_required_socle_overlap_witness_is_q_annihilated:
  Let x in X_1 satisfy

    a*x in T_3 and a*x !=0,
    ell*b*x=0.

  Then

    q*x=0.

Proof:
  By definition

    q*x
      =ell*(a*x)+lambda*(ell*b*x).

  The second term is zero by the witness condition.

  The first term is also zero.  Indeed a*x belongs to T_3, while the exact
  torsion Hilbert function is

    Hilb_T=t+t^2+t^3.

  Thus T_4=0, and multiplication by the positive-degree element ell sends
  T_3 to T_4=0.

  Therefore q*x=0.
Qed.

Theorem the_square_zero_equality_configuration_is_impossible:
  No x can satisfy the witness conditions of the preceding square-zero
  equality reduction.

Proof:
  Suppose such x exists.

  The preceding theorem gives

    x in 0:_X q.

  The kernel-equality theorem therefore gives

    x in A_1=0:_X K_1.

  Since a belongs to K_1, this forces

    a*x=0.

  But the required equality-case witness has a*x spanning the nonzero line
  T_3.  Contradiction.
Qed.

Corollary no_square_zero_candidate_passes_the_order13_tangent_gate:
  In the ZERO_SELF_ACTION case T^2=0, no candidate satisfies the necessary
  order-13 tangent-dimension gate.

Proof:
  The preceding square-zero socle-map reduction already closes the subcase

    L intersect T=T_3.

  It proves that every dangerous candidate in the remaining subcase

    L intersect T=0

  must satisfy the exact equality configuration and must carry the witness x
  used above.

  The equality-configuration theorem rules out that witness.  Hence no
  dangerous square-zero candidate remains.
Qed.

Corollary e5_h122_height3_subbranch_closed:
  No homogeneous q=4, ht(Q)=3, e(B)=5 candidate with saturated-core h-vector

    (1,2,2)

  satisfies the necessary order-13 tangent-dimension gate.

Proof:
  The preceding torsion-self-action split has exactly two cases.

  NONZERO_SELF_ACTION was already closed there by eta_1<=16.

  ZERO_SELF_ACTION is closed by the preceding corollary.

  Therefore the full e=5, h=(1,2,2) height-three subbranch is closed.
Qed.

Interpretation:
  The final equality case cannot realize its own one-dimensional overlap.
  Equality of the K_1-annihilator and q-annihilator kernels forces every
  q-annihilated class to be killed by a.  But the required overlap witness is
  automatically q-annihilated because its a-product lies in the top torsion
  line T_3 and its ell*b-product is zero.  This contradicts the required
  nonzero a-product.

IMPORTANT_NONCONCLUSION:
  This closes only

    q=4,
    ht(Q)=3,
    e(B)=5,
    h=(1,2,2).

  It does NOT close the remaining e=3, e=4, or e=5 h=(1,2,1,1) height-three
  cores, the q=4 height-two branch, homogeneous q<=3, the unrestricted
  nonhomogeneous local deviation-two frontier, or generic F_13 algebraicity.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  not q4_height3_low_multiplicity_tangent_closure.
  not full_order13_closure.

NEXT_BOUNDED_OBJECT:
  Return to the exact low-multiplicity saturation table and select the next
  still-open q=4, ht(Q)=3 h-vector according to the repository ordering.
  Recompute only its smallest regular-versus-zerodivisor predecessor split;
  do not import the e=5, h=(1,2,2) square-zero argument unless its torsion
  module and annihilator action are reproved there.
