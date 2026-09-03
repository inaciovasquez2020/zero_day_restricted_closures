Standalone residual-generator bound for the low-embedding-dimension H01-C5 m=3
colon types E0/E1 in the homogeneous q=4, height-two multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_residual_product_annihilator.v

  and retain

    S = C[x1,x2,x3,x4],
    Q subset Qsat,
    D = P/Qsat,
    J_res = Ann_S(D) = (Qsat:P),

  in H01-C5 with

    m = 3,
    sigma = 5,

  and only in the E0/E1 torsion-colon states.

The preceding file reduces the tangent carrier to

    t(A) >= 2*N - 2*L_res - 8*r_res,

where

    L_res = length_C S/(J_res,f,g),
    r_res = mu_A((J_res)_A).

This file performs one bounded task only: prove the absolute generator bound

    r_res <= 6.

The key point is that the exact Artinian reduction of D has total length four.
After localizing at the regular parameter, D becomes a faithful four-dimensional
module over the generic residual algebra.  The standard Schur--Jacobson bound
for commutative matrix algebras then forces the residual multiplicity to be at
most five.  A length-at-most-five Artinian reduction in three variables has at
most six minimal generators.

IMPORTANT:
  The Artinian reduction of D is NOT assumed faithful over the Artinian
  reduction of S/J_res.  Such faithfulness need not survive reduction by a
  regular parameter.  Therefore this file does not identify J_res/(h) with
  Ann(D/hD).

No numerical bound for L_res is made here.
No E2, H01-C4, q<=3, or full order-13 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE RESIDUAL RING AND A COMMON REGULAR PARAMETER
--------------------------------------------------------------------------

Put

    R_res := S/J_res.

Since

    J_res = Ann_S(D),

D is faithful as an R_res-module.  Moreover

    dim D = 1,

so

    dim R_res = 1.

Choose the same general linear form h used in the established H01 Artinian
reduction.  Thus h is D-regular and

    E := D/hD

has Hilbert series

    Hilb_E(t) = 2*t+t^2+t^3.

Theorem H01_C5_m3_E01_h_is_Rres_regular:
  Multiplication by h is injective on R_res.

Proof:
  Suppose a class r in R_res satisfies

    h*r = 0.

  Acting on D gives

    h*(r*D)=0.

  Since h is D-regular,

    r*D=0.

  D is faithful over R_res, hence r=0.
Qed.

Thus R_res is a one-dimensional Cohen--Macaulay standard graded ring and h is a
homogeneous parameter on it.

Corollary H01_C5_m3_E01_colon_saturation_by_h:
  One has

    (J_res:h)=J_res

and therefore

    J_res intersect (h) = h*J_res.
Qed.

--------------------------------------------------------------------------
2. D HAS GENERIC RANK FOUR OVER C[h]
--------------------------------------------------------------------------

The exact m=3 residual Hilbert series is

    Hilb_D(t)
      = (2*t+t^2+t^3)/(1-t).

Hence

    dim_C D_n = 4

for every n>=3.

Because h is injective on D, multiplication

    h : D_n -> D_(n+1)

is an isomorphism for every n>=3.

Therefore D is finite and torsion-free over C[h].  Since C[h] is a PID, D is a
finite free C[h]-module.  Its rank is the eventual Hilbert value:

    rank_(C[h]) D = 4.

More precisely, its graded free shape is compatible with

    D ~= C[h](-1)^2 direct_sum C[h](-2) direct_sum C[h](-3)

as a C[h]-module.

Theorem H01_C5_m3_E01_D_generic_dimension_four:
  If

    K := C(h)

is the fraction field of C[h], then

    D_K := D tensor_(C[h]) K

is a four-dimensional K-vector space.
Qed.

--------------------------------------------------------------------------
3. THE GENERIC RESIDUAL ALGEBRA ACTS FAITHFULLY
--------------------------------------------------------------------------

Since h is a parameter and nonzerodivisor on R_res, the ring R_res is finite
and torsion-free over C[h].  Hence it is also free over C[h].

Put

    A_gen := R_res tensor_(C[h]) K.

Then A_gen is a finite-dimensional commutative K-algebra and

    dim_K A_gen = e(R_res),

the multiplicity of the one-dimensional residual ring.

Theorem H01_C5_m3_E01_generic_action_is_faithful:
  The natural action

    A_gen -> End_K(D_K)

is injective.

Proof:
  D is faithful over R_res.  Localization preserves faithfulness because a
  localized element that kills D_K has a denominator multiple that kills D,
  hence is zero in the localization.
Qed.

Thus A_gen is a commutative K-subalgebra of the endomorphism algebra of a
four-dimensional K-vector space.

--------------------------------------------------------------------------
4. SCHUR--JACOBSON FORCES RESIDUAL MULTIPLICITY AT MOST FIVE
--------------------------------------------------------------------------

Use the standard Schur--Jacobson theorem:

  If A is a commutative subalgebra of End_K(V), with dim_K V=n, then

    dim_K A <= floor(n^2/4)+1.

The bound is valid over an arbitrary field.

For n=4 this gives

    dim_K A <= 5.

Apply this to the faithful generic action from Section 3.

Theorem H01_C5_m3_E01_residual_multiplicity_at_most_five:
  One has

    e(R_res) <= 5.
Qed.

Equivalently, since h is R_res-regular,

    length_C R_res/hR_res <= 5.

This is the only external standard matrix-algebra input used in this file.

--------------------------------------------------------------------------
5. REDUCTION MODULO h PRESERVES THE NUMBER OF IDEAL GENERATORS
--------------------------------------------------------------------------

Put

    Sbar := S/(h) ~= C[y1,y2,y3],

and

    Jbar := (J_res+(h))/(h).

Because

    J_res intersect (h) = h*J_res,

one has a graded identification

    Jbar ~= J_res/hJ_res.

Let m be the homogeneous maximal ideal of S and mbar its image in Sbar.
Since h*J_res is contained in m*J_res,

    Jbar/(mbar*Jbar)
      ~= J_res/(m*J_res).

Therefore:

Theorem H01_C5_m3_E01_generator_number_survives_regular_cut:
  One has

    mu_S(J_res) = mu_Sbar(Jbar).
Qed.

Also

    Sbar/Jbar ~= R_res/hR_res,

so

    length_C(Sbar/Jbar) = e(R_res) <= 5.

--------------------------------------------------------------------------
6. LENGTH <=5 ARTIN IDEALS IN THREE VARIABLES NEED AT MOST SIX GENERATORS
--------------------------------------------------------------------------

Let

    Rbar := Sbar/Jbar.

It is a standard graded Artinian C-algebra of length at most five.  Write

    c := dim_C (Rbar)_1.

Then c is in {0,1,2,3}.  We bound the minimal number of generators of Jbar in
each case.

CASE c=0.
  Jbar contains all three linear variables, hence

    Jbar = mbar

  and

    mu(Jbar)=3.

CASE c=1.
  After coordinates Jbar contains two independent linear forms.  Modulo them
  one has a finite-colength homogeneous ideal in C[u], hence a single power
  (u^s).  Therefore

    Jbar = (v,w,u^s)

  and

    mu(Jbar)=3.

CASE c=2.
  After coordinates Jbar contains one linear form, and modulo it one obtains an
  m-primary homogeneous ideal I in C[u,v] of colength at most five.

  For an m-primary ideal in two variables, four minimal generators require
  colength at least six; equivalently the smallest two-variable staircase with
  four corners is the degree-three staircase of length six.

  Therefore

    mu(I)<=3,

  and hence

    mu(Jbar)<=1+3=4.

CASE c=3.
  Jbar has no linear generator.  Since

    length Rbar <=5,

  and degrees zero and one already contribute

    1+3=4,

  the degree-two piece has dimension at most one and every later contribution
  is zero once the total length reaches five.

  If dim(Rbar)_2=0, then all six quadrics generate Jbar and

    mu(Jbar)=6.

  If dim(Rbar)_2=1, then Jbar has five independent quadratic generators.  At
  most one additional cubic generator is needed to kill the unique surviving
  quadratic direction in the next degree.  Thus again

    mu(Jbar)<=6.

Combining all four cases gives:

Theorem H01_C5_m3_E01_artin_length_five_generator_bound:
  Every homogeneous mbar-primary ideal Jbar in three variables with

    length(Sbar/Jbar)<=5

  satisfies

    mu(Jbar)<=6.
Qed.

--------------------------------------------------------------------------
7. ABSOLUTE BOUND FOR r_res
--------------------------------------------------------------------------

Sections 5 and 6 give

    mu_S(J_res)<=6.

Passing to the Artin quotient A can only decrease the minimal number of
generators of the image ideal.  Hence

    r_res
      = mu_A((J_res)_A)
      <= mu_S(J_res)
      <= 6.

Theorem q4_H01_C5_m3_E01_residual_generator_bound:
  One has

    r_res <= 6.
Qed.

Insert this into the preceding product-carrier estimate

    t(A) >= 2*N - 2*L_res - 8*r_res.

Corollary H01_C5_m3_E01_tangent_bound_after_generator_control:
  One has

    t(A) >= 2*N - 2*L_res - 48.
Qed.

Against the necessary gate

    t(A)<=N-20,

this route now closes E0/E1 whenever

    L_res + 24 < (N+20)/2.

No assertion is made here that this inequality already follows.

--------------------------------------------------------------------------
8. WHY THE STRONGER r_res<=4 CLAIM IS NOT MADE
--------------------------------------------------------------------------

The established Artinian reduction of D is

    E ~= C(-1) direct_sum C[u]/(u^3)(-1),

whose annihilator in Sbar is, after coordinates,

    Ann_Sbar(E)=(v,w,u^3).

However one only gets the inclusion

    Jbar subset Ann_Sbar(E).

Equality is not automatic: an element may act on D by a multiple of h and
therefore annihilate D/hD without annihilating D itself.

Thus the tempting conclusion

    Jbar=(v,w,u^3)

and hence

    mu(J_res)=3

is not justified by the current data.  The absolute bound six above is the
strongest conclusion established here without a further lifting/classification
argument.

--------------------------------------------------------------------------
9. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_h_regular_on_residual_ring.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_generic_residual_degree_at_most_five.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_residual_generator_number_at_most_six.

CURRENT_E01_STATUS:
  The exact product annihilator remains

    K_T*J_res subset Ann H_1(f,g;B),

  and the two numerical residual invariants now satisfy

    r_res<=6,

  while L_res is still unbounded numerically.

IMPORTANT_NONCONCLUSION:
  This file does NOT identify J_res/(h) with Ann(D/hD).
  It does NOT prove r_res<=4 or r_res<=3.
  It does NOT bound L_res.
  It does NOT prove the tangent gate fails in E0/E1.
  It does NOT close H01-C5 m=3.
  It does NOT treat E2.
  It does NOT enter H01-C4.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_mge4_closed.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_saturation_cyclic.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_colon_classified.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_Koszul_reduced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_product_annihilator_reduced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_rres_at_most_six.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_tangent_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in H01-C5 m=3 and E0/E1.  Bound

    L_res = length_C S/(J_res,f,g)

  using only the now established facts that R_res=S/J_res is a one-dimensional
  Cohen--Macaulay standard graded ring of multiplicity at most five and that
  f,g cut it to finite length.  Determine whether the resulting bound is enough
  for

    L_res + 4*r_res < (N+20)/2

  with r_res<=6.  If not, isolate the additional residual-ring structure needed
  to improve either the multiplicity-five bound or the generator bound.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 E0/E1.
  2. Bound L_res from e(R_res)<=5 and the final degrees d,e.
  3. Insert r_res<=6 into the tangent criterion.
  4. If the numerical gate still does not close, identify the exact surviving degree pairs or residual h-vectors.
  5. Stop before E2, H01-C4, q<=3, or any full order-13 claim.
