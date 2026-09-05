Standalone initial-colon-degree reduction for the surviving equal-degree-five
residual nonreduced homogeneous q=3, height-three complete-intersection R2
branch in the order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_annihilator_support_sharpening.v
    order13_homogeneous_q3_height3_nonreduced_ci_R2_socle_kernel_reduction.v.

  Retain

    d=5,
    A=R/(u1,u2),
    Cbar=im(tau_bar) != 0,
    eta=q(tau_bar),
    t=dim_C Soc(A).

  The preceding reductions proved

    Cbar_j=0 unless 1<=j<=6,

    h_A(0),...,h_A(5)=(1,4,7,8,8,6),

    dim_C ker(lambda)>=2t,

  and, with

    sigma=rank_C(mu4),
    rho=rank_C(mu5),

  every still-unresolved d=5 candidate satisfies

    sigma+rho>=2t.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. INITIAL COLON DEGREE CONTROLS THE CYCLIC MULTIPLIER WINDOW
--------------------------------------------------------------------------

Because Cbar is nonzero and homogeneous, define

  m:=min{j : Cbar_j != 0}.

The established support gives

  1<=m<=6.

Take a homogeneous element a in A_r with

  r>=7-m.

For every homogeneous c in Cbar_j we have j>=m, so

  r+j>=7.

Since Cbar is a homogeneous ideal of A,

  a*c in Cbar_{r+j}.

But every component Cbar_k with k>=7 vanishes. Hence a*c=0 for every c in
Cbar. Therefore

  A_{>=7-m} subset Ann_A(Cbar) subset Ann_A(eta).    (1)

Consequently A*eta is supported only by multiplier degrees

  0<=r<=6-m.                                         (2)

Theorem R2_d5_initial_colon_degree_controls_multiplier_support:
  If m is the least nonzero degree of Cbar in the surviving d=5 branch, then

    A_{>=7-m} subset Ann_A(eta),

  so A*eta has no multiplier layer above degree 6-m.
Qed.

--------------------------------------------------------------------------
2. EVERY INITIAL COLON DEGREE AT LEAST THREE CLOSES
--------------------------------------------------------------------------

Suppose

  m>=3.

Then (2) confines A*eta to multiplier degrees 0,...,3. Using the forced
initial Hilbert function,

  length_C(A*eta)
    <=1+4+7+8
    =20.                                             (3)

The surviving branch is non-Gorenstein, so t>=2. The socle-square inclusion
therefore gives

  dim_C ker(lambda)>=2t>=4.                          (4)

Combining (3) and (4),

  length_C(A*eta)
    <=20
    <=dim_C ker(lambda)+19.

Thus the sharp R2 tangent inequality holds.

Theorem R2_d5_initial_colon_degree_at_least_three_closed:
  Every surviving d=5 candidate with

    Cbar_1=Cbar_2=0

  satisfies

    length_C(A*eta)<=dim_C ker(lambda)+19,

  and hence

    dim_C Hom_B(L,A)>=N-19.
Qed.

Therefore every still-unresolved d=5 candidate has

  m in {1,2}.                                        (5)

--------------------------------------------------------------------------
3. INITIAL COLON DEGREE TWO REDUCES TO SOCLE TYPE AT MOST FOUR
--------------------------------------------------------------------------

Suppose

  m=2.

Then (2) confines A*eta to multiplier degrees 0,...,4, so

  length_C(A*eta)
    <=1+4+7+8+8
    =28.                                             (6)

If t>=5, the socle-square kernel bound gives

  dim_C ker(lambda)+19
    >=2t+19
    >=29,

and (6) closes the sharp tangent inequality. Hence every unresolved m=2
candidate satisfies

  2<=t<=4.                                           (7)

There is also an exact rank simplification. Since Cbar_1=0, the map

  mu5:A_5 -> Hom_C(Cbar_1,Cbar_6)

is zero. Thus

  rho=0.

The preceding two-layer reduction says every unresolved d=5 candidate must
satisfy sigma+rho>=2t. Therefore in the m=2 branch

  sigma>=2t.                                         (8)

Since dim_C A_4=8, sigma<=8, which recovers t<=4 and shows that the type-four
case is extremal:

  t=4 implies sigma=8.

In particular mu4 is injective in that type-four extremal case.

Theorem R2_d5_initial_colon_degree_two_reduction:
  Every still-unresolved d=5 candidate with m=2 satisfies

    2<=t<=4,
    rho=0,
    sigma>=2t.

  If t=4, then sigma=8 and mu4 is injective.
Qed.

--------------------------------------------------------------------------
4. INITIAL COLON DEGREE ONE HAS SOCLE TYPE AT MOST SEVEN
--------------------------------------------------------------------------

Suppose

  m=1.

The full d=5 multiplier window 0,...,5 can remain. The crude bound is

  length_C(A*eta)<=34.

If t>=8, then

  dim_C ker(lambda)+19>=16+19=35,

so the sharp tangent inequality is automatic. Thus every unresolved m=1
candidate satisfies

  2<=t<=7.                                           (9)

This same cutoff is visible from the rank reduction because

  sigma<=dim_C A_4=8,
  rho<=dim_C A_5=6,

while unresolved candidates satisfy sigma+rho>=2t.

Let

  s4:=dim_C Soc(A)_4,
  s5:=dim_C Soc(A)_5.

Every socle element annihilates the positive-degree ideal Cbar. Therefore

  Soc(A)_4 subset ker(mu4),
  Soc(A)_5 subset ker(mu5).

Consequently

  sigma<=8-s4,
  rho<=6-s5.

Combining these inequalities with sigma+rho>=2t gives

  s4+s5<=14-2t.                                      (10)

In particular, if t=7, equality is forced throughout:

  sigma=8,
  rho=6,
  s4=s5=0.                                           (11)

Thus both mu4 and mu5 are injective in every unresolved type-seven m=1
candidate.

Theorem R2_d5_initial_colon_degree_one_socle_distribution_reduction:
  Every still-unresolved d=5 candidate with m=1 satisfies

    2<=t<=7,
    s4+s5<=14-2t.

  In type t=7 one necessarily has

    sigma=8,
    rho=6,
    Soc(A)_4=Soc(A)_5=0.
Qed.

--------------------------------------------------------------------------
5. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_d5_initial_colon_degree_controls_multiplier_support.
  R2_d5_initial_colon_degree_at_least_three_closed.
  R2_d5_initial_colon_degree_two_reduction.
  R2_d5_initial_colon_degree_one_socle_distribution_reduction.

IMPORTANT_NONCONCLUSION:
  This file does NOT close every surviving d=5 candidate.
  It does NOT close all residual R2.
  It does NOT close residual R1 or any parent branch.
  The theorem statements in this file remain pseudo-formal mathematical
  documentation and are not machine-verified Lean or Coq theorems.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Every still-unresolved d=5 candidate has exactly one of the following forms:

  (A) m=2, 2<=t<=4, rho=0, sigma>=2t;

  (B) m=1, 2<=t<=7, sigma+rho>=2t, with

        dim Soc(A)_4 + dim Soc(A)_5 <= 14-2t.

  All cases with m>=3 are closed.

MISSING_OBJECT:
  In the two surviving initial-colon-degree regimes above, use the top colon
  layer

    Cbar_6 subset Soc(A)_6

  together with the degree-six and higher Koszul layers to force either
  additional annihilator in multiplier degrees four and five or additional
  graded kernel beyond Soc(A)^2.

NEXT_ACTIONS:
  1. Rebuild the exact terminal workflow on this commit.
  2. If green, treat m=2 first, where rho=0 and only mu4 remains.
  3. Do not continue past a failed rebuild.
