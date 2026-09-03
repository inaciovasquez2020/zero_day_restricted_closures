Standalone saturated-incidence classification of the exact H00 endpoint in the
homogeneous q=4, height-two multiplicity-one, depth-one order-13 deviation-two
program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H00_residual_module_classification.v

  and retain

    S := C[x1,x2,x3,x4],
    P := (l1,l2),
    Q subset Qsat subset P,
    D := P/Qsat,

in the exact H00 state

    (u1,u2)=(0,3),
    Hilb_D(t)=2*t/(1-t),
    dim_C D_n=2 for n>=1.

The preceding file classifies the abstract graded S-module D into exactly three
module types:

  H00-P2:
    two copies of one point module;

  H00-P1P1:
    two distinct point modules;

  H00-J2:
    the unique Jordan self-extension of one point module by itself.

The present file performs one bounded task only: impose the distinguished
quotient presentation

    D=P/Qsat

and recover every possible saturated ideal Qsat up to graded linear coordinate
change.  The original four-dimensional quadratic subspace Q_2 is NOT used yet.
No tangent estimate is made.  H01 and H11 are not entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE DISTINGUISHED P-GENERATORS SATISFY AN INTRINSIC COMMUTATIVITY RELATION
--------------------------------------------------------------------------

Because u1=0 one has

    (Qsat)_1=0.

Hence the quotient map P -> D identifies

    P_1 ~= D_1.

For p in P_1 write pbar for its class in D_1.

Theorem H00_distinguished_generator_relation:
  For every p,q in P_1,

    p*qbar = q*pbar

in D_2.

Proof:
  Both sides are the class of the same quadratic product p*q in P/Qsat.
Qed.

This relation is the extra constraint absent from the preceding abstract module
classification.  It determines how the fixed two-plane P_1 may meet the point
or double-point annihilator support.

--------------------------------------------------------------------------
2. TYPE H00-P2 FORCES ITS POINT TO LIE ON THE LINE P
--------------------------------------------------------------------------

Assume

    D ~= S/J(-1) direct_sum S/J(-1),

where J is a height-three linear prime.

Choose a linear form h not in J and identify S/J~=C[h].  The S_1-action on
D_1 is scalar through a linear character

    chi:S_1 -> C,
    ker(chi)=J.

Theorem H00_P2_forces_P_inside_J:
  One has

    P subset J.

Proof:
  Choose a basis p,q of P_1.  Under the scalar action the intrinsic relation is

    chi(p)*qbar = chi(q)*pbar.

  The vectors pbar,qbar form a basis of D_1.  Therefore both scalar coefficients
  must vanish:

    chi(p)=chi(q)=0.

  Thus p,q lie in J and P subset J.
Qed.

Theorem H00_P2_exact_saturated_ideal:
  One has

    Qsat=P*J.

Proof:
  Since J annihilates D=P/Qsat,

    J*P subset Qsat.

  Because P subset J, the standard presentation of P tensored with S/J has
  zero Koszul relation, so

    P/(P*J) ~= (S/J)(-1)^2.

  This has the same Hilbert series 2*t/(1-t) as D=P/Qsat.  The natural
  surjection

    P/(P*J) -> P/Qsat

therefore has zero kernel.  Hence Qsat=P*J.
Qed.

Corollary H00_P2_coordinate_normal_form:
  After a graded linear change of coordinates one may take

    S=C[x,y,z,w],
    P=(x,y),
    J=(x,y,z),

and then

    Qsat=(x^2,x*y,y^2,x*z,y*z).
Qed.

--------------------------------------------------------------------------
3. TYPE H00-P1P1 HAS EXACTLY THREE INCIDENCE RANKS
--------------------------------------------------------------------------

Assume

    D ~= S/J0(-1) direct_sum S/J1(-1),

with distinct height-three linear primes J0,J1.

Choose a common linear form h outside J0 union J1 and write

    S/Ji ~= C[h].

Let

    chi_i:S_1 -> C

be the corresponding normalized characters, with ker(chi_i)=Ji.

Choose generators e0,e1 for the two summands in degree one.  The distinguished
identification P_1~=D_1 gives two coordinate functionals

    c_i:P_1 -> C

by

    pbar=c_0(p)*e0+c_1(p)*e1.

Because P_1 -> D_1 is an isomorphism, c0,c1 form a basis of P_1^*.

Theorem H00_semisimple_restriction_proportionality:
  For i=0,1 there is a scalar lambda_i such that

    chi_i|_(P_1)=lambda_i*c_i.

Proof:
  Apply the intrinsic relation to p,q in P_1 and then project to the i-th point
  summand.  One obtains

    chi_i(p)*c_i(q)=chi_i(q)*c_i(p)

for all p,q.  Since c_i is nonzero, the two linear functionals are proportional.
Qed.

Rescale e_i when lambda_i is nonzero.  Thus each lambda_i may be normalized to

    epsilon_i in {0,1}.

Choose a basis l0,l1 of P_1 dual to c0,c1, so that

    l0bar=e0,
    l1bar=e1.

Then

    chi_0(l0)=epsilon_0,
    chi_0(l1)=0,
    chi_1(l0)=0,
    chi_1(l1)=epsilon_1.

Consequently

    l1 in J0,
    l0 in J1,

while

    l0 in J0 iff epsilon_0=0,
    l1 in J1 iff epsilon_1=0.

Thus epsilon_i=0 means the i-th point lies on the line P, and epsilon_i=1
means it lies off P.

Theorem H00_semisimple_exact_Qsat_formula:
  One has

    Qsat=l0*J0+l1*J1.

Proof:
  Define

    Phi:P -> S/J0(-1) direct_sum S/J1(-1)

by

    Phi(a*l0+b*l1)=(a mod J0,b mod J1).

  This is well-defined: changing the representation of an element of P by the
  Koszul relation (-l1,l0) changes the first coefficient by a multiple of l1,
  which lies in J0, and the second by a multiple of l0, which lies in J1.

  The map is surjective and agrees in degree one with the distinguished
  identification P_1~=D_1.  Its kernel consists exactly of those pairs with

    a in J0,
    b in J1,

so its kernel ideal inside P is l0*J0+l1*J1.  Therefore this kernel is Qsat.
Qed.

Up to swapping the two point summands, only the number

    r:=epsilon_0+epsilon_1 in {0,1,2}

matters.  It is the number of reduced residual points lying off P.

--------------------------------------------------------------------------
4. THE THREE SEMISIMPLE SATURATED NORMAL FORMS
--------------------------------------------------------------------------

Work in S=C[x,y,z,w] with P=(x,y).

CASE H00-P1P1-R2: both points off P.

Take

    J0=(y,z,w),
    J1=(x,z,w).

Then

    Qsat=x*J0+y*J1
        =(x*y,x*z,x*w,y*z,y*w).

CASE H00-P1P1-R1: exactly one point off P.

Take

    J0=(y,z,w),
    J1=(x,y,z).

Then

    Qsat=x*J0+y*J1
        =(x*y,x*z,x*w,y^2,y*z).

CASE H00-P1P1-R0: both points on P.

Take

    J0=(x,y,z),
    J1=(x,y,w).

Then

    Qsat=x*J0+y*J1
        =(x^2,x*y,x*z,y^2,y*w).

Theorem H00_semisimple_incidence_list_is_complete:
  Every distinguished H00-P1P1 quotient P/Qsat is, up to a graded linear
  coordinate change and exchange of the two point summands, exactly one of the
  three displayed normal forms.
Qed.

--------------------------------------------------------------------------
5. TYPE H00-J2: THE INTRINSIC RELATION HAS THREE POSSIBLE RANKS
--------------------------------------------------------------------------

Assume H00-J2.  Use the normalized abstract module from the preceding file:

    L:=Ann_S(D)_1,
    dim L=2,

and choose h,u so that

    S_1=L direct_sum C*h direct_sum C*u,

with degree-one generators e0,e1 satisfying

    u*e0=0,
    u*e1=h*e0,

and L killing both generators.

Equivalently, write the action as

    rho(x)=alpha(x)*Id+beta(x)*N,

where

    N(e0)=0,
    N(e1)=e0,
    N^2=0,

and

    alpha(h)=1,
    beta(u)=1,
    ker(alpha,beta)=L.

Choose a basis l0,l1 of P_1 whose classes are e0,e1 respectively.

Put

    alpha_i:=alpha(li),
    beta_i:=beta(li).

The intrinsic relation

    l0*l1bar=l1*l0bar

becomes

    rho(l0)e1=rho(l1)e0.

Theorem H00_Jordan_intrinsic_equations:
  One has

    alpha_0=0,
    beta_0=alpha_1.

Proof:
  The left side is

    alpha_0*e1+beta_0*e0,

while the right side is

    alpha_1*e0.

  Compare the independent e0,e1 coefficients.
Qed.

Therefore the image of P_1 under rho has rank exactly one of

    0,
    1,
    2.

These three ranks are invariant under the allowed coordinate and generator
changes and exhaust the Jordan incidence possibilities.

--------------------------------------------------------------------------
6. A UNIVERSAL JORDAN FORMULA FOR Qsat
--------------------------------------------------------------------------

The normalized Jordan module has relation module generated by

    L*e0,
    L*e1,
    u*e0,
    u*e1-h*e0.

Hence the distinguished map

    S(-1)^2 -> D,
    (a,b) |-> a*e0+b*e1

has kernel generated by

    L*S^2,
    (u,0),
    (-h,u).

Theorem H00_Jordan_exact_Qsat_formula:
  Under the identification e0=l0bar, e1=l1bar,

    Qsat=L*P + (u*l0, u*l1-h*l0).

Proof:
  Apply the natural map

    S(-1)^2 -> P,
    (a,b) |-> a*l0+b*l1

  to the displayed relation generators.  Their images are precisely

    L*P,
    u*l0,
    u*l1-h*l0.

  Every relation of D is generated by these, so every element of Qsat is
  generated by these images.  The reverse containment is immediate from the
  relations.
Qed.

--------------------------------------------------------------------------
7. THE THREE JORDAN SATURATED NORMAL FORMS
--------------------------------------------------------------------------

Again use S=C[x,y,z,w] and P=(x,y).

CASE H00-J2-R2: rho(P_1) has rank two.

Normalize

    l0=u=x,
    l1=h=y,
    L=(z,w).

The universal formula gives

    Qsat=(z,w)*(x,y)+(x^2)
        =(x^2,x*z,x*w,y*z,y*w).

The second Jordan relation u*l1-h*l0 is the intrinsic Koszul zero in this
normalization.

CASE H00-J2-R1: rho(P_1) has rank one.

Normalize

    l0=x in L,
    l1=u=y,
    L=(x,z),
    h=w.

Then

    Qsat=(x,z)*(x,y)+(y^2-w*x)
        =(x^2,x*y,x*z,y*z,y^2-w*x).

CASE H00-J2-R0: rho(P_1)=0.

Then P_1=L.  Normalize

    P=L=(x,y),
    u=z,
    h=w,
    l0=x,
    l1=y.

The universal formula gives

    Qsat=(x,y)^2+(z*x,z*y-w*x)
        =(x^2,x*y,y^2,x*z,y*z-w*x).

Theorem H00_Jordan_incidence_list_is_complete:
  Every distinguished H00-J2 quotient P/Qsat is, up to graded linear coordinate
  change and a compatible basis change of P_1=D_1, exactly one of the three
  displayed rank-two, rank-one, or rank-zero normal forms.
Qed.

--------------------------------------------------------------------------
8. ALL SEVEN NORMAL FORMS ARE SATURATED H00 CORES
--------------------------------------------------------------------------

The seven normal forms are:

  H00-P2:
    (x^2,x*y,y^2,x*z,y*z).

  H00-P1P1-R2:
    (x*y,x*z,x*w,y*z,y*w).

  H00-P1P1-R1:
    (x*y,x*z,x*w,y^2,y*z).

  H00-P1P1-R0:
    (x^2,x*y,x*z,y^2,y*w).

  H00-J2-R2:
    (x^2,x*z,x*w,y*z,y*w).

  H00-J2-R1:
    (x^2,x*y,x*z,y*z,y^2-w*x).

  H00-J2-R0:
    (x^2,x*y,y^2,x*z,y*z-w*x).

Theorem every_displayed_H00_normal_form_is_saturated:
  Each displayed ideal Qsat is saturated with respect to the homogeneous
  maximal ideal.

Proof:
  By construction each normal form fits into an exact sequence

    0 -> D -> S/Qsat -> S/P -> 0

with D one of the H00 residual modules classified above.

  Every H00 residual module D is one-dimensional Cohen--Macaulay, hence

    H^0_m(D)=0.

  Also S/P is a polynomial ring in two variables, so

    H^0_m(S/P)=0.

  The local-cohomology exact sequence therefore gives

    H^0_m(S/Qsat)=0.

  For a homogeneous ideal this is equivalent to

    Qsat^sat/Qsat=0.

  Hence Qsat is saturated.
Qed.

Theorem every_displayed_H00_normal_form_has_the_exact_H00_profile:
  For every displayed Qsat,

    Qsat subset P,
    (Qsat)_1=0,
    dim_C (Qsat)_2=5,
    D=P/Qsat has Hilbert series 2*t/(1-t),
    dim S/Qsat=2,
    e(S/Qsat)=1,
    depth_m(S/Qsat)=1.

Proof:
  The first four statements follow directly from the explicit five-quadratic
  presentations and the corresponding exact residual modules.

  The quotient S/P has dimension two and multiplicity one, while D has dimension
  one, so the exact sequence forces S/Qsat to have dimension two and
  multiplicity one.

  Finally local cohomology gives

    H^1_m(D) ~= H^1_m(S/Qsat)

because S/P has depth two.  The top local cohomology H^1_m(D) of the nonzero
one-dimensional Cohen--Macaulay module D is nonzero.  Hence S/Qsat has depth
exactly one.
Qed.

--------------------------------------------------------------------------
9. EXACT H00 SATURATED-INCIDENCE CLASSIFICATION
--------------------------------------------------------------------------

Theorem q4_H00_exact_saturated_incidence_classification:
  Let Qsat be a saturated homogeneous ideal with

    Qsat subset P=(l1,l2),
    (Qsat)_1=0,
    D=P/Qsat,
    Hilb_D(t)=2*t/(1-t),

in the H00 multiplicity-one depth-one branch.

  Then, up to graded linear coordinate change, Qsat is exactly one of the seven
  normal forms in Section 8.

No eighth incidence type occurs.

Proof:
  The preceding residual-module classification gives exactly H00-P2,
  H00-P1P1, or H00-J2.

  Section 2 gives one and only one distinguished P-incidence for H00-P2.

  Sections 3--4 show that H00-P1P1 is classified by the number of its two point
  characters nonzero on P, giving exactly ranks 0,1,2.

  Sections 5--7 show that H00-J2 is classified by rank rho(P_1), again giving
  exactly ranks 0,1,2.

  The exact Qsat formulas in each case produce the seven displayed ideals.
Qed.

Corollary H00_saturated_core_is_quadratically_generated_by_five_quadrics:
  Every H00 saturated core Qsat is generated by exactly five independent
  quadrics.

Proof:
  Each of the seven normal forms is visibly generated by five independent
  quadrics and has no linear generator.  The classification is exhaustive.
Qed.

This is consistent with the already established H00 value u2=3, which gives

    dim_C (Qsat)_2=5.

--------------------------------------------------------------------------
10. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_CLASSIFIED:
  q4_height2_multiplicity_one_depth_one_H00_saturated_incidence_seven_types.
  q4_height2_multiplicity_one_depth_one_H00_Qsat_five_quadrics.

IMPORTANT_NONCONCLUSION:
  This file classifies Qsat, not the original four-quadric ideal Q.

  It does NOT yet choose the four-dimensional hyperplane

    Q_2 subset (Qsat)_2,
    dim Q_2=4,
    dim (Qsat)_2=5.

  It does NOT prove which hyperplanes Q_2 saturate back to the displayed Qsat.
  It does NOT classify T=Qsat/Q beyond the already known low-degree start

    T_1=0,
    dim T_2=1.

  It does NOT make a tangent-space estimate.
  It does NOT enter H01, H11, or q<=3.
  It does NOT close H00, the multiplicity-one branch, q=4 height two, or full
  order 13.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H10_tangent_closed.
  q4_height2_multiplicity_one_depth_one_H00_residual_module_classified.
  q4_height2_multiplicity_one_depth_one_H00_saturated_incidence_classified.
  not q4_height2_multiplicity_one_depth_one_H00_fourplane_classified.
  not q4_height2_multiplicity_one_depth_one_H00_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  For each of the seven exact H00 saturated normal forms, classify the
  four-dimensional hyperplanes

    Q_2 subset (Qsat)_2

  for which the ideal Q=(Q_2) has height two and saturation exactly Qsat.

NEXT_ACTIONS:
  1. Stay only in H00.
  2. Use dim(Qsat)_2=5 and dim Q_2=4.
  3. Classify saturation-valid hyperplanes Q_2 for the seven normal forms.
  4. Determine the resulting cyclic degree-two saturation defect T.
  5. Stop before tangent estimates, H01, or H11.
