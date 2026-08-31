Standalone Koszul-annihilator reduction for the Cohen--Macaulay endpoint of the
homogeneous q=4, height-three order-13 deviation-two branch.

SCOPE:
  This file starts from the height-three branch isolated in

    order13_homogeneous_four_quadric_height_split.v

  and treats only its maximal-multiplicity endpoint

    e(S/Q)=6.

  The preceding four-quadric multiplicity theorem says that this endpoint is
  Cohen--Macaulay.  The embedded-torsion cases e<=5 and the height-two
  four-quadric core are not treated here.

  The original generators f,g are homogeneous, but the regular-combination
  step below is local at the homogeneous maximal ideal and may replace them by
  a nonhomogeneous constant linear combination.  This does not change the
  local ideal (f,g), the Artin quotient, or its embedded tangent space.

This is pseudo-formal mathematical documentation.  It is not Coq and does not
assert generic F_13 algebraicity.

Setup:
  Let

    S := C[x1,x2,x3,x4],
    m := (x1,x2,x3,x4),

  let Q subset S be homogeneous, generated minimally by four independent
  quadrics, and assume

    ht(Q)=3,
    e(S/Q)=6.

  Put

    B := (S/Q)_m.

  By the maximal-multiplicity endpoint theorem already recorded on this
  branch, B is a one-dimensional Cohen--Macaulay local ring.

  Let f,g in m_B generate an m_B-primary ideal

    L := (f,g)B,

  and set

    A := B/L,
    N := length_C(A) >= 32.

  The order-13 repair route requires the necessary tangent gate

    t(A) := dim_C Hom_S(I,A) <= N-20,

  where I=Q+(f,g) before localization.

ExternalResult GeneralParameterInOneDimensionalCMRing:
  Let (B,m,k) be a one-dimensional Cohen--Macaulay local ring with infinite
  residue field k, and let L=(f,g) be m-primary.  A sufficiently general
  k-linear combination of f and g avoids every associated prime of B and is
  therefore a nonzerodivisor on B.

  This is the standard prime-avoidance/general-parameter lemma.

Theorem choose_regular_first_cut:
  After replacing the ordered generating pair (f,g) by another constant
  C-basis of the same two-generated ideal L, one may assume

    f is a nonzerodivisor on B.

Proof:
  Since L is m-primary, L is not contained in any minimal prime of B.  Because
  B is Cohen--Macaulay of dimension one,

    Ass(B)=Min(B).

  The residue field C is infinite, so a general C-linear combination of f and
  g avoids the finite union Ass(B).  Such a combination is a nonzerodivisor.
  Completing it to a GL_2(C) change of generators preserves L.
Qed.

Define

  C0 := B/(f),

and write again g for the image of g in C0.  Since f is a parameter and a
nonzerodivisor on the one-dimensional Cohen--Macaulay ring B, C0 is Artinian.
Moreover

  A = C0/(g).

Define the annihilator/Koszul defect

  D := 0:_(C0) g.

Theorem annihilator_defect_has_exact_length_N:
  D is naturally an A-module and

    length_C(D)=N.

Proof:
  Multiplication by g on the Artin ring C0 gives an exact sequence

    0 -> D -> C0 --g--> C0 -> A -> 0.

  Taking lengths yields

    length(D)=length(A)=N.

  Also fD=0 in C0 and gD=0 by definition, so the B-action on D factors
  through

    B/(f,g)=A.
Qed.

Let

  M := Syz_B(f,g)
     := { (a,b) in B^2 : a*f+b*g=0 }.

Theorem two_cut_syzygies_are_an_extension_of_D:
  There is a natural short exact sequence of B-modules

    0 -> B --kappa--> M --pi--> D -> 0,

  where

    kappa(c)=(-c*g,c*f)

  is the Koszul syzygy and

    pi(a,b)=b mod (f).

Proof:
  Since f is a nonzerodivisor, kappa is injective.

  If (a,b) is a syzygy, then modulo f one has

    b*g=0 in C0,

  so pi indeed lands in D.

  Conversely, if d in D is represented by b in B, then b*g lies in (f), say

    b*g=-a*f.

  Thus (a,b) belongs to M and maps to d, proving surjectivity.

  Finally, if pi(a,b)=0, write b=c*f.  The syzygy equation becomes

    (a+c*g)*f=0.

  Regularity of f gives a=-c*g, hence

    (a,b)=c*(-g,f)=kappa(c).

  Therefore ker(pi)=im(kappa).
Qed.

Theorem conormal_tangent_kernel_factors_through_D:
  There is an exact sequence of C-vector spaces

    0 -> Hom_B(L,A)
      -> A^2
      -> Hom_A(D,A),

  where no surjectivity at the right is asserted.

Proof:
  The presentation

    B^2 -> L,
    (u,v) |-> u*f+v*g

  has kernel M.  Applying Hom_B(-,A) identifies Hom_B(L,A) with the pairs in
  A^2 whose induced functional on M vanishes.

  Since f=g=0 in A, every A-valued functional coming from a pair in A^2 kills
  the Koszul submodule

    kappa(B)=B*(-g,f).

  Hence the restriction map

    A^2 -> Hom_B(M,A)

  factors through

    M/kappa(B) ~= D.

  Because both D and A are annihilated by (f,g), B-linear maps D->A are the
  same as A-linear maps.  Thus the factored target is Hom_A(D,A), and its
  kernel is precisely Hom_B(L,A).
Qed.

Corollary two_cut_conormal_lower_bound:
  One has

    dim_C Hom_B(L,A)
      >= 2*N - dim_C Hom_A(D,A).

Proof:
  Take dimensions in the preceding left-exact sequence.  The rank of the map

    A^2 -> Hom_A(D,A)

  is at most dim Hom_A(D,A).
Qed.

Theorem maps_killing_Q_contain_two_cut_conormal:
  There is a natural injection

    Hom_B(L,A) -> Hom_S(I,A),

  hence

    t(A) >= dim_C Hom_B(L,A).

Proof:
  The quotient I/Q is exactly the B-ideal L.  An S-linear map I->A that
  vanishes on Q factors uniquely through I/Q=L, and conversely every B-linear
  map L->A defines such an S-linear map.
Qed.

Theorem dangerous_e6_candidate_forces_large_annihilator_Hom:
  If the order-13 tangent gate holds,

    t(A) <= N-20,

  then necessarily

    dim_C Hom_A(D,A) >= N+20,

  where

    D=0:_(B/(f)) g

  has the same length N as A.

Proof:
  The preceding two bounds give

    N-20
      >= t(A)
      >= dim Hom_B(L,A)
      >= 2*N - dim Hom_A(D,A).

  Rearranging yields

    dim Hom_A(D,A) >= N+20.
Qed.

Corollary e6_endpoint_is_reduced_to_equal_length_annihilator_excess:
  The Cohen--Macaulay e=6 endpoint of the homogeneous q=4, height-three branch
  can pass the necessary order-13 tangent gate only if there exists an Artin
  principal-cut pair

    C0 --g--> C0,

  with

    A=C0/(g),
    D=0:_(C0)g,
    length(A)=length(D)=N>=32,

  and the exceptional module-theoretic inequality

    dim_C Hom_A(D,A) >= N+20.

  Thus the e=6 endpoint no longer requires an arbitrary two-generator
  conormal classification: it is reduced to an explicit equal-length
  annihilator-pair Hom excess.
Qed.

IMPORTANT_NONCONCLUSION:
  No universal upper bound

    dim Hom_A(D,A) < N+20

  is proved here.  In particular this file does NOT close the e=6 branch.

  It also does not apply to the e<=5 embedded-torsion height-three cases or to
  the height-two four-quadric core.

BOUNDARY:
  The first missing object in the e=6 endpoint is now exact:

    prove that every annihilator pair arising from the above four-quadric
    Cohen--Macaulay core satisfies

      dim Hom_A(D,A) < N+20,

    or construct one for which the reverse inequality holds and then compute
    the full tangent/semiregularity map.

NEXT_BOUNDED_OBJECT:
  exploit the Hilbert function and canonical-module structure of the
  multiplicity-six four-quadric Cohen--Macaulay core to control the Artin
  annihilator pair (A,D).  Stop rather than assuming a general bound for
  Hom_A(D,A).