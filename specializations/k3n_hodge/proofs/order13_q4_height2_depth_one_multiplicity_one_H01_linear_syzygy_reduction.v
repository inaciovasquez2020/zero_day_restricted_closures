Standalone linear-syzygy reduction of the remaining H01 endpoint in the
homogeneous q=4, height-two multiplicity-one, depth-one order-13 deviation-two
program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_artinian_chain_classification.v

  and retain

    S := C[x1,x2,x3,x4],
    P := (l1,l2),
    Q subset Qsat subset P,
    B := S/Q,
    Ccore := S/Qsat,
    D := P/Qsat,
    T := Qsat/Q,

with

    Q generated minimally by exactly four independent quadrics,
    ht(Q)=2,
    e(Ccore)=1,
    depth_m(Ccore)=1,

and the H01 state

    (u1,u2)=(0,2).

The preceding file proves that, for a general D-regular linear form h,

    E:=D/hD

has exact Hilbert numerator

    2*t+t^2+...+t^m

for some integer m>=2.  Equivalently,

    Hilb_D(t)=(2*t+t^2+...+t^m)/(1-t),

and

    Q_2=(Qsat)_2,
    T_1=T_2=0.

This file performs one bounded task only: translate the chain parameter m into
an exact count of linear first syzygies of the original four quadrics and reduce
the nonminimal case m>=3 to two cubic possibilities.

The only external tools used are the standard Macaulay growth theorem and
Gotzmann persistence for a homogeneous ideal generated through degree two.

No tangent estimate is made.
No q<=3 branch is entered.
No closure of H01 is claimed.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE DEGREE-THREE RESIDUAL DIMENSION
--------------------------------------------------------------------------

From the exact H01 Hilbert series,

    Hilb_D(t)=(2*t+t^2+...+t^m)/(1-t),

one has

    dim_C D_1=2,
    dim_C D_2=3.

Theorem H01_degree_three_residual_dimension:
  One has

    dim_C D_3 = 3  if m=2,
    dim_C D_3 = 4  if m>=3.

Proof:
  For m=2 the numerator is 2*t+t^2, so the cumulative coefficient in degree
  three is 2+1=3.

  For m>=3 the numerator contains 2*t+t^2+t^3, so the cumulative coefficient in
  degree three is 2+1+1=4.
Qed.

--------------------------------------------------------------------------
2. LINEAR SYZYGIES OF THE ORIGINAL FOUR QUADRICS
--------------------------------------------------------------------------

Let

    W:=Q_2,
    dim_C W=4.

Let

    sigma := dim_C ker(S_1 tensor_C W -> Q_3),

where the multiplication map sends a tensor l tensor q to l*q.

Thus sigma is exactly the number of independent linear first syzygies among the
four minimal quadratic generators of Q.

Since dim_C S_1=4 and dim_C W=4,

    dim_C(S_1 tensor W)=16.

Therefore

    dim_C Q_3=16-sigma.

Also

    dim_C P_3
      = dim_C S_3 - dim_C(S/P)_3
      = 20-4
      = 16.

Because D=P/Qsat,

    dim_C (Qsat)_3=16-dim_C D_3.

Put

    tau_3 := dim_C T_3.

Since T=Qsat/Q and Q_3 subset (Qsat)_3,

    tau_3
      = dim_C(Qsat)_3-dim_C Q_3
      = (16-dim D_3)-(16-sigma).

Theorem H01_exact_cubic_syzygy_identity:
  One has

    sigma = dim_C D_3 + tau_3.

Hence

    if m=2,   sigma=3+tau_3,
    if m>=3,  sigma=4+tau_3.
Qed.

Corollary H01_nonminimal_chain_forces_four_linear_syzygies:
  If m>=3, then

    sigma>=4.
Qed.

This conclusion is intrinsic to the original four-quadric ideal Q; it does not
come from a chosen presentation of Qsat.

--------------------------------------------------------------------------
3. THE DEGREE-THREE HILBERT VALUE OF B=S/Q
--------------------------------------------------------------------------

Since

    dim_C Q_3=16-sigma

and

    dim_C S_3=20,

one has

    dim_C B_3=4+sigma.

Thus

    B_0=1,
    B_1=4,
    B_2=6,
    B_3=4+sigma.

The H01 identities sharpen this to

    if m=2,
      B_3=7+tau_3,

    if m>=3,
      B_3=8+tau_3.

--------------------------------------------------------------------------
4. MACAULAY GROWTH GIVES sigma<=6
--------------------------------------------------------------------------

The standard Macaulay growth theorem applied to the standard graded algebra B
gives

    B_3 <= B_2^{<2>}.

Since

    B_2=6=binom(4,2),

its second Macaulay successor is

    6^{<2>}=binom(5,3)=10.

Therefore

    B_3<=10.

Using B_3=4+sigma gives:

Theorem H01_linear_syzygy_Macaulay_bound:
  One has

    sigma<=6.
Qed.

Consequently

    if m=2,  tau_3<=3,
    if m>=3, tau_3<=2.

--------------------------------------------------------------------------
5. THE MAXIMAL sigma=6 CASE HAS HEIGHT ONE
--------------------------------------------------------------------------

Assume

    sigma=6.

Then

    B_3=10=B_2^{<2>}.

Thus the Hilbert function of B has maximal Macaulay growth from degree two to
degree three.

The ideal Q is generated entirely in degree two.  Therefore the hypotheses of
standard Gotzmann persistence apply at degree two.

Theorem H01_sigma_six_forces_persistent_maximal_growth:
  If sigma=6, then for every n>=2,

    dim_C B_n = binom(n+2,2).

Proof:
  Gotzmann persistence propagates equality in Macaulay growth because Q has no
  generators above degree two.  Starting from

    B_2=binom(4,2),
    B_3=binom(5,3),

  the persistent successor sequence is

    B_n=binom(n+2,2).
Qed.

Corollary H01_sigma_six_has_dimension_three:
  If sigma=6, then B has Hilbert polynomial of degree two and hence

    dim B=3,
    ht(Q)=1.
Qed.

This contradicts the standing hypothesis ht(Q)=2.

Therefore:

Theorem H01_sigma_six_is_impossible:
  One has

    sigma<=5.
Qed.

--------------------------------------------------------------------------
6. EXACT CUBIC SPLIT FOR m>=3
--------------------------------------------------------------------------

Combine

    sigma=4+tau_3

with

    sigma<=5.

Theorem H01_nonminimal_chain_exact_cubic_split:
  If m>=3, exactly one of the following two cases occurs:

  H01-C4:
    sigma=4,
    tau_3=0,
    Q_3=(Qsat)_3.

  H01-C5:
    sigma=5,
    tau_3=1,
    dim_C((Qsat)_3/Q_3)=1.

No third cubic case occurs.
Qed.

Interpretation:
  Every nonminimal H01 chain is already extremal in degree three.

  In H01-C4 the original four quadrics have four independent linear syzygies and
  saturation does not add a cubic.

  In H01-C5 the original four quadrics have five independent linear syzygies and
  saturation adds exactly one cubic class.

  The previously possible value tau_3=2 would force sigma=6 and therefore height
  one, so it is excluded.

--------------------------------------------------------------------------
7. THE MINIMAL m=2 CASE ALSO BECOMES FINITE
--------------------------------------------------------------------------

For completeness, if m=2 then

    sigma=3+tau_3

and sigma<=5.  Hence

    tau_3 in {0,1,2},
    sigma in {3,4,5}.

Thus even the minimal H01 chain has only three cubic states.

No claim is made here that all three are realizable.

--------------------------------------------------------------------------
8. WHAT THE SYZYGY COUNT DOES AND DOES NOT PROVE
--------------------------------------------------------------------------

The familiar product ideal

    (x,y)*(z,w)

has four independent linear syzygies and multiplicity two.  Thus H01-C4 has the
same cubic syzygy count as the already classified skew-line product endpoint.

However, the equality

    sigma=4

alone does not yet prove that Q is a product of two linear ideals.  Likewise,

    sigma=5

does not by itself identify the unique cubic saturation class.

Therefore this file does NOT promote the numerical resemblance to a geometric
classification.

The next missing object is now finite and explicit: classify the coefficient
matrices of four height-two quadrics of multiplicity one in the two cases

    sigma=4, tau_3=0,
    sigma=5, tau_3=1,

under the additional condition that their saturation has the H01 residual chain.

--------------------------------------------------------------------------
9. UPDATED H01 FRONTIER
--------------------------------------------------------------------------

NEWLY_REDUCED:
  q4_height2_multiplicity_one_depth_one_H01_linear_syzygy_identity.
  q4_height2_multiplicity_one_depth_one_H01_sigma_at_most_five.
  q4_height2_multiplicity_one_depth_one_H01_nonminimal_cubic_two_case.

EXACT_NONMINIMAL_CUBIC_FRONTIER:
  H01-C4: sigma=4, tau_3=0.
  H01-C5: sigma=5, tau_3=1.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove H01-C4 is the skew-line product.
  It does NOT prove H01-C5 is impossible.
  It does NOT close m>=3.
  It does NOT close H01.
  It does NOT close the multiplicity-one depth-one branch.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H00_tangent_closed.
  q4_height2_multiplicity_one_depth_one_H10_tangent_closed.
  q4_height2_multiplicity_one_depth_one_H11_empty.
  q4_height2_multiplicity_one_depth_one_H01_Artinian_chain_classified.
  q4_height2_multiplicity_one_depth_one_H01_nonminimal_cubic_two_case.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  In the nonminimal H01 chain m>=3, classify the two exact cubic cases

    H01-C4: sigma=4, tau_3=0,
    H01-C5: sigma=5, tau_3=1,

  using the coefficient matrix q_i=a_i*l1+b_i*l2.  Determine whether C4 forces
  the multiplicity-two product configuration and whether C5 can occur at height
  two with multiplicity one.

NEXT_ACTIONS:
  1. Stay only in H01 and m>=3.
  2. Treat H01-C5 first because it has the stronger five-syzygy hypothesis.
  3. Normalize one lowest-rank linear syzygy of the four quadrics.
  4. Test whether five independent linear syzygies force a common factor or a
     multiplicity-two unmixed part.
  5. Stop before H01-C4, tangent estimates, or q<=3.