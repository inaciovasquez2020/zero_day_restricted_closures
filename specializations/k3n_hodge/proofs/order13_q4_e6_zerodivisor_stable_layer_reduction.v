Standalone B-linear stable-layer reduction for the remaining unequal-degree
zerodivisor lower-cut subbranch in the homogeneous q=4, height-three,
multiplicity-six order-13 endpoint.

SCOPE:
  Continue from order13_q4_e6_zerodivisor_lower_cut_profile.v and
  order13_q4_e6_zerodivisor_conormal_ext_reduction.v.

  Work with

    J_i := (a, ell^i*b)  for i>=0,
    J_0 = (a,b),
    A := B/(ell^r*J_k),
    M := J_0/(a) = b*(B/(a)),

  where ell is B-regular, a is a nonzero quadratic zerodivisor,
  J_k is m-primary, r>=1, k>=1, and the previous profile proves that

    M is a finite graded C[ell]-module of rank s,
    1<=s<=5,
    T:=H^0_((ell))(M) is supported only in two degrees,
    ell^2*T=0.

  IMPORTANT REPAIR:
  The abstract PID decomposition M ~= F direct_sum T is only C[ell]-linear.
  It need not be B-linear, so it cannot be inserted directly into Hom_B or
  Ext_B.  This file replaces that noncanonical split by canonical B-submodules
  and a B-linear filtration.

This is pseudo-formal mathematical documentation.  It is not Coq and does not
assert generic F_13 algebraicity.

Define

  H := (a :_B b).

Theorem support_module_has_cyclic_B_model:
  There is a natural graded B-module isomorphism

    M ~= (B/H)(-2).

Proof:
  The map

    B(-2) -> M,
    x |-> x*b mod (a)

  is surjective by definition of M.  Its kernel consists exactly of the x with

    x*b in (a),

  namely H=(a:b).  The first isomorphism theorem gives the result.
Qed.

Corollary delayed_support_has_cyclic_B_model:
  For every k>=1,

    D_k:=J_0/J_k
       ~= M/ell^k*M
       ~= (B/(H,ell^k))(-2)

  as graded B-modules.

Proof:
  The first identification was established previously.  Apply the cyclic
  model and quotient by ell^k.
Qed.

Put

  C := B/H,
  U := H^0_((ell))(C),
  Cbar := C/U.

Under M ~= C(-2), the torsion module U(-2) is exactly the previously defined
T.  Hence

  ell^2*U=0.

Theorem torsion_quotient_is_canonical_and_B_linear:
  U is a graded B-submodule of C, Cbar is a graded B-module, and ell is a
  nonzerodivisor on Cbar.

Proof:
  If ell^n*x=0 and b0 in B, then ell^n*(b0*x)=0, so U is B-stable.

  If ell*(x+U)=0 in Cbar, then ell*x belongs to U.  Thus ell^(n+1)*x=0 for some
  n, so x belongs to U and x+U=0.  Therefore ell is Cbar-regular.
Qed.

Theorem canonical_free_quotient:
  As a C[ell]-module, Cbar is finite free of rank s.

Proof:
  Cbar is finite over C[ell] because C is.  It is torsion-free over the PID
  C[ell] by the preceding theorem, hence free.  Removing finite ell-primary
  torsion does not change the eventual Hilbert-function value, so its rank is
  the already established stable rank s.
Qed.

For k>=1 define

  Q_k := Cbar/ell^k*Cbar.

Theorem delayed_support_splits_canonically_only_as_an_extension:
  There is a natural exact sequence of graded B-modules

    0 -> U/ell^k*U
      -> C/ell^k*C
      -> Q_k
      -> 0.

  Equivalently, after the degree-two shift,

    0 -> (U/ell^k*U)(-2)
      -> D_k
      -> Q_k(-2)
      -> 0.

  For every k>=2 this becomes

    0 -> U(-2)
      -> D_k
      -> Q_k(-2)
      -> 0

  because ell^2*U=0.

Proof:
  Apply quotient by ell^k to

    0 -> U -> C -> Cbar -> 0.

  Since ell is a nonzerodivisor on Cbar, multiplication by ell^k is injective
  there.  Equivalently Tor_1^{C[ell]}(Cbar,C[ell]/(ell^k))=0, so the left-hand
  injection survives quotienting.  Shift by two and use D_k~=C/(ell^k)(-2).
Qed.

Corollary free_growth_has_exact_length:
  One has

    length_C(Q_k)=k*s.
Qed.

Define

  V := Cbar/ell*Cbar.

Then V is a finite cyclic B/(ell)-module and

  length_C(V)=s<=5.

Theorem free_growth_has_B_linear_length_k_filtration:
  For every i>=2 there is a natural exact sequence

    0 -> ell^(i-1)*Cbar / ell^i*Cbar
      -> Q_i
      -> Q_(i-1)
      -> 0,

  and multiplication by ell^(i-1) induces a graded B-module isomorphism

    (Cbar/ell*Cbar)(-(i-1))
      ~= ell^(i-1)*Cbar / ell^i*Cbar.

  Thus Q_k has a B-linear filtration whose k successive factors are graded
  shifts of the single fixed module V, each of C-length s.

Proof:
  The first sequence is the evident ell-adic filtration.  Because ell is
  Cbar-regular, multiplication by ell^(i-1) has kernel exactly ell*Cbar after
  passage to the displayed quotient, giving the second assertion.
Qed.

Now return directly to the ideals J_i.

For 1<=i<=k put

  W_i := J_(i-1)/J_i.

Theorem one_step_delayed_quotient:
  There is a natural graded B-module isomorphism

    W_i ~= ell^(i-1)*M / ell^i*M.

Proof:
  Modulo the common subideal (a), J_(i-1) maps to ell^(i-1)*M while J_i maps
  to ell^i*M.  Taking their quotient gives the claim.
Qed.

Theorem stable_steps_are_repetitions_of_one_B_module:
  For every i>=3,

    W_i ~= V(-(i+1))

  as graded B-modules, up to the displayed degree convention; in particular,
  forgetting grading, every W_i with i>=3 is B-isomorphic to the same module V.

Proof:
  Under M~=C(-2), the quotient is

    ell^(i-1)*C / ell^i*C

  shifted by two.  Since i-1>=2 and ell^2*U=0, the torsion U contributes
  nothing to either ell^(i-1)*C or ell^i*C.  Passing to Cbar therefore does not
  change this quotient.  The preceding ell-adic theorem identifies the result
  with a shift of V.
Qed.

Interpretation:
  All unbounded dependence on k is now a repetition of one fixed cyclic
  B/(ell)-module V of length s<=5.  The first two steps contain every possible
  ell-primary torsion correction; no later step introduces a new module type.

For the fixed final target A=B/(ell^r*J_k), define

  Delta_i := dim_C Hom_B(J_(i-1),A)
             - dim_C Hom_B(J_i,A).

Theorem exact_telescoping_of_delayed_conormal_defect:
  The defect from the preceding conormal--Ext file satisfies

    delta_k = sum_(i=1)^k Delta_i.

Proof:
  The previous file proved

    delta_k = dim Hom_B(J_0,A)-dim Hom_B(J_k,A).

  Insert the intermediate ideals J_1,...,J_(k-1) and telescope.
Qed.

For each i, apply Hom_B(-,A) to

  0 -> J_i -> J_(i-1) -> W_i -> 0.

If

  rho_i := dim_C ker(
             Ext^1_B(W_i,A) -> Ext^1_B(J_(i-1),A)),

then exactness gives

  Delta_i = dim_C Hom_B(W_i,A)-rho_i.

Therefore, for every stable step i>=3, the only remaining unbounded issue is
not a new support module: it is the connecting-map rank for the same fixed
length-s module V (with the extension class changing along the chain).

IMPORTANT_NONCONCLUSION:
  This file does NOT prove Delta_i=0 or Delta_i<=0 for i>=3.

  The C[ell]-free quotient cannot be split off B-linearly without an additional
  argument.  The correct replacement is the canonical B-linear filtration
  above.

BOUNDARY:
  The zerodivisor unequal-degree e=6 branch is reduced to:

    (1) two exceptional steps W_1,W_2 containing all ell-primary torsion, and
    (2) repeated stable steps W_i~=V for i>=3,

  where V is one fixed cyclic B/(ell)-module of length

    s in {1,2,3,4,5}.

  The first missing statement is the stable-layer compensation inequality

    Delta_i <= 0

  (or any uniform bound strong enough for the deficit-twenty gate) for i>=3.
  Equivalently, one must bound the failure of

    Hom_B(V,A) -> Ext^1_B(V,A)

  to be recovered by the connecting map attached to

    0 -> J_i -> J_(i-1) -> V -> 0.

NEXT_BOUNDED_OBJECT:
  identify the saturated colon

    Hsat := H : ell^infinity

  so that

    Cbar ~= B/Hsat,
    V ~= B/(Hsat,ell),

  and compute the stable one-step extension class in the Artin ring B/(ell),
  whose Hilbert function is (1,3,2).  Do not use a non-B-linear PID splitting
  inside Hom_B or Ext_B.
