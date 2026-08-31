Standalone closure of the proportional simple rank-zero, c1=0
Buchweitz--Flenner semiregularity route for the primitive order-13 F_13
real-multiplication class.

This file strengthens order13_corrected_alpha_semiregularity_window.v.
It is pseudo-formal mathematical documentation and does not assert generic
algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  L1 := U direct_sum <-4> direct_sum <-4>,
  T := T_L1 = L1^perp in H^2(X,Z),
  F := Q(zeta_13 + zeta_13^(-1)),
  alpha := zeta_13 + zeta_13^(-1).

  Let Z_prim be the primitive-normalized rational degree-four class from
  order13_corrected_alpha_semiregularity_window.v.  Its middle action is

    alpha on T_Q,
    0 on L1_Q,

  and

    integral_Y Z_prim^2 = 33.

Theorem rational_scalar_integral_lift_forces_integer_scalar:
  Let q in Q be nonzero.  Suppose q*Z_prim is integral in

    H^2(X,Z) tensor H^2(X,Z) subset H^4(Y,Z).

  Then q is an integer.

Proof:
  Unimodularity of the K3 lattice identifies an integral middle tensor with
  an integral endomorphism B of H^2(X,Z).  The associated operator satisfies

    B|L1 = 0,
    B|T_Q = q*alpha.

  Hence q*alpha preserves the rank-18 lattice T.  The determinant of an
  integral lattice endomorphism is an integer.  Now

    det_Q(alpha | T_Q)
      = Norm_F/Q(alpha)^3
      = (-1)^3
      = -1,

  because T has F-dimension 3 and the minimal polynomial of alpha has
  constant term -1.  Therefore

    det_Q(q*alpha | T_Q) = -q^18

  is an integer.

  Write q=a/b in lowest terms with b>0.  If q^18 is an integer, then

    b^18 divides a^18.

  Coprimality forces b=1.  Thus q is an integer.
Qed.

Theorem unit_scalar_integral_lift_is_impossible:
  Neither Z_prim nor -Z_prim is integral.

Proof:
  The positive case is primitive_alpha_tensor_is_not_integral from
  order13_corrected_alpha_semiregularity_window.v.

  If -Z_prim were integral, multiplying the integral class by -1 would make
  Z_prim integral, contradiction.
Qed.

Corollary nonzero_integral_proportional_lift_has_abs_scalar_at_least_two:
  If q in Q is nonzero and q*Z_prim is integral, then

    q in Z

  and

    |q| >= 2.

Proof:
  The first statement is rational_scalar_integral_lift_forces_integer_scalar.
  The possibilities q=1 and q=-1 are excluded by
  unit_scalar_integral_lift_is_impossible.
Qed.

ExternalResult CY4RankZeroEulerPairing:
  If E is a perfect complex on the smooth Calabi--Yau fourfold Y with

    ch_0(E)=0,
    ch_1(E)=0,

  then

    chi(E,E) = integral_Y ch_2(E)^2.

ExternalResult BF_target_dimension_on_K3_product:
  The Buchweitz--Flenner semiregularity target

    product_(r>=0) H^(r+2)(Y,Omega_Y^r)

  has complex dimension 44.

Theorem every_simple_rankzero_c1zero_proportional_package_fails_BF_dimension:
  Let E be a simple perfect complex on Y and q in Q nonzero with

    ch_0(E)=0,
    ch_1(E)=0,
    ch_2(E)=q*Z_prim.

  Then

    dim_C Ext^2_Y(E,E) >= 130.

  In particular E is not Buchweitz--Flenner semiregular.

Proof:
  Since ch_1(E)=0,

    ch_2(E) = -c_2(E)

  is integral modulo torsion.  Hence q*Z_prim is integral.  By
  nonzero_integral_proportional_lift_has_abs_scalar_at_least_two,

    |q| >= 2.

  The self-intersection scales quadratically:

    integral_Y (q*Z_prim)^2 = 33*q^2 >= 132.

  Therefore CY4 Riemann--Roch gives

    chi(E,E) >= 132.

  Write e_i=dim Ext^i(E,E).  Triviality of K_Y and simplicity give

    e_4=e_0=1,
    e_3=e_1.

  Thus

    chi(E,E) = 2 - 2*e_1 + e_2,

  so

    e_2 = chi(E,E)-2+2*e_1
        >= 132-2
        = 130.

  Since 130>44, the semiregularity map cannot be injective.
Qed.

Corollary proportional_rankzero_semiregularity_route_is_closed:
  Rational algebraicity cannot be obtained by replacing Z_prim with an
  arbitrary nonzero rational scalar multiple and then realizing that multiple
  as ch_2 of a simple rank-zero, c1=0 perfect complex.

  The obstruction is exhaustive for this package:

    - any integral proportional lift has integer scalar q;
    - q=+/-1 is impossible by K3 discriminant gluing;
    - every remaining |q|>=2 has square at least 132 and therefore
      Ext^2-dimension at least 130, far above the 44-dimensional BF target.
Qed.

Important limitation:
  This does NOT rule out

    - a perfect complex of nonzero rank;
    - a perfect complex with nonzero persistent first Chern class;
    - a Chern character containing additional persistent algebraic degree-four
      terms whose RR cross-terms alter the Euler pairing;
    - a non-simple deformation package;
    - a direct cycle-theoretic or family-level correspondence construction.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this closure:
  a genuinely different deformation package, necessarily leaving the exact
  simple rank-zero/c1=0 proportional class.  For the perfect-complex route,
  the next bounded case is nonzero rank and/or nonzero persistent c1, with
  all RR Todd and cross terms included explicitly rather than inferred from
  the rank-zero formula.