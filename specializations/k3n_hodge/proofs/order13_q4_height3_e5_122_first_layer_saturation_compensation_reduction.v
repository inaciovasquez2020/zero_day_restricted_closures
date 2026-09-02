Standalone first-layer saturation-compensation reduction for the multiplicity-five
h=(1,2,2) subbranch of the homogeneous q=4, height-three order-13
low-multiplicity problem.

SCOPE:
  Continue only from

    order13_q4_height3_e5_122_cyclic_torsion_annihilator_reduction.v
    order13_q4_height3_e5_122_quadratic_predecessor_split_reduction.v

  in the ZERODIVISOR_QUADRATIC_LOWER case.

Retain

  C:=Cbar,
  X:=Ann_A(T),
  K_i:=(a,ell^i*b),
  G:=(a:b),
  Gsat:=G:ell^infinity=G:ell,

with a a quadratic zerodivisor, K_0=(a,b) m-primary, and

  eta_i:=dim_C X-dim_C Hom_C(K_i,X).

The preceding reduction proves

  eta_0<=13,
  eta_k>=17 for every tangent-gate candidate,
  G:ell=Gsat,
  G:ell^j=Gsat for j>=1,
  Delta_i<=0 for i>=2,

where

  Delta_i:=dim Hom_C(K_(i-1),X)-dim Hom_C(K_i,X).

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

The purpose of this file is one structural sharpening: replace the crude
first-layer bound Delta_1<=6 by the exact saturation-annihilator drop produced
when G is enlarged to Gsat.  The residual correction is then supported by at
most two degree-one saturation directions.

Put

  V_1:=K_0/K_1,
  N_0:=0:_X G,
  N_sat:=0:_X Gsat.

Theorem first_layer_is_the_unsaturated_cyclic_colon:
  The class of b generates V_1 and

    Ann_C(V_1)=(G,ell).

  Hence

    Hom_C(V_1,X) ~= 0:_X(G,ell).

Proof:
  This is the i=1 specialization of the exact delayed-layer annihilator in the
  preceding quadratic-predecessor reduction.
Qed.

Theorem ell_sends_N0_into_Nsat:
  Multiplication by ell gives a linear map

    ell:N_0 -> N_sat.

  Its kernel is

    0:_X(G,ell)=Hom_C(V_1,X).

Proof:
  If x is killed by G and c belongs to Gsat=G:ell, then ell*c belongs to G.
  Therefore

    c*(ell*x)=(ell*c)*x=0,

  so ell*x belongs to N_sat.

  The kernel consists exactly of those x killed by G and by ell, namely
  0:_X(G,ell).  Use the preceding cyclic identification.
Qed.

Apply Hom_C(-,X) to

  0 -> K_1 -> K_0 -> V_1 -> 0

and let

  partial_1:Hom_C(K_1,X)->Ext^1_C(V_1,X)

be the connecting map.

Theorem saturated_annihilator_supplies_explicit_first_layer_connecting_classes:
  For every y in N_sat define

    phi_y:K_1->X

  by

    phi_y(a)=0,
    phi_y(ell*b)=y.

  Then phi_y is well defined.  Its connecting class vanishes exactly when

    y belongs to ell*N_0.

  Consequently

    rank_C(partial_1)>=dim_C(N_sat/ell*N_0).

Proof:
  A relation

    p*a+q*ell*b=0

  forces

    q in (a:ell*b)
      =((a:b):ell)
      =G:ell
      =Gsat.

  Hence q*y=0 for y in N_sat, proving that phi_y is well defined.

  The connecting class of phi_y vanishes exactly when phi_y extends to a map
  K_0->X.  Such an extension must still send a to zero and may send b to some
  x in X.  The two necessary and sufficient conditions are

    ell*x=y,
    G*x=0.

  The second condition says x belongs to N_0.  Therefore extension is possible
  exactly for y in ell*N_0.

  Thus y |-> [partial_1(phi_y)] factors through an injection

    N_sat/ell*N_0 -> im(partial_1),

  which proves the rank bound.
Qed.

Theorem exact_first_layer_compensation_bound:
  One has

    Delta_1
      <=dim_C N_0-dim_C N_sat.

Proof:
  Exactness gives

    Delta_1
      =dim Hom_C(V_1,X)-rank(partial_1).

  By the theorem ell_sends_N0_into_Nsat,

    dim(ell*N_0)
      =dim N_0-dim Hom_C(V_1,X).

  Therefore

    dim(N_sat/ell*N_0)
      =dim N_sat-dim N_0+dim Hom_C(V_1,X).

  Substitute the preceding connecting-rank lower bound into the exact formula
  for Delta_1 and simplify.
Qed.

Corollary the_stable_first_layer_closes_immediately:
  If

    G=Gsat,

  then

    Delta_1<=0.

  Hence every delayed layer is nonpositive and

    eta_k<=eta_0<=13<17.

  Thus no tangent-gate candidate can have G already ell-saturated.
Qed.

We now isolate the finite saturation correction.

Put

  D:=Gsat/G.

The preceding quadratic-predecessor reduction proves that G and Gsat agree in
every degree at least two, while properness removes degree zero.  Hence D is
concentrated in degree one.

Theorem saturation_defect_is_a_socle_vector_space_of_dimension_at_most_two:
  One has

    m_C*D=0,
    dim_C D<=2.

Proof:
  If d represents a degree-one class of D and u has positive degree, then u*d
  has degree at least two.  Since G and Gsat agree from degree two onward,

    u*d belongs to G.

  Hence m_C kills D.

  Also Gsat is ell-saturated:

    Gsat:ell=Gsat.

  Since Gsat is proper, ell cannot belong to Gsat; otherwise 1 would belong to
  Gsat:ell=Gsat.  The h=(1,2,2) core has

    dim_C C_1=3.

  Therefore the proper linear subspace (Gsat)_1 does not contain ell and has
  dimension at most two.  Since D_1 is a quotient of (Gsat)_1,

    dim_C D<=2.
Qed.

Let

  r:=dim_C D in {0,1,2}

and choose degree-one representatives d_1,...,d_r in Gsat whose classes form a
basis of D.

Theorem saturation_annihilator_drop_embeds_into_r_socle_copies:
  The map

    Theta:N_0 -> Soc_C(X)^r,
    x |-> (d_1*x,...,d_r*x)

  has kernel N_sat.  Consequently

    N_0/N_sat injects into Soc_C(X)^r

and

    dim_C N_0-dim_C N_sat
      <=r*dim_C Soc_C(X).

Proof:
  For u in m_C, the product u*d_j has degree at least two and belongs to G.
  Since x in N_0 is killed by G,

    u*(d_j*x)=0.

  Thus every d_j*x lies in Soc_C(X).

  Because Gsat/G is generated by the displayed degree-one classes, an element
  x in N_0 is killed by every d_j exactly when it is killed by all of Gsat.
  Hence ker(Theta)=N_sat.
Qed.

For reference, the target has an exact six-dimensional parameter section
before the final cuts.

Theorem exact_parameter_section_of_the_torsion_annihilator:
  Put

    J:=Ann_B(T).

  Then

    Hilb_(J/ell*J)(t)=3*t+2*t^2+t^3,
    length_C(J/ell*J)=6.

Proof:
  The cyclic-torsion reduction gives

    B/J ~= C[z]/(z^3),
    Hilb_(B/J)=1+t+t^2.

  Combining

    Hilb_C=(1+2*t+2*t^2)/(1-t),
    Hilb_T=t+t^2+t^3,
    Hilb_B=Hilb_C+Hilb_T

  yields

    Hilb_J=(3*t+2*t^2+t^3-t^4)/(1-t).

  The refined general parameter from the preceding file satisfies

    0:_B ell=T_3.

  Since T_3 is contained in J, the kernel of ell on J is exactly T_3.  The
  multiplication exact sequence therefore gives

    Hilb_(J/ell*J)
      =(1-t)*Hilb_J+t*Hilb_(T_3)
      =3*t+2*t^2+t^3.
Qed.

Corollary socle_of_X_has_dimension_at_most_six:
  One has

    dim_C Soc_C(X)<=dim_C(0:_X ell)<=6.

Proof:
  The socle is killed by every positive-degree element, hence by ell.  The
  preceding quadratic-predecessor reduction already proves

    dim_C(0:_X ell)<=6.
Qed.

Theorem dangerous_candidate_requires_a_four_dimensional_saturation_annihilator_drop:
  Every zerodivisor-lower candidate satisfying the necessary order-13 tangent
  gate must satisfy

    dim_C N_0-dim_C N_sat>=4.

Proof:
  By definition,

    eta_k=eta_0+sum_(i=1)^k Delta_i.

  Every i>=2 has Delta_i<=0.  The exact first-layer compensation theorem gives

    Delta_1<=dim N_0-dim N_sat,

  while the preceding quadratic baseline bound gives eta_0<=13.  Therefore

    eta_k<=13+dim N_0-dim N_sat.

  A tangent-gate candidate requires eta_k>=17, forcing the displayed lower
  bound four.
Qed.

Corollary finite_residual_split:
  A dangerous candidate must have r in {1,2}.

  If r=1, then

    dim_C Soc_C(X)>=4.

  If r=2, then

    dim_C Soc_C(X)>=2.

Proof:
  The case r=0 has G=Gsat and was already closed.  Combine the required
  four-dimensional annihilator drop with

    dim(N_0/N_sat)<=r*dim Soc_C(X).
Qed.

Interpretation:
  The crude independent estimate

    eta_0<=13,
    Delta_1<=6

  allowed eta_k<=19.

  The first delayed layer is now tied to the same colon saturation that creates
  it:

    Delta_1<=dim(0:_X G)-dim(0:_X Gsat).

  Therefore the only remaining danger is not an arbitrary six-dimensional
  ell-kernel.  It is a degree-one saturation defect of dimension at most two
  whose action must remove at least four dimensions from 0:_X G.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    dim(0:_X G)-dim(0:_X Gsat)<=3.

  Hence it does NOT close the full e=5, h=(1,2,2) branch.

  It does not classify the r=1 or r=2 degree-one saturation actions and makes
  no claim for other h-vectors, q=4 height two, homogeneous q<=3, the
  unrestricted nonhomogeneous frontier, or generic F_13 algebraicity.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  not e5_h122_height3_closed.

MISSING_OBJECT:
  In the zerodivisor quadratic predecessor, classify the degree-one saturation
  action

    D=(Gsat/G)_1,
    dim D in {1,2},

  on

    N_0=0:_X G.

  A dangerous candidate requires

    dim(N_0/N_sat)>=4,
    N_sat=0:_X Gsat.

NEXT_BOUNDED_OBJECT:
  Split r=1 and r=2.  Use the Artin parameter section

    C/ell*C,  h=(1,2,2),

  together with

    Hilb_(J/ell*J)=3*t+2*t^2+t^3

  to compute the possible degree-one maps D*N_0 -> Soc_C(X).  Prove the image
  has dimension at most three, or stop at the first explicit r=1 or r=2 normal
  form whose annihilator drop reaches four.
