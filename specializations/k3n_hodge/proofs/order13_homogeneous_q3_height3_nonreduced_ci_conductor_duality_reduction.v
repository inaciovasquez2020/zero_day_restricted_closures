Standalone conductor-duality reduction for the residual nonreduced homogeneous
q=3, height-three complete-intersection core in the order-13 deviation-two
branch.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_stable_trace_duality_reduction.v.

  Let

    B=S/(q1,q2,q3),
    L=(fbar1,fbar2,fbar3) subset B,
    E=End_B(L),
    P=tr_B(L),
    C=E/B.

  The three quadrics form a regular sequence in four variables, so B is a
  one-dimensional standard graded Gorenstein ring with

    Hilb_B(t)=(1+t)^3/(1-t),
    a(B)=2.

  The ideal L is homogeneous, m-primary, regular and reflexive.  The previous
  reduction proved

    delta_neg=length_C(B/P)_{>=3}.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

ExternalResult graded_local_duality_dim1_finite_length:
  Let R be a one-dimensional standard graded Cohen--Macaulay k-algebra with
  canonical module omega_R, and let M be a finite-length graded R-module.
  Then

    Ext^1_R(M,omega_R) ~= D(M)

  as graded modules, where D is graded k-dual.

  This is the finite-length case of graded local duality.

--------------------------------------------------------------------------
1. THE TRACE IDEAL IS THE CONDUCTOR INTO THE ENDOMORPHISM RING
--------------------------------------------------------------------------

Let

  Lstar:=Hom_B(L,B).

The evaluation map

  mu: L tensor_B Lstar -> B

has image P=tr_B(L).  Its kernel T is supported only at the homogeneous
maximal ideal: away from that point L is free of rank one and evaluation is an
isomorphism.  Hence T has finite length.

Since depth(B)=1,

  Hom_B(T,B)=0.

Dualizing

  0 -> T -> L tensor_B Lstar -> P -> 0

therefore gives

  Hom_B(P,B)
    ~= Hom_B(L tensor_B Lstar,B)
    ~= Hom_B(L,Hom_B(Lstar,B))
    ~= Hom_B(L,L**)
    ~= End_B(L)
    = E,

using reflexivity L**~=L.

Because P contains L, it is m-primary and contains a nonzerodivisor.  Hence P
is maximal Cohen--Macaulay over the one-dimensional Gorenstein ring B and is
reflexive.  Dualizing once more yields

  P
    = P**
    ~= Hom_B(E,B).

Under the usual identification inside the homogeneous total quotient ring,

  Hom_B(E,B)=B:E.

Therefore

Theorem trace_equals_endomorphism_conductor:

  tr_B(L)=B:End_B(L).
Qed.

Thus P is exactly the conductor of B into the finite birational overring E.
No reducedness hypothesis is used.

--------------------------------------------------------------------------
2. THE CONDUCTOR QUOTIENT IS THE SHIFTED DUAL OF E/B
--------------------------------------------------------------------------

Consider

  0 -> B -> E -> C -> 0.

The module C has finite length.  The module E is torsionfree over the
one-dimensional Cohen--Macaulay ring B, hence maximal Cohen--Macaulay.  Since
B is Gorenstein,

  Ext^1_B(E,B)=0.

Also Hom_B(C,B)=0.  Applying Hom_B(-,B) gives the exact sequence

  0 -> Hom_B(E,B) -> B -> Ext^1_B(C,B) -> 0.

Using Hom_B(E,B)=P from Section 1,

  B/P ~= Ext^1_B(C,B).

Because a(B)=2,

  omega_B ~= B(2).

Graded local duality gives

  Ext^1_B(C,B(2)) ~= D(C).

Equivalently,

  Ext^1_B(C,B) ~= D(C)(-2).

Hence

Theorem conductor_quotient_dual_to_endomorphism_defect:

  B/tr_B(L) ~= D(End_B(L)/B)(-2).
Qed.

With the grading convention M(a)_n=M_{n+a}, this means degree-by-degree

  (B/P)_n ~= D(C_{2-n}).

In particular

  dim_C(B/P)_n = dim_C(E/B)_{2-n}.

--------------------------------------------------------------------------
3. EXACT LOW/HIGH DEGREE REFLECTION
--------------------------------------------------------------------------

The previous punctured-section argument gives

  E_n=B_n for every n>=3.

Therefore C_n=0 for n>=3.  The conductor quotient is nonnegatively graded, so
its degreewise duality separates exactly as follows:

  degree 0 of B/P  <-> degree 2 of C,
  degree 1 of B/P  <-> degree 1 of C,
  degree 2 of B/P  <-> degree 0 of C,
  degree >=3 of B/P <-> degree <=-1 of C.

Consequently

  length_C(B/P)_{<=2}=delta_nonneg,

and

  length_C(B/P)_{>=3}=delta_neg.

Thus

  length_C(B/P)=length_C(E/B)=delta_nonneg+delta_neg.

This recovers the previous trace-tail identity without Auslander--Reiten
pairing and upgrades it to a full conductor-duality statement.

--------------------------------------------------------------------------
4. WHAT THIS DOES AND DOES NOT BUY IN R2
--------------------------------------------------------------------------

In the residual R2 pattern

  d1=d2=d<d3=e,

write D=e-d.  The trapped-component reduction gives

  E_n=0 for n<-D.

By the conductor duality above, this is equivalent to

  (B/P)_n=0 for n>D+2.

Hence the remaining trace tail is supported in the explicit finite range

  3 <= n <= D+2.

However, multiplicity e(B)=8 alone does not force

  length_C(B/P)_{>=3}<=8.

The conductor-duality theorem converts the obstruction exactly but does not by
itself bound the number of nonzero tail layers.  A further R2-specific input is
still required.

The current sufficient inequality remains

  length_C(B/P)_{>=3} - epsilon_L <= 7,

where

  epsilon_L=length_C Ext^1_B(L,L)>=1.

RESULT:
  trace_equals_endomorphism_conductor.
  conductor_quotient_dual_to_endomorphism_defect.
  exact_low_high_degree_reflection.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove length_C(B/P)_{>=3}<=8.
  It does NOT prove the compensated inequality.
  It does NOT close R1 or R2.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation using standard graded local
  duality.  The new theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  The trace quotient is now identified canonically as the conductor quotient
  B/(B:E), and its high-degree tail is exactly dual to the negative-degree
  endomorphism defect.

MISSING_OBJECT:
  In R2=d1=d2<d3, prove an R2-specific compensated bound

    length_C(B/(B:E))_{>=3} - epsilon_L <= 7,

  equivalently

    delta_neg - epsilon_L <= 7.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. In R2, analyze the conductor quotient B/(B:E) on each trapped minimal
     component using the common escape degree e=d3.
  3. Identify whether each additional tail layer forces an independent
     self-extension class of L.
  4. Prove the compensated inequality rather than assuming the raw tail bound
     eight.
  5. Rebuild immediately after the first structural R2 lemma.
