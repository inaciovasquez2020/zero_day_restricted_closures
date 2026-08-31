Standalone rank-one frontier for the order-13 F_13 Buchweitz--Flenner
semiregularity route.

This file follows order13_nonzero_rank_rr_frontier.v.  It isolates exactly
what rank +/-1 can and cannot do.  It is pseudo-formal mathematical
documentation and does not assert generic algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  L1 := U direct_sum <-4> direct_sum <-4>,
  T := T_L1 = L1^perp in H^2(X,Z),
  F := Q(zeta_13 + zeta_13^(-1)),
  alpha := zeta_13 + zeta_13^(-1),
  Z_prim := the primitive-normalized rational degree-four class whose middle
            action is alpha on T_Q and zero on L1_Q.

ExternalResult ShiftPreservesBFKernel:
  For a perfect complex E, shifting by one identifies

    Ext^2(E,E) ~= Ext^2(E[1],E[1])

  and changes the categorical trace by an overall sign.  Hence the kernel of
  the Buchweitz--Flenner semiregularity map is unchanged by shifts.

Corollary rank_minus_one_reduces_to_rank_plus_one:
  A rank -1 semiregularity candidate exists if and only if the shifted rank +1
  package exists, up to changing the sign of its Chern character.  Therefore
  it is enough to analyze rank +1.
Qed.

ExternalResult DeterminantOfPerfectComplex:
  Every perfect complex E has a determinant line bundle det(E), and

    c1(E) = c1(det(E)).

Theorem persistent_rankone_c1_can_be_normalized_to_zero:
  Let E be a rank-one perfect complex intended to deform along the
  L1-polarized F_13-RM curve, and suppose its first Chern class is persistent
  along that curve.  Then tensoring by det(E)^(-1) gives a rank-one perfect
  complex E0 with

    c1(E0)=0.

  By line_bundle_twist_preserves_semiregularity_kernel from
  order13_semiregularity_twist_stabilization_no_go.v, E is semiregular if and
  only if E0 is semiregular.

  Thus every rank-one candidate with persistent c1 may be analyzed after the
  normalization

    r=1,
    c1=0.
Qed.

Remark:
  Persistence of c1 is not an extra closure assumption for the intended
  Buchweitz--Flenner deformation route: if the full Chern character is to
  remain Hodge along the L1-polarized family, its integral degree-two part
  must remain of type (1,1), hence is represented by the persistent Picard
  subsystem on a very general fiber.

Theorem normalized_rankone_Euler_pairing:
  Let E be rank one with c1(E)=0.  Then

    chi(E,E)
      = integral_Y [
          ch2(E)^2
          + 2*ch4(E)
          + ch2(E)*c2(Y)/6
        ]
        + 4.

Proof:
  Substitute r=1 and c1=0 into exact_CY4_self_Euler_pairing from
  order13_nonzero_rank_rr_frontier.v.
Qed.

Theorem normalized_rankone_Chern_class_form:
  For rank one and c1=0,

    ch2(E) = -c2(E),

    ch4(E) = (c2(E)^2 - 2*c4(E))/12.

  Therefore

    chi(E,E)
      = integral_Y [
          (7/6)*c2(E)^2
          - (1/3)*c4(E)
          - (1/6)*c2(E)*c2(Y)
        ]
        + 4.
Qed.

Corollary normalized_rankone_semiregularity_gate:
  If E is simple and Buchweitz--Flenner semiregular, then

    integral_Y [
      7*c2(E)^2
      - 2*c4(E)
      - c2(E)*c2(Y)
    ] <= 252.

Proof:
  simple_semiregular_candidate_must_have_small_Euler_pairing gives

    chi(E,E) <= 46.

  Substitute normalized_rankone_Chern_class_form and multiply by 6.
Qed.

Theorem rankone_degree_four_class_is_integral:
  If E has rank one and c1(E)=0, then

    ch2(E)=-c2(E)

  is integral modulo torsion.

  Hence a rank-one candidate carrying a nonzero primitive alpha coefficient
  cannot use the nonintegral class Z_prim by itself.  Its total degree-four
  class must contain additional algebraic components which repair integral
  K3-lattice gluing.
Qed.

Theorem rankone_locally_free_route_is_closed:
  A locally free rank-one sheaf on Y is a line bundle.  After determinant
  normalization it is O_Y, whose higher Chern classes vanish.  In particular

    ch2(O_Y)=0,

  so it has no primitive alpha component.

  Therefore no rank-one vector bundle can realize the order-13 generator.
Qed.

ExternalResult RankOneTorsionFreeIdealSheafForm:
  Let M be a smooth integral variety and E a rank-one torsion-free coherent
  sheaf on M.  Then E** is a line bundle L.  After twisting by L^(-1), E is an
  ideal sheaf I_Z of a closed subscheme Z of codimension at least two.

Theorem normalized_rankone_torsionfree_route_is_ideal_sheaf_route:
  Every rank-one torsion-free sheaf candidate with persistent determinant is,
  after a semiregularity-kernel-preserving line-bundle twist, of the form

    I_Z

  for a codimension-at-least-two subscheme Z subset Y.

  If Z has a codimension-two component with fundamental cycle [Z]_2, then

    ch2(I_Z) = -[Z]_2.

  Consequently a nonzero primitive alpha component in ch2(I_Z) is already the
  primitive projection of an actual effective codimension-two algebraic cycle
  on the special fiber.
Qed.

Corollary rankone_sheaf_route_is_not_a_formal_Ktheory_escape:
  The surviving rank-one coherent-sheaf strategy is exactly a Hilbert/ideal-
  sheaf semiregularity problem:

    construct Z subset X_13 x X_13

  such that

    (1) the primitive projection of [Z]_2 is a nonzero rational multiple of
        Z_prim (up to persistent algebraic degree-four terms),
    (2) I_Z is simple and Buchweitz--Flenner semiregular,
    (3) the full Chern character of I_Z remains Hodge along the F_13-RM
        deformation.

  If such Z exists, Buchweitz--Flenner deformation would spread its algebraic
  codimension-two class and close the desired primitive alpha algebraicity.
Qed.

Theorem rankone_RR_alone_does_not_rule_out_ideal_sheaf_candidate:
  The rank-one identity contains the top Chern term

    -(1/3)*integral c4(E).

  No inequality established in this repository bounds c4(E) strongly enough
  in terms of the primitive alpha coefficient of c2(E) to force

    chi(E,E)>46.

  Therefore the rank-one Riemann--Roch calculation by itself does not rule out
  an ideal-sheaf or genuinely derived rank-one candidate.
Qed.

Important limitation:
  This file does NOT construct an effective codimension-two cycle Z with the
  required primitive projection.
  It does NOT prove an ideal sheaf I_Z is semiregular.
  It does NOT rule out a genuinely derived rank-one perfect complex which is
  not quasi-isomorphic to a torsion-free sheaf.
  It does NOT prove generic F_13 algebraicity.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this rank-one reduction:
  an explicit effective codimension-two subscheme Z on X_13 x X_13 whose
  cycle class has nonzero primitive alpha projection and whose ideal sheaf
  passes the Buchweitz--Flenner injectivity test.

  If no such effective representative can exist, the rank-one coherent-sheaf
  branch closes and the perfect-complex search must move to genuinely derived
  rank >=2 objects.