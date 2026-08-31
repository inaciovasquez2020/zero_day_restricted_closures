Standalone Euler-pairing reduction for rank-one ideal-sheaf semiregularity in the
order-13 F_13 real-multiplication problem.

This file follows order13_graph_union_ideal_sheaf_semiregularity_no_go.v.
It proves that the codimension-two cycle class alone can never give a universal
Riemann--Roch obstruction for ideal sheaves on the K3-product Calabi--Yau
fourfold.  It is pseudo-formal mathematical documentation and does not assert
generic algebraicity or semiregularity.

Setup:
  X := X_13,
  Y := X x X,
  K_Y ~= O_Y,
  chi(O_Y)=4.

  Let Z subset Y be any closed subscheme of codimension at least two and put

    I_Z := ideal sheaf of Z,
    C_Z := ch_2(O_Z) = the codimension-two cycle class [Z]_2.

  Since codim(Z)>=2,

    ch_0(O_Z)=ch_1(O_Z)=0.

Theorem structure_sheaf_self_Euler_depends_only_on_codimtwo_cycle:
  chi(O_Z,O_Z) = integral_Y C_Z^2.

Proof:
  Hirzebruch--Riemann--Roch gives

    chi(O_Z,O_Z)
      = integral_Y ch(O_Z^dual) ch(O_Z) td(Y).

  The first nonzero Chern-character component is codimension two.  In complex
  dimension four, total codimension four can therefore only come from

    ch_2(O_Z) * ch_2(O_Z).

  All terms involving ch_3, ch_4, or positive-degree Todd components are too
  large because ch_0=ch_1=0.  Hence the claimed identity.
Qed.

Theorem universal_ideal_sheaf_Euler_formula:
  chi(I_Z,I_Z)
    = 4 + integral_Y C_Z^2 - 2*chi(O_Z).

Proof:
  In K_0(Y),

    [I_Z] = [O_Y] - [O_Z].

  Bilinearity gives

    chi(I_Z,I_Z)
      = chi(O_Y,O_Y)
        - chi(O_Y,O_Z)
        - chi(O_Z,O_Y)
        + chi(O_Z,O_Z).

  Here

    chi(O_Y,O_Y)=chi(O_Y)=4,
    chi(O_Y,O_Z)=chi(O_Z).

  Since dim_C(Y)=4 is even and K_Y is trivial, Serre duality makes the Euler
  pairing symmetric, so

    chi(O_Z,O_Y)=chi(O_Y,O_Z)=chi(O_Z).

  Substitute structure_sheaf_self_Euler_depends_only_on_codimtwo_cycle.
Qed.

Corollary simple_semiregular_ideal_requires_large_holomorphic_Euler:
  If I_Z is simple and Buchweitz--Flenner semiregular, then

    chi(O_Z) >= ( integral_Y C_Z^2 - 42 ) / 2.

Proof:
  Every simple semiregular perfect complex on Y satisfies

    chi(E,E) <= 46

  by the 44-dimensional BF target and CY4 Serre duality.  Combine with
  universal_ideal_sheaf_Euler_formula.
Qed.

Theorem lower_dimensional_scheme_data_can_cross_RR_gate:
  Fix the codimension-two cycle class C_Z.  The quantity chi(I_Z,I_Z) is not
  bounded below by C_Z alone.

Proof:
  Let P_N be any zero-dimensional subscheme of length N disjoint from Z, and
  set

    Z_N := Z disjoint_union P_N.

  Then

    C_(Z_N)=C_Z

  because zero-dimensional components do not contribute to ch_2, while

    chi(O_(Z_N)) = chi(O_Z) + N.

  Hence

    chi(I_(Z_N),I_(Z_N))
      = chi(I_Z,I_Z) - 2*N.

  As N grows this is arbitrarily small while the codimension-two cycle, and
  therefore its primitive F_13 projection, is unchanged.
Qed.

Corollary graph_union_plus_twenty_points_crosses_numerical_gate:
  Let

    G := Graph(sigma) union Graph(sigma^(-1)).

  Earlier files prove

    integral_Y [G]_2^2 = 70,
    chi(O_G) = -6,
    chi(I_G,I_G) = 86.

  Choose twenty reduced points P_20 disjoint from G and set

    G_20 := G disjoint_union P_20.

  Then

    [G_20]_2 = [G]_2,
    chi(O_(G_20)) = -6 + 20 = 14,

  and therefore

    chi(I_(G_20),I_(G_20))
      = 4 + 70 - 2*14
      = 46.

  Thus the exact primitive alpha direction carried by the graph cycle can
  pass the necessary simple-semiregularity Euler bound after adding only
  zero-dimensional scheme data.
Qed.

Corollary RR_only_rankone_ideal_no_go_is_closed_negatively:
  No argument depending only on

    rank(I_Z)=1,
    c1(I_Z)=0,
    and the codimension-two primitive alpha cycle class

  can force chi(I_Z,I_Z)>46 for every ideal sheaf representative.

  Lower-dimensional scheme data alter chi(O_Z), equivalently the top Chern
  data of I_Z, without changing the primitive codimension-two class.
Qed.

Important limitation:
  Crossing the Euler gate does NOT prove Buchweitz--Flenner semiregularity.
  In particular this file does not prove that adjoining disjoint points kills
  the previously exhibited semiregularity kernel of the graph-union ideal.

  It does not construct a generic algebraic alpha correspondence.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this reduction:
  determine whether the nonzero Buchweitz--Flenner kernel for I_G survives
  under passage to

    I_(G disjoint_union P_N).

  If the graph-union obstruction injects/retracts into the obstruction theory
  after adjoining disjoint points, then point-adjunction cannot repair
  semiregularity despite improving the Euler number.  If it does not persist,
  the N=20 numerical threshold gives the first concrete rank-one candidate
  family requiring an actual semiregularity-map calculation.
