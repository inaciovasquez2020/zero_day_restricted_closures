Standalone residual-canonical tangent closure of the r-not-in-P half of the
LK3-C2 carrier in the saturated H01 minimal-chain rank-two endpoint of the
homogeneous q=4, height-two, multiplicity-one, depth-one order-13
deviation-two program.

SCOPE:
  Continue only from the established r-not-in-P complete-intersection carrier

    S := C[x1,x2,x3,x4],
    Q=Qsat subset P,
    P=(a,b),
    r notin P,
    D:=P/Q,
    B:=S/Q,

with

    Q=(r*a,r*b,q3,q4)=P intersect (r,q3,q4),

where q3,q4 lie in P and

    J:=(r,q3,q4)

is a saturated complete intersection of type (1,2,2).  Retain also

    Hilb_D(t)=(2*t+t^2)/(1-t).

The full r-in-P half of LK3-C2 was closed previously.  This file performs one
bounded task only: close the complementary r-not-in-P half at the necessary
order-13 tangent gate, using the residual length-three linked ring and its
canonical module.

No LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is entered.
No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE 2-BY-3 MATRIX AND THE RESIDUAL MINOR
--------------------------------------------------------------------------

Because q3,q4 belong to P=(a,b), choose linear forms c,d,e,f such that

    q3=a*c+b*d,
    q4=a*e+b*f.

Put

    R:=S/(r)

and write bars for images in R.  The established r-not-in-P reduction says

    q3bar,q4bar

form a regular sequence of two quadrics in the three-variable polynomial ring
R.

Consider the 2-by-3 linear matrix

         [ -b   c   e ]
    N := [  a   d   f ]

(over R after reduction modulo r) and define the third signed maximal minor

    g:=c*f-d*e.

Up to the conventional signs, the three 2-by-2 minors of N are

    q3bar,
    q4bar,
    gbar.

Since q3bar,q4bar already have height two, the full maximal-minor ideal

    Hbar:=(q3bar,q4bar,gbar)

also has height two.  Hilbert--Burch therefore gives

    0 -> R(-3)^2
      -> R(-2)^3
      -> R
      -> R/Hbar
      -> 0.

Consequently

    Hilb_(R/Hbar)(t)
      =(1-3*t^2+2*t^3)/(1-t)^3
      =(1+2*t)/(1-t).

Thus R/Hbar is one-dimensional Cohen--Macaulay of multiplicity three.

Theorem H01_m2_R2_LK3_C2_r_notin_P_residual_minor_ring:
  The maximal-minor ideal

    Hbar=(q3bar,q4bar,gbar)

is a saturated height-two perfect ideal in R and R/Hbar has multiplicity three.
Qed.

--------------------------------------------------------------------------
2. THE RESIDUAL MINOR IDEAL IS THE EXACT ANNIHILATOR OF D
--------------------------------------------------------------------------

Modulo r one has

    D ~= Pbar/(q3bar,q4bar),
    Pbar=(a,b).

Hence

    Ann_R(D)
      =(q3bar,q4bar):Pbar.

The element gbar belongs to this colon because

    a*g = f*q3-d*q4,
    b*g = c*q4-e*q3.

Thus

    Hbar subset (q3bar,q4bar):Pbar.

Conversely, (q3bar,q4bar) is a (2,2) complete intersection contained in the
height-two linear prime Pbar.  Direct linkage by that complete intersection
leaves residual projective degree

    2*2-1=3.

The colon ideal is therefore an unmixed height-two residual ideal of degree
three.  Section 1 shows that Hbar is already a saturated height-two ideal of
degree three contained in the colon.  Hence equality holds:

    (q3bar,q4bar):Pbar
      =Hbar.

Lift to S and set

    H:=(r,q3,q4,g).

Since r annihilates D and reduction modulo r gives the exact colon above,

    Ann_S(D)=H.

Theorem H01_m2_R2_LK3_C2_r_notin_P_exact_residual_annihilator:
  For

    H=(r,q3,q4,g)

one has

    Ann_S(D)=H,

and

    C3:=S/H

is a saturated one-dimensional Cohen--Macaulay ring of multiplicity three with

    Hilb_C3(t)=(1+2*t)/(1-t).
Qed.

Geometrically C3 is the length-three scheme residual to the reduced
P-intersection point inside the length-four (1,2,2) complete intersection J.

--------------------------------------------------------------------------
3. D IS THE SHIFTED CANONICAL MODULE OF THE RESIDUAL RING
--------------------------------------------------------------------------

The two generators a,b of Pbar give a presentation of D over R.  The three
relations are the columns of N:

    (-b,a)^T,
    (c,d)^T,
    (e,f)^T.

Their unique quadratic relation is, up to the harmless common sign convention,

    (g,q4bar,-q3bar)^T.

Hence D has exact R-resolution

    0 -> R(-4)
      -> R(-2)^3
      --N--> R(-1)^2
      -> D
      -> 0.

On the other hand, Section 1 gives the Hilbert--Burch resolution of C3 over R:

    0 -> R(-3)^2
      --N^T--> R(-2)^3
      -> R
      -> C3
      -> 0,

again up to row/column signs.

Since R is a three-variable polynomial ring, the canonical module of C3 is

    omega_C3 := Ext^2_R(C3,R(-3)).

Dualizing the Hilbert--Burch resolution gives

    0 -> R(-3)
      -> R(-1)^3
      --N--> R^2
      -> omega_C3
      -> 0.

After shifting by -1 this is exactly the displayed resolution of D.  The maps
agree through the same matrix N, so

    D ~= omega_C3(-1).

Theorem H01_m2_R2_LK3_C2_r_notin_P_residual_canonical_module:
  As a graded C3-module,

    D ~= omega_C3(-1).
Qed.

--------------------------------------------------------------------------
4. TWO-GENERATOR CUTS HAVE EQUAL COLENGTH ON C3 AND ITS CANONICAL MODULE
--------------------------------------------------------------------------

Let f0,g0 be the standing final homogeneous forms with

    d:=deg(f0)>=3,
    e:=deg(g0)>=3,

and suppose

    A:=S/(Q,f0,g0)

is Artinian, as required in the order-13 tangent setting.

Because Q subset H, the quotient

    C3/(f0,g0)C3

is also Artinian.  Put

    L_C:=length_C C3/(f0,g0)C3,
    L_D:=length_C D/(f0,g0)D.

We claim

    L_D=L_C.

The grading shift in D~=omega_C3(-1) does not affect total length, so it is
enough to prove

    length omega_C3/I*omega_C3
      =length C3/I

for the two-generated m-primary ideal

    I=(f0,g0)C3.

Because C3 is one-dimensional Cohen--Macaulay over the infinite field C, a
generic C-linear combination of f0 and g0 is a nonzerodivisor h in I.  Complete
h to another generator k so that

    I=(h,k).

Set

    T:=C3/(h).

Then T is Artinian, and

    Omega:=omega_C3/h*omega_C3

is a canonical module of T.  For an Artinian C-algebra, the canonical module is
its C-linear dual, up to the irrelevant grading shift.  Multiplication by k on
Omega is therefore the linear dual of multiplication by k on T.

For a linear endomorphism of a finite-dimensional vector space,

    dim coker(k on Omega)
      =dim ker(k on T)
      =dim coker(k on T).

Thus

    length Omega/k*Omega
      =length T/k*T.

Equivalently,

    L_D=L_C.

Theorem H01_m2_R2_LK3_C2_r_notin_P_canonical_cut_length_equality:
  Every admissible final two-form cut satisfies

    length D/(f0,g0)D
      =length C3/(f0,g0)C3.
Qed.

--------------------------------------------------------------------------
5. THE RESIDUAL DEGREE-THREE CUT HAS LENGTH AT MOST 3*M
--------------------------------------------------------------------------

Put

    M:=max(d,e).

The m-primary ideal (f0,g0)C3 contains a homogeneous C3-nonzerodivisor of degree
M.

Indeed, assume d<=e=M.  If d=e, a generic homogeneous linear combination of
f0,g0 avoids all associated primes of the Cohen--Macaulay ring C3.  If d<M,
choose a homogeneous form s of degree M-d avoiding every minimal prime on which
f0 is nonzero, and then choose lambda generically so that

    h_M:=s*f0+lambda*g0

avoids every minimal prime.  This is possible because (f0,g0) is m-primary, so
no minimal prime contains both generators, and there are only finitely many
minimal primes.

Thus h_M is a homogeneous nonzerodivisor of degree M contained in (f0,g0).  It
follows that

    C3/(f0,g0)C3

is a quotient of C3/(h_M), and therefore

    L_C<=length C3/(h_M).

Since C3 is one-dimensional Cohen--Macaulay of multiplicity three,

    length C3/(h_M)=3*M.

Hence

    L_C<=3*M.

Theorem H01_m2_R2_LK3_C2_r_notin_P_residual_cut_bound:
  With M=max(d,e),

    L_C<=3*M.
Qed.

--------------------------------------------------------------------------
6. THE LINE CUT AND THE TOTAL LENGTH
--------------------------------------------------------------------------

Let

    Lline:=S/P ~= C[s,t].

Because A is Artinian, the restrictions of f0,g0 to Lline are a homogeneous
parameter pair of degrees d,e.  Hence they form a regular sequence and

    H_1(f0,g0;Lline)=0,
    length Lline/(f0,g0)=d*e.

Apply the Koszul complex to

    0 -> D -> B -> Lline -> 0.

The vanishing of H_1 on the line gives

    H_1(f0,g0;B) ~= H_1(f0,g0;D)

and an exact H_0 sequence

    0 -> D/(f0,g0)D
      -> A
      -> Lline/(f0,g0)
      -> 0.

Therefore, writing

    N:=length A,

one has

    N=d*e+L_D
     =d*e+L_C.

Theorem H01_m2_R2_LK3_C2_r_notin_P_exact_final_length:
  Every admissible final pair satisfies

    N=d*e+L_C.
Qed.

--------------------------------------------------------------------------
7. THE RESIDUAL ANNIHILATOR GIVES A TWO-COPY TANGENT CARRIER
--------------------------------------------------------------------------

Put

    H1:=H_1(f0,g0;B).

By Section 6,

    H1 ~= H_1(f0,g0;D).

Since H=Ann_S(D), the ideal H annihilates the entire Koszul complex on D and
therefore annihilates H1.  Let H_A be the image of H in A and set

    E:=Ann_A(H1).

Then

    H_A subset E.

Moreover Q subset H, so

    A/H_A ~= S/(H,f0,g0)
            ~= C3/(f0,g0)C3.

Thus

    dim_C H_A=N-L_C.

The standard two-cut annihilator carrier gives a natural injection

    E direct_sum E
      -> Hom_B((f0,g0)B,A)
      -> Hom_S((Q,f0,g0),A).

Consequently, for

    t(A):=dim_C Hom_S((Q,f0,g0),A),

one has

    t(A)>=2*dim_C(E)
        >=2*(N-L_C).

Using N=d*e+L_C gives the exact coarse lower bound

    t(A)>=2*d*e.

Theorem H01_m2_R2_LK3_C2_r_notin_P_two_copy_tangent_bound:
  Every admissible final pair satisfies

    t(A)>=2*d*e.
Qed.

--------------------------------------------------------------------------
8. EVERY FINAL DEGREE VIOLATES THE ORDER-13 NECESSARY GATE
--------------------------------------------------------------------------

The standing order-13 necessary tangent gate is

    t(A)<=N-20.

But Sections 5 and 6 give

    N-20
      =d*e+L_C-20
      <=d*e+3*M-20.

Since d,e>=3,

    d*e>=3*M.

Therefore

    N-20
      <=d*e+3*M-20
      <=2*d*e-20
      <2*d*e
      <=t(A).

This contradicts the necessary gate for every admissible pair of final degrees.
No bounded-degree exception remains.

Theorem H01_m2_R2_LK3_C2_r_notin_P_tangent_closed:
  The full r-not-in-P LK3-C2 carrier is EXCLUDED at the necessary order-13
  tangent gate for every admissible final pair with d,e>=3.
Qed.

--------------------------------------------------------------------------
9. FULL LK3-C2 CLOSURE
--------------------------------------------------------------------------

The LK3-C2 split is exhaustive:

    r in P,
    r notin P.

The first half was previously closed at necessary tangent or structural gates.
Section 8 closes the second half.  Hence all LK3-C2 children are excluded.

Corollary H01_m2_R2_LK3_C2_closed:
  The full H01-M2-R2-LK3-C2 carrier is CLOSED at the necessary order-13 tangent
  or structural gates.
Qed.

This promotion is only the exhaustive parent promotion from two closed children.
It does not promote LK3-C3, R2-LK3, H01-M2-R2, or any generic order-13 theorem.

--------------------------------------------------------------------------
10. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  r_notin_P_residual_minor_ring_degree_three.
  r_notin_P_exact_residual_annihilator.
  r_notin_P_residual_canonical_module.
  r_notin_P_canonical_cut_length_equality.
  r_notin_P_residual_cut_bound.
  r_notin_P_exact_final_length.
  r_notin_P_all_degrees_tangent_closed.
  full_LK3_C2_closed.

CLOSED:
  H01_m2_R2_LK3_C2 r-in-P half.
  H01_m2_R2_LK3_C2 r-not-in-P half.
  H01_m2_R2_LK3_C2.

NOT_PROVED:
  LK3-C3 closure.
  R2-LK3 closure.
  R2-LK2 closure.
  R2-QK closure.
  H01-M2-R2 closure.
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
  H01_m2_R2_LK3_C2_closed.
  not H01_m2_R2_LK3_C3_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_LK2_closed.
  not H01_m2_R2_QK_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay in H01-M2-R2.  With LK3-C2 now closed, return to the remaining LK3-C3
  child of the linear primitive-kernel span-three branch.  Derive its weakest
  exact structural or tangent obstruction before entering R2-LK2 or R2-QK.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
