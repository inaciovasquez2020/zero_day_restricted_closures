Standalone square-syzygy/colon reduction of the remaining H01-M2-R1 endpoint
in the homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Retain the established H01-M2-R1 data

    S := C[x1,x2,x3,x4],
    P := (l1,l2),
    Q subset Qsat subset P,
    D := P/Qsat,
    T := Qsat/Q,

with

    Q generated minimally by exactly four independent quadrics,
    Qsat = Q+(gamma),
    gamma of degree three,
    T ~= S/(Q:gamma)(-3),
    sigma=4,
    tau_3=1,

and exact minimal S-resolution

    0 -> S(-4) direct_sum S(-5)
      -> S(-3)^4 direct_sum S(-4)^2
      -> S(-2)^5 direct_sum S(-3)
      -> S(-1)^2
      -> D
      -> 0.

The H01-M2-R2 branch is already closed.  This file performs one bounded task
only: derive the exact saturated-core resolution, isolate the square matrix of
four linear syzygies among the four quadrics, and identify the degree-one part
of the cyclic saturation colon with the gamma-coefficient map of the two
quartic syzygies.

No tangent closure is claimed here.  No q<=3 or Oblivion Closure promotion is
made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. REMOVE THE INTRINSIC KOSZUL GENERATOR
--------------------------------------------------------------------------

The presentation of P gives

    0 -> S(-2) -> S(-1)^2 -> P -> 0.

Pulling Qsat subset P back to S(-1)^2 gives the relation module K_D and an exact
sequence

    0 -> S(-2) -> K_D -> Qsat -> 0.

The embedded S(-2) is the intrinsic Koszul relation between l1 and l2.  In the
minimal free cover

    F1=S(-2)^5 direct_sum S(-3) -> K_D,

this intrinsic relation is one of the five minimal degree-two generators.
Choose the degree-two basis so that the first S(-2) maps to it.

Quotient F1 by that basis summand.  Exactness is preserved: if a relation from
F2 mapped after quotient to zero, its image in F1 would be a multiple of the
intrinsic basis vector; mapping further to K_D would say that a nonzero
polynomial kills the intrinsic Koszul relation, impossible over the domain S.
Thus the projected kernel is still exactly the image of F3.

No unit entry is introduced by deleting one target row, so the projected
resolution remains minimal.

Therefore the saturated core Ccore:=S/Qsat has exact minimal resolution

    0 -> S(-4) direct_sum S(-5)
      -> S(-3)^4 direct_sum S(-4)^2
      -> S(-2)^4 direct_sum S(-3)
      -> S
      -> Ccore
      -> 0.

Theorem H01_m2_R1_exact_saturated_core_resolution:
  The displayed resolution is the exact minimal graded S-resolution of
  S/Qsat.
Qed.

Its Hilbert numerator is

    1-(4*t^2+t^3)+(4*t^3+2*t^4)-(t^4+t^5)
      =1-4*t^2+3*t^3+t^4-t^5,

as required by the already-known H01 m=2 saturated-core Hilbert series.

--------------------------------------------------------------------------
2. BLOCK FORM OF THE SATURATED FIRST-SYZYGY MATRIX
--------------------------------------------------------------------------

Use the minimal generator row

    (q1,q2,q3,q4,gamma)

for Qsat, where the qi are the original four quadrics and gamma is the unique
cubic saturation generator.

The four S(-3) summands in the first-syzygy module give degree-three syzygies.
Their coefficients on gamma would have degree zero.  Minimality forbids any
nonzero degree-zero entry, so every one of these four syzygies has zero gamma
coefficient.

Hence the degree-three part of the first-syzygy differential has block form

          [ L ]
          [ 0 ]

where L is a 4-by-4 matrix of linear forms and

    (q1,q2,q3,q4)*L=0.

These are exactly the four independent linear syzygies counted by sigma=4.

The two S(-4) summands give quartic syzygies.  Write their block as

          [ U ]
          [lambda]

with

    U a 4-by-2 matrix of quadratic forms,
    lambda=(ell1,ell2) a 1-by-2 row of linear forms.

The first-syzygy identities are therefore

    q*L=0,
    q*U + gamma*lambda=0,

where q=(q1,q2,q3,q4).

Theorem H01_m2_R1_square_linear_syzygy_block:
  The four linear first syzygies of Q form a square 4-by-4 linear matrix L,
  while every linear coefficient multiplying gamma occurs in the two-entry row

    lambda=(ell1,ell2)

  of the quartic syzygy block.
Qed.

--------------------------------------------------------------------------
3. THE LINEAR COLON IS EXACTLY THE IMAGE OF THE TWO QUARTIC COEFFICIENTS
--------------------------------------------------------------------------

Put

    K_gamma:=(Q:gamma).

The quartic syzygy identities give

    ell_j*gamma in Q

for j=1,2, so

    span_C{ell1,ell2} subset (K_gamma)_1.

Conversely, let ell belong to (K_gamma)_1.  Then

    ell*gamma=sum_i A_i*q_i

for quadratic forms A_i.  Thus

    (A_1,A_2,A_3,A_4,-ell)

is a degree-four first syzygy of the minimal generators of Qsat.

Every degree-four first syzygy is a sum of

  * a linear-form multiple of one of the four minimal degree-three syzygies,
    and
  * a constant linear combination of the two minimal degree-four syzygies.

The first class has gamma coefficient zero by Section 2.  Therefore the gamma
coefficient -ell lies in the C-span of ell1,ell2.

Hence

    (Q:gamma)_1 = span_C{ell1,ell2}.

Theorem H01_m2_R1_linear_colon_coefficient_identity:
  One has the exact equality

    (Q:gamma)_1=span_C{ell1,ell2}.
Qed.

In particular

    dim_C (Q:gamma)_1 <= 2,

and the cyclic Artinian saturation quotient

    S/(Q:gamma)

has embedding dimension

    e_col=4-dim_C(Q:gamma)_1 >= 2.

Thus R1 cannot fall into a residue-field or one-variable colon type.

--------------------------------------------------------------------------
4. THE FIRST FINAL SYZYGY LIES ENTIRELY IN THE LINEAR BLOCK
--------------------------------------------------------------------------

Write the final differential from the S(-4) summand as a column into

    S(-3)^4 direct_sum S(-4)^2.

Its coefficients toward the two S(-4) target summands would have degree zero.
Minimality forces them to vanish.  Hence this final column has form

    (u1,u2,u3,u4,0,0)^T

with ui linear forms, not all zero by exactness/minimality.

The equation d2*d3=0 then gives

    L*u=0,

where u=(u1,u2,u3,u4)^T.

Thus the square linear matrix L has a nonzero linear right-kernel vector.
Together with q*L=0 it has both the distinguished quadratic left kernel q and a
nonzero linear right kernel u.

Theorem H01_m2_R1_square_matrix_two_sided_kernel:
  The 4-by-4 linear syzygy matrix satisfies

    q*L=0,
    L*u=0,

  with q the primitive four-quadric generator row and u a nonzero linear
  column.
Qed.

--------------------------------------------------------------------------
5. THE SECOND FINAL SYZYGY COUPLES THE COLON ROW
--------------------------------------------------------------------------

Write the final differential from S(-5) as

    (a1,a2,a3,a4,b1,b2)^T

with ai quadratic and bj linear.  The equation d2*d3=0 splits into

    L*a + U*b=0,
    ell1*b1+ell2*b2=0.

Therefore the quartic-colon row lambda and the linear tail b=(b1,b2)^T satisfy
the exact rank-one relation

    lambda*b=0.

If ell1,ell2 are independent, every linear syzygy between them is a scalar
multiple of

    (ell2,-ell1)^T,

so either b=0 or, after rescaling the S(-5) generator,

    b=(ell2,-ell1)^T.

If dim span{ell1,ell2}=1, a change of basis of the two quartic syzygies gives

    lambda=(ell,0),

and then b1=0.

Theorem H01_m2_R1_colon_tail_coupling:
  The exact final relation satisfies

    lambda*b=0,

  with the preceding normal forms according to rank(lambda).
Qed.

--------------------------------------------------------------------------
6. SHARP R1 FRONTIER
--------------------------------------------------------------------------

The H01-M2-R1 branch is now encoded by the finite coefficient-rank split

    rank_C(lambda)=0,1,2,

where

    lambda=(ell1,ell2),
    (Q:gamma)_1=span_C{ell1,ell2},

and the same square linear matrix obeys

    q*L=0,
    L*u=0,
    u!=0.

Equivalently the cyclic saturation quotient has linear embedding dimension

    e_col=4,3,2

respectively.  No lower embedding dimension is possible.

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude rank(lambda)=0,1,2.
  It does NOT bound the total length of S/(Q:gamma).
  It does NOT close H01-M2-R1.
  It does NOT close H01-M2 or H01.
  It does NOT enter q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_m2_R2_closed.
  H01_m2_R1_square_syzygy_colon_reduced.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in H01-M2-R1.  Use

    q*L=0,
    L*u=0,
    (Q:gamma)_1=span{ell1,ell2},
    lambda*b=0,

  and the exactness/rank conditions of the saturated-core resolution to
  eliminate or classify rank(lambda)=0,1,2.  The strongest next target is to
  force rank(lambda)=2 and then determine the resulting two-variable Artinian
  colon quotient.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
