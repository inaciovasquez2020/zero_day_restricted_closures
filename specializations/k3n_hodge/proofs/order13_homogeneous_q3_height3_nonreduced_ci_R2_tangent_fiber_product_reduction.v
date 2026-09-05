Standalone tangent fiber-product reduction for the residual R2 branch of the
nonreduced homogeneous q=3, height-three complete-intersection core in the
order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_R2_colon_tangent_compensation.v.

  Thus

    B=S/(q1,q2,q3)

  is the one-dimensional standard graded Gorenstein complete intersection of
  three quadrics and, after the regular-escape replacement,

    L=J+(g),
    J=(u1,u2),
    deg(u1)=deg(u2)=d<e=deg(g),

  with g homogeneous and B-regular. Put

    A=B/L,
    N=length_C(A),
    C=(J :_B g).

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE INTERSECTION OF THE TWO R2 SUMMANDS
--------------------------------------------------------------------------

Because g is B-regular,

  J intersect (g)=g*C.

Proof.
  If x lies in J intersect (g), write x=g*b. Since x lies in J, b lies in
  (J:g)=C, so x lies in g*C. The reverse inclusion is immediate from the
  definition of C.
Qed.

Multiplication by g is injective on B, hence restricts to an isomorphism

  C(-e) ~= g*C.

Likewise

  B(-e) ~= (g).

--------------------------------------------------------------------------
2. THE MAYER-VIETORIS SEQUENCE FOR L=J+(g)
--------------------------------------------------------------------------

There is a short exact sequence of B-modules

  0 -> g*C
    -> J direct_sum (g)
    -> L
    -> 0,

where the first map sends x to (x,-x) and the second sends (j,h) to j+h.

Apply Hom_B(-,A). Left exactness gives

  0 -> Hom_B(L,A)
    -> Hom_B(J,A) direct_sum Hom_B((g),A)
    -> Hom_B(g*C,A).

Using the regularity identifications above,

  Hom_B((g),A) ~= A(e),

and

  Hom_B(g*C,A) ~= Hom_B(C,A)(e).

Ignoring grading shifts when taking total C-dimensions, define

  Delta:
    Hom_B(J,A) direct_sum A
      -> Hom_B(C,A)

by the equivalent formula on g*C

  Delta(psi,a)(g*c)=psi(g*c)-c*a.

Then

  Hom_B(L,A)=ker(Delta).

Theorem R2_tangent_is_fiber_product_kernel:

  Hom_B(L,A)
    ~= ker(
         Hom_B(J,A) direct_sum A
           -> Hom_B(C,A)
       ).
Qed.

Equivalently, Hom_B(L,A) is the fiber product of maps on J and maps on the
principal escape summand (g), with agreement imposed only on their overlap g*C.

--------------------------------------------------------------------------
3. EXACT DIMENSION FORMULA AND A NEW LOWER BOUND
--------------------------------------------------------------------------

Taking dimensions gives the exact identity

  dim_C Hom_B(L,A)
    = dim_C Hom_B(J,A)
      + N
      - rank_C(Delta).

Since

  rank_C(Delta)<=dim_C Hom_B(C,A),

we obtain

  dim_C Hom_B(L,A)
    >= N
       + dim_C Hom_B(J,A)
       - dim_C Hom_B(C,A).

Theorem R2_fiber_product_tangent_lower_bound:

  dim_C Hom_B(L,A)
    >= N
       - (dim_C Hom_B(C,A)-dim_C Hom_B(J,A)).
Qed.

This bound captures all mixed J/g tangent maps at once. It is strictly more
structural than retaining only maps that kill g or only maps that kill J.

--------------------------------------------------------------------------
4. THE ORDER-13 TARGET BECOMES A COLON-DUAL DEFECT BOUND
--------------------------------------------------------------------------

The order-13 exclusion follows once

  dim_C Hom_B(L,A) >= N-19.

By the fiber-product bound it is enough to prove

  dim_C Hom_B(C,A)-dim_C Hom_B(J,A) <= 19.

Thus the residual R2 tangent problem has been reduced to bounding how many more
A-valued homomorphisms the colon ideal

  C=(J:g)

admits than the original two-generator trapped ideal J.

There is a second exact sequence

  0 -> J -> C -> D -> 0,

where

  D:=C/J=0:_{B/J}g.

Since J and g annihilate D, D is naturally an A-module. Applying Hom_B(-,A)
gives

  0 -> Hom_A(D,A)
    -> Hom_B(C,A)
    -> Hom_B(J,A)
    -> Ext^1_B(D,A).

Therefore the difference

  dim Hom_B(C,A)-dim Hom_B(J,A)

is not an uncontrolled difference of two unrelated spaces: it is governed by
the A-dual of the finite colon module D together with the connecting map into
Ext^1_B(D,A).

No numerical bound on this difference is asserted here.

--------------------------------------------------------------------------
5. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_tangent_is_fiber_product_kernel.
  R2_fiber_product_tangent_lower_bound.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    dim_C Hom_B(C,A)-dim_C Hom_B(J,A) <= 19.

  It does NOT close R2 or R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation. The argument uses only the exact
  sum/intersection sequence for L=J+(g), regularity of g, and left exactness of
  Hom. The new theorem statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Residual R2 is now an exact fiber-product tangent problem. The only numerical
  loss in the resulting lower bound is the colon-dual defect

    dim_C Hom_B(C,A)-dim_C Hom_B(J,A).

MISSING_OBJECT:
  Prove

    dim_C Hom_B(C,A)-dim_C Hom_B(J,A) <= 19,

  or prove a stronger bound, using

    D=C/J=0:_{B/J}g

  and the exact Hom/Ext sequence above.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, compute the Hom/Ext Euler defect of D=C/J.
  3. Use the fact that D is killed by L and sits in the Koszul mapping-cone
     filtration for (u1,u2,g).
  4. Prove only the <=19 colon-dual defect bound.
  5. Rebuild immediately after that bounded lemma.
