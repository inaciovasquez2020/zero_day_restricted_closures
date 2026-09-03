Standalone quartic-growth and cubic-colon reduction for the H01-C5 branch in the
homogeneous q=4, height-two multiplicity-one, depth-one order-13 deviation-two
program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_linear_syzygy_reduction.v
    order13_q4_height2_depth_one_multiplicity_one_H01_C5_second_syzygy_obstruction.v

  and retain the nonminimal H01-C5 state

    m>=3,
    sigma=5,
    tau_3=1.

Write

    S=C[x1,x2,x3,x4],
    Q=(q1,q2,q3,q4),
    B=S/Q,
    Qsat=Q^sat,
    Ccore=S/Qsat,
    T=Qsat/Q,
    P=(l1,l2),
    D=P/Qsat.

The preceding files prove

    e(B)=e(Ccore)=1,
    dim B=2,
    dim B_3=9,
    dim T_3=1,

and, for the H01 chain parameter m,

    Hilb_D(t)=(2*t+t^2+...+t^m)/(1-t).

The previous C5 second-syzygy file used only the raw Macaulay inequality

    B_4<=12

to obtain

    beta_(3,4)(B)>=beta_(2,4)(B)+3.

This file performs one bounded strengthening only.  The equality B_4=12 would
trigger Gotzmann persistence and force multiplicity three, contradicting the
standing multiplicity-one branch.  Hence B_4<=11.  This sharpens the linear
second-syzygy bound and forces a large linear annihilator of the unique cubic
saturation class.

No exclusion of H01-C5 is claimed.
No H01-C4 or tangent argument is entered.
No q<=3 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE MACAULAY EQUALITY B_4=12 IS INCOMPATIBLE WITH e(B)=1
--------------------------------------------------------------------------

The C5 state has

    dim_C B_3=9.

Its third Macaulay expansion is

    9=binom(4,3)+binom(3,2)+binom(2,1),

so

    9^{<3>}
      =binom(5,4)+binom(4,3)+binom(3,2)
      =12.

Thus Macaulay growth gives

    dim B_4<=12.

Theorem H01_C5_B4_is_not_twelve:
  One has

    dim_C B_4 != 12.

Proof:
  Suppose instead that

    dim B_4=12=9^{<3>}.

  Then B has maximal Macaulay growth from degree three to degree four.
  The defining ideal Q is generated entirely in degree two, hence in degrees at
  most three.  Standard Gotzmann persistence therefore propagates the maximal
  growth for all later degrees.

  Iterating the Macaulay successor of

    9=binom(4,3)+binom(3,2)+binom(2,1)

  gives

    dim B_n=3*n

  for every n>=3.

  Hence the Hilbert polynomial of the two-dimensional graded algebra B has
  leading coefficient three, so

    e(B)=3.

  But T=Qsat/Q has finite length, so B and Ccore have the same multiplicity.
  The standing H01 branch has

    e(Ccore)=1.

  Therefore e(B)=1, contradiction.
Qed.

Corollary H01_C5_sharp_quartic_growth_bound:
  One has

    dim_C B_4<=11.
Qed.

--------------------------------------------------------------------------
2. THE LINEAR SECOND-SYZYGY BOUND IMPROVES BY ONE
--------------------------------------------------------------------------

Retain the Betti notation from the preceding C5 file:

    a:=beta_(2,4)(B),
    c:=beta_(3,4)(B).

That file proves the exact degree-four identity

    dim B_4=15+a-c.

Theorem H01_C5_forces_four_excess_linear_second_syzygies:
  One has

    c>=a+4.

In particular

    beta_(3,4)(B)>=4.

Proof:
  Combine

    15+a-c=dim B_4<=11.

  Rearranging gives

    c>=a+4.
Qed.

This strictly strengthens the preceding bound c>=a+3.

--------------------------------------------------------------------------
3. THE SATURATED CORE HAS AN EXPLICIT DEGREE-FOUR SIZE
--------------------------------------------------------------------------

The line quotient exact sequence is

    0 -> D -> Ccore -> S/P -> 0,

with

    S/P ~= C[s,t].

Hence

    dim_C(S/P)_4=5.

The H01 chain gives

    dim D_4=4  if m=3,
    dim D_4=5  if m>=4.

Therefore:

Theorem H01_C5_exact_core_degree_four:
  One has

    dim Ccore_4=9   if m=3,
    dim Ccore_4=10  if m>=4.
Qed.

Put

    tau_4:=dim_C T_4.

Since

    0 -> T -> B -> Ccore -> 0

is graded exact,

    dim B_4=dim Ccore_4+tau_4.

Corollary H01_C5_quartic_torsion_bounds:
  One has

    tau_4<=2  if m=3,
    tau_4<=1  if m>=4.
Qed.

More precisely, combining with the Betti identity gives

    c=a+6-tau_4  if m=3,
    c=a+5-tau_4  if m>=4.

Thus

    if m=3,   c-a is in {4,5,6},
    if m>=4,  c-a is in {4,5}.

--------------------------------------------------------------------------
4. THE UNIQUE CUBIC SATURATION CLASS HAS A LARGE LINEAR ANNIHILATOR
--------------------------------------------------------------------------

Because tau_3=1, choose a homogeneous cubic

    gamma in (Qsat)_3

whose class

    eta:=gamma+Q

spans T_3.

Put

    K:=Ann_S(eta)=(Q:gamma).

Theorem H01_C5_cubic_colon_is_m_primary:
  K is homogeneous m-primary.

Proof:
  The cyclic submodule S*eta is a nonzero submodule of the finite-length module
  T.  Therefore

    S*eta ~= S/K

  has finite length.  Equivalently K is homogeneous m-primary.
Qed.

Consider multiplication by eta in the next degree:

    mu_eta:S_1 -> T_4,
    ell |-> ell*eta.

Its kernel is exactly K_1.  Hence

    dim K_1
      =4-rank(mu_eta)
      >=4-dim T_4
      =4-tau_4.

Theorem H01_C5_cubic_colon_linear_rank:
  One has

    dim_C K_1>=2  if m=3,
    dim_C K_1>=3  if m>=4.
Qed.

Thus the unique cubic saturation class is already supported on an Artin quotient
of embedding dimension at most two when m=3, and at most one when m>=4.

--------------------------------------------------------------------------
5. FOR m>=4 THE CUBIC TORSION SUBMODULE IS A ONE-VARIABLE CHAIN
--------------------------------------------------------------------------

Assume m>=4.

By the preceding theorem K contains at least three independent linear forms.
Choose independent linear forms

    z1,z2,z3 in K_1

and complete them to coordinates

    S=C[z1,z2,z3,u].

Modulo L=(z1,z2,z3), the m-primary homogeneous ideal K becomes a homogeneous
(u)-primary ideal in C[u].  Hence it is generated by one power u^r.

Theorem H01_C5_cubic_torsion_chain_for_m_at_least_four:
  For some integer r>=1,

    K=L+(u^r)

  after a linear coordinate change, and therefore

    S*eta ~= C[u]/(u^r)(-3).

Proof:
  K/L is a homogeneous finite-colength ideal in the one-variable polynomial
  ring C[u].  Every such ideal is (u^r) for a unique r>=1.
Qed.

Corollary H01_C5_cubic_torsion_has_no_branching_for_m_at_least_four:
  The cyclic submodule generated by T_3 has Hilbert function

    1,1,...,1

  in consecutive degrees beginning at degree three and then terminates.

  In particular its degree-four piece has dimension at most one, in agreement
  with tau_4<=1.
Qed.

IMPORTANT:
  T itself may still have additional minimal generators in degree four or higher.
  The theorem classifies only the cyclic submodule generated by the unique
  degree-three saturation class.

--------------------------------------------------------------------------
6. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_B4_at_most_11.
  q4_height2_multiplicity_one_depth_one_H01_C5_beta34_at_least_beta24_plus_4.
  q4_height2_multiplicity_one_depth_one_H01_C5_tau4_bound.
  q4_height2_multiplicity_one_depth_one_H01_C5_cubic_colon_linear_rank.
  q4_height2_multiplicity_one_depth_one_H01_C5_m_ge_4_cubic_torsion_chain.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove that H01-C5 is impossible.
  It does NOT prove that all of T is cyclic.
  It does NOT prove that the m>=4 one-variable cubic chain forces a common
  factor among the original four quadrics.
  It does NOT enter H01-C4.
  It does NOT make a tangent-space estimate.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_second_syzygy_obstruction.
  q4_height2_multiplicity_one_depth_one_H01_C5_quartic_colon_reduced.
  not q4_height2_multiplicity_one_depth_one_H01_C5_excluded.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay in H01-C5 and treat the stronger subcase m>=4.  Combine the four-by-five
  linear first-syzygy matrix, at least four excess linear second syzygies, and
  the cubic colon

    (Q:gamma)=L+(u^r),
    dim L=3,

  to determine whether the coefficient matrix q_i=a_i*l1+b_i*l2 must acquire a
  common factor or a multiplicity-two unmixed component.

NEXT_ACTIONS:
  1. Stay only in H01-C5 with m>=4.
  2. Normalize K_1=(z1,z2,z3) for the cubic class gamma.
  3. Push z_i*gamma in Q through the five-linear-syzygy matrix.
  4. Test whether the resulting coefficient rank forces multiplicity two.
  5. Stop before m=3, H01-C4, tangent estimates, or q<=3.
