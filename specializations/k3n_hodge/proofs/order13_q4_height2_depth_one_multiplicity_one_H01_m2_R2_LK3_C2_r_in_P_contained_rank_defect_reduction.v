Standalone rank-defect reduction for the contained K/J incidence inside the
r-in-P half of the LK3-C2 carrier in the saturated H01 minimal-chain rank-two
endpoint of the homogeneous q=4, height-two, multiplicity-one, depth-one
order-13 deviation-two program.

SCOPE:
  Continue only from the contained-incidence classification at commit
  c4d88754396eb773c3cd6cd35d1d2666d5b0fbf4.

  Retain

    S := C[x1,x2,x3,x4],
    Q=Qsat subset P,
    K=(a,b,F) subset J=(a,b,c),
    q1=r*a,
    q2=r*b,

  with Q_2 four-dimensional and q1,q2,q3,q4 linearly independent.

  Over

    R_J:=S/J ~= C[t],

  the conormal module is

    K/(J*K) ~= R_J(-1)^2 direct_sum R_J(-2),

  with basis e_a,e_b,e_F, and the classes of q3,q4 are encoded by

          [ alpha_3*t   alpha_4*t ]
    Phi = [ beta_3*t    beta_4*t  ].
          [ gamma_3     gamma_4   ]

  Put

    rho_Q:=rank_{C(t)}(Phi).

This file performs one bounded task: identify rho_Q exactly with the missing
degree-two incidence dimension Q_2/(Q_2 intersect (J*K)_2).  No tangent closure
of the remaining rank-defect cases is claimed.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. REMOVE THE HOMOGENEOUS t-WEIGHTS OVER C(t)
--------------------------------------------------------------------------

Over the fraction field C(t), multiplication of the first two target basis
vectors by t^{-1} is invertible.  Therefore Phi has the same C(t)-rank as the
constant matrix

              [ alpha_3   alpha_4 ]
    Phi_0  =  [ beta_3    beta_4  ].
              [ gamma_3   gamma_4 ]

Hence rho_Q is the ordinary C-rank of the two constant column vectors

    v_3=(alpha_3,beta_3,gamma_3),
    v_4=(alpha_4,beta_4,gamma_4).

In particular:

    rho_Q=2
      iff v_3,v_4 are C-linearly independent;

    rho_Q<=1
      iff there exist lambda_3,lambda_4 in C, not both zero, such that

        lambda_3*v_3 + lambda_4*v_4 = 0.

--------------------------------------------------------------------------
2. CONSTANT COLUMN DEPENDENCE IS EXACTLY A QUADRATIC JK RELATION
--------------------------------------------------------------------------

By construction, v_i is the degree-two coordinate vector of [q_i] in
K/(J*K).  Therefore

    lambda_3*v_3 + lambda_4*v_4 = 0

is equivalent to

    lambda_3*q3 + lambda_4*q4 in (J*K)_2.

Since q1,q2 already lie in (J*K)_2, the kernel of the degree-two map

    Q_2 -> (K/(J*K))_2

contains span_C(q1,q2).  The images of q3,q4 have dimension rho_Q, and
q1,q2,q3,q4 are a basis of Q_2.  Consequently

    dim_C(Q_2 intersect (J*K)_2)
      = 4-rho_Q.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rank_defect_intersection_formula:
  In the contained incidence,

    rho_Q = 4 - dim_C(Q_2 intersect (J*K)_2).

Equivalently,

    rho_Q=2
      iff Q_2 intersect (J*K)_2 = span_C(q1,q2);

    rho_Q=1
      iff dim_C(Q_2 intersect (J*K)_2)=3;

    rho_Q=0
      iff Q_2 subset (J*K)_2.
Qed.

--------------------------------------------------------------------------
3. THE REMAINING DEFECT IS NOW A PURE DEGREE-TWO INCIDENCE QUESTION
--------------------------------------------------------------------------

The preceding contained-incidence file reduced the product-cut obstruction to
rho_Q.  The present formula removes the fraction-field matrix from the next
step: it is enough to determine how many independent quadrics of Q_2 lie in
(J*K)_2.

Thus the strongest generic-rank case rho_Q=2 is equivalent to the exact
intersection statement

    Q_2 intersect (J*K)_2 = span_C(r*a,r*b).

Any failure of rho_Q=2 requires one additional nonzero quadratic

    q in Q_2 intersect (J*K)_2

independent of r*a and r*b.

This is a strict structural reduction only.  It does not exclude rho_Q=0 or
rho_Q=1.

STATUS:
  CONTAINED_RANK_DEFECT_REDUCED_TO_QUADRATIC_INTERSECTION.

PROVED_IN_THIS_FILE:
  rho_Q = 4 - dim_C(Q_2 intersect (J*K)_2).

NOT_PROVED:
  rho_Q=2 universally.
  rho_Q=1 impossible.
  rho_Q=0 impossible.
  all-degree contained-incidence tangent closure.
  H01_m2_R2_LK3_C2_r_in_P closure.
  H01 closure.
  q=4 height-two full closure.
  homogeneous q<=3 closure.
  Oblivion Closure.

BOUNDARY:
  not H01_m2_R2_LK3_C2_r_in_P_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in the contained r-in-P LK3-C2 incidence.  Assume an extra
  quadratic

    q in (Q_2 intersect (J*K)_2) / span_C(r*a,r*b)

  exists, classify its normal form in the reduced-point and double-point
  contained K-types, and determine whether rho_Q=0 or rho_Q=1 can survive the
  exact H01 m=2 Hilbert and saturation constraints.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
