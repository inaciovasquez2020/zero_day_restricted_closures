Standalone low-embedding-dimension colon bound for the unique surviving H01-C5
chain value m=3 in the homogeneous q=4, height-two multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_degree6_persistence.v
    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_cyclic_colon_classification.v

  and retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,
    Qsat = Q^sat,
    Ccore = S/Qsat,
    T = Qsat/Q,

  in the H01-C5 state

    m = 3,
    sigma = 5.

The preceding files prove that there is a cubic gamma with

    Qsat = Q + (gamma),
    T ~= S/K(-3),
    K = (Q:gamma),

and classify the Artinian colon quotient R=S/K into three types E0,E1,E2.

This file treats ONLY the low-embedding-dimension types E0 and E1.
It proves that the one-variable torsion chain has length at most four.  Hence
both E0 and E1 satisfy the uniform conclusions

    length(T) <= 4,
    m^4*T = 0,
    T_n = 0 for n>=7.

No E0 or E1 exclusion is claimed here.
No E2, H01-C4, tangent-space estimate, q<=3 branch, or full order-13 closure is
entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. UNIFY E0 AND E1 AS A ONE-VARIABLE CHAIN OF LENGTH s
--------------------------------------------------------------------------

The cyclic-colon classification gives:

  E0:
    K = m,
    R ~= C,
    T ~= C(-3).

  E1:
    after coordinates

      K = (z1,z2,z3,u^s),
      s >= 2,

    and

      R ~= C[u]/(u^s),
      T ~= C[u]/(u^s)(-3).

For E0 set s:=1.  Then both types admit the uniform presentation

    T ~= C[u]/(u^s)(-3)

with s>=1, where for s=1 the variable u acts trivially and K=m.

Thus:

Theorem H01_C5_m3_low_colon_torsion_Hilbert_chain:
  In E0 or E1, for some integer s>=1,

    dim_C T_n = 1  for 3 <= n <= s+2,
    dim_C T_n = 0  otherwise.

  Moreover

    length(T)=s.
Qed.

--------------------------------------------------------------------------
2. EXACT HILBERT FUNCTION OF B ALONG THE CHAIN
--------------------------------------------------------------------------

The degree-six persistence file proves that for m=3 the saturated core has

    dim_C Ccore_n = n+5

for every n>=3.

The graded exact sequence

    0 -> T -> B -> Ccore -> 0

therefore gives, in E0 or E1,

    dim_C B_n = n+6  for 3 <= n <= s+2,
    dim_C B_n = n+5  for n >= s+3.

Theorem H01_C5_m3_low_colon_exact_B_Hilbert_function:
  With s as above,

    B_n = n+6  while the torsion chain is alive,
    B_n = n+5  after the torsion chain terminates,

for every n>=3.
Qed.

Interpretation:
  E0 is s=1, so the extra one-dimensional contribution occurs only in degree
  three.  E1 contributes one extra dimension in each consecutive degree
  3,...,s+2.

--------------------------------------------------------------------------
3. IF s>=5 THEN B HAS MAXIMAL MACAULAY GROWTH FROM 6 TO 7
--------------------------------------------------------------------------

Assume for contradiction that

    s>=5.

Then the torsion chain is nonzero in both degrees six and seven because

    6,7 <= s+2.

Hence Section 2 gives

    dim_C B_6 = 12,
    dim_C B_7 = 13.

Compute the degree-six Macaulay expansion of twelve:

    12
      = binom(7,6)
        + binom(5,5)
        + binom(4,4)
        + binom(3,3)
        + binom(2,2)
        + binom(1,1)
      = 7+1+1+1+1+1.

Therefore

    12^{<6>}
      = binom(8,7)
        + binom(6,6)
        + binom(5,5)
        + binom(4,4)
        + binom(3,3)
        + binom(2,2)
      = 8+1+1+1+1+1
      = 13.

Thus:

Theorem H01_C5_m3_low_colon_s_ge_5_has_maximal_6_to_7_growth:
  If s>=5, then

    dim_C B_7 = (dim_C B_6)^{<6>} = 13.
Qed.

--------------------------------------------------------------------------
4. GOTZMANN PERSISTENCE WOULD FORCE THE WRONG HILBERT POLYNOMIAL
--------------------------------------------------------------------------

The ideal Q is generated entirely by its four quadrics.  In particular Q is
generated in degrees at most six.

Under the temporary assumption s>=5, Section 3 gives maximal Macaulay growth
from degree six to degree seven.  Standard Gotzmann persistence therefore
propagates that growth in every later degree.

At every d>=6, the number d+6 has the degree-d Macaulay representation

    d+6
      = binom(d+1,d)
        + binom(d-1,d-1)
        + binom(d-2,d-2)
        + binom(d-3,d-3)
        + binom(d-4,d-4)
        + binom(d-5,d-5).

The five trailing terms are all one, and the top indices are strictly
decreasing for d>=6.  Its successor is

    binom(d+2,d+1)
      + binom(d,d)
      + binom(d-1,d-1)
      + binom(d-2,d-2)
      + binom(d-3,d-3)
      + binom(d-4,d-4)

    = (d+2)+5
    = d+7.

Starting from

    dim_C B_6 = 12 = 6+6,

Gotzmann persistence yields:

Theorem H01_C5_m3_low_colon_s_ge_5_Gotzmann_profile:
  If s>=5, then

    dim_C B_n = n+6

  for every n>=6.
Qed.

Hence the Hilbert polynomial of B would be

    P_B(n)=n+6.

But T=Qsat/Q has finite length.  Saturation changes only finite-length data, so
B=S/Q and Ccore=S/Qsat have the same Hilbert polynomial.

The exact saturated-core Hilbert function is already

    dim_C Ccore_n=n+5

for every n>=3.  Therefore

    P_Ccore(n)=n+5.

The two Hilbert polynomials cannot simultaneously be equal.

Thus the assumption s>=5 is impossible.

Theorem H01_C5_m3_low_colon_chain_length_at_most_four:
  In E0 or E1 one has

    s<=4.
Qed.

--------------------------------------------------------------------------
5. EXACT SURVIVING LOW-COLON FRONTIER
--------------------------------------------------------------------------

For E0, by definition,

    s=1.

For E1, the cyclic-colon classification already gives s>=2, while Section 4
gives s<=4.

Therefore:

Theorem H01_C5_m3_low_colon_exact_length_frontier:
  The low-embedding-dimension colon types reduce to exactly

    E0: s=1,

    E1: s in {2,3,4}.
Qed.

Equivalently,

    length(T) in {1,2,3,4}

throughout E0 union E1.

No claim is made here that every value 2,3,4 is realizable.

--------------------------------------------------------------------------
6. UNIFORM NILPOTENCE CONSEQUENCES
--------------------------------------------------------------------------

In E0, K=m, so certainly

    m^4 subset K.

In E1, after coordinates

    K=(z1,z2,z3,u^s)

with s<=4.

Every homogeneous monomial of degree four either contains at least one of
z1,z2,z3, or equals u^4.  The first kind lies in (z1,z2,z3), while

    u^4 in (u^s)

because s<=4.

Therefore

    m^4 subset K

throughout E0 union E1.

Since

    T ~= S/K(-3),

we obtain:

Theorem H01_C5_m3_low_colon_m4T_zero:
  In E0 or E1,

    m^4*T=0.
Qed.

Corollary H01_C5_m3_low_colon_torsion_length_at_most_four:
  In E0 or E1,

    length(T)<=4.
Qed.

Corollary H01_C5_m3_low_colon_torsion_vanishes_from_degree_seven:
  In E0 or E1,

    T_n=0

  for every n>=7.

Proof:
  The top nonzero degree of the chain is s+2, and s<=4.
Qed.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_chain_length_at_most_four.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E1_s_in_2_3_4.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_m4T_zero.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_lengthT_at_most_four.

CURRENT_C5_STATUS:
  H01-C5 with m>=4 is empty.
  H01-C5 with m=3 has cyclic saturation defect.
  In the low-colon types E0/E1, the full defect has length at most four and is
  annihilated by m^4.
  The genuine two-variable E2 type remains untouched.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude E0.
  It does NOT exclude E1 with s=2,3,4.
  It does NOT treat E2.
  It does NOT close H01-C5 m=3.
  It does NOT enter H01-C4.
  It does NOT make a tangent-space estimate.
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
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in H01-C5 m=3 and still treat E0/E1 before E2.  Use the new uniform

    length(T)<=4,
    m^4*T=0

  together with the exact final two-cut Koszul sequence to determine the
  strongest annihilator that survives in H_1(f,g;S/Q).  Test whether the
  resulting two-copy Hom carrier already violates the order-13 tangent gate.

NEXT_ACTIONS:
  1. Stay only in H01-C5 m=3 and E0/E1.
  2. Use m^4*T=0 and length(T)<=4 in the final Koszul sequence.
  3. Compute the residual H_1 contribution from the m=3 H01 module D.
  4. Form the weakest uniform annihilator product for the full H_1(f,g;B).
  5. Stop before E2, H01-C4, or q<=3.