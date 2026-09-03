Standalone proof repair for the exact H00 tangent endpoint in the homogeneous
q=4, height-two multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H00_tangent_closed.v

  at the exact H00 reduced P1P1 residual ring

    R0 = C[h,u]/(u*(u-h)),
    m0=(h,u),

  with homogeneous final restrictions

    f0 in (R0)_d,
    g0 in (R0)_e,
    d,e>=3,

  and

    K0=(f0,g0),
    Lcut=length_C(R0/K0)<infinity,
    M=max(d,e).

The tangent-closure file asserted the correct numerical bound

    Lcut <= 2*M,

but its reduced-case proof used the statement that the embedding of R0 into the
direct sum of its two branch rings induces an injection after quotienting by K0.
That quotient injection does not follow formally from the ring embedding alone.

This file replaces only that reduced-case argument by a degreewise proof using
the exact fiber-product structure of R0.  No tangent inequality, H01/H11 claim,
or parent truth state is otherwise changed.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. EXACT FIBER-PRODUCT DESCRIPTION OF THE REDUCED H00 RING
--------------------------------------------------------------------------

Define

    phi : R0 -> C[h] direct_sum C[h]

by

    phi(p(h,u)) := (p(h,0), p(h,h)).

Theorem H00_reduced_ring_is_the_equal_constant_fiber_product:
  The map phi is injective and its image is

    {(A(h),B(h)) : A(0)=B(0)}.

  Equivalently,

    R0 ~= C[h] fiber_product_C C[h],

  where both polynomial rings map to C by evaluation at h=0.

Proof:
  The two minimal primes of u*(u-h) are

    (u),
    (u-h).

  Their intersection in C[h,u] is the principal ideal

    (u*(u-h)),

  so simultaneous restriction to the two branches is injective modulo that
  ideal.

  A polynomial has the same constant value on both branches, giving the stated
  containment of the image.

  Conversely, if A(0)=B(0), then B-A is divisible by h.  Write

    B(h)-A(h)=h*C(h).

  The class

    A(h)+u*C(h)

  restricts to A(h) on u=0 and to

    A(h)+h*C(h)=B(h)

  on u=h.  Hence every equal-constant pair lies in the image.
Qed.

Corollary H00_positive_degree_piece_is_two_independent_branch_coordinates:
  For every n>=1,

    (R0)_n ~= C*h^n direct_sum C*h^n.

  In particular

    dim_C (R0)_n = 2.

Proof:
  A homogeneous positive-degree pair has zero constant on both branches, so the
  equal-constant condition imposes no relation.  Each branch contributes one
  scalar multiple of h^n.
Qed.

--------------------------------------------------------------------------
2. FINITE COLENGTH FORCES BOTH BRANCHES TO BE HIT
--------------------------------------------------------------------------

Write the branch restrictions as

    phi(f0)=(alpha_1*h^d, alpha_2*h^d),
    phi(g0)=(beta_1*h^e,  beta_2*h^e).

Theorem H00_reduced_primary_cut_hits_each_branch:
  For i=1,2, at least one of

    alpha_i,
    beta_i

  is nonzero.

Proof:
  Suppose both coefficients vanish on branch i.  Then every element of K0
  restricts to zero on that branch.  The quotient R0/K0 therefore still maps
  onto the branch polynomial ring C[h], so it has infinite length.  This
  contradicts the standing finiteness of Lcut.
Qed.

--------------------------------------------------------------------------
3. EVERY DEGREE STRICTLY ABOVE M IS ALREADY IN K0
--------------------------------------------------------------------------

Theorem H00_reduced_cut_fills_all_degrees_above_M:
  For every n>M,

    (K0)_n=(R0)_n.

Proof:
  Fix n>M.

  By the positive-degree fiber-product description,

    (R0)_n ~= C*h^n direct_sum C*h^n.

  It is enough to produce the two branch basis vectors independently.

  On branch one, choose f0 if alpha_1!=0 and otherwise choose g0; this is
  possible by the preceding theorem.  If the chosen generator has degree r in
  {d,e}, then

    n-r >= 1

  because n>M>=r.

  The degree-(n-r) piece of R0 has two independent branch coordinates.  Choose a
  multiplier whose restriction is h^(n-r) on branch one and zero on branch two.
  Multiplication by the chosen generator produces a nonzero scalar multiple of

    (h^n,0)

  inside (K0)_n.

  Repeat the same argument on branch two to obtain

    (0,h^n).

  These two vectors span (R0)_n.  Hence (K0)_n=(R0)_n.
Qed.

--------------------------------------------------------------------------
4. THE TOP POSSIBLE QUOTIENT DEGREE HAS DIMENSION AT MOST ONE
--------------------------------------------------------------------------

Theorem H00_reduced_degree_M_quotient_has_dimension_at_most_one:
  One has

    dim_C (R0/K0)_M <= 1.

Proof:
  The two-dimensional space (R0)_M contains a nonzero element of (K0)_M.

  Indeed, if a degree-M generator among f0,g0 has nonzero image in R0, it itself
  supplies such an element.

  If every degree-M displayed generator vanishes in R0, then some lower-degree
  displayed generator must be nonzero because K0 is m0-primary.  Let its degree
  be r<M.  Multiplication by any positive-degree branch multiplier in

    (R0)_(M-r)

  on a branch where that generator is nonzero gives a nonzero element of
  (K0)_M.

  Thus (K0)_M is a nonzero subspace of the two-dimensional vector space
  (R0)_M, so the quotient has dimension at most one.
Qed.

--------------------------------------------------------------------------
5. REPAIRED MULTIPLICITY-TWO CUT BOUND
--------------------------------------------------------------------------

Theorem H00_reduced_multiplicity_two_cut_bound_repaired:
  One has

    Lcut <= 2*M.

Proof:
  Degree zero contributes exactly one dimension to R0/K0 because K0 is generated
  in positive degrees.

  For degrees

    1 <= n < M,

  each quotient piece has dimension at most

    dim_C (R0)_n = 2.

  Degree M contributes at most one dimension by the preceding theorem.

  Every degree n>M contributes zero by the theorem that K0 fills all such
  degrees.

  Therefore

    Lcut
      <= 1 + 2*(M-1) + 1
      = 2*M.
Qed.

Corollary H00_uniform_multiplicity_two_cut_bound_is_restored:
  The theorem

    Lcut <= 2*max(d,e)

  used in the H00 tangent-closure file is valid in both residual cases:

  REDUCED P1P1:
    by the repaired degreewise fiber-product argument above;

  JORDAN J2:
    by the existing nonzerodivisor argument in
    order13_q4_height2_depth_one_multiplicity_one_H00_tangent_closed.v.
Qed.

--------------------------------------------------------------------------
6. CONSEQUENCE FOR THE EXISTING H00 TANGENT INEQUALITY
--------------------------------------------------------------------------

The downstream H00 closure uses only

    Lcut <= 2*max(d,e)

from the repaired step.  All later established inequalities therefore remain
unchanged:

    t(A) >= 2*N-2*Lcut-6,

    N >= d*e+Lcut,

and hence

    t(A)-(N-20)
      >= d*e-Lcut+14
      >= d*e-2*max(d,e)+14
      > 0

for d,e>=3.

Thus the reduced P1P1 proof gap does not reopen the H00 endpoint; it is repaired
without changing the numerical conclusion.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

REPAIRED:
  q4_height2_multiplicity_one_depth_one_H00_reduced_P1P1_cut_bound.

RESTORED:
  q4_height2_multiplicity_one_depth_one_H00_tangent_closed.

IMPORTANT_NONCONCLUSION:
  This file does NOT enter H11 or H01.
  It does NOT close the full multiplicity-one depth-one branch.
  It does NOT close q=4 height two.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

NEXT_ACTIONS:
  1. Leave H00 and H10; both are tangent-closed after this repair.
  2. Stay in q=4 height-two multiplicity one.
  3. Enter only H11.
  4. Determine the smallest exact Artinian reduction Hilbert function beyond t+t^2.
  5. Stop before H01 or q<=3.
