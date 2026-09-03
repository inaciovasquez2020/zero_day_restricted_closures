Standalone realizability test for the two incidence forms at the exact H10
endpoint in the multiplicity-one, depth-one saturated core of the homogeneous
q=4, height-two order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H10_colon_profile.v
    order13_q4_height2_depth_one_multiplicity_one_H10_quadratic_subspace.v

  and retain the exact H10 consequences

    S := C[x1,x2,x3,x4],
    Q generated minimally by four independent quadrics,
    ht(Q)=2,
    Qsat := saturation(Q),
    (u1,u2)=(1,4),
    P=(l1,l2),
    D=P/Qsat,
    Hilb_D(t)=t/(1-t),
    Qsat=(l1)+l2*J,

  where J is a height-three linear prime containing l1.

The preceding files leave two incidence forms:

  H10-OFF:
    l2 notin J,
    Qsat=(l1,l2*m1,l2*m2),

  H10-ON:
    l2 in J,
    Qsat=(l1,l2^2,l2*m).

They also prove

    dim(Q_2 intersect l1*S_1)=2,
    Qsat=Q+(l1),
    T=Qsat/Q is cyclic on l1 mod Q,
    C=(Q:l1) is m-primary,
    dim C_1=2.

This file performs one bounded test only:

  determine whether either H10 incidence is excluded by the original
  four-independent-quadric and saturation requirements.

The answer is NO.  Explicit four-quadric ideals are constructed in both
incidence classes.  Each has height two, exact prescribed saturation, and the
required rank-two intersection with the l1-multiple quadratic space.

Thus the incidence bit is genuinely realizable on both sides and cannot be
removed from the standing H10 assumptions alone.

No classification of all admissible four-planes Q_2 is attempted.
No tangent-space estimate is made.
No other Hilbert state is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. A SATURATION CERTIFICATE USED IN BOTH EXAMPLES
--------------------------------------------------------------------------

Let m denote the homogeneous maximal ideal of S.

Lemma colon_m_primary_forces_linear_saturation:
  Let I be a homogeneous ideal and let x be a nonzero linear form.  If

    I:x

contains an m-primary ideal, then

    x in saturation(I).

Proof:
  If K subset I:x is m-primary, then m^N subset K for some N.  Therefore

    m^N*x subset I,

which is exactly the condition x in I^sat.
Qed.

This elementary criterion is the only saturation device needed below.

--------------------------------------------------------------------------
2. H10-OFF IS REALIZED
--------------------------------------------------------------------------

Work in coordinates

    S=C[x,y,z,w]

and set

    l1=x,
    l2=y,
    P=(x,y),
    Joff=(x,z,w).

Then y notin Joff and the H10-OFF saturated ideal is

    Aoff
      := (x)+y*Joff
       = (x,yz,yw).

Theorem Aoff_is_saturated:
  The ideal Aoff is saturated.

Proof:
  One has

    Aoff=(x,y) intersect (x,z,w).

  Indeed, modulo (x), this is the identity

    (y) intersect (z,w)=y*(z,w).

  Both factors are homogeneous prime ideals and hence saturated.  Their
  intersection is saturated.
Qed.

Define the four quadrics

    q1 := x*y,
    q2 := x*z,
    q3 := y*z + x*w,
    q4 := y*w + x^2,

and let

    Qoff := (q1,q2,q3,q4).

Theorem Qoff_has_four_independent_quadratic_generators:
  The four displayed quadrics are linearly independent in S_2.

Proof:
  In a linear relation among q1,q2,q3,q4, the coefficients of the monomials

    x*y,
    x*z,
    y*z,
    y*w

force the four scalar coefficients successively to vanish.
Qed.

Corollary Qoff_is_contained_in_Aoff:
  One has

    Qoff subset Aoff.

Proof:
  The first two generators lie in (x), while q3 and q4 are sums of one element
  of (x) and one of (yz,yw).
Qed.

Theorem x_saturates_into_Qoff:
  One has

    x in saturation(Qoff).

Proof:
  Put Coff=(Qoff:x).  The generators q1 and q2 give

    y in Coff,
    z in Coff.

  Next,

    x*q4 - w*q1 = x^3,

so

    x^2 in Coff.

  Also

    w*q3 - z*q4 + x*q2
      = (y*z*w+x*w^2) - (y*z*w+x^2*z) + x^2*z
      = x*w^2,

so

    w^2 in Coff.

  Therefore

    (y,z,x^2,w^2) subset Coff.

  The ideal on the left is m-primary because its radical is

    (x,y,z,w)=m.

  The preceding saturation lemma gives x in Qoff^sat.
Qed.

Theorem saturation_Qoff_is_exactly_Aoff:
  One has

    saturation(Qoff)=Aoff.

Proof:
  Since x is in Qoff^sat, all multiples of x are in Qoff^sat.  Hence

    y*z = q3 - x*w

and

    y*w = q4 - x^2

also belong to Qoff^sat.  Therefore

    Aoff=(x,yz,yw) subset Qoff^sat.

  Conversely Qoff subset Aoff and Aoff is saturated, so minimality of
  saturation gives

    Qoff^sat subset Aoff.

  Thus equality holds.
Qed.

Theorem Qoff_has_height_two:
  One has

    ht(Qoff)=2.

Proof:
  Since Qoff subset Aoff and Aoff has the height-two prime (x,y) as a minimal
  prime,

    ht(Qoff)<=2.

  On the other hand a height-one prime in the UFD S is principal.  Any common
  irreducible factor of all four generators would divide both

    x*y and x*z,

so it would divide x.  But q3=y*z+x*w is not divisible by x.  Hence the four
quadrics have no common nonconstant factor and Qoff is contained in no
height-one prime.

  Therefore ht(Qoff)>=2, proving equality.
Qed.

Theorem Qoff_has_the_exact_H10_OFF_profile:
  The saturated ideal Aoff has

    (Aoff)_1=C*x,
    dim_C (Aoff)_2=6,

and, with P=(x,y),

    Doff:=P/Aoff ~= S/Joff(-1),
    Hilb_Doff(t)=t/(1-t).

Moreover

    dim_C(Qoff_2 intersect x*S_1)=2.

Proof:
  The degree-one claim is immediate.  In degree two,

    (Aoff)_2=x*S_1 + C*(y*z) + C*(y*w),

and the final two quadrics are independent modulo x*S_1, so the dimension is
six.

  The class of y generates P/Aoff and

    (Aoff:y)=(x,z,w)=Joff,

hence Doff ~= S/Joff(-1) and its Hilbert series is t/(1-t).

  Finally q1,q2 lie in x*S_1, while the non-x parts y*z and y*w of q3,q4 are
  independent.  Thus no nontrivial combination of q3,q4 can enter x*S_1, and

    Qoff_2 intersect x*S_1 = span_C(q1,q2)

has dimension two.
Qed.

Thus H10-OFF is compatible with all original four-quadric, height-two,
saturation, and exact H10 low-degree requirements.

--------------------------------------------------------------------------
3. H10-ON IS REALIZED
--------------------------------------------------------------------------

Again work in

    S=C[x,y,z,w]

and now set

    l1=x,
    l2=y,
    P=(x,y),
    Jon=(x,y,z).

Then y in Jon and the H10-ON saturated ideal is

    Aon
      := (x)+y*Jon
       = (x,y^2,y*z).

Theorem Aon_is_saturated:
  The ideal Aon is saturated.

Proof:
  The variable w is a nonzerodivisor on S/Aon, because Aon is extended from the
  subring C[x,y,z].

  If f belongs to Aon^sat, then for some N

    m^N*f subset Aon.

  In particular w^N*f belongs to Aon.  Since multiplication by w^N is injective
  on S/Aon, one gets f in Aon.  Hence Aon^sat=Aon.
Qed.

Define the four quadrics

    p1 := x*y,
    p2 := x*w,
    p3 := y^2 + x*z,
    p4 := y*z + x^2,

and let

    Qon := (p1,p2,p3,p4).

Theorem Qon_has_four_independent_quadratic_generators:
  The four displayed quadrics are linearly independent in S_2.

Proof:
  The monomials

    x*y,
    x*w,
    y^2,
    y*z

occur with independent leading coefficients in p1,p2,p3,p4, so a scalar linear
relation forces all four coefficients to vanish.
Qed.

Corollary Qon_is_contained_in_Aon:
  One has

    Qon subset Aon.
Qed.

Theorem x_saturates_into_Qon:
  One has

    x in saturation(Qon).

Proof:
  Put Con=(Qon:x).  The generators p1 and p2 give

    y in Con,
    w in Con.

  Next,

    x*p4 - z*p1 = x^3,

so

    x^2 in Con.

  Also

    z*p3 - y*p4 + x*p1
      = (y^2*z+x*z^2) - (y^2*z+x^2*y) + x^2*y
      = x*z^2,

so

    z^2 in Con.

  Therefore

    (y,w,x^2,z^2) subset Con.

  This ideal is m-primary.  Hence the saturation lemma gives

    x in Qon^sat.
Qed.

Theorem saturation_Qon_is_exactly_Aon:
  One has

    saturation(Qon)=Aon.

Proof:
  Since x lies in Qon^sat,

    y^2 = p3 - x*z

and

    y*z = p4 - x^2

lie in Qon^sat.  Thus Aon subset Qon^sat.

  The reverse containment follows from Qon subset Aon and saturation of Aon.
Qed.

Theorem Qon_has_height_two:
  One has

    ht(Qon)=2.

Proof:
  The inclusion Qon subset Aon gives ht(Qon)<=2 because Aon has height two.

  Any common irreducible factor of all four quadrics would divide p1=x*y and
  p2=x*w, hence would divide x.  But p3=y^2+x*z is not divisible by x.
  Therefore no height-one prime contains Qon.

  Hence ht(Qon)>=2 and equality follows.
Qed.

Theorem Qon_has_the_exact_H10_ON_profile:
  The saturated ideal Aon has

    (Aon)_1=C*x,
    dim_C (Aon)_2=6,

and, with P=(x,y),

    Don:=P/Aon ~= S/Jon(-1),
    Hilb_Don(t)=t/(1-t).

Moreover

    dim_C(Qon_2 intersect x*S_1)=2.

Proof:
  One has

    (Aon)_2=x*S_1 + C*y^2 + C*y*z,

with the last two classes independent modulo x*S_1, so the dimension is six.

  The class of y generates P/Aon and

    (Aon:y)=(x,y,z)=Jon.

  Thus Don ~= S/Jon(-1), giving Hilb_Don=t/(1-t).

  Finally p1,p2 span the x-multiple part of Qon_2, while the non-x parts y^2 and
  y*z of p3,p4 are independent.  Therefore

    Qon_2 intersect x*S_1 = span_C(p1,p2)

has dimension two.
Qed.

Thus H10-ON is also compatible with all original four-quadric, height-two,
saturation, and exact H10 low-degree requirements.

--------------------------------------------------------------------------
4. THE INCIDENCE BIT CANNOT BE EXCLUDED
--------------------------------------------------------------------------

Theorem both_H10_incidence_classes_are_realizable:
  Under the standing q=4, height-two multiplicity-one H10 numerical and
  saturation requirements, neither incidence class is formally excluded.

More precisely, there exist explicit four-independent-quadric height-two ideals
Q whose saturation has the H10-OFF form, and there exist explicit such ideals
whose saturation has the H10-ON form.

Proof:
  The H10-OFF example is Qoff above, with

    saturation(Qoff)=(x,yz,yw),
    Joff=(x,z,w),
    y notin Joff.

  The H10-ON example is Qon above, with

    saturation(Qon)=(x,y^2,y*z),
    Jon=(x,y,z),
    y in Jon.

  Both examples have exactly four independent quadratic generators, height two,
  exact quadratic intersection rank two, and cyclic saturation defect generated
  by x modulo Q.
Qed.

Corollary no_universal_H10_incidence_exclusion_from_current_assumptions:
  No theorem using only the current H10 hypotheses can conclude universally

    l2 in J

or universally

    l2 notin J.

Any later tangent or restricted-closure argument must either handle both
incidences or use an additional hypothesis not present in the current branch.
Qed.

--------------------------------------------------------------------------
5. SHARP BOUNDARY AFTER REALIZABILITY
--------------------------------------------------------------------------

The H10 incidence question is now settled at the existence level:

    H10-OFF is realizable,
    H10-ON  is realizable.

Therefore the incidence split is not a numerical artifact and cannot be removed
by the four-independent-quadric or saturation conditions alone.

What remains unclassified is the full family of admissible four-dimensional
subspaces

    Q_2 subset (Qsat)_2

inside each incidence class.

The two explicit realizations also exhibit the already-proved colon pattern:

  H10-OFF example:
    (Qoff:x)_1=span(y,z),
    (y,z,x^2,w^2) subset (Qoff:x),

  H10-ON example:
    (Qon:x)_1=span(y,w),
    (y,w,x^2,z^2) subset (Qon:x).

In both examples the colon is m-primary and has embedding dimension two after
removing its two linear forms.

IMPORTANT_NONCONCLUSION:
  This file does NOT classify every admissible four-plane Q_2.

  It does NOT classify the full m-primary colon C=(Q:l1).
  It does NOT classify the higher Hilbert function of T.
  It makes no tangent-space estimate.
  It does NOT close H10.
  It does NOT close the multiplicity-one branch.
  It does NOT close q=4 height two or full order 13.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H10_OFF_realizable.
  q4_height2_multiplicity_one_depth_one_H10_ON_realizable.
  q4_height2_multiplicity_one_depth_one_H10_incidence_nonexclusive.
  not q4_height2_multiplicity_one_depth_one_H10_fourplane_classified.
  not q4_height2_multiplicity_one_depth_one_H10_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Classify, separately in H10-OFF and H10-ON, the embedding-dimension-two
  m-primary colon

    C=(Q:l1)

  or equivalently the admissible four-dimensional quadratic spaces

    Q_2 subset (Qsat)_2

  satisfying

    dim(Q_2 intersect l1*S_1)=2,
    saturation((Q_2))=Qsat.

  The incidence itself is no longer a candidate obstruction: both sides occur.

NEXT_ACTIONS:
  1. Stay only in H10.
  2. Treat H10-OFF and H10-ON separately.
  3. Normalize C_1=(Q:l1)_1 in each incidence.
  4. Determine the smallest possible Artinian quotient S/C compatible with the two explicit quadratic directions.
  5. Stop before tangent-space estimates.
