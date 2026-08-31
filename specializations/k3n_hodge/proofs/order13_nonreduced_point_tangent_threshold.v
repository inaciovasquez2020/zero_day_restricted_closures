Standalone tangent-threshold reduction for nonreduced zero-dimensional decorations in
the order-13 F_13 rank-one ideal-sheaf semiregularity route.

This file follows order13_graph_union_point_adjunction_ext_no_go.v.  The
reduced-point case is closed there because N distinct reduced points contribute
4N Hilbert tangent directions.  The present file isolates the exact condition
for an arbitrary zero-dimensional decoration Q, and records why one may not
replace the reduced-point 4N bound by a universal theorem for Hilb^N(A^4).

This is pseudo-formal mathematical documentation.  It does not assert generic
algebraicity.

Setup:
  X := X_13,
  Y := X x X,
  G := Graph(sigma) union Graph(sigma^(-1)),
  Q subset Y a zero-dimensional subscheme of length N disjoint from G,
  W := G disjoint_union Q,
  I_W := ideal sheaf of W.

  Put

    t(Q) := dim_C Hom_Y(I_Q,O_Q),

  the Zariski tangent-space dimension of Hilb^N(Y) at [Q].

Imported facts:
  chi(I_W,I_W) = 86 - 2*N,
  I_W is simple,
  K_Y ~= O_Y,
  the Buchweitz--Flenner target has dimension 44.

Theorem Q_tangent_injects_into_decorated_Ext1:
  There is an injection

    Hom_Y(I_Q,O_Q) -> Ext^1_Y(I_W,I_W).

Proof:
  As in order13_graph_union_point_adjunction_ext_no_go.v, applying
  Hom(I_W,-) to

    0 -> I_W -> O_Y -> O_W -> 0

  gives an injection

    Hom(I_W,O_W) -> Ext^1(I_W,I_W).

  Since W=G disjoint_union Q, restriction to the disjoint component Q splits
  Hom(I_Q,O_Q) as a direct summand of Hom(I_W,O_W).
Qed.

Corollary decorated_Ext1_lower_bound:
  If

    e_1(W) := dim Ext^1_Y(I_W,I_W),

  then

    e_1(W) >= t(Q).
Qed.

Theorem exact_nonreduced_point_semiregularity_threshold:
  If I_W is Buchweitz--Flenner semiregular, then

    t(Q) <= N - 20.

Proof:
  Simplicity and CY4 Serre duality give

    chi(I_W,I_W) = 2 - 2*e_1(W) + e_2(W).

  Since chi(I_W,I_W)=86-2N,

    e_2(W) = 84 - 2*N + 2*e_1(W)
           >= 84 - 2*N + 2*t(Q).

  Semiregularity requires e_2(W)<=44 because the entire BF target has
  dimension 44.  Therefore

    84 - 2*N + 2*t(Q) <= 44,

  hence

    t(Q) <= N - 20.
Qed.

Corollary every_N_less_than_20_is_impossible:
  If N<20, no zero-dimensional decoration Q of length N can repair
  semiregularity, regardless of its scheme structure.

Proof:
  t(Q)>=0 but the threshold requires t(Q)<=N-20<0.
Qed.

Corollary reduced_points_fail_far_above_threshold:
  If Q is N distinct reduced points, then t(Q)=4N, so

    4N > N-20

  for every N>0.  This recovers the reduced-point no-go.
Qed.

ExternalResult SmallElementaryComponentsA4:
  There exist elementary irreducible components of Hilb^N(A^4) whose
  dimension is strictly less than 4N.  In particular, the reduced-point
  tangent lower bound 4N is not a universal lower bound for arbitrary
  nonreduced points.

  Source:
    Matthew Satriano and Andrew P. Staal,
    Small elementary components of Hilbert schemes of points,
    Forum of Mathematics, Sigma 11 (2023), e45.

  Their explicit family has

    N = (1/2)*a*b*(a+b),

    D = (1/3)*m^3 + m*M^2 + m^2 + 2*m*M + M^2 - (1/3)*m - 1,

  where m=min(a,b), M=max(a,b), a,b>=2, and the displayed points are smooth
  points of their unique elementary components.  Hence their Hilbert tangent
  dimension equals D.

Theorem Satriano_Staal_small_components_do_not_meet_order13_threshold:
  For the explicit Satriano--Staal family above,

    D > N,

  and therefore certainly

    D > N - 20.

Proof:
  Write M=m+k with m>=2 and k>=0.  Direct subtraction gives

    6*(D-N)
      = 3*k^2*m + 6*k^2
        + 3*k*m^2 + 24*k*m
        + 2*m^3 + 24*m^2 - 2*m - 6.

  Every term except the final -2m-6 is nonnegative, and for m>=2

    2*m^3 + 24*m^2 - 2*m - 6 > 0.

  Thus D-N>0.
Qed.

Corollary known_small_A4_components_do_not_supply_the_needed_decoration:
  The explicit small elementary Hilbert components from Satriano--Staal do
  not approach the much stronger order-13 requirement

    t(Q) <= N-20.

  Their smooth points satisfy t(Q)=D>N.
Qed.

Important limitation:
  The literature contains nonreduced elementary components of Hilbert schemes
  of points in A^4 with tangent/component dimensions below the main-component
  value 4N.  Therefore this repository must NOT claim a universal lower bound

    t(Q) >= 4N

  for arbitrary nonreduced Q.

  This file also does NOT prove a universal lower bound t(Q)>N-20.  Such a
  theorem would be sufficient to close every disjoint zero-dimensional repair,
  but it is not established here.

Boundary:
  generic algebraicity of the primitive F_13 generator alpha remains open.

First missing object after this reduction:
  either

    (A) prove, for every finite Q embedded in a smooth complex fourfold,

          dim Hom(I_Q,O_Q) > length(Q)-20,

        which would close all disjoint zero-dimensional decorations; or

    (B) exhibit a concrete Q with

          t(Q) <= length(Q)-20,

        and then compute the full Buchweitz--Flenner map for
        I_(G disjoint_union Q).

  The weaker claim t(Q)>=4*length(Q) is false as a universal strategy and is
  retired outside the reduced-point locus.
