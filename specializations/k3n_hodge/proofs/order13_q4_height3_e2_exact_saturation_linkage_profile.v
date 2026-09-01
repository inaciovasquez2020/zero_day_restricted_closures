Standalone exact saturation-defect profile for the multiplicity-two height-three
subbranch of the homogeneous q=4 order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_four_quadric_height_split.v
    order13_q4_height3_low_multiplicity_saturated_core_profile.v
    order13_q4_height3_e2_rank_two_core_reduction.v
    order13_q4_height3_e2_regular_lower_connecting_reduction.v

  Work only with

    S := C[x1,x2,x3,x4],
    I := Q+(f,g),
    B := S/Q,
    e(B)=2,
    ht(Q)=3,

  where Q is generated minimally by four independent quadrics.

  Put

    T := H^0_m(B),
    Cbar := B/T.

  The preceding e=2 reduction proves that Cbar has Artin-reduction h-vector

    (1,1)

  and is one of the two rank-two quadratic hypersurface algebras

    C[x,y]/(x*y)

  or

    C[ell,v]/(v^2).

  In particular

    Hilb_Cbar(t)=(1+t)/(1-t).

  Earlier files only needed the bounds

    dim T_1=2,
    dim T_2=4,
    dim T_3<=4,
    dim T_4<=1,
    T_n=0 for n>=5.

  This file computes T exactly by Gorenstein linkage inside the three-quadric
  complete-intersection section ring.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
does not assert generic F_13 algebraicity.

Retain the complete-intersection section model

  R := S/(q1,q2,q3),
  a := image of the fourth quadric,
  J := a*R,
  B = R/J.

Then R is a one-dimensional graded Gorenstein complete intersection with

  Hilb_R(t)=(1+t)^3/(1-t)

and canonical module

  omega_R ~= R(2).

Let

  K := 0:_R a,
  U := Jsat,

where Jsat is the homogeneous saturation of J in R.  Thus

  Cbar=R/U,
  T=U/J.

Theorem saturated_principal_hull_is_the_double_annihilator:
  One has

    U = 0:_R K.

Proof:
  Put V:=0:_R K.  Since a*K=0, one has J=aR subseteq V.

  First show V/J has finite length.  At every homogeneous prime p different
  from the irrelevant maximal ideal, R_p is zero-dimensional Gorenstein.  In a
  zero-dimensional Gorenstein local ring the annihilator involution satisfies

    0:(0:(a))=(a).

  Therefore

    V_p=J_p

  away from the irrelevant maximal ideal.  Hence V/J is supported only there,
  so V is contained in the saturation U.

  Conversely let x belong to U.  By saturation there is n such that

    m^n*x subseteq J.

  Choose a linear nonzerodivisor ell on the one-dimensional Cohen--Macaulay
  ring R.  Then for every k in K,

    ell^n*x*k belongs to J*K=0.

  Since ell is R-regular, so is ell^n, and therefore x*k=0 for every k in K.
  Hence x belongs to 0:_R K=V.

  Thus U=V.
Qed.

Theorem residual_annihilator_is_exactly_K:
  One has

    0:_R U = K.

Proof:
  The inclusion K subseteq 0:_R U follows from U=0:_R K.

  Conversely let x belong to 0:_R U.  Away from the irrelevant maximal ideal,
  zero-dimensional Gorenstein double-annihilator duality gives

    x in K_p.

  Hence the class of x modulo K is finite-length.  Therefore for some n,

    ell^n*x belongs to K,

  with ell the same R-regular linear form.  Multiplying by a gives

    ell^n*a*x=0.

  Regularity of ell implies a*x=0, so x belongs to K.
Qed.

Theorem K_is_the_shifted_canonical_module_of_the_rank_two_core:
  There is a graded isomorphism

    K(2) ~= omega_Cbar.

  Since Cbar is one of the two quadratic hypersurfaces above,

    omega_Cbar ~= Cbar.

  Consequently

    K ~= Cbar(-2).

Proof:
  The ring Cbar=R/U is one-dimensional Cohen--Macaulay, hence maximal
  Cohen--Macaulay over R.  Therefore its canonical module is

    omega_Cbar
      ~= Hom_R(Cbar,omega_R)
      ~= Hom_R(R/U,R(2))
      ~= (0:_R U)(2).

  The preceding theorem identifies 0:_R U with K, giving

    omega_Cbar ~= K(2).

  On the other hand the e=2 algebra classification writes Cbar as a quotient
  of a polynomial ring in two degree-one variables by one nonzero quadratic.
  Such a degree-two hypersurface has a-invariant zero, hence

    omega_Cbar ~= Cbar.

  Therefore K(2)~=Cbar, equivalently K~=Cbar(-2).
Qed.

Theorem exact_Hilbert_series_of_B:
  One has

    Hilb_B(t)
      = (1+t)^4 + t^4*Hilb_Cbar(t).

Proof:
  Multiplication by the quadratic a gives the exact graded sequence

    0 -> K(-2)
      -> R(-2)
      --a--> R
      -> B
      -> 0.

  Hence

    Hilb_B
      = (1-t^2)*Hilb_R + t^2*Hilb_K.

  Since

    Hilb_R=(1+t)^3/(1-t),

  the first term equals

    (1-t^2)*Hilb_R=(1+t)^4.

  The preceding canonical-linkage theorem gives

    Hilb_K=t^2*Hilb_Cbar.

  Substitution proves the formula.
Qed.

Theorem exact_multiplicity_two_saturation_defect:
  The saturation torsion has Hilbert series

    Hilb_T(t)=2*t+4*t^2+2*t^3.

  Equivalently,

    dim_C T_1=2,
    dim_C T_2=4,
    dim_C T_3=2,
    T_n=0 for n=0 or n>=4.

  In particular

    length_C(T)=8,
    T_4=0,
    m^3*T=0.

Proof:
  From

    0 -> T -> B -> Cbar -> 0

  one has

    Hilb_T=Hilb_B-Hilb_Cbar.

  Using

    Hilb_B=(1+t)^4+t^4*Hilb_Cbar

  gives

    Hilb_T
      =(1+t)^4-(1-t^4)*Hilb_Cbar.

  Since

    Hilb_Cbar=(1+t)/(1-t),

  one computes

    (1-t^4)*Hilb_Cbar
      =(1+t)*(1+t+t^2+t^3)
      =1+2*t+2*t^2+2*t^3+t^4.

  Subtracting this from

    (1+t)^4
      =1+4*t+6*t^2+4*t^3+t^4

  yields

    2*t+4*t^2+2*t^3.

  The annihilation m^3*T=0 follows because T starts in degree one and has no
  component in degree four or above.
Qed.

Corollary every_higher_cut_annihilates_T_in_the_e2_branch:
  Every homogeneous element of degree at least three annihilates T.

  In particular the two final generators satisfy

    f*T=0,
    g*T=0

  throughout the entire e=2 height-three branch, including both REGULAR_LOWER
  and ZERODIVISOR_LOWER.
Qed.

Corollary strengthened_one_core_active_degree_bound:
  In the already closed one-core-active e=2 subcase, if the unique core-active
  cut has degree n, then

    n>=12.

Proof:
  The rank-two core quotient by one regular homogeneous degree-n cut has length

    2*n.

  The exact torsion/core sequence gives

    N=2*n+kappa,
    0<=kappa<=length(T)=8.

  Since N>=32,

    2*n>=24,

  hence n>=12.
Qed.

Corollary strengthened_regular_lower_degree_bound:
  In the two-core-active REGULAR_LOWER case, the common degree d satisfies

    d>=13.

Proof:
  The preceding rank-two-core reduction proves

    length(Cbar/(fbar,gbar))=2*d-1.

  The embedded correction has length at most eight, so

    N <= (2*d-1)+8 = 2*d+7.

  Since N>=32, one has 2*d>=25 and therefore d>=13.
Qed.

Corollary strengthened_zerodivisor_lower_degree_sum:
  In the two-core-active ZERODIVISOR_LOWER case, with

    d:=deg(f)<=D:=deg(g),

  one has

    d+D>=25.

Proof:
  The preceding rank-two-core reduction proves the exact core length

    d+D-1.

  Adding at most length(T)=8 gives

    N<=d+D+7.

  Since N>=32, the claimed inequality follows.
Qed.

Interpretation:
  The multiplicity-two saturation defect is not an arbitrary finite module of
  length at most eleven.  Its graded vector-space profile is forced exactly:

    T : (2,4,2)

  in degrees one, two, and three.

  Thus every degree-three-or-higher final cut annihilates T automatically.  In
  the REGULAR_LOWER connecting reduction, the remaining uncertainty is no
  longer the size or top degree of T, but only the multiplication structure of
  this fixed eight-dimensional defect and its effect on

    N_T=Ann_A(T).

IMPORTANT_NONCONCLUSION:
  This file does NOT determine the Cbar-module multiplication structure on T.
  It therefore does NOT prove

    mu_A0(N_T)-socdim_A0(N_T)<=5

  and does not close REGULAR_LOWER.

  It also does not close ZERODIVISOR_LOWER, e=3,4,5, the q=4 height-two branch,
  homogeneous q<=3, or the unrestricted nonhomogeneous local frontier.

BOUNDARY:
  For e=2 one now has the exact finite defect

    Hilb_T(t)=2*t+4*t^2+2*t^3,
    length(T)=8,
    m^3*T=0.

  The first remaining REGULAR_LOWER object is the actual multiplication action
  of the rank-two saturated core on this fixed defect, equivalently the graded
  structure of

    N_T=Ann_A(T).

NEXT_BOUNDED_OBJECT:
  compute the degree-one multiplication maps

    Cbar_1*T_1 -> T_2,
    Cbar_1*T_2 -> T_3

  through the linkage presentation

    T=(0:_R(0:_R a))/(a).

  Use them to bound

    mu_A0(N_T)-socdim_A0(N_T).

  Stop at the first multiplication type for which this defect can reach six;
  otherwise close REGULAR_LOWER before moving to ZERODIVISOR_LOWER.
