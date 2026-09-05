Standalone determinantal-alignment reduction for the rho_Q=1 contained leaf of the
r-in-P LK3-C2 carrier in the saturated H01 minimal-chain rank-two endpoint of
the homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_normal_forms.v

  together with the already-established R2 facts

    sigma=3,

    0 -> S(-5)
      -> S(-3)^3 direct_sum S(-4)
      -> S(-2)^4
      -> S
      -> S/Q
      -> 0,

  and, for the 4-by-3 matrix L of the complete linear syzygy space of Q,

    I_3(L)=(r)Q.

Here r is the same distinguished linear form used throughout the r-in-P branch,
including K=(Q:r).

The preceding rho_Q=1 classification leaves exactly eight canonical ideals:

  AP-D,
  AP-R,
  AR0,
  AR1,
  ANR-P2-D,
  ANR-P2-R,
  ANR-PC-D,
  ANR-PC-R.

This file performs one bounded task only: compute the complete three-dimensional
linear-syzygy space for each canonical ideal and compare the common factor of its
maximal minors with the forced determinantal factor r.

No tangent estimate is made.  No rho_Q=2, r-not-in-P, LK3-C3, R2-LK2,
R2-QK, H01-M2-R1, or q<=3 branch is entered.  No Oblivion Closure promotion
is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE COMMON MAXIMAL-MINOR FACTOR IS AN INVARIANT
--------------------------------------------------------------------------

Because sigma=3, the linear syzygies of the four quadratic generators form an
exact three-dimensional C-vector space.  Choosing another basis multiplies the
4-by-3 syzygy matrix L on the right by an element of GL_3(C), hence multiplies
all signed 3-by-3 maximal minors by the same nonzero scalar.

Since ht(Q)=2, the four quadratic generators are primitive: they have no common
nonconstant factor.  Therefore, whenever the signed maximal-minor vector is

    Delta=lambda*(q1,q2,q3,q4),

with lambda linear, the line C*lambda is intrinsic to Q and to its full linear
syzygy space.

The previously established determinantal factorization gives

    Delta=r*(q1,q2,q3,q4)

up to one common nonzero scalar.  Consequently every surviving canonical form
must have intrinsic common maximal-minor factor proportional to r.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_factor_alignment:
  In every surviving rho_Q=1 canonical carrier, the common linear factor of the
  signed maximal minors of the complete linear-syzygy matrix is proportional to
  r.
Qed.

--------------------------------------------------------------------------
2. AP-D HAS THE REQUIRED FACTOR r
--------------------------------------------------------------------------

For

    AP-D:
      Q=(r^2,
         r*p,
         p^2+r*c,
         p*c+r*t),

one basis of the complete linear-syzygy space is given by the columns of

        [ -p  -c  -t ]
    L = [  r  -p  -c ]
        [  0   r   0 ]
        [  0   0   r ].

Its signed maximal minors are

    (r^3,
     p*r^2,
     r*(p^2+r*c),
     r*(p*c+r*t)).

Thus

    Delta=r*(q1,q2,q3,q4),
    I_3(L)=(r)Q.

Hence AP-D is compatible with the determinantal alignment.

--------------------------------------------------------------------------
3. AP-R HAS THE REQUIRED FACTOR r
--------------------------------------------------------------------------

For

    AP-R:
      Q=(r^2,
         r*p,
         p^2+r*t,
         p*c),

one basis of the complete linear-syzygy space is given by

        [ -p  -t   0 ]
    L = [  r  -p  -c ]
        [  0   r   0 ]
        [  0   0   r ].

Its signed maximal minors are

    (r^3,
     p*r^2,
     r*(p^2+r*t),
     r*p*c).

Therefore

    Delta=r*(q1,q2,q3,q4),
    I_3(L)=(r)Q.

Hence AP-R is also compatible with the determinantal alignment.

--------------------------------------------------------------------------
4. BOTH AR FORMS HAVE COMMON FACTOR c, NOT r
--------------------------------------------------------------------------

For

    AR0:
      Q=(r^2,r*c,p*c,p^2),

use

        [ -c   0   0 ]
    L = [  r  -p   0 ]
        [  0   r  -p ]
        [  0   0   c ].

The signed maximal minors are

    (c*r^2,
     c*(r*c),
     c*(p*c),
     c*p^2)

so the intrinsic common factor is c.

For

    AR1:
      Q=(r^2,r*c,p*c,p^2+r*t),

use

        [ -c   0   0 ]
    L = [  r  -p  -t ]
        [  0   r  -p ]
        [  0   0   c ].

The signed maximal minors are

    (c*r^2,
     c*(r*c),
     c*(p*c),
     c*(p^2+r*t)).

Again the intrinsic common factor is c.

In the AR coordinate normalization

    J=(r,p,c),

r and c are independent.  Hence c is not proportional to r, contradicting the
forced determinantal alignment.

Therefore both AR0 and AR1 are empty under the full R2 hypotheses.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AR_empty:
  Neither AR0 nor AR1 can occur.
Qed.

--------------------------------------------------------------------------
5. BOTH ANR-P2 FORMS HAVE COMMON FACTOR p, NOT r
--------------------------------------------------------------------------

For

    ANR-P2-D:
      Q=(r*p,r*c,p^2,p*c+r^2),

use

        [ -c  -p  -r ]
    L = [  p   0   0 ]
        [  0   r  -c ]
        [  0   0   p ].

The signed maximal minors are

    (p*(r*p),
     p*(r*c),
     p*p^2,
     p*(p*c+r^2)).

Thus the intrinsic common factor is p.

For

    ANR-P2-R:
      Q=(r*p,r*c,p^2,p*c+r*t),

use

        [ -c  -p  -t ]
    L = [  p   0   0 ]
        [  0   r  -c ]
        [  0   0   p ].

Its signed maximal minors are

    (p*(r*p),
     p*(r*c),
     p*p^2,
     p*(p*c+r*t)).

Again the common factor is p.

In the ANR normalization P=(r,p), with r and p independent.  Hence p is not
proportional to r.  Both ANR-P2 carriers contradict the determinantal alignment.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_ANR_P2_empty:
  Neither ANR-P2-D nor ANR-P2-R can occur.
Qed.

--------------------------------------------------------------------------
6. BOTH ANR-PC FORMS HAVE COMMON FACTOR c, NOT r
--------------------------------------------------------------------------

For

    ANR-PC-D:
      Q=(r*p,r*c,p*c,p^2+r^2),

use

        [ -c  -c   0 ]
    L = [  p   0  -r ]
        [  0   r  -p ]
        [  0   0   c ].

The signed maximal minors are

    (c*(r*p),
     c*(r*c),
     c*(p*c),
     c*(p^2+r^2)).

For

    ANR-PC-R:
      Q=(r*p,r*c,p*c,p^2+r*t),

use

        [ -c  -c   0 ]
    L = [  p   0  -t ]
        [  0   r  -p ]
        [  0   0   c ].

The signed maximal minors are

    (c*(r*p),
     c*(r*c),
     c*(p*c),
     c*(p^2+r*t)).

Thus both ANR-PC forms have intrinsic common factor c.

In the ANR normalization J=(r,p,c), r and c are independent.  Hence c is not
proportional to r, so both forms contradict the determinantal alignment.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_ANR_PC_empty:
  Neither ANR-PC-D nor ANR-PC-R can occur.
Qed.

--------------------------------------------------------------------------
7. EXACT rho_Q=1 DETERMINANTAL FRONTIER
--------------------------------------------------------------------------

The eight-form rho_Q=1 frontier has therefore collapsed to exactly two
not-yet-excluded canonical carriers:

    AP-D:
      K=(r,p,c^2),
      Q=(r^2,r*p,p^2+r*c,p*c+r*t);

    AP-R:
      K=(r,p,c*t),
      Q=(r^2,r*p,p^2+r*t,p*c).

Equivalently, the determinantal identity forces

    A=K_1=P_1=span_C{r,p}.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_determinantal_frontier:
  Under the full R2 determinantal factorization, every contained rho_Q=1 carrier
  is linearly equivalent to AP-D or AP-R.
Qed.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude AP-D or AP-R.
  It does NOT tangent-close rho_Q=1.
  It does NOT enter rho_Q=2.
  It does NOT close the contained incidence.
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
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AR_empty.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_ANR_empty.
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_closed.
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
  Close AP-D and AP-R separately.  Their exact determinantal matrices are now
  fixed and may be fed directly into the tangent-product-cut calculation; do not
  reopen the six determinantal-misaligned forms.

NEXT_ACTIONS:
  1. Attack AP-D first using K=(r,p,c^2), J=(r,p,c), and the exact displayed L.
  2. Derive the sharp product-cut length C_A rather than the generic rho_Q=1
     upper bound.
  3. Stop if no strict tangent inequality follows for all final degrees.
