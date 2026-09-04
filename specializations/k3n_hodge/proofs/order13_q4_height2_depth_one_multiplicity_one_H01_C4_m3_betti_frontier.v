Standalone graded-Betti reduction for the saturated H01-C4 m=3 endpoint in the
homogeneous q=4, height-two multiplicity-one, depth-one order-13 deviation-two
program.

SCOPE:
  Retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,

  with

    ht(Q)=2,
    depth_m(B)=1,
    Q=Q^sat,
    m=3,
    sigma=4,
    Hilb_B(0,1,2,3,4,5,6,...)
      =(1,4,6,8,9,10,11,...),
    dim_C B_n=n+5 for n>=3.

This file performs one bounded task only: derive the weakest exact numerical
Betti frontier and the generic rank of the four-linear-first-syzygy matrix.
No tangent estimate, coefficient normal form, H01 m=2 branch, q<=3 branch, or
full order-13 closure is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EXACT HILBERT NUMERATOR AND PROJECTIVE DIMENSION
--------------------------------------------------------------------------

The exact Hilbert series is

    Hilb_B(t)=(1+2*t-t^2-t^4)/(1-t)^2.

Equivalently, over the ambient four-variable polynomial ring,

    (1-t)^4 Hilb_B(t)
      =1-4*t^2+4*t^3-2*t^4+2*t^5-t^6.

Since depth_m(B)=1 and S has depth four, Auslander-Buchsbaum gives

    pd_S(B)=3.

Thus the minimal graded free resolution has the form

    0 -> F3 -> F2 -> S(-2)^4 -> S -> B -> 0.

Put

    a_j := beta_{2,j}(B),
    c_j := beta_{3,j}(B).

The four linear first syzygies give

    a_3=4,

and minimality gives

    c_3=0.

Comparing coefficients with the exact Hilbert numerator yields

    c_4=a_4+2,
    a_5=c_5+2,
    c_6=a_6+1,
    a_j=c_j for j>=7.

--------------------------------------------------------------------------
2. THE FOUR-LINEAR-SYZYGY MATRIX HAS GENERIC RANK TWO
--------------------------------------------------------------------------

Let

    A : S(-3)^4 -> S(-2)^4

be the 4-by-4 matrix of the four minimal linear first syzygies.

Every degree-four third syzygy maps, by minimality, only into the cubic block
S(-3)^4 and therefore gives a linear relation among the columns of A.
Since d3 is injective in the minimal resolution, these c_4 relations are
independent over Frac(S).  Hence

    c_4 <= dim_K ker(A_K),

where K=Frac(S).

The matrix A cannot have generic rank zero.

It also cannot have generic rank one.  Indeed, if its four homogeneous linear
columns span a rank-one K-subspace, choose a primitive polynomial generator v
for that rank-one module.  Since all columns have degree one, either:

  (i) deg(v)=1, in which case every column is a scalar multiple of v and the
      four columns span at most one dimension over C, contradicting sigma=4;

or

  (ii) deg(v)=0, in which case v is a nonzero constant vector and every column
       is a linear form times v.  From d1*A=0 and the domain property of S one
       obtains d1(v)=0, a nontrivial constant linear relation among
       q1,q2,q3,q4, contradicting minimal independence of the four quadrics.

Therefore

    rank_K(A)>=2.

On the other hand

    c_4=a_4+2>=2,

so A has at least two independent K-kernel vectors and hence

    rank_K(A)<=2.

Therefore

    rank_K(A)=2,
    dim_K ker(A_K)=2.

Consequently

    c_4<=2.

Together with c_4=a_4+2 this forces

    a_4=0,
    c_4=2.

Theorem H01_C4_m3_linear_matrix_rank_two:
  The four-linear-first-syzygy matrix has generic rank exactly two and exactly
  two independent linear second syzygies.
Qed.

--------------------------------------------------------------------------
3. THERE ARE EXACTLY TWO MINIMAL QUINTIC FIRST SYZYGIES
--------------------------------------------------------------------------

Because a_4=0, a degree-five third syzygy can map only into the cubic block
S(-3)^4: a component into S(-5) has degree zero and is forbidden by minimality.
Thus every c_5 generator gives a K-kernel vector of A.

But the two degree-four third syzygies already span the full two-dimensional
kernel of A_K.  Any additional degree-five third-syzygy column lying entirely
in that same kernel would make d3 fail to be injective over K.

Therefore

    c_5=0.

The Hilbert-numerator identity a_5=c_5+2 now gives

    a_5=2.

Theorem H01_C4_m3_two_quintic_first_syzygies:
  The minimal resolution has exactly two degree-five first-syzygy generators
  and no degree-five second-syzygy generators.
Qed.

--------------------------------------------------------------------------
4. THE SHIFT-SIX AMBIGUITY IS AT MOST BINARY
--------------------------------------------------------------------------

From the numerator,

    c_6=a_6+1.

A degree-six third syzygy maps only into the already-existing cubic and quintic
blocks

    S(-3)^4 direct_sum S(-5)^2,

because a degree-zero component into a possible S(-6) summand of F2 is
forbidden by minimality.

These two blocks have total K-rank six.  The two degree-four third syzygies and
the c_6 degree-six third syzygies are K-independent and lie in the kernel of
the restriction of d2 to this six-dimensional source.  Since the cubic block
alone already maps with generic rank two, that restricted kernel has dimension
at most four.  Hence

    2+c_6 <=4.

Using c_6=a_6+1 gives

    a_6<=1.

Thus

    a_6 in {0,1},
    c_6 in {1,2}.

--------------------------------------------------------------------------
5. GOTZMANN REGULARITY REMOVES ALL HIGHER GHOST PAIRS
--------------------------------------------------------------------------

The Hilbert polynomial is

    P_B(n)=n+5.

Its Gotzmann representation has five terms,

    n+5
      = binom(n+1,1)
        + binom(n-1,0)
        + binom(n-2,0)
        + binom(n-3,0)
        + binom(n-4,0).

Hence the saturated ideal Q is 5-regular by the standard Gotzmann regularity
theorem, so

    reg(B)<=4.

Therefore

    beta_{2,j}=0 for j>=7,
    beta_{3,j}=0 for j>=8.

The numerator coefficient in degree seven is zero, so a_7=c_7.  Since a_7=0,
one gets c_7=0 as well.  Thus there are no higher shifts.

--------------------------------------------------------------------------
6. EXACT TWO-TABLE BETTI FRONTIER
--------------------------------------------------------------------------

Only two numerical minimal free resolutions remain.

BETTI-A:

    0
      -> S(-4)^2 direct_sum S(-6)
      -> S(-3)^4 direct_sum S(-5)^2
      -> S(-2)^4
      -> S
      -> B
      -> 0.

This is the case

    a_6=0,
    c_6=1.

BETTI-B:

    0
      -> S(-4)^2 direct_sum S(-6)^2
      -> S(-3)^4 direct_sum S(-5)^2 direct_sum S(-6)
      -> S(-2)^4
      -> S
      -> B
      -> 0.

This is the case

    a_6=1,
    c_6=2.

Theorem H01_C4_m3_exact_two_table_Betti_frontier:
  Every surviving saturated H01-C4 m=3 endpoint has exactly one of the two
  numerical Betti tables BETTI-A or BETTI-B above.
Qed.

In both cases the 4-by-4 matrix of the four linear first syzygies has generic
rank exactly two.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_linear_matrix_rank_two.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_beta24_zero_beta34_two.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_beta25_two_beta35_zero.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_beta26_at_most_one.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_two_table_Betti_frontier.

IMPORTANT_NONCONCLUSION:
  This file does NOT decide BETTI-A versus BETTI-B.
  It does NOT exclude the saturated H01-C4 m=3 endpoint.
  It does NOT classify the rank-two linear matrix A up to row/column changes.
  It does NOT prove a tangent carrier or tangent-space estimate.
  It does NOT treat H01 m=2.
  It does NOT close all H01.
  It does NOT enter q<=3 or prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_closed.
  q4_height2_multiplicity_one_depth_one_H01_C4_reduced_to_saturated_m3.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_two_table_Betti_frontier.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in the saturated H01-C4 m=3 endpoint.  Use the exact generic-rank
  two 4-by-4 linear-syzygy matrix and the BETTI-A/B dichotomy to determine the
  weakest coefficient-matrix normal form or to exclude one Betti table before
  any tangent estimate.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
