Standalone Ext-dimension obstruction for adjoining disjoint reduced points to the
canonical effective order-13 graph-union ideal sheaf.

This file follows order13_ideal_sheaf_euler_escape.v.  That file showed that
adding N disjoint reduced points lowers the Euler pairing of the ideal sheaf by
2N without changing the codimension-two primitive alpha class, so Riemann--
Roch alone reaches the necessary semiregularity gate at N=20.  The present
file restores the full Ext calculation and shows that the new point-motion
Ext^1 directions force Ext^2 to grow instead of shrink.

This is pseudo-formal mathematical documentation.  It does not assert generic
algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  G := Graph(sigma) union Graph(sigma^(-1)),
  P_N := {p_1,...,p_N} a set of N distinct reduced points disjoint from G,
  G_N := G disjoint_union P_N,
  I_N := I_(G_N).

Imported facts:
  chi(I_G,I_G) = 86,
  chi(I_N,I_N) = 86 - 2*N,
  I_N is rank-one torsion-free and simple,
  K_Y ~= O_Y,
  the Buchweitz--Flenner target on Y has dimension 44.

Theorem hilbert_tangent_injects_into_ideal_Ext1:
  Let W subset Y be any codimension-at-least-two subscheme with ideal I_W.
  Then there is a natural injection

    Hom_Y(I_W,O_W) -> Ext^1_Y(I_W,I_W).

Proof:
  Apply Hom_Y(I_W,-) to

    0 -> I_W -> O_Y -> O_W -> 0.

  The beginning of the long exact sequence is

    Hom(I_W,I_W)
      -> Hom(I_W,O_Y)
      -> Hom(I_W,O_W)
      -> Ext^1(I_W,I_W).

  Since Y is smooth connected and I_W is rank-one torsion-free with
  codim(Y\W)=0, both

    Hom(I_W,I_W) = C,
    Hom(I_W,O_Y) = C,

  and the first arrow sends the identity to the inclusion I_W -> O_Y, hence
  is an isomorphism.  Exactness therefore makes the connecting map

    Hom(I_W,O_W) -> Ext^1(I_W,I_W)

  injective.
Qed.

Theorem each_disjoint_reduced_point_contributes_four_Ext1_directions:
  For G_N=G disjoint_union P_N,

    dim_C Hom_Y(I_N,O_(G_N)) >= 4*N.

Proof:
  Because the points are disjoint from G, restriction to the zero-dimensional
  component splits off

    direct_sum_i Hom_{O_{Y,p_i}}(m_{p_i},k(p_i))

  as a direct summand of Hom_Y(I_N,O_(G_N)).

  At a smooth point p_i of the complex fourfold Y,

    Hom(m_{p_i},k(p_i)) ~= (m_{p_i}/m_{p_i}^2)^*,

  whose dimension is dim_C T_{p_i}Y = 4.

  Summing over N reduced points gives the lower bound 4N.
Qed.

Corollary point_adjunction_Ext1_lower_bound:
  Put

    e_1(N) := dim Ext^1_Y(I_N,I_N).

  Then

    e_1(N) >= 4*N.

Proof:
  Combine hilbert_tangent_injects_into_ideal_Ext1 with
  each_disjoint_reduced_point_contributes_four_Ext1_directions.
Qed.

Theorem exact_CY4_relation_for_I_N:
  Put

    e_i(N) := dim Ext^i_Y(I_N,I_N).

  Since I_N is simple and K_Y is trivial,

    e_0(N)=e_4(N)=1,
    e_3(N)=e_1(N).

  Therefore

    chi(I_N,I_N)
      = 2 - 2*e_1(N) + e_2(N).

  Using chi(I_N,I_N)=86-2N gives

    e_2(N)
      = 84 - 2*N + 2*e_1(N).
Qed.

Corollary point_adjunction_Ext2_grows:
  For every N>=0,

    e_2(N) >= 84 + 6*N.

Proof:
  Substitute e_1(N)>=4N into

    e_2(N)=84-2N+2e_1(N).
Qed.

Corollary twenty_point_Euler_escape_fails_semiregularity:
  For N=20,

    chi(I_20,I_20)=46,

  but

    dim Ext^2_Y(I_20,I_20) >= 84 + 6*20 = 204.

  Since the entire Buchweitz--Flenner target has dimension 44,

    dim ker(sigma_(I_20)) >= 204 - 44 = 160.

  Hence I_20 is not Buchweitz--Flenner semiregular.
Qed.

Theorem all_reduced_point_adjunctions_fail_semiregularity:
  For every N>=0,

    dim Ext^2_Y(I_N,I_N) >= 84 > 44.

  Therefore no ideal sheaf obtained from the canonical graph union by
  adjoining any finite number of disjoint reduced points can be
  Buchweitz--Flenner semiregular.
Qed.

Corollary RR_escape_was_only_numerical:
  The decrease

    chi(I_N,I_N)=86-2N

  does not represent a decrease in the obstruction-space dimension.  The same
  point components which lower the Euler pairing introduce at least 4N new
  first-order deformations, and CY4 Serre duality forces the Ext^2 dimension
  to satisfy

    dim Ext^2(I_N,I_N) >= 84+6N.

  Thus the point-adjunction mechanism cannot repair semiregularity.
Qed.

Important limitation:
  This closes only disjoint REDUCED point adjunctions to the canonical graph
  union.  It does not rule out embedded or nonreduced zero-dimensional
  structure whose local tangent contribution behaves differently, nor a
  genuinely different codimension-two effective representative, nor a
  derived rank-one or rank>=2 perfect complex.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this no-go:
  test nonreduced/embedded zero-dimensional decorations or prove a local
  inequality showing that any zero-dimensional modification large enough to
  lower chi(I,I) necessarily contributes enough Ext^1 to keep

    dim Ext^2(I,I) > 44.

  If such a general local inequality is proved, the zero-dimensional repair
  branch of rank-one ideal sheaves closes completely.
