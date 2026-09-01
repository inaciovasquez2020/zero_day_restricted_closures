Standalone connecting-map sharpening for the REGULAR_LOWER multiplicity-two
subbranch of the homogeneous q=4, height-three order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_q4_height3_low_multiplicity_conormal_rank_reduction.v
    order13_q4_height3_low_multiplicity_cyclic_connecting_reduction.v
    order13_q4_height3_e2_rank_two_core_reduction.v

  Work only in the multiplicity-two REGULAR_LOWER case.  Thus

    S := C[x1,x2,x3,x4],
    I := Q+(f,g),
    B := S/Q,
    T := H^0_m(B),
    Cbar := B/T,
    e(B)=2,

  and after the preceding reduction the two final homogeneous core-active cuts
  have one common degree

    d>=11.

  Their images span Cbar_d, equivalently

    (fbar,gbar)=ell^(d-1)*m_Cbar.

  The saturated core is exactly one of

    REDUCED_SPLIT:
      Cbar = C[x,y]/(x*y),

    DOUBLE_LINE:
      Cbar = C[ell,v]/(v^2).

  As in the cyclic-connecting reduction, keep a core-regular first generator h
  and replace the second generator by k+lambda*h if necessary so that both hbar
  and kbar are nonzerodivisors on Cbar.  Because the two original cuts have the
  same degree, this triangular normalization remains homogeneous of degree d
  and preserves L=(h,k), hB, the colon K=(h:k), and the connecting map.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
it does not assert generic F_13 algebraicity.

The purpose of this file is to compute the saturated-core connecting map
exactly and then isolate the only possible positive correction in one finite
annihilator module attached to the embedded torsion.

Put

  L := (h,k)B,
  A := B/L,
  D := 0:_B h,
  E := 0:_B k,
  K := (h:k),
  M := L/hB ~= B/K.

Recall from the cyclic reduction that

  epsilon := rank(partial)-dim_C Hom_B(M,A),

and every dangerous order-13 tangent-gate candidate must satisfy

  epsilon>=6.

Theorem high_equal_degree_cuts_annihilate_the_embedded_torsion:
  One has

    h*T=0,
    k*T=0,
    D=T,
    E=T.

Proof:
  The low-multiplicity profile gives

    m^4*T=0.

  Since d>=11, both homogeneous cuts lie in m^11, hence annihilate T.
  Therefore T is contained in both D and E.

  Conversely, if h*b=0 in B, then modulo T one has

    hbar*bbar=0

  in the one-dimensional Cohen--Macaulay core Cbar.  The chosen hbar is a
  nonzerodivisor, so bbar=0 and b belongs to T.  Thus D=T.  The same argument
  for the regularized kbar gives E=T.
Qed.

Corollary the_final_ideal_does_not_meet_T:
  One has

    L intersect T=0.

  Hence there is an exact sequence

    0 -> T -> A -> A0 -> 0,

  where

    A0 := Cbar/(hbar,kbar).

Proof:
  The ideal L is homogeneous and generated in degree d>=11, so every nonzero
  homogeneous element of L has degree at least eleven.  The embedded torsion T
  is concentrated in degrees one through four.  Therefore their intersection
  is zero.
Qed.

We now compute the core colon.

Theorem regular_lower_core_colon_is_the_maximal_ideal:
  Put

    Kbar := (hbar:kbar) in Cbar.

  Then

    Kbar=m_Cbar.

Proof:
  Treat the two possible core algebras separately.

  REDUCED_SPLIT:
    Write

      hbar=a*x^d+b*y^d,
      kbar=c*x^d+e*y^d.

    Regularity of both cuts gives

      a,b,c,e != 0,

    while linear independence gives

      Delta:=a*e-b*c != 0.

    Since x*y=0,

      x*kbar=(c/a)*x*hbar,
      y*kbar=(e/b)*y*hbar.

    Thus x and y belong to Kbar, so m_Cbar is contained in Kbar.

    On the other hand 1 does not belong to Kbar, because that would say
    kbar belongs to hbar*Cbar.  Since hbar and kbar have the same degree, the
    required coefficient would have degree zero, contradicting their linear
    independence.  The colon is homogeneous, hence no element with nonzero
    degree-zero part belongs to it.  Therefore Kbar=m_Cbar.

  DOUBLE_LINE:
    Write

      hbar=ell^(d-1)*(a*ell+b*v),
      kbar=ell^(d-1)*(c*ell+e*v),

    with

      a,c != 0,
      Delta:=a*e-b*c != 0.

    Direct multiplication gives

      ell*kbar
        = ((c/a)*ell+(Delta/a^2)*v)*hbar,

      v*kbar
        = (c/a)*v*hbar.

    Hence ell and v belong to Kbar, so again m_Cbar is contained in Kbar.
    As in the split case, 1 cannot belong to Kbar because hbar and kbar are
    linearly independent in the same degree.  Thus Kbar=m_Cbar.
Qed.

Theorem full_colon_is_the_homogeneous_maximal_ideal:
  One has

    K=m_B.

Proof:
  The preceding theorem identifies K modulo T with m_Cbar.  It remains to show
  that every core colon relation lifts exactly through the finite torsion.

  Let cbar be homogeneous of degree n in m_Cbar and suppose

    cbar*kbar=qbar*hbar.

  Lift cbar and qbar homogeneously to B.  The difference

    c*k-q*h

  belongs to T_(n+d).  But

    n+d>=d>=11

  while T_j=0 for j>=5.  Therefore the difference is zero in B and c belongs
  to K.

  Conversely every c in K maps to Kbar=m_Cbar.  Since T is contained in K by
  k*T=0, K is exactly the inverse image of m_Cbar under B->Cbar.  That inverse
  image is the homogeneous maximal ideal m_B.
Qed.

Corollary cyclic_quotient_is_the_residue_field:
  One has

    M ~= B/K ~= C.

  Consequently

    Hom_B(M,A) ~= Soc(A),

  where Soc(A)=0:_A m_B.
Qed.

Corollary the_colon_carrier_has_no_extra_T_piece:
  For

    P:=K/(E+hB),

  one has a natural A0-linear isomorphism

    P ~= m_Cbar/(hbar*Cbar).

  Moreover T annihilates P.

Proof:
  Use

    K=m_B,
    E=T.

  Quotienting m_B by T gives m_Cbar, and the image of hB is hbar*Cbar.  Hence

    P=m_B/(T+hB)
      ~=m_Cbar/(hbar*Cbar).

  Since T is killed in this quotient, the A-action factors through A/T=A0.
Qed.

We next compute the actual connecting class on the saturated core rather than
using only the larger Hom_A(P,A) carrier bound.

Let

  qbar:m_Cbar -> Cbar

be the core transport map characterized by

  c*kbar=qbar(c)*hbar.

In the split case it is

  qbar(x)=(c/a)*x,
  qbar(y)=(e/b)*y,

with

  c/a != e/b.

In the double-line case it is

  qbar(ell)=(c/a)*ell+(Delta/a^2)*v,
  qbar(v)=(c/a)*v,

with

  Delta/a^2 != 0.

Theorem saturated_core_connecting_map_has_rank_one:
  Suppose first that T=0, so A=A0 and D=E=0.  Then the connecting map

    partial_0:A0 -> Ext^1_Cbar(C,A0)

  has

    ker(partial_0)=m_A0,
    rank_C(partial_0)=1.

Proof:
  Under the cyclic presentation Cbar/m_Cbar, the class partial_0(z) is
  represented by

    c |-> qbar(c)*z,

  on m_Cbar.  It vanishes exactly when there is w in A0 such that

    c*w=qbar(c)*z

  for every c in m_Cbar.

  REDUCED_SPLIT:
    Put

      alpha:=c/a,
      beta:=e/b,

    so alpha!=beta.  The extension equations on the generators x,y are

      x*w=alpha*x*z,
      y*w=beta*y*z.

    Reducing these equations to degree one shows that if z has constant term
    z0 and w has constant term w0, then

      w0=alpha*z0,
      w0=beta*z0.

    Since alpha!=beta, z0=0.  Thus every element of the kernel lies in m_A0.

    Conversely if z belongs to m_A0, write

      z=x*u+y*v0.

    Set

      w=alpha*x*u+beta*y*v0.

    Because x*y=0, the two extension equations hold.  Hence every z in m_A0
    lies in the kernel.

  DOUBLE_LINE:
    Put

      p:=c/a,
      r:=Delta/a^2,

    so r!=0.  The extension equations are

      ell*w=(p*ell+r*v)*z,
      v*w=p*v*z.

    Comparing degree-one terms gives

      w0=p*z0

    from the second equation, and then the first equation forces

      r*z0=0.

    Since r!=0, z0=0.  Hence the kernel is contained in m_A0.

    Conversely, if z belongs to m_A0, write

      z=ell*u+v*v0.

    Define

      w=p*z+r*v*u.

    Using v^2=0 gives

      ell*w=(p*ell+r*v)*z,
      v*w=p*v*z.

    Thus m_A0 is contained in the kernel.

  In either core algebra

    ker(partial_0)=m_A0.

  Since A0/m_A0 is one-dimensional, rank(partial_0)=1.
Qed.

Theorem saturated_core_Hom_term_has_dimension_two:
  One has

    dim_C Hom_Cbar(C,A0)=dim_C Soc(A0)=2.

Proof:
  Again use the two normal forms.

  REDUCED_SPLIT:
    Since hbar,kbar span Cbar_d,

      A0 ~= C[x,y]/(x*y,x^d,y^d).

    Its socle has basis

      x^(d-1), y^(d-1).

  DOUBLE_LINE:
    Since hbar,kbar span Cbar_d,

      A0 ~= C[ell,v]/(v^2,ell^d,ell^(d-1)*v).

    Its socle has basis

      ell^(d-1), ell^(d-2)*v.

  Thus the socle dimension is two in both cases.  Since C=Cbar/m_Cbar,

    Hom_Cbar(C,A0)=Soc(A0).
Qed.

Corollary saturated_core_connecting_excess_is_minus_one:
  With no embedded torsion,

    epsilon_0
      = rank(partial_0)-dim Hom_Cbar(C,A0)
      = 1-2
      = -1.

  Therefore the saturated rank-two core itself cannot supply positive
  connecting excess.
Qed.

We now restore the actual embedded torsion T.

Define

  N_T := Ann_A(T)=0:_A T.

Because T is an ideal of A and N_T is killed by T, N_T is naturally an A0-module.

Theorem actual_connecting_domain_is_the_torsion_annihilator_module:
  Under D=T, the domain of the connecting map is exactly

    Ann_A(D)=N_T.

  Moreover

    Soc_A(A)=Soc_A0(N_T).

Proof:
  The first statement is the definition after D=T.

  Every socle element of A is killed by m_B, hence by T subseteq m_B, so it
  belongs to N_T.  Since T already annihilates N_T, being killed by the maximal
  ideal of A0 is equivalent on N_T to being killed by m_B.  Therefore the two
  socles agree.
Qed.

Theorem maximal_ideal_times_NT_lies_in_the_connecting_kernel:
  One has

    m_A0*N_T subseteq ker(partial).

Proof:
  The cyclic representative for z in N_T is again

    c |-> qbar(c)*z

  on K/T=m_Cbar; the T-part of K maps to zero because E=T.

  REDUCED_SPLIT:
    If

      z=x*u+y*v0

    in m_A0*N_T, put

      w=alpha*x*u+beta*y*v0

    with alpha=c/a and beta=e/b as above.  Then x*y=0 gives

      x*w=alpha*x*z,
      y*w=beta*y*z.

    Thus the representative extends to B by multiplication with w.  Since
    w belongs to N_T, the extension also vanishes on T as required.

  DOUBLE_LINE:
    If

      z=ell*u+v*v0,

    put

      w=p*z+r*v*u

    with p=c/a and r=Delta/a^2.  Then v^2=0 gives

      ell*w=(p*ell+r*v)*z,
      v*w=p*v*z.

    Again w belongs to N_T, so the representative extends across B and is zero
    in Ext^1.

  Hence every element of m_A0*N_T lies in the connecting kernel.
Qed.

Corollary connecting_rank_is_bounded_by_the_generator_number_of_NT:
  One has

    rank_C(partial)
      <= dim_C(N_T/m_A0*N_T)
      = mu_A0(N_T).
Qed.

Theorem dangerous_regular_lower_candidate_forces_generator_socle_defect_six:
  Any REGULAR_LOWER e=2 candidate satisfying the necessary order-13 tangent
  gate must satisfy

    mu_A0(N_T)-dim_C Soc_A0(N_T)>=6.

Proof:
  The tangent gate forces

    epsilon>=6.

  The preceding rank bound and M~=C give

    epsilon
      = rank(partial)-dim Hom_B(C,A)
      <= mu_A0(N_T)-dim Soc_A(A).

  The socle-identification theorem gives

    dim Soc_A(A)=dim Soc_A0(N_T).

  Therefore a dangerous candidate requires the displayed defect at least six.
Qed.

Interpretation:
  The finite Koszul-colon carrier P itself is not the remaining source of
  uncertainty in the REGULAR_LOWER multiplicity-two case.  Modulo T it has an
  exact rank-one connecting map and a two-dimensional cyclic Hom term, giving
  saturated-core excess -1.

  After restoring T, all possible positive excess is concentrated in the single
  finite A0-module

    N_T=Ann_A(T).

  A dangerous candidate would have to make this torsion-annihilator module have
  at least six more minimal generators than socle dimensions:

    mu_A0(N_T)-socdim_A0(N_T)>=6.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove that such a generator-socle defect is impossible.
  Therefore it does NOT close the REGULAR_LOWER e=2 case and does not close the
  full multiplicity-two branch.

  It also does not treat the ZERODIVISOR_LOWER e=2 normal form, e=3,4,5, the
  q=4 height-two branch, homogeneous q<=3, or the unrestricted nonhomogeneous
  local deviation-two frontier.

BOUNDARY:
  The first remaining object in the REGULAR_LOWER e=2 case is now

    N_T:=Ann_A(T)

  for the actual saturation-torsion module

    T=Qsat/Q,

  with

    dim T_1=2,
    dim T_2=4,
    dim T_3<=4,
    dim T_4<=1,
    m^4*T=0.

  One must either prove

    mu_A0(N_T)-socdim_A0(N_T)<=5,

  or construct a repository-native multiplicity-two four-quadric example for
  which the defect is at least six and then compute the actual connecting rank.

NEXT_BOUNDED_OBJECT:
  compute the graded multiplication action of the rank-two core maximal ideal
  on T and hence on N_T=Ann_A(T).  Use the complete-intersection section model

    T=Jsat/J

  to bound the minimal-generator minus socle defect.  Stop if the defect can
  reach six; otherwise close REGULAR_LOWER before moving to ZERODIVISOR_LOWER.
