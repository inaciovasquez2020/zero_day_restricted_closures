Standalone canonical-duality tangent closure of the full H01-M2-R2 endpoint in
the homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Retain the established H01-M2-R2 data

    S := C[x1,x2,x3,x4],
    P := (l1,l2),
    Q=Qsat subset P,
    B:=S/Q,
    D:=P/Q,

with

    D one-dimensional Cohen--Macaulay,
    Hilb_D(t)=(2*t+t^2)/(1-t),

and exact minimal S-resolution

    0 -> S(-5)
      -> S(-3)^3 direct_sum S(-4)
      -> S(-2)^5
      -> S(-1)^2
      -> D
      -> 0.

The preceding kernel analysis split R2 into R2-QK, R2-LK2, and R2-LK3, and
LK3 further into C2/C3.  LK3-C2 has already been closed.  This file performs
one stronger bounded task: use the exact R2 residual resolution itself to
construct a universal degree-three canonical carrier and close every R2 kernel
subtype at once.  Thus no separate LK3-C3, LK2, or QK classification is needed.

No H01-M2-R1, q<=3, or generic order-13 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE THIRD EXT IS A CYCLIC ONE-DIMENSIONAL CM RING SHIFT
--------------------------------------------------------------------------

Dualize the exact minimal resolution of D by S(-4).  The final dual map has
source

    S(-1)^3 direct_sum S

and target

    S(1).

Write its four homogeneous entries as

    a1,a2,a3 in S_2,
    r in S_1.

The preceding R2 analysis already proves r!=0.  Set

    H:=(r,a1,a2,a3)

and

    C3:=S/H.

Then by construction

    E:=Ext^3_S(D,S(-4)) ~= C3(1).

Because D is Cohen--Macaulay of dimension one over the regular ring S, it is a
perfect S-module of grade three.  Its canonical module E is again
one-dimensional Cohen--Macaulay.  Hence C3 itself is a one-dimensional
Cohen--Macaulay standard graded ring and

    ht(H)=3.

Theorem H01_m2_R2_third_ext_is_cyclic_CM_carrier:
  There is a height-three homogeneous ideal

    H=(r,a1,a2,a3)

  with one linear and three quadratic displayed generators such that

    Ext^3_S(D,S(-4)) ~= (S/H)(1),

  and S/H is one-dimensional Cohen--Macaulay.
Qed.

--------------------------------------------------------------------------
2. PERFECT BIDUALITY IDENTIFIES D WITH THE SHIFTED CANONICAL MODULE
--------------------------------------------------------------------------

Perfect-module biduality in codimension three gives

    D ~= Ext^3_S(E,S(-4)).

Since E~=C3(1),

    Ext^3_S(E,S(-4))
      ~= Ext^3_S(C3,S(-4))(-1)
      = omega_C3(-1).

Therefore

    D ~= omega_C3(-1).

For a Cohen--Macaulay ring with canonical module, the canonical module is
faithful; equivalently the natural homothety map

    C3 -> Hom_C3(omega_C3,omega_C3)

is injective (indeed an isomorphism in this setting).  Hence

    Ann_S(D)=H.

Since Q annihilates D=P/Q, it follows in particular that

    Q subset H.

Theorem H01_m2_R2_residual_is_shifted_canonical_module:
  With C3=S/H as above,

    D ~= omega_C3(-1),
    Ann_S(D)=H,
    Q subset H.
Qed.

--------------------------------------------------------------------------
3. THE CANONICAL CARRIER HAS MULTIPLICITY THREE
--------------------------------------------------------------------------

For a one-dimensional Cohen--Macaulay graded module, canonical Hilbert
reciprocity gives

    Hilb_(omega_C3)(t)=-Hilb_C3(t^(-1)).

The shift D~=omega_C3(-1) and the standing series

    Hilb_D(t)=(2*t+t^2)/(1-t)

therefore force

    Hilb_(omega_C3)(t)=(2+t)/(1-t)

and hence

    Hilb_C3(t)=(1+2*t)/(1-t).

Thus

    e(C3)=3.

Theorem H01_m2_R2_canonical_carrier_degree_three:
  The universal residual carrier C3 has

    Hilb_C3(t)=(1+2*t)/(1-t)

  and multiplicity three.
Qed.

--------------------------------------------------------------------------
4. EVERY TWO-GENERATOR ARTINIAN CUT HAS EQUAL LENGTH ON C3 AND D
--------------------------------------------------------------------------

Let f,g be the standing final homogeneous forms with

    d:=deg(f)>=3,
    e:=deg(g)>=3,

and assume

    A:=S/(Q,f,g)

is Artinian.  Since Q subset H, the quotient

    C3/(f,g)C3

is also Artinian.  Put

    L_C:=length_C C3/(f,g)C3,
    L_D:=length_C D/(f,g)D.

We prove

    L_C=L_D.

The grading shift in D~=omega_C3(-1) does not affect total length.  Let

    I:=(f,g)C3.

Because C3 is one-dimensional Cohen--Macaulay over the infinite field C and I
is m-primary, a generic C-linear combination h of f and g is a
nonzerodivisor.  Complete it by an invertible 2-by-2 constant change of
I-generators to

    I=(h,k).

Set

    T:=C3/(h),
    Omega:=omega_C3/h*omega_C3.

Then T is Artinian and Omega is its canonical module.  Up to grading shift,

    Omega~=Hom_C(T,C).

Multiplication by k on Omega is the C-linear dual of multiplication by k on T.
Therefore

    dim_C coker(k:Omega->Omega)
      =dim_C ker(k:T->T)
      =dim_C coker(k:T->T),

where the last equality is rank-nullity for an endomorphism of the finite
vector space T.  Hence

    length omega_C3/I*omega_C3
      =length C3/I.

Thus

    L_D=L_C.

Theorem H01_m2_R2_canonical_cut_length_equality:
  Every admissible final pair satisfies

    length D/(f,g)D
      =length C3/(f,g)C3.
Qed.

--------------------------------------------------------------------------
5. THE DEGREE-THREE CARRIER CUT IS AT MOST 3*M
--------------------------------------------------------------------------

Put

    M:=max(d,e).

The m-primary ideal I=(f,g)C3 contains a homogeneous C3-nonzerodivisor of degree
M.  To see this, assume d<=e=M.  If d=e, take a generic homogeneous linear
combination.  If d<M, choose a homogeneous s of degree M-d outside the finitely
many minimal primes on which f is nonzero, and then choose lambda generically:

    h_M:=s*f+lambda*g.

Because no minimal prime contains both f and g, h_M avoids every minimal prime.
Since C3 is Cohen--Macaulay, its associated primes are its minimal primes, so
h_M is a nonzerodivisor.

Therefore

    L_C<=length C3/(h_M).

A degree-M nonzerodivisor on a one-dimensional Cohen--Macaulay ring of
multiplicity three has quotient length 3*M.  Hence

    L_C<=3*M.

Theorem H01_m2_R2_canonical_cut_bound:
  For M=max(d,e),

    L_C=L_D<=3*M.
Qed.

--------------------------------------------------------------------------
6. EXACT TOTAL LENGTH OF THE FINAL ARTINIAN ALGEBRA
--------------------------------------------------------------------------

The standing exact sequence is

    0 -> D -> B -> S/P -> 0.

Because A is Artinian, the restrictions of f,g to

    S/P ~= C[s,t]

form a homogeneous parameter pair of degrees d,e.  Hence they are a regular
sequence and

    H_1(f,g;S/P)=0,
    length S/(P,f,g)=d*e.

The Koszul H_0 tail therefore gives an exact sequence

    0 -> D/(f,g)D
      -> A
      -> S/(P,f,g)
      -> 0.

Writing

    N:=length A,

one obtains

    N=d*e+L_D
     =d*e+L_C.

Theorem H01_m2_R2_exact_final_length_from_canonical_carrier:
  Every admissible R2 final pair satisfies

    N=d*e+L_C.
Qed.

--------------------------------------------------------------------------
7. THE UNIVERSAL ANNIHILATOR PRODUCES A TWO-COPY TANGENT CARRIER
--------------------------------------------------------------------------

Put

    H1:=H_1(f,g;B).

The preceding line-quotient vanishing identifies

    H1 ~= H_1(f,g;D).

Since H=Ann_S(D), H annihilates the whole Koszul complex on D and therefore H1.
Let H_A be the image of H in A and let

    E_A:=Ann_A(H1).

Then

    H_A subset E_A.

Because Q subset H,

    A/H_A ~= S/(H,f,g)
            ~= C3/(f,g)C3.

Thus

    dim_C H_A=N-L_C=d*e.

The standard two-cut annihilator carrier gives a natural injection

    E_A direct_sum E_A
      -> Hom_B((f,g)B,A)
      -> Hom_S((Q,f,g),A).

Consequently, with

    t(A):=dim_C Hom_S((Q,f,g),A),

one has

    t(A)>=2*dim_C(E_A)
        >=2*d*e.

Theorem H01_m2_R2_universal_two_copy_tangent_bound:
  Every admissible H01-M2-R2 endpoint satisfies

    t(A)>=2*d*e.
Qed.

--------------------------------------------------------------------------
8. EVERY R2 FINAL PAIR VIOLATES THE NECESSARY ORDER-13 GATE
--------------------------------------------------------------------------

Since d,e>=3,

    d*e>=3*M.

Section 5 gives

    L_C<=3*M<=d*e.

Therefore

    N=d*e+L_C<=2*d*e.

Together with Section 7,

    t(A)>=2*d*e>=N>N-20.

This contradicts the necessary order-13 tangent gate

    t(A)<=N-20

for every admissible final degree pair.

Theorem H01_m2_R2_tangent_closed:
  The full H01-M2-R2 endpoint is EXCLUDED at the necessary order-13 tangent gate
  for every admissible final pair.
Qed.

--------------------------------------------------------------------------
9. KERNEL SUBTYPES CLOSE BY PARENT PROMOTION
--------------------------------------------------------------------------

The earlier exhaustive reduction was

    H01-M2-R2
      -> R2-QK or R2-LK2 or R2-LK3.

Section 8 excludes the parent directly, independently of kernel subtype.
Therefore no separate survival of LK3-C3, R2-LK2, or R2-QK remains possible.
The already-proved LK3-C2 closure remains a compatible stronger local result.

Corollary H01_m2_R2_kernel_frontier_closed:
  R2-QK, R2-LK2, LK3-C2, and LK3-C3 are all excluded as children of the direct
  H01-M2-R2 tangent closure.
Qed.

--------------------------------------------------------------------------
10. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  R2_third_ext_cyclic_CM_carrier.
  R2_residual_shifted_canonical_duality.
  R2_universal_degree_three_carrier.
  R2_canonical_two_generator_cut_equality.
  R2_all_degree_tangent_bound.
  H01_m2_R2_tangent_closed.

CLOSED:
  H01-M2-R2.
  R2-QK.
  R2-LK2.
  R2-LK3, including LK3-C2 and LK3-C3.

NOT_PROVED:
  H01-M2-R1 closure.
  H01-M2 closure.
  H01 closure.
  q4 height-two full closure.
  homogeneous q<=3 closure.
  Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in H01-M2-R1.  Derive the corresponding residual/canonical carrier
  from its exact Artinian-action structure and decide whether the same
  two-copy tangent mechanism closes R1.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
