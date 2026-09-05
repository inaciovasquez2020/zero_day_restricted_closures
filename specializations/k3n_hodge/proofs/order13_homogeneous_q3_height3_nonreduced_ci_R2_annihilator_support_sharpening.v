Standalone annihilator-support sharpening for the surviving residual
nonreduced homogeneous q=3, height-three complete-intersection R2 branch in
the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_koszul_hilbert_symmetry_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_koszul_image_identification.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_regular_escape_reduction.v.

  Retain

    A=R/(u1,u2),
    deg(u1)=deg(u2)=d,
    Cbar=im(tau_bar),
    eta=q(tau_bar).

  The preceding Hilbert-symmetry reduction proved

    Cbar_j=0 unless 1<=j<=d+1.                      (1)

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE ANNIHILATOR BEGINS IN DEGREE d+1, NOT d+2
--------------------------------------------------------------------------

Take a homogeneous element

  a in A_r,
  r>=d+1.

For every homogeneous c in Cbar_j, equation (1) gives j>=1.  Hence

  r+j>=d+2.

Because Cbar is a homogeneous ideal of A, a*c lies in Cbar_{r+j}; but (1)
shows every Cbar component in degree at least d+2 is zero.  Therefore

  a*c=0

for every c in Cbar.  Thus

  A_{>=d+1} subset Ann_A(Cbar).                     (2)

The exact colon/Koszul reduction gives

  Ann_A(Cbar) subset Ann_A(eta).

Consequently

  A_{>=d+1} subset Ann_A(eta).                      (3)

Theorem R2_cyclic_obstruction_is_annihilated_from_degree_d_plus_1:
  Every homogeneous multiplier of degree at least d+1 annihilates eta.
Qed.

--------------------------------------------------------------------------
2. SHARPENED MULTIPLIER SUPPORT
--------------------------------------------------------------------------

Since A*eta is the cyclic quotient A/Ann_A(eta), up to the grading shift by e,
equation (3) gives

  (A*eta)_{r-e}=0 for r>=d+1.

Hence A*eta is supported only by multiplier degrees

  0<=r<=d.                                          (4)

This improves the previous bound 0<=r<=d+1 by one full layer.

Theorem R2_cyclic_obstruction_multiplier_support_is_at_most_d:
  A*eta has no multiplier layer above degree d.
Qed.

--------------------------------------------------------------------------
3. THE POSSIBLE KOSZUL-OVERLAP WINDOW SHRINKS AGAIN
--------------------------------------------------------------------------

The graded cyclic-quotient reduction proved that lambda-overlap is impossible
for multiplier degrees

  0<=r<D=e-d.

Equation (3) shows the multiple already vanishes for r>=d+1.  Therefore the
only multiplier degrees in which nonzero overlap can occur are

  D<=r<=d.                                          (5)

In particular, if

  D>=d+1,

equivalently

  e>=2d+1,

then the interval (5) is empty and

  (A*tau_bar) intersect image(lambda)=0,
  Ann_A(eta)=Ann_A(Cbar).

Corollary R2_escape_gap_at_least_d_plus_1_has_zero_Koszul_overlap:
  If e>=2d+1, the Koszul-overlap term vanishes identically.
Qed.

--------------------------------------------------------------------------
4. EQUAL DEGREE FOUR REDUCES TO LOW SOCLE TYPE WITH NONZERO LINEAR COLON
--------------------------------------------------------------------------

Assume now

  d=4.

The surviving R2 branch has D=e-d>=2, hence e>=6.  From

  Hilb_R(t)=(1+t+...+t^{e-1})(1+t)^3

and the fact that u1,u2 form a two-dimensional minimal degree-four slice, the
initial Hilbert function of A is

  h_A(0)=1,
  h_A(1)=4,
  h_A(2)=7,
  h_A(3)=8,
  h_A(4)=6.                                         (6)

By (4), only multiplier degrees 0,...,4 can contribute to A*eta.  Therefore

  length_C(A*eta)<=1+4+7+8+6=26.                   (7)

Let

  t=dim_C Soc(A).

The surviving branch is non-Gorenstein, so t>=2, and the established socle
square injection gives

  dim_C ker(lambda)>=2t.                            (8)

If t>=4, equations (7) and (8) give

  length_C(A*eta)<=26<=27<=dim_C ker(lambda)+19.

Thus equal degree four is closed whenever t>=4.

It remains to use the linear colon layer.  Suppose

  Cbar_1=0.

Then (1), with d=4, sharpens to

  Cbar_j=0 unless 2<=j<=5.

For a in A_4 and c in Cbar_j we have

  deg(a*c)=4+j>=6.

Because Cbar has no component above degree 5, a*c=0.  Hence

  A_4 subset Ann_A(Cbar) subset Ann_A(eta).         (9)

Consequently the degree-four multiplier layer contributes nothing to A*eta,
and

  length_C(A*eta)<=1+4+7+8=20.                     (10)

Using only t>=2 in (8),

  dim_C ker(lambda)+19>=4+19=23,

so (10) closes the sharp tangent inequality.

Theorem R2_equal_degree_four_reduces_to_low_type_nonzero_linear_colon:
  In the surviving d=4 branch, the sharp inequality

    length_C(A*eta)<=dim_C ker(lambda)+19

  holds if either

    t>=4

  or

    Cbar_1=0.

  Therefore every still-unresolved d=4 candidate satisfies

    t in {2,3},
    Cbar_1 != 0.
Qed.

--------------------------------------------------------------------------
5. A PRINCIPAL LINEAR COLON LAYER CLOSES EQUAL DEGREE FOUR
--------------------------------------------------------------------------

Continue with d=4 and suppose

  dim_C Cbar_1=1.

Choose a nonzero homogeneous generator

  c in Cbar_1.

For every j>=2 and every a in A_4, equation (1) gives

  a*Cbar_j subset Cbar_{4+j}=0,

because 4+j>=6 while Cbar has no component above degree 5.  Hence the only
part of Cbar seen by multiplication from A_4 is Cbar_1=C*c.  Therefore

  Ann_A(Cbar)_4
    =ker(m_c:A_4 -> Cbar_5),

where

  m_c(a)=a*c.                                       (11)

Also

  A_+*Cbar_5 subset Cbar_{>=6}=0.

Thus

  Cbar_5 subset Soc(A)_5,

and consequently

  dim_C Cbar_5<=t.                                  (12)

Since h_A(4)=6, equations (11) and (12) imply

  dim_C Ann_A(Cbar)_4>=6-t.                         (13)

Using Ann_A(Cbar) subset Ann_A(eta), the degree-four quotient layer of A*eta
has dimension at most t.  Together with (6),

  length_C(A*eta)
    <=1+4+7+8+t
    =20+t.                                          (14)

The socle-square kernel estimate (8) gives

  dim_C ker(lambda)+19>=2t+19.

Since t>=2,

  20+t<=19+2t.

Therefore

  length_C(A*eta)<=dim_C ker(lambda)+19.

Theorem R2_equal_degree_four_principal_linear_colon_closed:
  If d=4 and dim_C Cbar_1=1, the sharp R2 tangent inequality holds.
Qed.

Combining this with the preceding reduction, every still-unresolved d=4
candidate must satisfy

  t in {2,3},
  dim_C Cbar_1>=2.                                  (15)

--------------------------------------------------------------------------
6. ALL NONEXTREMAL DEGREE-FOUR MULTIPLICATION RANKS CLOSE
--------------------------------------------------------------------------

Continue with the surviving case (15).  Put

  U:=Cbar_1,
  V:=Cbar_5,

and define the multiplication map

  m_4:A_4 -> Hom_C(U,V),
  m_4(a)(c)=a*c.

Let

  rho:=rank_C(m_4).

For every j>=2, multiplication by A_4 sends Cbar_j into Cbar_{4+j}=0.
Therefore an element a in A_4 annihilates all of Cbar if and only if it
annihilates U.  Hence

  Ann_A(Cbar)_4=ker(m_4).                            (16)

Since Ann_A(Cbar) subset Ann_A(eta), the degree-four multiplier layer of the
cyclic quotient A*eta=A/Ann_A(eta) has dimension at most rho.  The lower
multiplier layers have total dimension

  h_A(0)+h_A(1)+h_A(2)+h_A(3)=1+4+7+8=20.

Thus

  length_C(A*eta)<=20+rho.                          (17)

If

  rho<=2t-1,

then equations (8) and (17) give

  length_C(A*eta)
    <=20+(2t-1)
    =2t+19
    <=dim_C ker(lambda)+19.

Therefore every multiplication rank rho<=2t-1 closes the sharp R2 tangent
inequality.

Theorem R2_equal_degree_four_nonextremal_multiplication_rank_closed:
  In the surviving d=4 branch, if

    rank_C(A_4 -> Hom_C(Cbar_1,Cbar_5))<=2t-1,

  then

    length_C(A*eta)<=dim_C ker(lambda)+19.
Qed.

Since dim_C A_4=6, a still-unresolved d=4 candidate must now satisfy exactly
one of

  t=2 and rho in {4,5,6},

or

  t=3 and rho=6.                                    (18)

No contradiction for the extremal ranks in (18) is asserted here.

--------------------------------------------------------------------------
7. RANK SIX CLOSES EXCEPT FOR ONE TYPE-THREE ONE-VARIABLE TAIL
--------------------------------------------------------------------------

Assume now

  rho=6.

Since dim_C A_4=6, the map m_4 is injective.  By (16),

  Ann_A(Cbar)_4=0.                                  (19)

Every degree-four socle element annihilates U subset A_1, so (19) also gives

  Soc(A)_4=0.                                       (20)

Write

  u:=dim_C U,
  v:=dim_C V.

Because U subset A_1 and V subset Soc(A)_5,

  u<=4,
  v<=t,

while rho=6 implies

  6<=u*v.                                           (21)

First suppose t=2.  Then v<=2, so (21) forces

  v=2=t,
  u>=3.

Thus V is the whole socle of A, concentrated in degree 5.  If A_j were
nonzero for some j>5, the highest nonzero homogeneous component above degree
5 would itself contribute a socle element independent of V, contradicting
t=2.  Hence

  A_{>=6}=0.                                        (22)

Now suppose t=3.  Equation (21) gives v>=2.  If v=3, then again V exhausts the
socle and (22) follows.  If v=2 and u=4, then U=A_1.  Since A is standard
graded, for j>=6

  A_j=A_1*A_{j-1}=U*A_{j-1} subset Cbar_j=0,

so (22) follows here as well.  Therefore failure of (22) under rho=6 can occur
only in the single numerical configuration

  t=3,
  u=3,
  v=2.                                              (23)

We next show that every rho=6 case satisfying (22) already closes.  Put

  h5:=dim_C A_5.

Since A_5 is then the top homogeneous component,

  h5<=t.                                            (24)

The graded Euler-characteristic formula from the Hilbert-symmetry reduction,
with d=4 and e>=6, gives

  h_H1(5)
    =h_A(5)+h_A(e+5)-h_R(5)+2h_R(1)-h_R(-3).

Under (22), h_A(e+5)=0, while the explicit Hilbert function of R gives

  h_R(5)=8,
  h_R(1)=4,
  h_R(-3)=0.

Hence

  h_H1(5)=h5.                                       (25)

Consider lambda on coefficient pairs in A_4^2, a twelve-dimensional
C-vector space.  By minimality there are no Koszul cycles with scalar
coefficients.  A Koszul class whose coefficients have degree at least two is
also invisible to A_4^2, because multiplying those coefficients by A_4 lands
in A_{>=6}=0.  Therefore the entire restriction of lambda to A_4^2 factors
through

  A_4^2 -> Hom_C(H1_5,A_5).

By (24) and (25), the target has dimension at most t^2.  Consequently

  dim_C(ker(lambda) intersect A_4^2)>=12-t^2.       (26)

The already established inclusion Soc(A)^2 subset ker(lambda) contributes
2t dimensions.  By (20), it has no degree-four part, so its contribution is
disjoint from the degree-four kernel in (26).  Thus

  dim_C ker(lambda)>=2t+12-t^2.                    (27)

For t=2, the right side is 12.  For t=3, it is 9.  In both cases, the crude
cyclic bound (7) gives

  length_C(A*eta)<=26<=(2t+12-t^2)+19.

Therefore every rho=6 case satisfying (22) closes the sharp R2 tangent
inequality.

Theorem R2_equal_degree_four_rank_six_tail_free_closed:
  If d=4, rho=6, and A_{>=6}=0, then

    length_C(A*eta)<=dim_C ker(lambda)+19.
Qed.

Combining this with the preceding case split, every still-unresolved rho=6
candidate must satisfy exactly (23) and must have A_{>=6} nonzero.

This remaining tail is itself rigid.  Choose x in A_1 with

  A_1=U direct_sum C*x.

For every j>=5, equation (1) gives

  U*A_j subset Cbar_{j+1}=0.

Hence standard gradedness yields

  A_{j+1}=x*A_j                                    (28)

for every j>=5.  Also, for j>=6, the ideal generated by U has zero degree-j
part because it lies in Cbar_j=0.  Therefore

  A_j ~= (A/(U))_j,

and A/(U) has embedding dimension one.  Thus

  dim_C A_j<=1                                      (29)

for every j>=6.

Since the tail is nonzero and V already contributes two independent socle
elements in degree 5, the total type t=3 leaves exactly one socle dimension
for the tail.  Therefore there is an integer q>5 such that

  dim_C A_5=3,
  dim_C A_j=1 for 6<=j<=q,
  A_j=0 for j>q,                                    (30)

with

  Soc(A)_5=V,

and multiplication by x is an isomorphism between successive one-dimensional
tail layers until the top degree q, where x kills A_q.

Indeed, U kills A_5 and A_6=x*A_5 is one-dimensional by (28)-(29).  Since the
only degree-five socle is V of dimension two, the kernel of

  x:A_5 -> A_6

has dimension two, forcing dim_C A_5=3.  Any vanishing before the top or any
additional kernel in degrees >=6 would create an extra socle element, contrary
to t=3.

Corollary R2_equal_degree_four_rank_six_reduces_to_unique_tail_shape:
  Every still-unresolved rho=6 candidate has

    t=3,
    dim_C Cbar_1=3,
    dim_C Cbar_5=2,
    dim_C A_5=3,

  and a single one-dimensional standard-graded tail as in (30).
Qed.

--------------------------------------------------------------------------
8. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_cyclic_obstruction_is_annihilated_from_degree_d_plus_1.
  R2_cyclic_obstruction_multiplier_support_is_at_most_d.
  R2_Koszul_overlap_is_confined_to_D_through_d.
  R2_equal_degree_four_reduces_to_low_type_nonzero_linear_colon.
  R2_equal_degree_four_principal_linear_colon_closed.
  R2_equal_degree_four_nonextremal_multiplication_rank_closed.
  R2_equal_degree_four_rank_six_tail_free_closed.
  R2_equal_degree_four_rank_six_reduces_to_unique_tail_shape.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    length_C(A*eta)<=dim_C ker(lambda)+19

  for every surviving d=4 candidate.
  It does NOT close the unique type-three rank-six tail shape in (30).
  It does NOT close the type-two rho=4 or rho=5 cases.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.

PROOF_STATUS:
  pseudo-formal mathematical documentation.  The theorem statements in this
  file are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Equal degree d=3 is closed in the dedicated low-degree file.  For d=4, every
  rho=6 case is closed except possibly the unique tail shape

    t=3,
    dim_C Cbar_1=3,
    dim_C Cbar_5=2,
    dim_C A_5=3,
    dim_C A_j=1 for 6<=j<=q,

  for some q>5, with multiplication by one complementary linear form carrying
  the tail.  Separately, t=2 with rho in {4,5} remains unresolved.

MISSING_OBJECT:
  For the rank-six branch, exclude the unique one-variable tail shape above or
  prove enough additional graded Koszul kernel on that tail to close

    length_C(A*eta)<=dim_C ker(lambda)+19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, compute lambda on the one-dimensional tail in (30), using that
     U kills every degree >=5 layer and x is the only surviving linear action.
  3. Do not continue past a failed rebuild.

--------------------------------------------------------------------------
9. THE UNIQUE RANK-SIX TAIL HAS AN EXTRA DEGREE-FOUR KOSZUL KERNEL DIRECTION
--------------------------------------------------------------------------

Continue with the unique tail shape (30).  Put

  K:=(U)_4 subset A_4.

Because dim_C U=3 and dim_C A_1=4, the quotient A/(U) has embedding dimension
one.  Its degree-six part is nonzero by (30).  A standard graded quotient of
C[x] which is nonzero in degree six is one-dimensional in every degree from
zero through six.  Hence

  dim_C (A/(U))_4=1.

Since dim_C A_4=6, it follows that

  dim_C K=5.                                        (31)

Now restrict lambda to coefficient pairs in K^2.  A homogeneous Koszul class
of total degree 4+k has coefficients of degree k.  For k>=2 and alpha in K,

  R_k*alpha subset (U)_{4+k} subset Cbar_{4+k}=0,

because 4+k>=6 and Cbar has no component above degree five.  There are no
nonzero Koszul classes with scalar coefficients by minimality of u1,u2.
Therefore lambda on K^2 can see only the linear-coefficient component H1_5:

  lambda|_{K^2}:K^2 -> Hom_C(H1_5,A_5).             (32)

The degreewise Koszul Euler formula at degree five gives, for d=4 and e>=6,

  h_H1(5)
    =h_A(5)+h_A(e+5)-h_R(5)+2h_R(1)-h_R(-3).

Since A is a quotient of the Artinian Gorenstein ring R of socle degree e+2,

  A_{e+5}=0.

Also h_R(5)=8, h_R(1)=4, and h_R(-3)=0.  Thus

  h_H1(5)=h_A(5)=3.                                 (33)

By (31) and (33), the domain of (32) has dimension ten while its target has
dimension nine.  Therefore

  dim_C(ker(lambda) intersect K^2)>=1.              (34)

The rank-six assumption makes m_4 injective, so equation (20) gives

  Soc(A)_4=0.

Consequently the nonzero degree-four kernel direction in (34) is disjoint
from the already established graded subspace

  Soc(A)^2 subset ker(lambda),

which has dimension 2t=6.  Hence

  dim_C ker(lambda)>=7.                             (35)

Combining (35) with the universal degree-four cyclic bound (7),

  length_C(A*eta)<=26<=7+19<=dim_C ker(lambda)+19.

Therefore the unique tail shape (30) also closes.

Theorem R2_equal_degree_four_rank_six_closed:
  Every surviving d=4 candidate with rho=6 satisfies

    length_C(A*eta)<=dim_C ker(lambda)+19.
Qed.

--------------------------------------------------------------------------
10. THE REMAINING TYPE-TWO RANKS FOUR AND FIVE ALSO CLOSE
--------------------------------------------------------------------------

It remains from (18) only to consider

  t=2,
  rho in {4,5}.

Retain

  u:=dim_C U,
  v:=dim_C V.

We have u<=4, v<=2 and rho<=u*v.

First suppose

  v=2.

Since V subset Soc(A)_5 and t=2, V is the entire socle of A.  If A had a
nonzero homogeneous component above degree five, its highest nonzero component
would supply an additional socle element outside V.  Hence

  A_{>=6}=0,
  A_5=V,
  dim_C A_5=2.                                      (36)

As in (25), the degreewise Euler formula gives

  dim_C H1_5=dim_C A_5=2.                           (37)

For coefficient pairs in A_4^2, all Koszul classes whose coefficients have
degree at least two are invisible by (36), and there are no scalar-coefficient
Koszul classes.  Thus

  lambda|_{A_4^2}:A_4^2 -> Hom_C(H1_5,A_5).

The domain has dimension twelve and, by (36)-(37), the target has dimension
four.  Therefore

  dim_C ker(lambda)>=8.                             (38)

Using (17) and rho<=5,

  length_C(A*eta)<=25<=8+19<=dim_C ker(lambda)+19.

So every v=2 case closes.

Now suppose

  v=1.

Since rho>=4 and u<=4, the inequality rho<=u*v forces

  rho=4,
  u=4.

Thus U=A_1.  Since Cbar is an ideal supported only through degree five and A
is standard graded, for every j>=6,

  A_j=A_1*A_{j-1}=U*A_{j-1} subset Cbar_j=0.

Hence again A_{>=6}=0.  Moreover

  A_5=A_1*A_4=U*A_4 subset V,

while V subset A_5, so

  A_5=V,
  dim_C A_5=1.                                      (39)

The same degree-five Euler formula gives

  dim_C H1_5=1.

Therefore lambda on the twelve-dimensional space A_4^2 factors through a
one-dimensional target, and

  dim_C ker(lambda)>=11.                            (40)

Together with (17) and rho=4,

  length_C(A*eta)<=24<=11+19<=dim_C ker(lambda)+19.

Thus the v=1 case also closes.

Theorem R2_equal_degree_four_type_two_extremal_ranks_closed:
  Every surviving d=4 candidate with t=2 and rho in {4,5} satisfies

    length_C(A*eta)<=dim_C ker(lambda)+19.
Qed.

Combining Sections 4--10 yields the full equal-degree-four closure.

Theorem R2_equal_degree_four_closed:
  Every surviving non-Gorenstein R2 candidate with d=4 satisfies

    length_C(A*eta)<=dim_C ker(lambda)+19,

  and hence

    dim_C Hom_B(L,A)>=N-19.
Qed.

--------------------------------------------------------------------------
11. FINAL UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_equal_degree_four_rank_six_closed.
  R2_equal_degree_four_type_two_extremal_ranks_closed.
  R2_equal_degree_four_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT close every surviving R2 degree.
  It does NOT close residual R1 or any parent branch.
  The theorem statements in this file remain pseudo-formal mathematical
  documentation and are not machine-verified Lean or Coq theorems.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Equal degree d=3 is closed in the dedicated low-degree file, and equal
  degree d=4 is now closed here.  The first equal-degree value not closed by
  these low-degree arguments is d=5.

MISSING_OBJECT:
  For d=5 in the surviving non-Gorenstein R2 branch, sharpen the finite
  multiplier-window estimate using the explicit initial Hilbert function,
  the socle-square inclusion in ker(lambda), and the multiplication pairing

    A_5 x Cbar_1 -> Cbar_6 subset Soc(A)_6,

  strongly enough to prove

    length_C(A*eta)<=dim_C ker(lambda)+19.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, compute the forced initial Hilbert function of A through degree
     five for d=5 and reduce only the resulting extremal multiplication ranks.
  3. Do not continue past a failed rebuild.
