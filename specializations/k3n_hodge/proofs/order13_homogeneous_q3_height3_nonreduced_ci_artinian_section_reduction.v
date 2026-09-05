Standalone Artinian-section reduction for the nonreduced homogeneous q=3,
height-three complete-intersection core in the order-13 deviation-two branch.

SCOPE:
  Continue from

    order13_homogeneous_q3_height_split.v
    order13_homogeneous_q3_height3_reduced_ci_tangent_closed.v.

  Let

    S := C[x1,x2,x3,x4],
    Q := (q1,q2,q3),
    B := S/Q,
    I := Q+(f1,f2,f3),
    L := I/Q subset B,
    A := B/L,
    N := length_C(A)>=32,

  with ht(Q)=3.  Thus q1,q2,q3 are a regular sequence of quadrics and

    Hilb_B(t)=(1+t)^3/(1-t),
    e(B)=8.

  No reducedness hypothesis is imposed in this file.

This file performs one bounded task only: replace the uncontrolled negative
part of End_B(L) by an exact regular-linear-section / Bockstein problem over a
finite Artinian Gorenstein quotient.  It does not assert the final negative
endomorphism inequality.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE INTRINSIC TANGENT FORMULA AND UNIVERSAL NONNEGATIVE DEFECT BOUND
--------------------------------------------------------------------------

Put

    Lstar := Hom_B(L,B),
    E := End_B(L),
    T := Ext^1_B(L,L),
    epsilon := length_C(T).

As in the reduced H3-CI file, one-dimensional Gorenstein duality gives

    length_C Hom_B(L,A)
      = N - length_C(E/B) + epsilon.

Because A has finite length,

    L_p=B_p

for every homogeneous prime p different from the irrelevant maximal ideal m.
Hence

    E_p=B_p

away from m, so E/B has finite length.

The punctured-section argument used in the reduced file does not require B to
be reduced in nonnegative degree.  With

    X:=Proj(B),

X is a zero-dimensional complete intersection of length eight, possibly
nonreduced, and O_X(n) is invertible.  Therefore

    dim_C H^0(X,O_X(n))=8

for every n.

Since

    dim B_0=1,
    dim B_1=4,
    dim B_2=7,
    dim B_n=8 for n>=3,

one obtains universally

    dim(E_0/B_0) <= 7,
    dim(E_1/B_1) <= 4,
    dim(E_2/B_2) <= 1,
    E_n=B_n for n>=3.

Define

    delta_plus := sum_{n>=0} dim_C(E_n/B_n).

Then

    delta_plus <= 12.

The only additional defect in the nonreduced case is therefore the negative
part

    delta_minus := sum_{n<0} dim_C E_n.

Thus

    length_C Hom_B(L,A)
      >= N - 12 - delta_minus + epsilon.

Consequently the nonreduced H3-CI child is tangent-closed as soon as

    delta_minus - epsilon <= 7.

No such inequality is assumed here.

--------------------------------------------------------------------------
2. REGULAR LINEAR SECTION
--------------------------------------------------------------------------

Because B is one-dimensional Cohen--Macaulay over the infinite field C, choose

    h in B_1

outside the finite union of associated primes.  Then h is a homogeneous
nonzerodivisor on B.

Since L is an ideal of B and B/L has finite length, L is maximal
Cohen--Macaulay, so h is also a nonzerodivisor on L.

If h*phi=0 for phi in E=End_B(L), then

    h*phi(x)=0

for every x in L.  Since h is L-regular, phi=0.  Hence h is E-regular as well.

For r>=1 set

    C_r := B/(h^r),
    M_r := L/h^r L.

Since B and L have the same multiplicity eight,

    length_C(C_r)=8*r,
    length_C(M_r)=8*r.

Also E/B has finite length, so e(E)=e(B)=8.  Since h is E-regular,

    length_C(E/h^r E)=8*r.

For r=1,

    C_1=B/(h)

is an Artinian Gorenstein complete intersection with Hilbert series

    Hilb_C1(t)=(1+t)^3

and Hilbert function

    (1,3,3,1).

--------------------------------------------------------------------------
3. EXACT BOCKSTEIN ENDOMORPHISM SEQUENCE
--------------------------------------------------------------------------

Consider the graded exact sequence

    0 -> L(-r) --h^r--> L -> M_r -> 0.

Apply Hom_B(L,-).  The first terms are

    0 -> E(-r) --h^r--> E
      -> Hom_B(L,M_r)
      -> T(-r) --h^r--> T.

Every B-linear map L->M_r kills h^r L because h^r acts by zero on M_r.
Therefore it factors uniquely through L/h^rL=M_r, and the induced map is
C_r-linear.  Hence

    Hom_B(L,M_r) ~= End_Cr(M_r).

It follows that there is an exact sequence

    0 -> E/h^r E
      -> End_Cr(M_r)
      -> (0 :_T h^r)(-r)
      -> 0.

Taking lengths gives the exact finite-dimensional identity

    dim_C End_Cr(M_r)
      = 8*r + length_C(0 :_T h^r).

In particular, for every r large enough that h^r T=0,

    epsilon
      = dim_C End_Cr(M_r) - 8*r.

Thus the self-extension correction epsilon is completely recoverable from a
finite Artinian endomorphism calculation.

--------------------------------------------------------------------------
4. NEGATIVE ENDOMORPHISM CHAIN
--------------------------------------------------------------------------

Because E is a finite graded B-module, E_n=0 for all sufficiently negative n.
For k>=1 define

    d_k := dim_C E_{-k}.

Multiplication by the E-regular element h gives injections

    E_{-(k+1)} -> E_{-k}.

Hence

    d_1 >= d_2 >= d_3 >= ... >= 0

and the sequence is eventually zero.  Moreover

    delta_minus = sum_{k>=1} d_k.

The first negative layer is automatically small.  Multiplication by h embeds
E_{-1} into E_0.  Its image has zero intersection with B_0: if

    h*e = c in C^* subset B_0,

then e=(c/h) would preserve L, forcing

    L subset hL,

contrary to Nakayama.  Therefore

    d_1 <= dim_C(E_0/B_0) <= 7.

For every r>=1, the negative-degree part of E/h^rE has length

    length_C((E/h^rE)_{<0})
      = sum_{k>=1} (d_k-d_{k+r})
      = sum_{k=1}^r d_k.

Hence for r beyond the negative support of E,

    length_C((E/h^rE)_{<0}) = delta_minus.

Combining with the Bockstein identity, for r simultaneously large enough that

    E_n=0 for n<-r

and

    h^r T=0,

the formerly infinite-looking obstruction is the finite Artinian inequality

    length_C((E/h^rE)_{<0})
      - (dim_C End_Cr(M_r)-8*r)
      <= 7.

This inequality is exactly

    delta_minus - epsilon <= 7.

--------------------------------------------------------------------------
5. PRECISE REMAINING GAP
--------------------------------------------------------------------------

Write

    tail_h(E) := sum_{k>=2} d_k.

Since d_1<=7,

    tail_h(E) <= epsilon

is a sufficient strengthening of the exact required inequality

    delta_minus - epsilon <= 7.

No proof of either inequality is claimed here.

The important reduction is that both sides are now encoded by finite Artinian
objects C_r and M_r once r kills T and reaches the lower graded support of E.
There is no need to assume reducedness, normalization, or absence of nilpotents.

RESULT:
  nonreduced_H3_CI_reduced_to_artinian_endomorphism_bockstein_inequality.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  reduced H3-CI remains closed.
  nonreduced H3-CI is not closed.
  H2-CM is not closed.
  H2-NCM is not closed.
  homogeneous q=3 is not closed.
  homogeneous q<=2 is not closed.
  OC is not proved.

MISSING_OBJECT:
  For the Artinian reductions

    C_r=B/(h^r),
    M_r=L/h^rL,

  prove, for one sufficiently large r,

    length_C((E/h^rE)_{<0})
      - (dim_C End_Cr(M_r)-8*r)
      <= 7.

  Equivalently prove

    delta_minus - epsilon <= 7.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, attack the displayed finite Artinian inequality; do not promote
     the nonreduced H3-CI child before that inequality is proved.
