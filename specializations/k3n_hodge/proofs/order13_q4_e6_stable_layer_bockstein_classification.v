Standalone saturation and stable-Bockstein classification for the remaining
unequal-degree zerodivisor lower-cut subbranch in the homogeneous q=4,
height-three, multiplicity-six order-13 endpoint.

SCOPE:
  Continue from

    order13_q4_e6_zerodivisor_lower_cut_profile.v,
    order13_q4_e6_zerodivisor_conormal_ext_reduction.v,
    order13_q4_e6_zerodivisor_stable_layer_reduction.v.

  Work with

    B := S/Q,
    ell in B_1 a fixed homogeneous nonzerodivisor,
    a,b in B_2,
    J_i := (a,ell^i*b),
    J_0=(a,b) m-primary,
    H := (a :_B b),
    C := B/H,
    U := H^0_((ell))(C),
    Cbar := C/U,
    V := Cbar/ell*Cbar.

  The preceding file proves

    M:=J_0/(a) ~= C(-2),
    rank_C[ell](Cbar)=s with 1<=s<=5,
    U_n=0 outside n=0,1,
    ell^2*U=0,

  and reduces all stable layers to copies of V after the first two steps.

  This file sharpens that reduction.  It identifies the saturation exactly,
  shows that the ell-primary torsion is in fact killed by one power of ell,
  classifies the possible Hilbert functions of V, and identifies the repeated
  two-layer extension as one fixed Bockstein class.

This is pseudo-formal mathematical documentation.  It is not Coq and does not
assert generic F_13 algebraicity.

Define

  Hsat := H : ell^infinity
        = union_n (H : ell^n).

Theorem colon_saturation_equals_principal_saturation:
  One has

    Hsat = (a) : ell^infinity.

Proof:
  Since J_0=(a,b) is m-primary, B/J_0 has finite length.  Hence after inverting
  ell,

    (a,b) B[ell^(-1)] = B[ell^(-1)].

  Thus there exist u,v in B[ell^(-1)] with

    u*a+v*b=1.

  In B[ell^(-1)], let x belong to (a:b).  Then x*b=y*a for some y, and

    x = x*(u*a+v*b)
      = (x*u+v*y)*a,

  so x belongs to (a).  The reverse inclusion (a) subset (a:b) is automatic.
  Therefore

    (a:b) B[ell^(-1)] = (a) B[ell^(-1)].

  Contracting both ideals back to B gives equality of their ell-saturations.
Qed.

Corollary canonical_free_quotient_is_principal_saturation_quotient:
  There are natural graded B-module identifications

    U ~= Hsat/H,
    Cbar ~= B/Hsat ~= B/((a):ell^infinity),
    V ~= B/(Hsat,ell).

Proof:
  For any ideal H, the ell-power torsion in B/H is exactly

    (H:ell^infinity)/H.

  Quotienting C=B/H by this torsion gives B/Hsat.  The preceding theorem then
  identifies Hsat with the principal saturation of (a).  Modding out by ell
  gives V.
Qed.

Theorem saturation_torsion_has_no_degree_zero_part:
  One has

    U_0=0.

Proof:
  The preceding stable-layer file proves that Cbar is a nonzero free
  C[ell]-module of rank s>=1.  If U_0 were nonzero, then because C_0=C and U is
  graded, the class of 1 would lie in U.  Thus ell^N would lie in H for some N,
  so Hsat=B and Cbar=0, contradiction.
Qed.

Corollary saturation_torsion_is_killed_by_ell:
  The module U is concentrated in degree one and

    ell*U=0.

  Equivalently, the torsion submodule

    T=H^0_((ell))(M)=U(-2)

  is concentrated in degree three and

    ell*T=0.

Proof:
  The preceding stable-layer file confines U to degrees zero and one.  The
  previous theorem removes degree zero.  Multiplication by ell sends U_1 to
  U_2=0, so ell*U=0.  Shift by two for the statement about T.
Qed.

Corollary delayed_torsion_correction_stabilizes_immediately:
  For every k>=1,

    tau_k := length_C(0:_M ell^k)
           = length_C(T).

Proof:
  The torsion-free quotient of M contributes no ell^k-kernel.  Since ell*T=0,
  every positive power ell^k kills all of T.
Qed.

Theorem stable_layers_begin_at_the_second_step:
  Put

    W_i := J_(i-1)/J_i.

  Then for every i>=2,

    W_i ~= V(-(i+1))

  as graded B-modules, with the same shift convention as in
  order13_q4_e6_zerodivisor_stable_layer_reduction.v.

Proof:
  The preceding file gives

    W_i ~= ell^(i-1)*C / ell^i*C

  followed by the fixed degree-two shift coming from M~=C(-2).

  For i>=2 one has i-1>=1, and ell*U=0.  Hence the torsion U contributes
  nothing to either ell^(i-1)*C or ell^i*C.  Replacing C by Cbar is therefore
  exact already from i=2 onward.  Since ell is Cbar-regular,

    ell^(i-1)*Cbar / ell^i*Cbar
      ~= (Cbar/ell*Cbar)(-(i-1))
      = V(-(i-1)).

  Restoring the fixed degree-two shift gives the displayed convention.
Qed.

Now retain the notation from the lower-cut profile

  t := dim_C(0:_B a)_1,
  epsilon in {0,1},

with

  Hilb_(B/J_0)=(1,4,4,epsilon).

Put

  u := dim_C U_1.

Theorem exact_h_vector_of_the_stable_layer:
  The Artin reduction V has Hilbert function

    Hilb_V = (1,p,q),

  where

    p = 1+t-epsilon-u,
    q = s-2-t+epsilon+u,

  so

    1+p+q=s.

Proof:
  Since M~=C(-2), the Hilbert profile already proved for M gives

    dim C_0 = 1,
    dim C_1 = 2+t-epsilon,
    dim C_n = s for n>=2.

  The only torsion in C is U_1 of dimension u.  Therefore

    dim Cbar_0 = 1,
    dim Cbar_1 = 2+t-epsilon-u,
    dim Cbar_n = s for n>=2.

  Because ell is Cbar-regular,

    0 -> Cbar(-1) --ell--> Cbar -> V -> 0

  is exact.  Taking degreewise first differences gives

    dim V_0=1,
    dim V_1=(2+t-epsilon-u)-1=p,
    dim V_2=s-(2+t-epsilon-u)=q,

  and V_n=0 for n>=3.
Qed.

Corollary only_eight_stable_h_vectors_are_possible:
  Let

    R:=B/(ell).

  The ring R is standard graded with Hilbert function

    (1,3,2),

  and V is a cyclic graded quotient of R of length s<=5.  Consequently the
  Hilbert function of V must be one of

    (1),
    (1,1),
    (1,1,1),
    (1,2),
    (1,2,1),
    (1,2,2),
    (1,3),
    (1,3,1).

Proof:
  Since V is a quotient of R,

    0<=p<=3,
    0<=q<=2.

  Since V is standard graded and generated by V_0, p=0 forces q=0.  If p=1,
  the degree-two part generated by one degree-one variable has dimension at
  most one, so q<=1.  Finally s=1+p+q<=5 excludes (p,q)=(3,2).  Enumerating
  the remaining pairs gives exactly the displayed list.
Qed.

Define the canonical two-layer Bockstein extension

  beta_V:
    0 -> V(-1)
      --ell-->
      Cbar/ell^2*Cbar
      -> V
      -> 0.

Theorem stable_two_layer_extension_is_independent_of_i:
  For every i>=2, the exact sequence

    0 -> W_(i+1)
      -> J_(i-1)/J_(i+1)
      -> W_i
      -> 0

  is, after the predictable grading shift, isomorphic to beta_V.

Proof:
  Modulo the common ideal (a),

    J_(i-1)/J_(i+1)
      ~= ell^(i-1)*M / ell^(i+1)*M.

  Since i>=2, multiplication by ell^(i-1) kills the entire torsion T.  Replace
  M by its canonical torsion-free quotient Cbar(-2).  Regularity of ell on
  Cbar then identifies

    ell^(i-1)*Cbar / ell^(i+1)*Cbar

  with Cbar/ell^2*Cbar up to shift, and the two successive quotients with the
  two copies of V in beta_V.  The inclusion is multiplication by ell.
Qed.

Corollary stable_extension_class_is_genuinely_non_split:
  The Bockstein beta_V is not split as a B-module extension.

Proof:
  If beta_V split B-linearly, its middle term would be

    V direct_sum V(-1).

  Multiplication by ell is zero on both summands because ell annihilates V.
  But ell acts nontrivially on Cbar/ell^2*Cbar: Cbar is ell-torsion-free and
  V is nonzero, so ell*Cbar/ell^2*Cbar is the nonzero submodule V(-1).
  Contradiction.
Qed.

Interpretation:
  The unbounded degree-gap parameter k no longer creates new module shapes or
  new extension shapes.

  After the first exceptional step W_1, every layer is one of only eight
  possible cyclic quotients V of the fixed level Artin ring R with Hilbert
  function (1,3,2), and every pair of consecutive stable layers is glued by
  the same non-split Bockstein beta_V.

  Thus the remaining stable compensation problem is finite in shape even
  though k is unbounded.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove the compensation inequality

    Delta_i <= 0

  for i>=2.

  It also does NOT claim that the eight Hilbert functions determine V up to
  B/(ell)-module isomorphism; continuous multiplication data can remain within
  a fixed Hilbert function.

BOUNDARY:
  The first missing local statement is now the rank of the connecting map

    Hom_B(J_i,A) -> Ext^1_B(V,A)

  for the single stable Bockstein beta_V.  Equivalently, compute the pushout
  map induced by beta_V and prove a uniform compensation bound for each of the
  eight possible h-vector shapes above.

NEXT_BOUNDED_OBJECT:
  Work over the fixed Artin reduction

    R=B/(ell), Hilb_R=(1,3,2),

  present each possible cyclic quotient V=R/K, and compute the regular-parameter
  Bockstein beta_V through the first syzygies of K.  The target is the uniform
  stable-layer inequality Delta_i<=0 (or a sharp positive bound still strong
  enough for the deficit-twenty gate).  Do not return to global semiregularity,
  Hecke, Kuga--Satake, or arbitrary PID splittings before this Bockstein rank is
  resolved.
