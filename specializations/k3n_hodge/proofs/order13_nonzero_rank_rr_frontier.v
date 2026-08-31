Standalone Riemann--Roch frontier for genuinely indecomposable nonzero-rank
Buchweitz--Flenner semiregularity candidates in the order-13 F_13
real-multiplication problem.

This file is pseudo-formal mathematical documentation.  It strengthens the
rank-zero and stabilization no-go files by deriving the exact Calabi--Yau
fourfold Euler pairing when rank, c1, ch3 and ch4 are allowed to be nonzero.
It does not assert generic algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  L1 := U direct_sum <-4> direct_sum <-4>,
  T := T_L1 = L1^perp in H^2(X,Z),
  F := Q(zeta_13 + zeta_13^(-1)),
  alpha := zeta_13 + zeta_13^(-1).

  Let Z_prim be the primitive-normalized rational degree-four class from
  order13_corrected_alpha_semiregularity_window.v.  Its action on H^2 is

    alpha on T_Q,
    0 on L1_Q,

  and

    integral_Y Z_prim^2 = 33.

ExternalResult HRRForPerfectComplexes:
  For a perfect complex E on a smooth projective variety Y,

    chi(E,E) = integral_Y ch(E^vee) ch(E) td(Y).

ExternalResult ToddClassCY4:
  If c1(Y)=0 and dim_C(Y)=4, then

    td(Y)
      = 1 + c2(Y)/12 + td_4(Y),

  with no odd Todd components, and

    integral_Y td_4(Y) = chi(O_Y).

  For Y=X x X with X a K3 surface,

    chi(O_Y) = chi(O_X)^2 = 2^2 = 4.

Theorem exact_CY4_self_Euler_pairing:
  Let E be any perfect complex on Y and write

    ch(E) = r + c1 + ch2 + ch3 + ch4

  by codimension.  Then

    chi(E,E)
      = integral_Y [
          ch2^2
          + 2*r*ch4
          - 2*c1*ch3
          + ((2*r*ch2 - c1^2)*c2(Y))/12
        ]
        + 4*r^2.

Proof:
  Duality changes signs on the odd Chern-character components:

    ch(E^vee) = r - c1 + ch2 - ch3 + ch4.

  Multiplying and collecting codimensions gives

    degree 0 : r^2,
    degree 1 : 0,
    degree 2 : 2*r*ch2 - c1^2,
    degree 3 : 0,
    degree 4 : ch2^2 + 2*r*ch4 - 2*c1*ch3.

  Since td_1(Y)=td_3(Y)=0, only

    degree4 * td_0,
    degree2 * td_2,
    degree0 * td_4

  contribute to the integral.  Substitute td_2=c2(Y)/12 and
  integral_Y td_4=4.
Qed.

ExternalResult BF_target_dimension_on_K3_product:
  The Buchweitz--Flenner semiregularity target

    product_(q>=0) H^(q+2)(Y,Omega_Y^q)

  has complex dimension 44.

Theorem simple_semiregular_candidate_must_have_small_Euler_pairing:
  If E is simple and Buchweitz--Flenner semiregular, then

    chi(E,E) <= 46.

Proof:
  Put e_i=dim Ext^i_Y(E,E).  Since K_Y is trivial and E is simple,

    e_0=e_4=1,
    e_3=e_1.

  Hence

    chi(E,E) = 2 - 2*e_1 + e_2.

  Semiregularity means the map from Ext^2(E,E) into the 44-dimensional BF
  target is injective, so e_2<=44.  Since e_1>=0,

    chi(E,E) <= 2 + 44 = 46.
Qed.

Corollary exact_nonzero_rank_RR_necessary_inequality:
  Every simple semiregular nonzero-rank candidate must satisfy

    integral_Y [
      ch2^2
      + 2*r*ch4
      - 2*c1*ch3
      + ((2*r*ch2 - c1^2)*c2(Y))/12
    ]
    + 4*r^2
    <= 46.

  This is the exact numerical gate replacing the rank-zero identity

    chi(E,E)=integral ch2^2.
Qed.

Theorem primitive_alpha_piece_is_Todd_orthogonal:
  The primitive class Z_prim satisfies

    integral_Y Z_prim * c2(Y) = 0.

Proof:
  Z_prim lies entirely in the middle Kunneth summand

    H^2(X,Q) tensor H^2(X,Q).

  Since c1(X)=0,

    c2(Y)
      = p1^*c2(X) + p2^*c2(X),

  which lies in the two outer summands

    H^4(X,Q) tensor H^0(X,Q)
    plus
    H^0(X,Q) tensor H^4(X,Q).

  Their product with a middle H^2 tensor H^2 class has degree six on one K3
  factor and therefore integrates to zero.
Qed.

Define the persistent middle identity projector P_T by subtracting from the
middle Kunneth component of the diagonal the divisor-product projector P_L1.
Then P_T is algebraic throughout the L1-polarized family and acts as

  Id on T_Q,
  0 on L1_Q.

Theorem primitive_alpha_identity_pairings:
  The middle intersection pairings are

    Z_prim^2 = 33,
    Z_prim . P_T = -3,
    P_T^2 = 18.

Proof:
  Under the correspondence/intersection trace dictionary these are

    Tr_Q(alpha^2 | T_Q),
    Tr_Q(alpha | T_Q),
    dim_Q(T_Q).

  Since dim_F(T_Q)=3,

    Tr_Q(alpha^2 | T_Q)
      = 3*Tr_F/Q(alpha^2)
      = 3*11
      = 33,

    Tr_Q(alpha | T_Q)
      = 3*Tr_F/Q(alpha)
      = 3*(-1)
      = -3,

  and dim_Q(T_Q)=18.
Qed.

Corollary field_direction_quadratic_form:
  If the middle degree-four component of ch2 has the form

    q*Z_prim + s*P_T + A,

  where A is a persistent algebraic degree-four class orthogonal to both
  Z_prim and P_T, then its contribution from the F-direction is

    33*q^2 - 6*q*s + 18*s^2
      = 18*(s-q/6)^2 + (65/2)*q^2.

  Thus adding a persistent scalar identity term can reduce the raw 33*q^2
  contribution only to the positive minimum

    (65/2)*q^2.

  This does not by itself produce a semiregularity contradiction because the
  nonzero-rank terms below can have either sign.
Qed.

Theorem nonzero_rank_introduces_genuine_cancellation_channels:
  For r != 0, the exact Euler pairing contains the additional terms

    2*r*integral ch4,
    -2*integral c1*ch3,
    (r/6)*integral ch2*c2(Y),
    -(1/12)*integral c1^2*c2(Y),
    4*r^2.

  No theorem established in this repository gives a lower bound on their
  total that depends only on the primitive alpha coefficient q.

  In particular, the rank-zero argument

    chi(E,E) >= integral (q*Z_prim)^2

  cannot be reused for a genuinely indecomposable nonzero-rank complex.
Qed.

Corollary RR_alone_does_not_close_nonzero_rank_semiregularity:
  The existing intersection and integrality calculations do not rule out an
  indecomposable nonzero-rank perfect complex whose Chern character contains
  a nonzero primitive alpha component and whose remaining Chern data make

    chi(E,E) <= 46.

  Therefore Riemann--Roch alone is no longer a no-go theorem once genuine
  nonzero-rank Chern data are allowed.
Qed.

Important limitation:
  This file does NOT construct such a perfect complex.
  It does NOT prove its semiregularity map is injective.
  It does NOT prove generic F_13 algebraicity.
  It proves only the exact numerical constraint and identifies the precise
  cancellation terms that a surviving nonzero-rank construction must control.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this frontier:
  either

    (A) an explicit genuinely indecomposable nonzero-rank perfect complex E
        with nonzero primitive alpha component and an injective BF
        semiregularity map,

  or

    (B) a new geometric inequality forcing the nonzero-rank correction terms
        in exact_CY4_self_Euler_pairing to keep chi(E,E)>46 whenever the
        primitive alpha coefficient is nonzero.

  Twist and direct-sum stabilization are already closed by
  order13_semiregularity_twist_stabilization_no_go.v, so (A) must be genuinely
  non-split rather than a formal repair of an obstructed rank-zero package.
