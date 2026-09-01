Standalone saturated-core profile for the remaining low-multiplicity height-three
subbranch of the homogeneous q=4 order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_four_quadric_height_split.v

  after the multiplicity-six Cohen--Macaulay endpoint has been closed by the
  q4/e6 files.

  Work only with

    S := C[x1,x2,x3,x4],
    I subset S homogeneous and m-primary,
    A := S/I,
    mu(I)=6,
    length_C(A)=N>=32,

  with exactly four quadratic minimal generators.  Put

    Q := (I_2),
    ht(Q)=3,
    B := S/Q,
    I = Q+(f,g),
    deg(f),deg(g)>=3,

  and assume the remaining multiplicity range

    e := e(B) in {1,2,3,4,5}.

  Let

    T := H^0_m(B)=Qsat/Q,
    Cbar := B/T = S/Qsat.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
does not assert generic F_13 algebraicity.

The preceding height-split file proves that T is concentrated in degrees
1 through 4, hence

  m^4*T=0.

The purpose of this file is not to close the tangent gate.  It identifies the
canonical Cohen--Macaulay quotient Cbar exactly enough to replace the unbounded
higher degrees of f and g by degree-three data plus two integers.

Theorem saturated_quotient_is_one_dimensional_CohenMacaulay:
  Cbar has dimension one, is Cohen--Macaulay at the homogeneous maximal ideal,
  and

    e(Cbar)=e(B)=e.

Proof:
  Saturation removes H^0_m(B), so

    H^0_m(Cbar)=0.

  The finite-length quotient T does not change Krull dimension or the Hilbert
  polynomial, hence dim(Cbar)=1 and e(Cbar)=e(B).

  Since H^0_m(Cbar)=0, the homogeneous maximal ideal is not an associated prime
  of Cbar.  Thus depth_m(Cbar)>=1.  Because dim(Cbar)=1,

    depth_m(Cbar)=dim(Cbar)=1,

  so Cbar is Cohen--Macaulay.
Qed.

Retain the complete-intersection section model from the height-split file.
After changing the four-dimensional basis of Q_2, choose

  q1,q2,q3,a

with

  K := (q1,q2,q3)

regular, and put

  R := S/K,
  J := (a)R.

Then

  B=R/J,

and

  X:=Proj(R)

is a zero-dimensional complete intersection of three quadrics in P^3 of
length eight.  Moreover

  dim_C R_n = 8

for every n>=3, and

  R_n -> H^0(X,O_X(n))

is an isomorphism for every n>=3.

Put

  Jsat := saturation of J in R.

Then

  Cbar = R/Jsat.

Let

  Y:=Proj(Cbar) subseteq X.

Theorem saturated_low_multiplicity_core_stabilizes_in_degree_three:
  For every n>=3,

    dim_C Cbar_n = e.

Proof:
  The projective scheme Y is zero-dimensional of length e.  Therefore every
  invertible twist O_Y(n) has

    dim_C H^0(Y,O_Y(n))=e.

  For n>=3 the established map

    R_n -> H^0(X,O_X(n))

  is an isomorphism.  Under this identification, the degree-n part of the
  saturated ideal Jsat is exactly the subspace of sections vanishing on Y.

  On the zero-dimensional scheme X the exact sheaf sequence

    0 -> I_(Y/X)(n) -> O_X(n) -> O_Y(n) -> 0

  remains exact on global sections because H^1 of every coherent sheaf on X
  vanishes.  Hence

    (R/Jsat)_n ~= H^0(Y,O_Y(n))

  for n>=3.  The right-hand side has dimension e.
Qed.

Corollary a_Noether_parameter_is_an_isomorphism_from_degree_three_onward:
  Choose a general linear nonzerodivisor

    ell in Cbar_1.

  Then for every n>=3,

    ell : Cbar_n -> Cbar_(n+1)

  is a vector-space isomorphism.

Proof:
  Cbar is one-dimensional Cohen--Macaulay, so a general linear form avoids all
  associated primes and is a nonzerodivisor.  Multiplication by ell is
  therefore injective in every degree.

  For n>=3 both source and target have dimension e by the preceding theorem,
  so the injective map is an isomorphism.
Qed.

Put

  H := Cbar/ell*Cbar.

Theorem only_ten_linear_Artin_reductions_are_possible:
  H is a standard graded Artin C-algebra of length e<=5, concentrated in
  degrees 0 through 3.  Its Hilbert function must be one of the following ten
  shapes:

    e=1:  (1)

    e=2:  (1,1)

    e=3:  (1,2),
          (1,1,1)

    e=4:  (1,3),
          (1,2,1),
          (1,1,1,1)

    e=5:  (1,3,1),
          (1,2,2),
          (1,2,1,1).

Proof:
  Since ell is regular,

    Hilb_H(n)=dim Cbar_n-dim Cbar_(n-1).

  The preceding stabilization gives Hilb_H(n)=0 for n>=4.  Also H_0=C and
  H_1 has dimension at most three because Cbar_1 has dimension at most four.

  The Hilbert function of a standard graded Artin algebra is an O-sequence.
  Enumerating O-sequences of total length at most five, first entry one,
  degree-one entry at most three, and no support in degree four or above gives
  exactly the displayed list.  In particular, if H_1=1 then every later
  nonzero entry is at most one; and the usual Macaulay growth inequalities
  exclude all remaining unlisted shapes.
Qed.

Write the selected Hilbert vector as

  h=(1,h1,h2,h3),

allowing trailing zero entries.  Thus

  e=1+h1+h2+h3.

Corollary canonical_C_ell_module_profile:
  As a graded C[ell]-module,

    Cbar
      ~= C[ell]
         direct_sum C[ell](-1)^h1
         direct_sum C[ell](-2)^h2
         direct_sum C[ell](-3)^h3.

Proof:
  Since Cbar/ell*Cbar is finite-dimensional, Cbar is finite over C[ell].
  Regularity of ell makes Cbar torsion-free over the PID C[ell], hence free.

  A homogeneous basis of H lifts to a homogeneous C[ell]-basis of Cbar.  The
  number of basis elements in each degree is exactly the corresponding Hilbert
  entry of H, giving the displayed decomposition.
Qed.

Theorem finite_torsion_budget_from_the_h_vector:
  The finite saturation defect satisfies

    dim T_1 = 3-h1,
    dim T_2 = 5-h1-h2,
    dim T_3 <= 8-e,
    dim T_4 <= 8-e,

and therefore

    length_C(T)
      <= 24 - 2*e - 2*h1 - h2.

In particular the worst possible total torsion length at each multiplicity is

    e=1: length(T)<=22,
    e=2: length(T)<=18,
    e=3: length(T)<=15,
    e=4: length(T)<=13,
    e=5: length(T)<=9.

Proof:
  The four independent quadrics give

    dim B_0=1,
    dim B_1=4,
    dim B_2=6.

  From the C[ell]-profile,

    dim Cbar_1=1+h1,
    dim Cbar_2=1+h1+h2,
    dim Cbar_3=dim Cbar_4=e.

  Since

    0 -> T -> B -> Cbar -> 0

  is graded exact, the first two displayed equalities follow.

  Also B=R/(a), while dim R_3=dim R_4=8, so

    dim B_3<=8,
    dim B_4<=8.

  This gives the two upper bounds in degrees three and four.

  The preceding height-split theorem gives T_n=0 for n>=5 and T_0=0.  Summing
  degrees one through four yields

    length(T)
      <= (3-h1)+(5-h1-h2)+2*(8-e)
      = 24-2*e-2*h1-h2.

  Maximizing this expression over the ten allowed h-vectors gives the five
  numerical bounds displayed above.
Qed.

Now let

  d := deg(f),
  D := deg(g),

and after interchanging f and g assume

  3<=d<=D.

Let

  fbar,gbar in Cbar

be their images.  Because A=B/(f,g) has finite length, the ideal

  Lbar := (fbar,gbar) in Cbar

is m-primary.

Put

  r:=d-3>=0,
  k:=D-d>=0.

Theorem all_higher_degree_cuts_factor_through_degree_three:
  There exist unique

    alpha,beta in Cbar_3

such that

    fbar = ell^r * alpha,
    gbar = ell^(r+k) * beta.

Consequently

    Lbar = ell^r * J_k,

where

    J_k := (alpha,ell^k*beta).

Moreover J_k is m-primary.

Proof:
  Multiplication

    ell^(n-3): Cbar_3 -> Cbar_n

  is an isomorphism for every n>=3.  Apply it in degrees d and D to obtain the
  unique alpha and beta.

  The displayed ideal factorization is immediate.

  If J_k were contained in a nonmaximal prime P, then because ell is a
  nonzerodivisor it avoids every minimal prime, and

    ell^r*J_k=Lbar

  would also be contained in P.  This contradicts the fact that Cbar/Lbar is
  finite-dimensional, hence Lbar is m-primary.  Therefore J_k is m-primary.
Qed.

Theorem exact_Noether_parameter_length_peel_on_the_saturated_core:
  One has

    length_C(Cbar/Lbar)
      = e*r + length_C(Cbar/J_k).

Proof:
  Since J_k is m-primary, Cbar/J_k has finite length.  Hence J_k has the same
  C[ell]-rank e as Cbar.  It is a graded C[ell]-submodule of the torsion-free
  module Cbar, so it is itself free of rank e.

  From

    ell^r*J_k subseteq J_k subseteq Cbar

  there is an exact sequence

    0 -> J_k/ell^r*J_k
      -> Cbar/ell^r*J_k
      -> Cbar/J_k
      -> 0.

  A free C[ell]-module of rank e has quotient by ell^r of length e*r.
  Since Lbar=ell^r*J_k, the claimed formula follows.
Qed.

Finally return from the saturated core to the original Artin quotient A.

Put

  kappa := length_C(T/(T intersect (f,g)B)).

Theorem exact_original_length_decomposition:
  There is a short exact sequence

    0 -> T/(T intersect (f,g)B)
      -> A
      -> Cbar/Lbar
      -> 0.

Consequently

    N
      = e*r + length_C(Cbar/J_k) + kappa,

with

    0<=kappa<=length_C(T)
      <=24-2*e-2*h1-h2.

Proof:
  Quotient the exact sequence

    0 -> T -> B -> Cbar -> 0

  by the ideal L=(f,g)B.  The kernel of

    B/L -> Cbar/Lbar

  is

    (T+L)/L ~= T/(T intersect L).

  This gives the short exact sequence and the first length identity.  The
  upper bound on kappa is immediate from the previous torsion theorem.
Qed.

Interpretation:
  The low-multiplicity height-three q=4 branch no longer has an unbounded
  graded core.

  After removing the finite saturation defect, every candidate is controlled
  by

    * one of ten Artin-reduction h-vectors of total length e<=5;
    * two degree-three elements alpha,beta in Cbar_3;
    * the two integers r>=0 and k>=0;
    * one finite embedded correction kappa bounded by the explicit h-vector
      torsion budget above.

  All dependence on arbitrarily large degrees d and D is isolated in the
  powers ell^r and ell^k.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove the order-13 tangent gate impossible in the
  multiplicity range e<=5.

  It does not identify Hom_B((f,g),A), does not prove that the torsion
  correction kappa is harmless for the conormal module, and does not transfer
  the e=6 Bockstein compensation theorem automatically to Cbar.

  The q=4 height-two branch, homogeneous q<=3 branches, and unrestricted
  nonhomogeneous local deviation-two frontier are untouched.

BOUNDARY:
  The first missing object in the q=4, ht(Q)=3, e<=5 branch is now the conormal
  effect of

    J_k=(alpha,ell^k*beta)

  on one of the ten rank-e C[ell]-free saturated cores, together with the
  bounded embedded extension

    0 -> T/(T intersect L) -> A -> Cbar/ell^r*J_k -> 0.

NEXT_BOUNDED_OBJECT:
  split first by k=0 versus k>0 on the saturated core.  For k>0, test whether
  the stable Bockstein compensation argument from the closed e=6 endpoint
  depends only on C[ell]-freeness and the colon saturation of

    (alpha : beta),

  or whether low-multiplicity embedded torsion creates a new connecting-map
  term.  Stop at the first genuinely new B-linear obstruction rather than
  importing the e=6 conclusion wholesale.
