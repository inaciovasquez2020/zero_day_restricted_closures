Standalone mod-r kernel-degree reduction of the saturated H01 minimal-chain rank-two
endpoint in the homogeneous q=4, height-two multiplicity-one, depth-one
order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_determinantal_factorization.v

  and retain

    S := C[x1,x2,x3,x4],
    Q=(q1,q2,q3,q4)=Qsat,
    B:=S/Q,

with Q generated minimally by exactly four independent quadrics, ht(Q)=2,
and exact minimal resolution

    0
      -> S(-5)
      -> S(-3)^3 direct_sum S(-4)
      -> S(-2)^4
      -> S
      -> B
      -> 0.

Write the second differential as

    A=[L1 L2 L3 Q4],
    L=[L1 L2 L3],

where L is 4-by-3 with linear entries, and write the final differential as

    d3=(a1,a2,a3,r)^T

with ai quadratic and r a nonzero linear form.  The preceding determinantal
factorization gives, after scalar normalization,

    Delta_i(L)=r*q_i

for the signed 3-by-3 maximal minors, equivalently

    I3(L)=(r)*Q,
    (I3(L):(r))=Q.

Put

    Sbar:=S/(r),
    M:=L mod r,
    abar:=(a1,a2,a3) mod r.

The preceding file proves

    abar != 0,
    M*abar=0.

This file performs one bounded task only: factor the common divisor of the
quadratic kernel vector abar and exclude the case in which its primitive part
is constant.

No tangent estimate is made.
No exclusion of H01-M2-R2 is claimed.
No H01-M2-R1 or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. PRIMITIVE FACTORIZATION OF THE MOD-r KERNEL VECTOR
--------------------------------------------------------------------------

Because r is a nonzero linear form,

    Sbar ~= C[y1,y2,y3]

is a UFD and a domain.  Let

    g := gcd(abar_1,abar_2,abar_3)

up to a nonzero scalar, and write

    abar=g*b,
    b=(b1,b2,b3)^T,

where b is primitive: its nonzero components have no common nonconstant factor.
Since abar is a nonzero homogeneous quadratic vector,

    deg(g) in {0,1,2}.

From

    M*(g*b)=0

and the fact that Sbar is a domain with g!=0, one obtains

    M*b=0.

Theorem H01_m2_R2_mod_r_has_primitive_kernel_vector:
  The rank-drop matrix M=L mod r has a nonzero primitive homogeneous right-kernel
  vector b of degree

    deg(b)=2-deg(g).
Qed.

--------------------------------------------------------------------------
2. A DEGREE-TWO COMMON FACTOR WOULD FORCE A CONSTANT KERNEL
--------------------------------------------------------------------------

Assume for contradiction that

    deg(g)=2.

Then b is a nonzero constant vector in C^3. Choose an invertible constant column
change

    V in GL_3(C)

so that, after replacing L by

    L':=L*V,

the corresponding constant kernel vector is the third coordinate vector. Thus
the third column of

    M':=L' mod r

is zero.

Since the entries of L' are linear, its third column must therefore have the
form

    r*v

for a constant vector

    v in C^4.

Moreover v!=0. If v=0, then L' would have only two nonzero columns over S and
hence rank at most two over Frac(S), contradicting the previously proved

    rank_Frac(S)(L)=3.

Write

    L'=[C1 C2 r*v]

and define the mixed-degree matrix

    N:=[C1 C2 v].

--------------------------------------------------------------------------
3. CANCELLING r FROM THE MAXIMAL MINORS RECOVERS THE FOUR QUADRICS
--------------------------------------------------------------------------

Right multiplication by the constant matrix V multiplies every signed maximal
minor by det(V). Hence

    Delta(L')=det(V)*Delta(L)
             =det(V)*r*q.

On the other hand, every maximal minor of L' has r as the factor contributed by
its third column, so

    Delta(L')=r*Delta(N).

Since S is a domain and r!=0, cancellation gives

    Delta(N)=det(V)*q.

Thus the four signed maximal minors of N are, up to one common nonzero scalar,
exactly the four original independent quadrics.

Theorem H01_m2_R2_constant_kernel_recovers_quadric_row:
  Under the assumption deg(g)=2,

    Delta(N)=det(V)*(q1,q2,q3,q4).
Qed.

--------------------------------------------------------------------------
4. THE CONSTANT THIRD COLUMN FORCES A CONSTANT LINEAR DEPENDENCE
--------------------------------------------------------------------------

For every 4-by-3 matrix N, its signed cofactor row is in the left kernel:

    Delta(N)*N=0.

Apply this identity to the constant third column v. One gets

    Delta(N)*v=0.

Using the preceding identity,

    det(V)*q*v=0.

Since det(V)!=0 and v is a nonzero constant vector, this is a nontrivial
C-linear relation among

    q1,q2,q3,q4.

But the standing H01-M2-R2 hypothesis says those four quadrics are linearly
independent. Contradiction.

Theorem H01_m2_R2_mod_r_constant_primitive_kernel_impossible:
  The case

    deg(g)=2

is empty.
Qed.

Equivalently, the common divisor of the three quadratic components of abar has
degree at most one:

    deg(g)<=1.

--------------------------------------------------------------------------
5. THE LINEAR PRIMITIVE KERNEL HAS SPAN TWO OR THREE
--------------------------------------------------------------------------

Suppose

    deg(g)=1.

Then b is a primitive vector of linear forms. Let

    s:=dim_C span_C{b1,b2,b3}.

Since b is nonzero,

    1<=s<=3.

The case s=1 is impossible. Indeed, then there is a nonzero linear form ell in
Sbar_1 and constants ci, not all zero, such that

    bi=ci*ell

for all i.  The form ell would divide every nonzero component of b, contradicting
primitivity. Therefore

    s in {2,3}.

Theorem H01_m2_R2_linear_primitive_kernel_span:
  If deg(g)=1, the primitive linear kernel vector has coefficient span exactly
  two or three.
Qed.

--------------------------------------------------------------------------
6. EXACT THREE-CARRIER REDUCTION
--------------------------------------------------------------------------

The preceding sections leave exactly three internal kernel carriers.

R2-QK:
  deg(g)=0. Then b is a primitive quadratic kernel vector of M.

R2-LK2:
  deg(g)=1 and

    dim_C span{b1,b2,b3}=2.

R2-LK3:
  deg(g)=1 and

    dim_C span{b1,b2,b3}=3.

The degree-two common-factor / constant-kernel carrier has been excluded.

Theorem H01_m2_R2_mod_r_kernel_degree_reduction:
  Every H01-M2-R2 endpoint lies in exactly one of

    R2-QK,
    R2-LK2,
    R2-LK3.
Qed.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_primitive_mod_r_kernel.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_constant_kernel_excluded.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_linear_kernel_span_two_or_three.
  q4_height2_multiplicity_one_depth_one_H01_m2_R2_three_kernel_carriers.

EXACT_REDUCTION:

    H01-M2-R2
      -> R2-QK or R2-LK2 or R2-LK3.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude H01-M2-R2.
  It does NOT exclude R2-QK, R2-LK2, or R2-LK3.
  It does NOT make a tangent-space estimate.
  It does NOT treat H01-M2-R1.
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
  H01_m2_R2_constant_kernel_empty.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in H01-M2-R2. Classify the three surviving primitive mod-r kernel
  carriers. The first bounded target should be R2-LK3: after a constant column
  basis change and a linear coordinate change on Sbar, normalize

    b=(y1,y2,y3)^T.

  Then every row of M is a linear syzygy of (y1,y2,y3), hence is a constant
  combination of the three Koszul syzygies. Determine the resulting lifted
  normal form for L and whether the identity

    I3(L)=(r)Q

  forces an excluded quadric configuration or a direct tangent carrier.

NEXT_ACTIONS:
  1. Classify the R2-LK3 Koszul normal form modulo r.
