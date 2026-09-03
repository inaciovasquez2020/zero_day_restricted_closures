Standalone second-syzygy obstruction for the H01-C5 branch in the homogeneous
q=4, height-two multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_linear_syzygy_reduction.v

  and retain the nonminimal H01-C5 state

    m>=3,
    sigma=5,
    tau_3=1,

where Q is generated minimally by four independent quadrics in
S=C[x1,x2,x3,x4], B=S/Q, and sigma is the number of independent linear first
syzygies among those quadrics.

The preceding file reduces H01-C5 to a four-by-five linear syzygy matrix but does
not yet constrain relations among its five columns.  This file performs exactly
one bounded step: Macaulay growth in degree four forces at least three linear
second syzygies among those five linear first syzygies.

No coefficient-matrix classification is made here.
No exclusion of H01-C5 is claimed.
No H01-C4 or tangent argument is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. BETTI NOTATION THROUGH DEGREE FOUR
--------------------------------------------------------------------------

Let the beginning of the minimal graded free resolution of B=S/Q be

  ... -> F_3 -> F_2 -> F_1 -> S -> B -> 0,

with

  F_1 = S(-2)^4.

In H01-C5 the preceding file proves that Q has exactly five independent linear
first syzygies, so write

  F_2 = S(-3)^5 direct_sum S(-4)^a direct_sum (summands shifted >=5),

where

  a := beta_{2,4}(B) >= 0

counts minimal first syzygies of total degree four.

Write

  F_3 = S(-4)^c direct_sum (summands shifted >=5),

where

  c := beta_{3,4}(B) >= 0

counts linear second syzygies among the five degree-three first syzygies.

Because every later shift is at least five, only the displayed summands can
contribute to the degree-four Hilbert function.

--------------------------------------------------------------------------
2. EXACT DEGREE-FOUR HILBERT VALUE FROM THE RESOLUTION
--------------------------------------------------------------------------

Theorem H01_C5_degree_four_Betti_identity:
  One has

    dim_C B_4 = 15 + a - c.

Proof:
  In four variables,

    dim_C S_4 = 35,
    dim_C S_2 = 10,
    dim_C S_1 = 4,
    dim_C S_0 = 1.

  Taking degree four in the alternating Hilbert-series contribution of the
  minimal free resolution gives

    dim B_4
      = dim S_4
        - 4*dim S_2
        + 5*dim S_1
        + a*dim S_0
        - c*dim S_0.

  Therefore

    dim B_4
      = 35 - 40 + 20 + a - c
      = 15 + a - c.
Qed.

--------------------------------------------------------------------------
3. MACAULAY GROWTH FROM B_3=9
--------------------------------------------------------------------------

The H01-C5 state has

  sigma=5.

The preceding cubic-syzygy file proves

  dim_C B_3 = 4 + sigma = 9.

The standard Macaulay growth theorem for the standard graded algebra B gives

  dim B_4 <= 9^{<3>}.

The third Macaulay expansion is

  9 = binom(4,3) + binom(3,2) + binom(2,1),

so

  9^{<3>}
    = binom(5,4) + binom(4,3) + binom(3,2)
    = 5 + 4 + 3
    = 12.

Hence

  dim_C B_4 <= 12.

--------------------------------------------------------------------------
4. THREE LINEAR SECOND SYZYGIES ARE FORCED
--------------------------------------------------------------------------

Combine the exact Betti identity

  dim B_4 = 15 + a - c

with the Macaulay bound

  dim B_4 <= 12.

Then

  15 + a - c <= 12,

so

  c >= a + 3.

Since a>=0:

Theorem q4_H01_C5_forces_three_linear_second_syzygies:
  In H01-C5 one has

    beta_{3,4}(B) >= 3.

More sharply,

    beta_{3,4}(B) >= beta_{2,4}(B) + 3.
Qed.

Interpretation:
  Let M be a 4-by-5 matrix whose columns are a basis of the five linear first
  syzygies among the four quadratic generators of Q.  Then the module of linear
  relations among those columns has dimension at least three.

  Thus any realizable H01-C5 coefficient matrix must support at least three
  independent linear second-syzygy columns.

--------------------------------------------------------------------------
5. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_beta34_at_least_three.
  q4_height2_multiplicity_one_depth_one_H01_C5_beta34_at_least_beta24_plus_three.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove that three linear second syzygies force rank(M)<=2.
  It does NOT prove a common linear factor among the four quadrics.
  It does NOT exclude H01-C5.
  It does NOT enter H01-C4.
  It does NOT close H01.
  It does NOT make a tangent-space estimate.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_second_syzygy_obstruction.
  not q4_height2_multiplicity_one_depth_one_H01_C5_excluded.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  For the 4-by-5 linear first-syzygy matrix M of H01-C5, classify the case in
  which ker(M) has at least three independent degree-one generators.  Determine
  whether that forces generic rank(M)<=2, a common linear factor of Q, or an
  unmixed multiplicity-two component, any of which would contradict the present
  height-two multiplicity-one H01 hypotheses.

NEXT_ACTIONS:
  1. Stay only in H01-C5.
  2. Analyze the 4-by-5 linear matrix M with at least three linear kernel vectors.
  3. Use only determinantal/rank consequences justified from that matrix.
  4. If no contradiction follows, record the weakest surviving matrix type.
  5. Stop before H01-C4, tangent estimates, or q<=3.
