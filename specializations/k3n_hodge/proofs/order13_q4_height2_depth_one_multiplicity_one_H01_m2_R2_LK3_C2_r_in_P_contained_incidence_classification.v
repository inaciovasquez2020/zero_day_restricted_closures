Standalone classification of the contained K/J incidence inside the r-in-P
half of the LK3-C2 carrier in the saturated H01 minimal-chain rank-two endpoint
of the homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_noncontained_incidence_tangent_closure.v

  and retain

    S := C[x1,x2,x3,x4],
    Q=Qsat subset P,
    B:=S/Q,
    D:=P/Q,

with the exact r-in-P filtration

    0 -> S/K(-1) -> D -> S/J(-1) -> 0,

where

    K=(a,b,F)

is a saturated complete intersection of type (1,1,2),

    J=(r,u,v)

is a height-three linear prime,

    q1=r*a,
    q2=r*b,

and

    K*J*D=0.

Let the final homogeneous equations be

    f,g in S,
    d:=deg(f)>=3,
    e:=deg(g)>=3,
    M:=max(d,e),

and put

    I:=Q+(f,g),
    A:=S/I=B/(f,g),
    N:=length_C(A)>=32.

Retain

    L_K:=length_C S/(K,f,g),
    L_J:=length_C S/(J,f,g),

with

    L_K<=2*M,
    L_J<=M,
    d*e>=3*M,

and the exact tangent carrier

    t(A):=dim_C Hom_S(I,A)
      >=2*(N-C_A),

where

    C_A:=length_C A/(K_A*J_A).

This file enters only the remaining incidence

    K subset J.

It performs one bounded task: classify the length-two (1,1,2) scheme K through
the J-point, compute the exact conormal module K/(J*K), quotient it by the two
remaining quadratic relations q3,q4, and reduce the product-cut problem to the
generic rank of one explicit 3-by-2 matrix over C[t].

No all-degree closure is claimed.
No r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE CONTAINED (1,1,2) SCHEME HAS EXACTLY TWO GEOMETRIC TYPES
--------------------------------------------------------------------------

Assume

    K=(a,b,F) subset J.

Because a,b are independent linear forms and J is a height-three linear prime,
choose a linear form c such that

    J=(a,b,c).

Pass modulo (a,b):

    T:=S/(a,b) ~= C[c,t].

The image Fbar is a nonzero quadratic because a,b,F is a regular sequence. The
containment F in J says

    Fbar in (c).

Hence

    Fbar=c*ell

for one nonzero linear form ell in T_1.

There are exactly two cases.

CONTAINED-REDUCED:
  ell is independent of c. Lift ell to S and replace F by F plus an element of
  (a,b) so that

    K=(a,b,c*ell).

  Put

    J':=(a,b,ell).

  Since c and ell are independent modulo (a,b),

    K=J intersect J'.

  Thus Proj(S/K) is the reduced length-two pair consisting of the J-point and
  the distinct J'-point.

CONTAINED-DOUBLE:
  ell is proportional to c. After scaling F and changing it by an element of
  (a,b),

    K=(a,b,c^2).

  Thus Proj(S/K) is the length-two double point supported at J.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_two_types:
  If K subset J, then after homogeneous linear coordinates exactly one of

    K=(a,b,c*ell),  J=(a,b,c),  J'=(a,b,ell),  c,ell independent,

  or

    K=(a,b,c^2),    J=(a,b,c)

  occurs.
Qed.

--------------------------------------------------------------------------
2. FINAL-PAIR CUT BOUNDS IN THE TWO CONTAINED TYPES
--------------------------------------------------------------------------

First note that K subset J gives a quotient

    S/K -> S/J,

so after the final cut

    L_K>=L_J.

CONTAINED-REDUCED:
  Put

    L_J':=length_C S/(J',f,g).

  This is finite because Q subset K subset J' and A=S/(Q,f,g) is Artinian. As
  S/J'~=C[t], the same one-variable argument as for J gives

    3<=L_J'<=M.

  Since K=J intersect J' and

    J+J'=(a,b,c,ell)

  is the homogeneous maximal ideal, there is an exact sequence

    0 -> S/K
      -> S/J direct_sum S/J'
      -> C
      -> 0.

  The positive-degree forms f,g annihilate C. Applying the two-element Koszul
  complex gives

    L_J+L_J'-1 <= L_K <= L_J+L_J'+1.

  In particular

    L_K<=L_J+M+1.

CONTAINED-DOUBLE:
  Here

    S/K ~= C[c,t]/(c^2),
    S/J ~= C[t].

  Let h be whichever of f,g has smallest degree among those having nonzero
  restriction to S/J. Then

    deg(h)=L_J.

  Its image in C[c,t]/(c^2) is not in the unique associated prime (c), hence h
  is a homogeneous nonzerodivisor. Since S/K is one-dimensional Cohen-Macaulay
  of multiplicity two,

    length_C (S/K)/(h)=2*L_J.

  Quotienting further by the other final equation can only decrease length, so

    L_J<=L_K<=2*L_J.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_cut_bounds:
  In the reduced type,

    L_J+L_J'-1 <= L_K <= L_J+L_J'+1,
    L_J'<=M.

  In the double type,

    L_J<=L_K<=2*L_J.
Qed.

--------------------------------------------------------------------------
3. THE CONORMAL K/(J*K) IS EXACTLY FREE OF RANK THREE
--------------------------------------------------------------------------

Put

    R_J:=S/J ~= C[t].

Because K=(a,b,F) is a complete intersection of type (1,1,2), its ideal has the
Koszul presentation. Tensor that presentation with R_J.

Every entry in the Koszul syzygy matrices is one of a,b,F, hence lies in J in
the contained incidence. Therefore all presentation differentials vanish after
tensoring with R_J at the generator stage. Consequently

    K/(J*K)
      ~= R_J(-1) direct_sum R_J(-1) direct_sum R_J(-2).

Let e_a,e_b,e_F denote the three free conormal generators.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_conormal_free:
  If K subset J, then

    K/(J*K) ~= R_J(-1)^2 direct_sum R_J(-2).
Qed.

This explains why the finite Tor defect used in the noncontained incidence no
longer exists: the contained conormal defect has positive R_J-rank three.

--------------------------------------------------------------------------
4. ONLY q3 AND q4 SURVIVE IN THE CONORMAL QUOTIENT BY Q
--------------------------------------------------------------------------

Recall

    q1=r*a,
    q2=r*b.

Since r belongs to J,

    q1,q2 in J*K.

Thus the image of Q inside K/(J*K) is generated by the classes of q3 and q4.
Choose the standard degree-one generator t of R_J=C[t]. Since q3,q4 have degree
two, their classes have unique forms

    [q3]=alpha_3*t*e_a + beta_3*t*e_b + gamma_3*e_F,
    [q4]=alpha_4*t*e_a + beta_4*t*e_b + gamma_4*e_F,

for constants alpha_i,beta_i,gamma_i in C.

Define

    Phi:R_J(-2)^2 -> R_J(-1)^2 direct_sum R_J(-2)

by the 3-by-2 matrix

          [ alpha_3*t   alpha_4*t ]
    Phi = [ beta_3*t    beta_4*t  ].
          [ gamma_3     gamma_4   ]

Then

    C_Q:=K/(Q+J*K)=coker(Phi).

Put

    rho_Q:=rank_{C(t)}(Phi),

so

    rho_Q in {0,1,2}.

Since the free target has rank three,

    rank_{R_J}(C_Q)=3-rho_Q.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_Q_conormal_matrix:
  The full effect of Q on the contained conormal carrier is encoded by the
  displayed 3-by-2 matrix Phi over C[t].
Qed.

--------------------------------------------------------------------------
5. THE TORSION OF coker(Phi) HAS LENGTH AT MOST TWO
--------------------------------------------------------------------------

Because R_J=C[t] is a PID, write

    C_Q ~= R_J^(3-rho_Q) direct_sum T_Q

up to graded shifts, where T_Q is finite torsion. Put

    tau_Q:=length_C(T_Q).

The special degree shape of Phi bounds tau_Q sharply.

If rho_Q=0, Phi=0 and

    tau_Q=0.

If rho_Q=1, the unique nonzero Smith invariant is the gcd of the entries of
Phi. The entries are either constants or scalar multiples of t. Therefore the
gcd is either 1 or t, so

    tau_Q<=1.

If rho_Q=2, the product of the two nonzero Smith invariants is the gcd of the
2-by-2 minors. Every nonzero such minor is a scalar multiple of t or t^2.
Hence the gcd has t-adic order at most two and

    tau_Q<=2.

Uniformly,

    tau_Q<=2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_conormal_torsion_bound:
  One has

    tau_Q<=2,

  with the sharper bounds

    rho_Q=0 => tau_Q=0,
    rho_Q=1 => tau_Q<=1,
    rho_Q=2 => tau_Q<=2.
Qed.

--------------------------------------------------------------------------
6. PRODUCT-CUT CODIMENSION REDUCES TO rho_Q
--------------------------------------------------------------------------

Because Q+J*K subset K, there is an exact sequence

    0 -> C_Q
      -> S/(Q+J*K)
      -> S/K
      -> 0.

In R_J=C[t], the final pair generates

    (f,g)R_J=(t^L_J).

Therefore

    length_C C_Q/(f,g)C_Q
      <= (3-rho_Q)*L_J + tau_Q.

Applying H_0(f,g;-) to the exact sequence gives

    C_A:=length_C A/(K_A*J_A)
      =length_C S/(Q+J*K,f,g)
      <=L_K+(3-rho_Q)*L_J+tau_Q.

Hence the three exact numerical carriers are

    rho_Q=0:
      C_A<=L_K+3*L_J,

    rho_Q=1:
      C_A<=L_K+2*L_J+1,

    rho_Q=2:
      C_A<=L_K+L_J+2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_product_cut_rank_reduction:
  The contained product-cut obstruction is reduced to the single finite
  invariant rho_Q=rank_{C(t)} Phi, with the three bounds above.
Qed.

This is strictly sharper than treating K and J as unrelated three-generated
ideals whenever rho_Q>=1.

--------------------------------------------------------------------------
7. THE rho_Q=2 CARRIER EXTENDS THE DEGREE-BOUND CLOSURE
--------------------------------------------------------------------------

Retain from the preceding tangent reduction

    N=d*e+L_D,
    L_D>=max(L_K,L_J).

Since K subset J gives L_K>=L_J,

    N>=d*e+L_K.

For rho_Q=2,

    C_A<=L_K+L_J+2.

Thus

    t(A)-(N-20)
      >=N-2*C_A+20
      >=d*e-L_K-2*L_J+16.

CONTAINED-REDUCED:
  Using

    L_K<=L_J+L_J'+1,
    L_J<=M,
    L_J'<=M,
    d*e>=3*M,

  gives

    t(A)-(N-20)
      >=d*e-3*L_J-L_J'+15
      >=15-M.

  Therefore this carrier is tangent-excluded whenever

    M<=14.

CONTAINED-DOUBLE:
  Using L_K<=2*L_J gives

    t(A)-(N-20)
      >=d*e-4*L_J+16
      >=16-M.

  Therefore this carrier is tangent-excluded whenever

    M<=15.

Uniformly across both contained geometric types,

    rho_Q=2 and M<=14

is tangent-excluded.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rank2_degree14_closed:
  In the contained incidence, if rho_Q=2 and max(d,e)<=14, then

    t(A)>N-20.
Qed.

No claim is made here for rho_Q=2 with larger final degrees or for rho_Q<=1.

--------------------------------------------------------------------------
8. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_reduced_or_double.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_cut_bounds.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_conormal_rank_three.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_Q_conormal_matrix.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_torsion_at_most_two.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_product_cut_rank_reduction.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_LK3_C2_r_in_P_contained_rank2_degree14_tangent_closed.

CURRENT_R_IN_P_STATUS:
  K not subset J is tangent-closed for all d,e>=3 by the preceding file.

  K subset J now reduces to

    CONTAINED-REDUCED or CONTAINED-DOUBLE,

  together with the finite coefficient-matrix invariant

    rho_Q in {0,1,2}.

  The rho_Q=2 subcarrier is additionally tangent-closed for M<=14 uniformly
  (and in the double type for M<=15).

IMPORTANT_NONCONCLUSION:
  This file does NOT prove rho_Q=2.
  It does NOT exclude rho_Q=0 or rho_Q=1.
  It does NOT close rho_Q=2 for arbitrary large final degree.
  It does NOT close the full contained incidence.
  It does NOT close the full r-in-P carrier.
  It does NOT close LK3-C2 or R2-LK3.
  It does NOT treat r-not-in-P, LK3-C3, R2-LK2, R2-QK, or H01-M2-R1.
  It does NOT close H01.
  It does NOT enter q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_mge3_closed.
  H01_m2_tau3_two_empty.
  H01_m2_R2_exact_Betti_table.
  H01_m2_R2_determinantal_factorization.
  H01_m2_R2_LK3_coefficient_rank_one_empty.
  H01_m2_R2_LK3_C2_r_in_P_noncontained_all_degrees_tangent_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_two_type_classification.
  H01_m2_R2_LK3_C2_r_in_P_contained_Q_conormal_matrix_reduction.
  not H01_m2_R2_LK3_C2_r_in_P_contained_all_degrees_closed.
  not H01_m2_R2_LK3_C2_r_in_P_all_degrees_closed.
  not H01_m2_R2_LK3_C2_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in the contained r-in-P LK3-C2 incidence. Determine the generic
  rank rho_Q of the explicit matrix

          [ alpha_3*t   alpha_4*t ]
    Phi = [ beta_3*t    beta_4*t  ]
          [ gamma_3     gamma_4   ]

  from the repository-native q3,q4 normal form. The weakest useful next result
  is to exclude rho_Q=0, or to prove rho_Q=2 in the double type, before any new
  global tangent estimate.
