Standalone dimension obstruction to semiregularity of the single graph-union sheaf in the order-13 F_13 real-multiplication transport problem.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let X := X_13 be Kondo's projective K3 surface with purely non-symplectic
  automorphism sigma of order 13.

  Put

    Y := X x X,
    G_plus  := Graph(sigma),
    G_minus := Graph(sigma^(-1)),
    Z := G_plus union G_minus,
    E := O_Z.

  The codimension-two cycle of Z is

    [Z]_2 = [G_plus] + [G_minus],

  and therefore E has the same degree-four / codimension-two Chern character
  as the algebraic alpha_13 correspondence supplied by the two graph classes.

  This makes O_Z the canonical single-sheaf alternative to

    O_(G_plus) direct_sum O_(G_minus),

  whose cross-Ext semiregularity failure was established in
  order13_semiregularity_cross_ext_obstruction.v.

ExternalResult BuchweitzFlennerSemiregularity:
  For a perfect complex E on a smooth complex variety Y, Buchweitz--Flenner
  define the semiregularity map

    sigma_E : Ext^2_Y(E,E)
              -> product_{q>=0} H^(q+2)(Y, Omega_Y^q).

  Injectivity is the semiregularity condition used to annihilate deformation
  obstructions when the Chern character remains of Hodge type.

Source:
  Ragnar-Olaf Buchweitz, Hubert Flenner,
  A Semiregularity Map for Modules and Applications to Deformations,
  Compositio Mathematica 137 (2003), 135-210.

Theorem graph_union_ch2_is_graph_sum:
  ch_2(O_Z) = [G_plus] + [G_minus].

Proof:
  There is an exact sequence

    0 -> O_Z
      -> O_(G_plus) direct_sum O_(G_minus)
      -> O_(G_plus intersect G_minus)
      -> 0.

  The intersection is Fix(sigma), consisting of one curve and nine points,
  hence has codimension at least three in Y. Therefore its structure sheaf
  has vanishing ch_2. Each graph is a codimension-two smooth subvariety, so
  the degree-four component of its structure-sheaf Chern character is its
  fundamental class. Taking ch_2 in the exact sequence gives the claim.
Qed.

Theorem graph_self_intersection_is_24:
  [G_plus]^2 = [G_minus]^2 = 24.

Proof:
  Each graph is isomorphic to X and its normal bundle in X x X is naturally
  isomorphic to T_X. Hence its self-intersection is

    integral_X c_2(T_X).

  For a K3 surface,

    integral_X c_2(T_X) = chi_top(X) = 24.
Qed.

ExternalResult Order13CohomologyTrace:
  For the order-13 K3 surface, the invariant lattice of sigma on H^2 has rank
  10 and the orthogonal complement has rank 12 and carries one copy of the
  primitive Q(zeta_13)-representation.

  Consequently, for every nontrivial power sigma^k,

    Tr(sigma^k | H^2(X,Q)) = 10 + (-1) = 9.

Sources:
  Michela Artebani, Alessandra Sarti, Shingo Taki,
  K3 surfaces with non-symplectic automorphisms of prime order,
  Table 5 / Theorem 8.4.

Theorem graph_cross_intersection_is_11:
  [G_plus] . [G_minus] = 11.

Proof:
  The intersection number of Graph(f) and Graph(g) equals the topological
  Lefschetz number of g^(-1) o f.

  Here

    g^(-1) o f = sigma^2.

  Since H^1(X)=H^3(X)=0 and sigma acts trivially on H^0 and H^4,

    L(sigma^2)
      = 1 + Tr(sigma^2 | H^2(X,Q)) + 1
      = 1 + 9 + 1
      = 11.

  This also agrees with the Euler characteristic of Fix(sigma): one rational
  curve contributes 2 and nine isolated points contribute 9.
Qed.

Theorem graph_union_self_Euler_pairing_is_70:
  chi(E,E) = 70.

Proof:
  Y is a smooth fourfold and E=O_Z has rank zero and ch_1(E)=0.
  By Grothendieck--Riemann--Roch,

    chi(E,E)
      = integral_Y ch(E^dual) ch(E) td(Y).

  The smallest nonzero Chern-character component of E is ch_2(E), of
  cohomological degree four. Therefore, in total degree eight, the only
  contribution to the integral is

    ch_2(E)^2.

  Higher ch_i terms have too large total degree, and the positive-degree
  Todd terms likewise cannot contribute because there is no rank or ch_1
  term available to pair with them.

  Thus

    chi(E,E)
      = ([G_plus]+[G_minus])^2
      = [G_plus]^2 + [G_minus]^2
        + 2 [G_plus].[G_minus]
      = 24 + 24 + 2*11
      = 70.
Qed.

Theorem graph_union_Ext2_has_dimension_at_least_68:
  dim_C Ext^2_Y(E,E) >= 68.

Proof:
  The fourfold Y=X x X has trivial canonical bundle. By Serre duality,

    Ext^4_Y(E,E) ~= Ext^0_Y(E,E)^*,
    Ext^3_Y(E,E) ~= Ext^1_Y(E,E)^*.

  The graph union Z is connected because its two irreducible graph components
  meet along Fix(sigma), so

    Hom_Y(O_Z,O_Z) = H^0(Z,O_Z) = C.

  Hence

    dim Ext^0 = dim Ext^4 = 1,
    dim Ext^3 = dim Ext^1.

  Writing e_i := dim Ext^i_Y(E,E), the Euler characteristic identity gives

    70
      = e_0 - e_1 + e_2 - e_3 + e_4
      = 2 - 2 e_1 + e_2.

  Therefore

    e_2 = 68 + 2 e_1 >= 68.
Qed.

Theorem BF_target_dimension_on_K3_product_is_44:
  The Buchweitz--Flenner target

    product_{q>=0} H^(q+2)(Y,Omega_Y^q)

  has complex dimension 44.

Proof:
  Since dim_C Y=4, only q=0,1,2 can contribute:

    q=0: H^2(Y,O_Y)       ~= H^(0,2)(Y), dimension 2;
    q=1: H^3(Y,Omega_Y^1) ~= H^(1,3)(Y), dimension 40;
    q=2: H^4(Y,Omega_Y^2) ~= H^(2,4)(Y), dimension 2.

  The q>=3 terms have cohomological degree q+2>4 and vanish.

  The dimensions follow from the K3 Hodge diamond and Kunneth:

    h^(0,2)(X x X)=2,

    h^(1,3)(X x X)
      = h^(1,1)(X) h^(0,2)(X)
        + h^(0,2)(X) h^(1,1)(X)
      = 20 + 20
      = 40,

    h^(2,4)(X x X)
      = h^(0,2)(X) h^(2,2)(X)
        + h^(2,2)(X) h^(0,2)(X)
      = 1 + 1
      = 2.

  Total dimension = 2+40+2=44.
Qed.

Theorem graph_union_sheaf_is_not_BF_semiregular:
  The Buchweitz--Flenner semiregularity map for E=O_Z cannot be injective.

Proof:
  Its source has dimension at least 68 by
  graph_union_Ext2_has_dimension_at_least_68, while its entire target has
  dimension 44 by BF_target_dimension_on_K3_product_is_44.

  Therefore

    dim ker(sigma_E) >= 68-44 = 24.

  In particular E is not semiregular.
Qed.

Corollary canonical_elementary_transform_route_is_closed:
  Replacing the split graph sheaf

    O_(G_plus) direct_sum O_(G_minus)

  by the single graph-union sheaf O_Z does not repair the semiregularity
  obstruction, even though O_Z couples the two branches at every component of
  their fixed-locus intersection and has the same ch_2 graph-sum class.

  The failure is numerical and global:

    dim Ext^2(O_Z,O_Z) >= 68 > 44 = dim(BF target).

  Thus no refinement of the local cross-Ext calculation is needed to rule out
  this canonical elementary-transform representative.
Qed.

First missing object after this no-go:
  Any further semiregularity attempt must use a genuinely different perfect
  complex with the same ch_2 alpha_13 class but a substantially smaller
  Ext^2 deformation space. Merely passing between

    the split graph sum,
    a two-step extension of the graph sheaves,
    or the reduced graph union

  does not provide the needed semiregular representative.

Boundary:
  this file does NOT prove that no perfect complex with ch_2 equal to the
    alpha_13 graph-sum class can be semiregular
  it proves that the canonical single-sheaf union representative cannot be
    semiregular by a strict source/target dimension obstruction
  it does NOT assume variational Hodge or invariant-cycle conjectures
  it does NOT close generic F_13 algebraicity
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
  no ZeroDayClosure semantics are used
  no required-class index is used
