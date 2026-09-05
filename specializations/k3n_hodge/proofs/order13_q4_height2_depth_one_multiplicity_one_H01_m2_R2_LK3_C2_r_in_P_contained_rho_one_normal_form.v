Standalone rho_Q=1 normal-form classification inside the P-subset-J contained
rank-defect leaf of the r-in-P LK3-C2 carrier in the saturated H01 minimal-chain
rank-two endpoint of the homogeneous q=4, height-two, multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rank_defect_P_incidence_reduction.v
    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_incidence_classification.v

  and retain

    S=C[x1,x2,x3,x4],
    Q=Qsat subset P,
    dim_C Q_2=4,
    ht(Q)=2,
    e(S/Q)=1,
    K=(Q:r)=(a,b,F) subset J,
    A:=K_1=span_C{a,b},
    P=(r,p) subset J,
    dim_C(Q_2 intersect r*S_1)=2,

  together with

    rho_Q=1.

The preceding rank-defect reduction gives

    rho_Q
      =4-dim_C(Q_2 intersect (J*K)_2),

so the present leaf is exactly

    dim_C(Q_2 intersect (J*K)_2)=3.

This file performs one bounded task only: classify the possible relative
positions of the two planes A and P inside the three-space J_1 and reduce every
rho_Q=1 carrier to a finite list of canonical four-quadric normal forms.

No tangent closure of any listed normal form is claimed.  No rho_Q=2 leaf,
no r-not-in-P leaf, no LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is
entered.  No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THREE INCIDENCE TYPES FOR A AND P
--------------------------------------------------------------------------

Both

    A=K_1

and

    P_1=span_C{r,p}

are two-dimensional subspaces of the three-dimensional vector space J_1.
Therefore exactly one of the following occurs:

  AP:      A=P;

  AR:      A!=P and r belongs to A;

  ANR:     A!=P and r does not belong to A.

In AR, after a linear change inside J preserving r and P, choose

    J=(r,p,c),
    A=(r,c),
    P=(r,p).

In ANR, the line A intersect P is different from C*r.  Replace p by a nonzero
generator of that intersection and then choose c modulo P.  Thus

    J=(r,p,c),
    A=(p,c),
    P=(r,p).

These three incidence types are invariant under the allowed coordinate changes
because they are distinguished by A=P and by whether r belongs to A.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_plane_incidence_split:
  Every rho_Q=1 contained carrier lies in exactly one of AP, AR, ANR above.
Qed.

--------------------------------------------------------------------------
2. THE AP CASE HAS EXACTLY TWO KERNEL-LINE ORBITS
--------------------------------------------------------------------------

Assume A=P.  Normalize

    J=(r,p,c),
    A=P=(r,p).

Since q1,q2 span the exact r-multiple subspace, choose

    q1=r^2,
    q2=r*p.

Modulo r, the remaining two quadrics span

    span_C{p^2,p*c}.

The degree-two space

    (J*K)_2=J_1*P_1

contains r^2,r*p,r*c,p^2,p*c.  Consequently the only possible component of
q3,q4 outside (J*K)_2 is an r*t term, where t completes J_1 to S_1.

Because rho_Q=1, the r*t coefficient is a nonzero linear functional on the
two-space span{p^2,p*c}.  Its kernel is one line.  Under changes

    c |-> lambda*c+mu*p,
    lambda!=0,

there are exactly two kernel-line orbits:

  AP-D: the kernel is C*p^2;

  AP-R: the kernel is not C*p^2, and may be normalized to C*(p*c).

AP-D.
  Normalize the kernel generator and the leaking generator as

    q3=p^2+alpha*r*c,
    q4=p*c+r*t.

  The coefficient alpha cannot vanish.  If alpha=0, then the colon

    K=(Q:r)

  has no nonzero quadratic class modulo P, contradicting that K is a complete
  intersection of type (1,1,2).  Hence alpha!=0, and rescaling c gives

    Q=(r^2,
       r*p,
       p^2+r*c,
       p*c+r*t).

  Moreover

    c*(p^2+r*c)-p*(p*c+r*t)
      =r*(c^2-p*t),

  and r*p*t belongs to Q.  Thus r*c^2 belongs to Q and c^2 belongs to K.
  Since K has linear part P and exactly one quadratic generator modulo P,

    K=(r,p,c^2).

AP-R.
  Normalize the zero-leak line to p*c.  After replacing p by p+lambda*r and
  replacing the complementary coordinate t by t+mu*c as needed, one obtains

    Q=(r^2,
       r*p,
       p^2+r*t,
       p*c).

  Here

    c*(p^2+r*t)-p*(p*c)=r*c*t,

  so c*t belongs to K.  Again the type-(1,1,2) colon forces equality:

    K=(r,p,c*t).

  Thus AP-D is the contained-double K type and AP-R is the contained-reduced K
  type.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_normal_forms:
  If A=P, exactly the following two canonical rho_Q=1 carriers remain:

    AP-D:
      K=(r,p,c^2),
      Q=(r^2,r*p,p^2+r*c,p*c+r*t);

    AP-R:
      K=(r,p,c*t),
      Q=(r^2,r*p,p^2+r*t,p*c).
Qed.

--------------------------------------------------------------------------
3. THE AR CASE HAS ONE DOUBLE COLON AND ONE BINARY LEAK FLAG
--------------------------------------------------------------------------

Assume A!=P and r belongs to A.  Normalize

    J=(r,p,c),
    A=(r,c),
    P=(r,p).

Choose

    q1=r^2,
    q2=r*c.

Modulo r, the remaining generators may be chosen with leading terms

    p^2,
    p*c.

Now

    (J*K)_2=J_1*A_1
      =span_C{r^2,r*p,r*c,p*c,c^2}.

Thus p*c already lies in (J*K)_2 whereas p^2 does not.  Since rho_Q=1, the
p*c generator cannot carry an independent r*t leak.  After allowed generator
and coordinate changes it is exactly p*c.

The p^2 generator may carry an r*t term without increasing rho_Q.  Terms r^2
and r*c are absorbed by q1,q2, and an r*p coefficient is removed by replacing
p with p+lambda*r.  Therefore only the dichotomy zero/nonzero r*t coefficient
remains.  Scaling t in the nonzero case gives epsilon in {0,1}:

    Q_AR(epsilon)
      =(r^2,
        r*c,
        p*c,
        p^2+epsilon*r*t).

For both values of epsilon,

    r*p^2
      =r*(p^2+epsilon*r*t)-epsilon*r^2*t
      belongs to Q,

so p^2 belongs to K.  Since K has linear part A=(r,c),

    K=(r,c,p^2).

Hence only the contained-double colon occurs in AR.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AR_normal_forms:
  If A!=P and r belongs to A, the rho_Q=1 carrier is exactly one of

    AR0:
      K=(r,c,p^2),
      Q=(r^2,r*c,p*c,p^2);

    AR1:
      K=(r,c,p^2),
      Q=(r^2,r*c,p*c,p^2+r*t).
Qed.

--------------------------------------------------------------------------
4. THE ANR CASE HAS TWO KERNEL ORBITS TIMES TWO COLON TYPES
--------------------------------------------------------------------------

Assume A!=P and r does not belong to A.  Normalize

    J=(r,p,c),
    A=(p,c),
    P=(r,p).

Choose

    q1=r*p,
    q2=r*c.

Modulo r, q3,q4 again span

    span_C{p^2,p*c}.

Here

    (J*K)_2=J_1*A_1
      =span_C{r*p,r*c,p^2,p*c,c^2}.

After subtracting q1,q2 components, the only possible leaks outside this space
are r^2 and r*t.  Thus each leak has the form

    r*lambda,

with lambda in span_C{r,t}.  Since rho_Q=1, the two leak vectors are dependent
and not both zero.  A generator change leaves one zero-leak line and one
nonzero leaking generator.

As in AP, the stabilizer of the distinguished intersection line C*p has exactly
two orbits on the possible zero-leak line inside span{p^2,p*c}:

  KER-P2: the zero-leak line is C*p^2;

  KER-PC: the zero-leak line is not C*p^2 and is normalized to C*(p*c).

The nonzero linear form lambda has exactly two orbits under changes of the
complementary coordinate t:

  DOUBLE:  lambda is proportional to r, normalized to lambda=r;

  REDUCED: lambda is independent of r, normalized to lambda=t.

In either kernel orbit, if q_leak denotes the leaking generator, multiplying it
by r and subtracting the corresponding multiple of q1 or q2 shows

    r^2*lambda belongs to Q.

Hence

    r*lambda belongs to (Q:r)=K.

Since K has linear part A=(p,c), its unique quadratic generator modulo A is
therefore r*lambda.  Thus

    lambda=r  => K=(p,c,r^2),
    lambda=t  => K=(p,c,r*t).

The four canonical forms are consequently:

  ANR-P2-D:
    K=(p,c,r^2),
    Q=(r*p,r*c,p^2,p*c+r^2);

  ANR-P2-R:
    K=(p,c,r*t),
    Q=(r*p,r*c,p^2,p*c+r*t);

  ANR-PC-D:
    K=(p,c,r^2),
    Q=(r*p,r*c,p*c,p^2+r^2);

  ANR-PC-R:
    K=(p,c,r*t),
    Q=(r*p,r*c,p*c,p^2+r*t).

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_ANR_normal_forms:
  If A!=P and r does not belong to A, exactly the four carriers displayed above
  remain.
Qed.

--------------------------------------------------------------------------
5. EXACT EIGHT-CARRIER rho_Q=1 FRONTIER
--------------------------------------------------------------------------

Combining the three incidence types gives exactly eight canonical rho_Q=1
normal-form carriers:

  AP-D,
  AP-R,
  AR0,
  AR1,
  ANR-P2-D,
  ANR-P2-R,
  ANR-PC-D,
  ANR-PC-R.

They are separated by the invariant data

    A=P or A!=P,
    r in A or r notin A,
    zero-leak kernel line parallel or nonparallel to p^2,
    contained-double or contained-reduced K type,
    and, in AR, the zero/nonzero r*t leak on the forced p^2 direction.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_finite_frontier:
  Every contained P-subset-J rho_Q=1 carrier is linearly equivalent, after
  admissible generator changes, to one of the eight displayed normal forms.
Qed.

IMPORTANT_NONCONCLUSION:
  This is a finite structural reduction only.

  The file does NOT prove that all eight displayed normal forms actually occur
  under every earlier global hypothesis; later saturation, Betti, or tangent
  constraints may remove some of them.

  It does NOT tangent-exclude any of the eight carriers.
  It does NOT close rho_Q=1.
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
  not H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Stay only in the eight rho_Q=1 normal forms.  Test the earliest structural
  constraints already available in H01-M2-R2 -- saturation Q=Qsat, the exact
  Betti table, and the determinantal identity I3(L)=(r)Q -- against the eight
  forms before attempting any new all-degree tangent estimate.

NEXT_ACTIONS:
  1. Intersect the eight rho_Q=1 normal forms with the standing saturation and
     exact-Betti constraints.
