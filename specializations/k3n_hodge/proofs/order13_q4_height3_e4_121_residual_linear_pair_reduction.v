Standalone residual-linear-pair reduction for the multiplicity-four
h=(1,2,1) subbranch of the homogeneous q=4, height-three order-13
low-multiplicity problem.

SCOPE:
  Continue from

    order13_q4_height3_e345_exact_saturation_linkage_table.v
    order13_q4_height3_degree3_hvector_linkage_impossible.v
    order13_q4_height3_low_multiplicity_cyclic_connecting_reduction.v

  Work only with

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3,q4),
    B := S/Q,

  where q1,q2,q3,q4 are four linearly independent homogeneous quadrics,

    ht(Q)=3,
    e(B)=4,

  and, with

    T := H^0_m(B),
    Cbar := B/T,

  a general linear nonzerodivisor ell on Cbar has Artin-reduction h-vector

    h(Cbar/ell*Cbar)=(1,2,1).

  The exact saturation-linkage table gives

    Hilb_T(t)=t+2*t^2+t^3,
    length_C(T)=4,
    m_B^3*T=0.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

The purpose of this file is one structural reduction.  The h-vector
(1,2,1) is symmetric, but symmetry alone does NOT imply that the Artin
reduction is Gorenstein.  Therefore the principal-link argument used in the
previous e=5, h=(1,2,2) branch cannot be imported unconditionally.

Instead, this file computes the residual linkage pair exactly at the Hilbert
series level and splits according to whether the saturated hull is generated
by its unique linear class.  In the principal subbranch the torsion
annihilator quotient has exact length four and the tangent gate forces
connecting excess at least sixteen.  In the nonprincipal subbranch the first
new object is a strict annihilator enlargement of the unique linear class.

Retain the three-quadric complete-intersection section model

  R := S/(q1,q2,q3),
  q := image of q4 in R,
  J := q*R,
  B = R/J,
  U := saturation(J),
  Cbar = R/U,
  T = U/J.

Put

  K := 0:_R q.

The established linkage identities are

  U = 0:_R K,
  K = 0:_R U,
  K(2) ~= omega_Cbar,

and

  Hilb_R(t)=(1+t)^3/(1-t).

Theorem exact_e4_121_residual_Hilbert_series:
  One has

    Hilb_Cbar(t)
      =(1+2*t+t^2)/(1-t),

    Hilb_K(t)
      =(t+2*t^2+t^3)/(1-t),

    Hilb_(R/K)(t)
      =(1+2*t+t^2)/(1-t),

    Hilb_U(t)
      =(t+2*t^2+t^3)/(1-t).

  In particular

    dim_C K_1=dim_C U_1=1.

Proof:
  The selected h-vector gives

    Hilb_Cbar(t)=(1+2*t+t^2)/(1-t).

  Canonical-module reciprocity gives

    Hilb_omega_Cbar(t)
      =t*(1+2*t^(-1)+t^(-2))/(1-t).

  Since K(2)~=omega_Cbar,

    Hilb_K(t)
      =t^2*Hilb_omega_Cbar(t)
      =(t+2*t^2+t^3)/(1-t).

  Subtracting from

    Hilb_R(t)=(1+3*t+3*t^2+t^3)/(1-t)

  yields

    Hilb_(R/K)(t)=(1+2*t+t^2)/(1-t).

  Finally U is the kernel of R->Cbar, so

    Hilb_U=Hilb_R-Hilb_Cbar
          =(t+2*t^2+t^3)/(1-t).

  The coefficient of t in each of Hilb_K and Hilb_U is one.
Qed.

Choose nonzero linear forms

  u in K_1,
  v in U_1.

They are unique up to nonzero scalar.

Corollary the_unique_residual_linear_classes_annihilate_each_other:
  One has

    u*v=0 in R.

Proof:
  Since U=0:_R K, every element of U annihilates every element of K.
  Apply this to u and v.
Qed.

Theorem K_is_saturated_and_C0_is_one_dimensional_CohenMacaulay:
  Put

    C0 := R/K.

  Then K is saturated and C0 is one-dimensional Cohen--Macaulay with

    Hilb_C0(t)=(1+2*t+t^2)/(1-t).

Proof:
  Suppose x is homogeneous and some power of the irrelevant ideal sends x
  into K.  Choose a linear nonzerodivisor lambda on the one-dimensional
  complete intersection R.  For sufficiently large n,

    lambda^n*x belongs to K=0:_R U.

  Thus for every y in U,

    lambda^n*x*y=0.

  Since lambda is R-regular, multiplication by lambda^n is injective, hence

    x*y=0

  for every y in U.  Therefore

    x belongs to 0:_R U=K.

  So K is saturated.  The preceding Hilbert series shows dim(C0)=1.
  Saturation removes H^0_m(C0), so depth(C0)>=1 and C0 is Cohen--Macaulay.
Qed.

We now make the exact dichotomy.

CASE PRINCIPAL_U:
  Assume

    U=v*R.

Theorem principal_U_identifies_the_residual_annihilator:
  In CASE PRINCIPAL_U,

    K=0:_R v,

  and multiplication by v induces a graded isomorphism

    C0(-1) ~= U.

Proof:
  Since U=vR,

    0:_R U = 0:_R v.

  The linkage identity 0:_R U=K gives the first statement.  The multiplication
  map R->vR has kernel 0:_R v=K, giving the displayed isomorphism with the
  degree shift.
Qed.

Theorem principal_U_factors_the_fourth_quadric:
  In CASE PRINCIPAL_U there exists a homogeneous linear form

    c in R_1

  such that

    q=v*c.

  The image of c in C0 is a nonzerodivisor.

Proof:
  The principal ideal J=qR is contained in U=vR.  Since q has degree two and v
  has degree one, q=v*c for some c in R_1.

  Under C0(-1)~=vR,

    T=U/J
      ~= (C0/c*C0)(-1).

  The exact torsion table gives

    Hilb_T=t+2*t^2+t^3,

  hence

    Hilb_(C0/c*C0)=1+2*t+t^2.

  This quotient is finite-dimensional.  Since C0 is one-dimensional
  Cohen--Macaulay, the homogeneous parameter c is a nonzerodivisor.
Qed.

Corollary exact_principal_U_torsion_module:
  In CASE PRINCIPAL_U,

    T ~= (C0/c*C0)(-1),

  where C0/c*C0 is a standard graded Artin algebra of length four and Hilbert
  function

    (1,2,1).

  No Gorenstein or uniqueness assertion for this Artin algebra is made.
Qed.

Theorem exact_principal_U_torsion_annihilator_in_B:
  In CASE PRINCIPAL_U,

    Ann_B(T)
      =(K+cR)/(v*c*R),

    B/Ann_B(T)
      ~= R/(K,c)
      ~= C0/c*C0,

  and therefore

    length_C(B/Ann_B(T))=4.

Proof:
  Write B=R/(v*c).  An element r modulo v*c annihilates

    T=vR/v*cR

  exactly when r*v belongs to v*cR.

  Under the isomorphism R/K -> vR, this is equivalent to

    r mod K belongs to c*(R/K),

  namely r belongs to K+cR.  This proves the annihilator formula.  Quotienting
  B by it gives R/(K,c)=C0/cC0, whose Hilbert function is (1,2,1) and whose
  length is four.
Qed.

Return to the two final homogeneous cuts.  Put

  L:=(f,g)B,
  A:=B/L,
  N:=length_C(A).

Corollary final_cuts_annihilate_the_e4_121_torsion:
  One has

    L*T=0,
    L subseteq Ann_B(T).

Proof:
  The exact linkage table gives m_B^3*T=0, while deg(f),deg(g)>=3.
Qed.

In CASE PRINCIPAL_U define the A-module

  X:=Ann_A(T).

Here T is regarded as an A-module through B->A, which is valid because L*T=0.

Theorem principal_U_exact_annihilator_size_after_final_cuts:
  In CASE PRINCIPAL_U,

    X=Ann_B(T)/L,

    A/X ~= B/Ann_B(T),

  and

    dim_C X=N-4.

Proof:
  Since L annihilates T, annihilators descend exactly through B->A.  The
  quotient by the descended annihilator is unchanged.  The preceding theorem
  gives length(B/Ann_B(T))=4.
Qed.

Choose an invertible constant change of the final generators

  L=(h,k)

such that the images hbar,kbar in Cbar are both nonzerodivisors, as in the
general cyclic connecting reduction.  Put

  D:=0:_B h,
  E:=0:_B k.

Theorem both_regularized_final_cuts_have_kernel_T:
  One has

    D=E=T.

Proof:
  Since h,k have degree at least three, they annihilate T.  Conversely, if
  h*x=0, projection to Cbar gives hbar*xbar=0.  Regularity of hbar forces
  xbar=0, hence x belongs to T.  Thus D=T.  The proof for k is identical.
Qed.

Put

  Hh:=hB,
  M:=L/Hh.

In CASE PRINCIPAL_U define

  sigma:=rank_C(partial),
  epsilon:=sigma-dim_C Hom_B(M,A),

for the connecting map in the exact sequence obtained from

  0 -> hB -> L -> M -> 0.

Theorem principal_U_exact_connecting_dimension_formula:
  In CASE PRINCIPAL_U,

    dim_C Hom_B(L,A)=N-4-epsilon.

Proof:
  Since 0:_B h=T, multiplication by h identifies

    hB ~= B/T.

  Therefore

    Hom_B(hB,A)
      ~= Ann_A(T)
      =X.

  Applying Hom_B(-,A) to 0->hB->L->M->0 and taking dimensions gives

    dim Hom_B(L,A)
      =dim X+dim Hom_B(M,A)-sigma
      =N-4-epsilon.
Qed.

Corollary principal_U_order13_tangent_gate_forces_excess_sixteen:
  In CASE PRINCIPAL_U, if the necessary order-13 tangent gate holds,

    dim_C Hom_S(I,A)<=N-20,

  then

    epsilon>=16.

Proof:
  Maps I->A vanishing on Q contain Hom_B(L,A), so

    dim Hom_S(I,A)>=dim Hom_B(L,A)=N-4-epsilon.

  Combining with the tangent gate gives

    N-4-epsilon<=N-20,

  hence epsilon>=16.
Qed.

Finally let

  Kh:=(h:k),
  P:=Kh/(T+hB).

The general cyclic connecting reduction gives

  M ~= B/Kh,
  Hom_B(M,A) ~= 0:_A Kh,

and

  epsilon
    <= dim_C Hom_A(P,A)
       - dim_C(0:_A Kh).

Corollary principal_U_dangerous_candidate_requires_carrier_excess_sixteen:
  In CASE PRINCIPAL_U every candidate satisfying the necessary tangent gate
  must satisfy

    dim_C Hom_A(P,A)
      - dim_C(0:_A Kh)
      >=16.
Qed.

We now isolate the genuinely new alternative.

CASE NONPRINCIPAL_U:
  Assume

    U != v*R.

Theorem nonprincipal_U_is_equivalent_to_strict_linear_annihilator_enlargement:
  In CASE NONPRINCIPAL_U,

    K is a proper subset of 0:_R v.

  Conversely, if

    0:_R v=K,

  then U=vR.

Proof:
  Always K=0:_R U is contained in 0:_R v because v belongs to U.

  Suppose equality held.  Then multiplication by v would give

    vR ~= (R/K)(-1).

  Hence

    Hilb_(vR)
      =t*Hilb_(R/K)
      =(t+2*t^2+t^3)/(1-t).

  But this is exactly Hilb_U from the first theorem.  Since vR is contained in
  U and the two graded modules have identical Hilbert series, vR=U,
  contradicting CASE NONPRINCIPAL_U.

  The converse is the same argument read forward.
Qed.

Define the strict annihilator defect

  H_v := (0:_R v)/K.

Corollary nonprincipal_U_has_a_nonzero_residual_annihilator_defect:
  In CASE NONPRINCIPAL_U,

    H_v != 0.

  Moreover

    Hilb_(U/vR)(t)=t*Hilb_(H_v)(t).

Proof:
  Nonvanishing is the preceding theorem.

  Multiplication by v gives

    Hilb_(vR)
      =t*(Hilb_R-Hilb_(0:_R v)).

  On the other hand the exact residual Hilbert computation gives

    Hilb_U
      =t*(Hilb_R-Hilb_K).

  Subtracting yields

    Hilb_(U/vR)
      =t*(Hilb_(0:_R v)-Hilb_K)
      =t*Hilb_(H_v).
Qed.

Corollary exact_principal_or_annihilator_defect_split:
  Every e=4, h=(1,2,1) height-three candidate lies in exactly one of the
  following two structural alternatives:

  PRINCIPAL_U:
    U=vR,
    q=v*c,
    T~=(C0/cC0)(-1),
    length(B/Ann_B(T))=4,
    and a dangerous order-13 candidate requires connecting carrier excess
    at least sixteen;

  NONPRINCIPAL_U:
    H_v=(0:_R v)/K is nonzero,
    and
    Hilb(U/vR)=t*Hilb(H_v).
Qed.

Interpretation:
  The symmetric h-vector (1,2,1) does not justify a Gorenstein shortcut.
  What linkage does force is a unique linear class on each side of the
  residual pair and an exact principal-versus-extra-annihilator dichotomy.

  The principal saturated-hull subbranch now has the same kind of exact
  annihilator control as the earlier e=5, h=(1,2,2) branch, with quotient
  length four and required connecting excess sixteen.

  The nonprincipal subbranch has been reduced to one concrete new module:

    H_v=(0:_R v)/K.

  Any further progress must classify or bound this strict annihilator defect;
  it is not legitimate to assume it vanishes merely from the h-vector.

IMPORTANT_NONCONCLUSION:
  This file does NOT close e=4, h=(1,2,1).

  In particular it does not prove U is principal, does not classify H_v in the
  nonprincipal case, and does not prove the principal-U carrier excess is at
  most fifteen.

  It makes no claim for the remaining e=3 rows, q=4 height two, homogeneous
  q<=3, the unrestricted nonhomogeneous local deviation-two frontier, or
  generic F_13 algebraicity.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  not e4_h121_height3_closed.
  not q4_height3_low_multiplicity_tangent_closure.
  not full_order13_closure.

MISSING_OBJECT:
  In CASE NONPRINCIPAL_U, classify or sharply bound

    H_v=(0:_R v)/K,

  equivalently the nonzero quotient U/vR through

    Hilb(U/vR)=t*Hilb(H_v).

  In CASE PRINCIPAL_U, an alternative closure route is an upper bound fifteen
  on

    dim_C Hom_A(P,A)-dim_C(0:_A(h:k)).

NEXT_BOUNDED_OBJECT:
  Attack CASE NONPRINCIPAL_U first.  Determine the first nonzero graded piece
  of H_v and use the three-quadric complete-intersection Hilbert function to
  decide whether the extra annihilator can begin in degree one, degree two,
  or only degree three.  Stop at the first realizable residual-annihilator
  profile rather than moving to e=3.