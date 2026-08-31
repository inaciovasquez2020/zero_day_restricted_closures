Standalone semiregularity obstruction for the ideal sheaf of the canonical effective
order-13 graph union.

This file follows order13_rankone_semiregularity_frontier.v and
order13_graph_union_semiregularity_dimension_obstruction.v.  It is
pseudo-formal mathematical documentation and does not assert generic
algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  G_plus  := Graph(sigma),
  G_minus := Graph(sigma^(-1)),
  Z := G_plus union G_minus,
  I_Z := ideal sheaf of Z in Y.

The codimension-two class of Z is

  [Z]_2 = [G_plus] + [G_minus],

so this is the canonical effective rank-one torsion-free candidate carrying
nonzero primitive alpha projection.

Imported facts from order13_graph_union_semiregularity_dimension_obstruction.v:

  chi(O_Z,O_Z) = 70,

  Fix(sigma) consists of one rational curve and nine isolated points,

and there is an exact sequence

  0 -> O_Z
    -> O_(G_plus) direct_sum O_(G_minus)
    -> O_(G_plus intersect G_minus)
    -> 0.

Theorem graph_union_structure_sheaf_holomorphic_euler_is_minus_six:
  chi(O_Z) = -6.

Proof:
  Each graph is isomorphic to the K3 surface X, so

    chi(O_(G_plus)) = chi(O_(G_minus)) = chi(O_X) = 2.

  The scheme-theoretic intersection used in the graph-union exact sequence is
  the fixed locus, one P^1 together with nine reduced points.  Hence

    chi(O_(G_plus intersect G_minus))
      = chi(O_(P^1)) + 9
      = 1 + 9
      = 10.

  Additivity of Euler characteristic gives

    chi(O_Z) = 2 + 2 - 10 = -6.
Qed.

Theorem graph_union_ideal_self_Euler_pairing_is_86:
  chi(I_Z,I_Z) = 86.

Proof:
  In K_0(Y), the ideal-sheaf sequence

    0 -> I_Z -> O_Y -> O_Z -> 0

  gives

    [I_Z] = [O_Y] - [O_Z].

  Bilinearity of the Euler pairing yields

    chi(I_Z,I_Z)
      = chi(O_Y,O_Y)
        - chi(O_Y,O_Z)
        - chi(O_Z,O_Y)
        + chi(O_Z,O_Z).

  Since Y=X x X,

    chi(O_Y,O_Y) = chi(O_Y) = chi(O_X)^2 = 4.

  Also

    chi(O_Y,O_Z) = chi(O_Z) = -6.

  Because Y is a Calabi--Yau fourfold, Serre duality and even complex
  dimension give symmetry of the Euler pairing:

    chi(O_Z,O_Y) = chi(O_Y,O_Z) = -6.

  Finally chi(O_Z,O_Z)=70.  Therefore

    chi(I_Z,I_Z)
      = 4 - (-6) - (-6) + 70
      = 86.
Qed.

Theorem graph_union_ideal_is_simple:
  Hom_Y(I_Z,I_Z) = C.

Proof:
  I_Z is a rank-one torsion-free sheaf on the smooth connected integral
  variety Y.  Any endomorphism is multiplication by a rational function on
  the generic point.  Preservation of I_Z across codimension one forces that
  rational function to be regular on Y.  Since Y is projective and connected,
  H^0(Y,O_Y)=C.
Qed.

Theorem graph_union_ideal_Ext2_has_dimension_at_least_84:
  dim_C Ext^2_Y(I_Z,I_Z) >= 84.

Proof:
  Put e_i := dim Ext^i_Y(I_Z,I_Z).  Triviality of K_Y and simplicity give

    e_0=e_4=1,
    e_3=e_1.

  Hence

    86
      = e_0 - e_1 + e_2 - e_3 + e_4
      = 2 - 2*e_1 + e_2.

  Therefore

    e_2 = 84 + 2*e_1 >= 84.
Qed.

ExternalResult BF_target_dimension_on_K3_product:
  The Buchweitz--Flenner semiregularity target

    product_(q>=0) H^(q+2)(Y,Omega_Y^q)

  has complex dimension 44.

Theorem graph_union_ideal_sheaf_is_not_BF_semiregular:
  The Buchweitz--Flenner semiregularity map for I_Z cannot be injective.

Proof:
  Its source Ext^2 has dimension at least 84, while the entire target has
  dimension 44.  Therefore

    dim ker(sigma_(I_Z)) >= 84 - 44 = 40.

  In particular I_Z is not semiregular.
Qed.

Corollary canonical_effective_rankone_route_is_closed:
  The canonical effective codimension-two cycle

    Graph(sigma) union Graph(sigma^(-1))

  already has the desired nonzero primitive alpha projection, so existence of
  an effective special-fiber representative is not the missing object.

  However its normalized rank-one torsion-free representative I_Z fails
  Buchweitz--Flenner semiregularity by the strict dimension obstruction

    dim Ext^2(I_Z,I_Z) >= 84 > 44.

  Thus replacing O_Z by I_Z does not rescue the graph-union deformation route.
Qed.

Important limitation:
  This does NOT rule out a different effective codimension-two subscheme with
  the same primitive alpha projection but substantially different lower- and
  higher-dimensional scheme structure and hence different ideal-sheaf Euler
  pairing.

  It does NOT rule out a nonreduced thickening, liaison transform, or another
  ideal sheaf whose codimension-two cycle class contains the primitive alpha
  component while its ch3/ch4 data reduce chi(I,I) enough to pass the BF gate.

  It does NOT rule out genuinely derived rank-one or rank >=2 perfect
  complexes.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this no-go:
  a genuinely different effective codimension-two subscheme Z' whose
  primitive cycle projection is nonzero in the alpha direction and whose
  ideal sheaf satisfies chi(I_Z',I_Z') <= 46, followed by an actual
  Buchweitz--Flenner injectivity proof.  If no such ideal sheaf can exist, the
  rank-one coherent-sheaf route closes completely.
