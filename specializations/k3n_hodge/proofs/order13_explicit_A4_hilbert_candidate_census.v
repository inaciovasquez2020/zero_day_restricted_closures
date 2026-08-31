Standalone finite literature census for the nonreduced zero-dimensional decoration
branch in the order-13 F_13 semiregularity problem.

This file follows order13_nonreduced_point_tangent_threshold.v.  It tests known
explicit families/components of Hilb^N(A^4) against the exact necessary gate

  t(Q) := dim_C Hom(I_Q,O_Q) <= N - 20.

It is deliberately only a finite/parametric literature census.  It does NOT
assert a universal lower bound for arbitrary finite schemes Q in A^4 and does
NOT assert generic F_13 algebraicity.

Setup:
  Q subset A^4 is zero-dimensional of length N,
  t(Q) := dim_C Hom(I_Q,O_Q).

Imported order-13 gate:
  If the decorated graph-union ideal

    I_(G disjoint_union Q)

  is Buchweitz--Flenner semiregular, then necessarily

    t(Q) <= N - 20.

Source family A -- Satriano--Staal small elementary components:
  Matthew Satriano and Andrew P. Staal,
  Small elementary components of Hilbert schemes of points,
  Forum of Mathematics, Sigma 11 (2023), e45.

  For their explicit A^4 family with integers a,b>=2, put

    N = a*b*(a+b)/2,

    m = min(a,b),
    M = max(a,b),

    D = m^3/3 + m*M^2 + m^2 + 2*m*M + M^2 - m/3 - 1.

  Their displayed ideals are smooth points on unique elementary components of
  dimension D, hence t(Q)=D there.

Theorem Satriano_Staal_family_fails_order13_gate:
  For every a,b>=2 in this family,

    D > N > N - 20.

Proof:
  This inequality was already established in
  order13_nonreduced_point_tangent_threshold.v by writing M=m+k and checking
  that 6*(D-N)>0 for m>=2, k>=0.
Qed.

Remark:
  Their additional explicit A^4 examples, including the degree-24 and
  degree-25 secondary elementary components and the degree-60 and degree-1000
  examples in the compendium, likewise have displayed tangent/component
  dimensions far above N-20.  They provide no order-13 candidate.

Source family B -- Jelisiejew generically smooth elementary A^4 family:
  Joachim Jelisiejew,
  Elementary components of Hilbert schemes of points,
  Journal of the London Mathematical Society 100 (2019), 249-272.

  For e>2, his family has

    N_e = binom(e+1,2)^2 - 1,

    D_e = e^4 + 2*e^3 - 4*e + 1,

  and the displayed point is smooth on its elementary component, so
  t(Q_e)=D_e.

Theorem Jelisiejew_infinite_family_fails_order13_gate:
  For every integer e>2,

    D_e > N_e > N_e - 20.

Proof:
  Direct subtraction gives

    D_e - N_e
      = (e-1)*(3*e^3 + 9*e^2 + 8*e - 8)/4,

  which is positive for e>2.
Qed.

Corollary Jelisiejew_degree56_example_fails_order13_gate:
  Jelisiejew also records an explicit degree-56 A^4 example with graded tangent
  Hilbert series

    4*T^(-1) + 98 + 84*T + 32*T^2.

  Hence

    t(Q)=218 > 36 = 56-20.
Qed.

Source family C -- Jelisiejew generically nonreduced A^4 components:
  Joachim Jelisiejew,
  Generically nonreduced components of Hilbert schemes on fourfolds,
  Rendiconti del Seminario Matematico, Universita e Politecnico di Torino
  82 (2024), 171-184.

  The base components have Hilbert functions

    (1,4,10,s),  s in {6,7,8,9},

  hence lengths N in {21,22,23,24}.  They are elementary and generically
  nonreduced.  Translation by A^4 gives the reduced component dimension at
  least four, while generic nonreducedness makes the Zariski tangent dimension
  strictly larger than the reduced component dimension.

Theorem Jelisiejew_nonreduced_base_components_fail_order13_gate:
  For N in {21,22,23,24}, every generic point of the above component satisfies

    t(Q) > 4 >= N-20,

  with strict inequality over the threshold also at N=24 because t(Q)>4.
Qed.

Corollary Jelisiejew_reduced_point_extensions_fail_order13_gate:
  The same paper obtains generically nonreduced components for every N>=21 by
  adjoining N-21 reduced points to a length-21 base example.

  The moving reduced points contribute 4*(N-21) parameters and the base
  elementary component contributes at least four translation parameters, so
  the reduced component dimension is at least

    4*(N-21)+4 = 4*N-80.

  For N>=21,

    4*N-80 > N-20.

  Generic nonreducedness only increases the tangent dimension beyond the
  reduced component dimension.  Therefore this entire extension family also
  fails the order-13 gate.
Qed.

Source family D -- Giovenzana--Giovenzana--Graffeo--Lella A^4 census:
  Franco Giovenzana, Luca Giovenzana, Michele Graffeo, Paolo Lella,
  New components of Hilbert schemes of points and 2-step ideals,
  arXiv:2507.02789 (2025), Section 6 and Figures 9-10.

ExternalResult DeltaMeaningForTwoStepStrata:
  In that paper, for a one-step nesting in A^4, the sign of Delta_(4,1,k)
  measures whether the relevant Hilbert stratum has dimension at least the
  smoothable-component dimension 4*N.  A TNT point on a generically reduced
  elementary component is smooth at the general point, so its Hilbert tangent
  dimension equals the component dimension.

Theorem order2_new_components_fail_order13_gate:
  Figure 9 gives the new order-two A^4 components at

    N=18,  t-graded dimensions (4,51,10),
    N=20,  t-graded dimensions (4,69,6).

  Thus their total tangent dimensions are respectively 65 and 79, while the
  order-13 thresholds are -2 and 0.  Neither is a candidate.
Qed.

Theorem order3_tabulated_components_fail_order13_gate:
  Figure 10 lists the order-three A^4 components covered by the construction,
  at lengths between 29 and 45.  In every listed row the degree-zero tangent
  component alone has dimension at least 68.

  Since

    N-20 <= 25

  throughout this table, every listed order-three component satisfies

    t(Q) >= 68 > N-20.
Qed.

Theorem all_95_order4_TNT_strata_fail_order13_gate:
  The 2025 paper reports 95 Hilbert strata of order-four 2-step ideals in A^4
  whose generic ideal has trivial negative tangents, and explicitly states
  that NONE of the 95 is Delta-negative.

  Therefore Delta_(4,1,4)>=0 for all 95.  By DeltaMeaningForTwoStepStrata,
  each corresponding generically reduced elementary component has

    t(Q) = dim(component) >= 4*N.

  For every positive N,

    4*N > N-20.

  Hence none of these 95 newest explicit order-four components can satisfy the
  order-13 semiregularity threshold.
Qed.

Corollary finite_explicit_A4_census_has_no_order13_candidate:
  None of the explicit/parametric A^4 families tested above supplies a finite
  scheme Q satisfying

    dim Hom(I_Q,O_Q) <= length(Q)-20.

  In particular, no candidate is supplied by

    - the Satriano--Staal small-component family,
    - the Jelisiejew 2019 generically smooth infinite family,
    - the explicit Jelisiejew degree-56 example,
    - the Jelisiejew 2024 generically nonreduced length >=21 family,
    - the GGGL order-two and order-three A^4 tables,
    - any of the 95 GGGL order-four TNT strata.
Qed.

Important limitation:
  This is NOT a classification of Hilb^N(A^4).
  It does NOT prove

    dim Hom(I_Q,O_Q) > length(Q)-20

  for every finite Q in a smooth fourfold.

  The 2025 paper itself emphasizes that its listed components are only a sample
  of those detectable by its method, and arbitrary nonreduced finite schemes
  outside these explicit families remain untested.

  Therefore no universal Hilbert tangent theorem is claimed and generic
  algebraicity of the primitive F_13 generator alpha remains open.

Boundary:
  The explicit literature candidate search has produced no Q meeting the
  necessary tangent threshold.

First missing object after the finite census:
  either

    (A) a universal theorem for finite schemes in smooth fourfolds proving

          dim Hom(I_Q,O_Q) > length(Q)-20,

        or

    (B) a new concrete finite scheme Q outside the censused families with

          dim Hom(I_Q,O_Q) <= length(Q)-20,

        followed by an actual Buchweitz--Flenner semiregularity-map
        computation for I_(G disjoint_union Q).
