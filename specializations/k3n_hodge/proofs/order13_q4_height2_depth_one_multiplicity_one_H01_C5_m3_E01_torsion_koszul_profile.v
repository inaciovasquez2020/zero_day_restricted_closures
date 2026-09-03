Standalone torsion-Koszul profile for the low-embedding-dimension H01-C5 m=3
colon types E0/E1 in the homogeneous q=4, height-two multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_low_embedding_colon_bound.v

  and retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,
    Qsat = Q^sat,
    Ccore = S/Qsat,
    T = Qsat/Q,

  in H01-C5 with

    m = 3,
    sigma = 5,

  and only in the low-colon types E0/E1.

The preceding files prove that there is a cubic gamma such that

    Qsat = Q + (gamma),
    T ~= S/K(-3),
    K = (Q:gamma),

and, after coordinates, E0/E1 admit the uniform presentation

    T ~= C[u]/(u^s)(-3)

with

    s in {1,2,3,4}.

For s=1 this is E0.  For s in {2,3,4} this is E1.  In particular

    length(T) = s <= 4,
    m^4*T = 0.

This file performs one bounded correction and reduction only.  The nilpotence
m^4*T=0 does NOT by itself imply that a cubic final equation kills T when
s=4.  The exceptional cubic action is classified explicitly.  Nevertheless
the full first Koszul homology H_1(f,g;T) is always annihilated by a homogeneous
m-primary ideal whose quotient has length at most four.

No residual H_1(f,g;Ccore) calculation is made here.
No tangent-space estimate is made.
No E2, H01-C4, q<=3, or full order-13 branch is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. FINAL FORMS ON THE ONE-VARIABLE TORSION QUOTIENT
--------------------------------------------------------------------------

Let

    f,g in S

be the final homogeneous equations, with

    deg(f)=d >= 3,
    deg(g)=e >= 3.

Write the low-colon quotient as

    R := C[u]/(u^s),
    T ~= R(-3),

with 1<=s<=4.

All three complementary linear coordinates z1,z2,z3 lie in K, so the action
of a homogeneous form F in S_r on T is determined by its image in

    S/K ~= R.

Since R has only one surviving degree-one variable, the image of F has the
form

    lambda_F * u^r

for a scalar lambda_F in C.

Therefore:

Theorem H01_C5_m3_E01_final_form_action:
  A final homogeneous form F of degree r>=3 acts on T as multiplication by

    lambda_F*u^r.

  In particular:

    if s<=3, every such F acts as zero;

    if s=4 and r>=4, F acts as zero;

    if s=4 and r=3, F acts either as zero or as a nonzero scalar multiple of
    u^3.
Qed.

Thus the only case not covered by the naive implication "final forms kill T"
is

    s=4

with at least one cubic final form having nonzero u^3 coefficient.

--------------------------------------------------------------------------
2. ZERO-ACTION CASE
--------------------------------------------------------------------------

Assume first that

    f*T = 0,
    g*T = 0.

This includes every E0 case, every E1 case with s<=3, and also the s=4 cases
in which the restrictions of all cubic final forms vanish.

The two-element Koszul complex on T is

    0 -> T(-d-e)
      -> T(-d) direct_sum T(-e)
      -> T
      -> 0.

Both differentials involving multiplication by f and g are zero.  Therefore

Theorem H01_C5_m3_E01_zero_action_torsion_H1:
  If fT=gT=0, then

    H_1(f,g;T) ~= T(-d) direct_sum T(-e).
Qed.

Since K annihilates T, it annihilates both copies and therefore

    K subset Ann_S H_1(f,g;T).

Moreover

    length(S/K)=length(T)=s<=4.

Hence:

Corollary H01_C5_m3_E01_zero_action_annihilator:
  In the zero-action case there is an m-primary homogeneous ideal

    K_T := K

  such that

    K_T * H_1(f,g;T)=0,
    length(S/K_T)<=4.
Qed.

--------------------------------------------------------------------------
3. THE UNIQUE NONZERO-ACTION CASE
--------------------------------------------------------------------------

Now assume the exceptional case

    s=4,

and at least one of f,g acts nontrivially on T.

Then

    R=C[u]/(u^4).

By Section 1 every nonzero final-form action is a nonzero scalar multiple of
u^3, and it can occur only for a cubic final form.

If exactly one action is nonzero, rescale that final equation.  If both actions
are nonzero, then d=e=3 and an invertible constant change of basis in the two
Koszul generators replaces the pair by one nonzero action and one zero action.

Thus, for purposes of the Koszul homology, the exceptional pair reduces to

    (u^3,0)

on R, up to nonzero scalar and the harmless grading shifts.

Put

    a:=u^3 in R.

Then

    Ann_R(a)=(u),
    aR=(u^3),
    R/aR ~= C[u]/(u^3).

The first Koszul differential for (a,0) is

    R direct_sum R -> R,
    (x,y) |-> a*x,

so its kernel is

    Ann_R(a) direct_sum R.

The second differential has image

    0 direct_sum aR.

Therefore:

Theorem H01_C5_m3_E1_s4_nonzero_action_torsion_H1:
  In the exceptional s=4 nonzero-action case, ignoring only the predictable
  grading shifts of the two summands,

    H_1(f,g;T)
      ~= Ann_R(u^3) direct_sum R/(u^3)
      ~= (u) direct_sum C[u]/(u^3).

  In particular

    length H_1(f,g;T)=3+3=6.
Qed.

Both summands are annihilated by u^3.  Restoring the three linear colon
generators gives the homogeneous ideal

    K_T := (z1,z2,z3,u^3).

Then

    K_T * H_1(f,g;T)=0

and

    S/K_T ~= C[u]/(u^3),

so

    length(S/K_T)=3.

Corollary H01_C5_m3_E1_s4_nonzero_action_annihilator:
  In the unique nonzero-action case, H_1(f,g;T) is annihilated by an m-primary
  homogeneous ideal K_T with

    length(S/K_T)=3.
Qed.

Notice that this is stronger than retaining the original colon

    K=(z1,z2,z3,u^4),

whose quotient has length four.

--------------------------------------------------------------------------
4. UNIFORM TORSION-KOSZUL ANNIHILATOR
--------------------------------------------------------------------------

Combine Sections 2 and 3.

Theorem H01_C5_m3_E01_uniform_torsion_Koszul_annihilator:
  For every E0/E1 low-colon state, every pair of final homogeneous equations

    f,g

  with degrees d,e>=3, there exists a homogeneous m-primary ideal K_T such that

    K_T * H_1(f,g;T)=0

  and

    length(S/K_T)<=4.

  More precisely:

    if fT=gT=0, one may take K_T=K=(Q:gamma), with quotient length s<=4;

    if the exceptional s=4 cubic action is nonzero, after coordinates one may
    take

      K_T=(z1,z2,z3,u^3),

    with quotient length three.
Qed.

Corollary H01_C5_m3_E01_torsion_Koszul_support_bound:
  The torsion contribution to the final first Koszul homology is uniformly
  supported on an Artinian quotient of length at most four.
Qed.

This is the exact replacement for the false stronger statement that

    m^4*T=0 and d,e>=3

would automatically imply

    fT=gT=0.

--------------------------------------------------------------------------
5. INJECTION INTO THE FULL FIRST KOSZUL HOMOLOGY
--------------------------------------------------------------------------

Apply the two-element Koszul complex on f,g to

    0 -> T -> B -> Ccore -> 0.

Because the final quotient

    Ccore/(f,g)

has finite length, the ideal generated by f,g is m-primary on Ccore.

If c in Ccore is killed by both f and g, then c is killed by a power of m.
But Qsat is saturated, so

    H^0_m(Ccore)=0.

Therefore

    H_2(f,g;Ccore)=0.

The long exact Koszul sequence consequently begins

    0 -> H_1(f,g;T)
      -> H_1(f,g;B)
      -> H_1(f,g;Ccore)
      -> H_0(f,g;T)
      -> ... .

Theorem H01_C5_m3_E01_torsion_H1_injects:
  The natural map

    H_1(f,g;T) -> H_1(f,g;B)

  is injective.
Qed.

Put

    U := H_1(f,g;T)

inside

    H := H_1(f,g;B).

Then the quotient H/U injects into H_1(f,g;Ccore).

Corollary H01_C5_m3_E01_exact_extension_shape:
  There is an exact sequence

    0 -> U -> H -> V -> 0

  where

    U=H_1(f,g;T),

    V is a submodule of H_1(f,g;Ccore),

  and U is annihilated by an m-primary homogeneous ideal K_T satisfying

    length(S/K_T)<=4.
Qed.

This is the form needed for the later extension-annihilator product: any ideal
annihilating H_1(f,g;Ccore) also annihilates V, and multiplying it by K_T then
annihilates all of H.

--------------------------------------------------------------------------
6. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_final_form_action_classified.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_H1_classified.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_H1_artin_support_at_most_four.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_H1_injects_into_full_H1.

CURRENT_E01_STATUS:
  The finite saturation defect itself has length at most four.
  Its first final Koszul homology is uniformly annihilated by an m-primary
  ideal K_T with length(S/K_T)<=4, including the exceptional s=4 cubic-action
  case.

IMPORTANT_NONCONCLUSION:
  This file does NOT compute H_1(f,g;Ccore).
  It does NOT classify Ann(D).
  It does NOT form the full extension-annihilator product.
  It does NOT prove the tangent gate fails in E0/E1.
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
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_low_length_reduced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_torsion_Koszul_reduced.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_tangent_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in H01-C5 m=3 and E0/E1.  Compute the weakest repository-justified
  annihilator J_res of

    H_1(f,g;Ccore) ~= H_1(f,g;D),

  where

    Hilb_D(t)=(2*t+t^2+t^3)/(1-t).

  Combine J_res with the now exact torsion-Koszul annihilator K_T using the
  extension product

    K_T * J_res subset Ann H_1(f,g;B),

  and only then test the two-copy tangent carrier.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 and E0/E1.
  2. Compute H_1(f,g;Ccore) through the residual module D.
  3. Find the weakest justified annihilator J_res of that residual H_1.
  4. Form K_T*J_res subset Ann H_1(f,g;B).
  5. Test the resulting tangent lower bound and stop before E2 or H01-C4.
