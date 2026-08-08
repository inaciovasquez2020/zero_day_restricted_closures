Conditional

ZeroDayDefectWitnessRequires(X,c) :=
  exists i : ZeroDayRequiredK3nHodgeClasses(X).I,
    ZeroDayRequiredK3nHodgeClasses(X).class(i) = c


ZeroDayDefectWitnessConstruction(X) :=
  required_index : ZeroDayRequiredK3nHodgeClasses(X).I
  required_class :
    H^(2 * degree(required_index))(X,Q)
  required_class :=
    ZeroDayRequiredK3nHodgeClasses(X).class(required_index)

Theorem defect_witness_construction_requires_its_class:
  forall w : ZeroDayDefectWitnessConstruction(X),
    ZeroDayDefectWitnessRequires(X,w.required_class)

Proof:
  Let w : ZeroDayDefectWitnessConstruction(X).
  Unfold ZeroDayDefectWitnessRequires(X,w.required_class).
  Witness w.required_index.
  Exact w.required_class =
    ZeroDayRequiredK3nHodgeClasses(X).class(w.required_index).
Qed.

Boundary:
  construction chooses exactly one existing required-class index
  construction existence is not asserted
  degree(required_index) = 2 is not asserted
  no geometric class is introduced
  no quotient projection is asserted


K3ThreeTypeDegreeFourDefectExtractionInterface(X,W) :=
  extract_index :
    W -> ZeroDayRequiredK3nHodgeClasses(X).I
  extract_degree_four :
    forall w : W,
      degree(extract_index(w)) = 2

Boundary:
  W is a supplied defect-witness type
  no inhabitant of W is asserted
  no extraction map is asserted to exist
  no geometric H^4 class is selected
  no quotient projection is defined
  this interface is exactly the missing bridge from supplied defect data
  to an existing degree-four required-class index

Boundary:
  requirement means membership in the declared finite required-class inventory
  it does not assert minimality, uniqueness, causal necessity, or completeness
  a concrete class c is required only after an index i with class(i) = c is exhibited


RequiredClassesSubsetSH(X) :=
  forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
    ZeroDayRequiredK3nHodgeClasses(X).class(i) in SH^(2 * degree(i))(X,Q)

ZeroDayConditionalClosureSurface(X) :=
  required_subset_SH : RequiredClassesSubsetSH(X)
  closure_from_required_subset :
    RequiredClassesSubsetSH(X) -> ZeroDayClosure(X)

Theorem required_classes_subset_SH_implies_zero_day_closure:
  RequiredClassesSubsetSH(X) -> ZeroDayClosure(X)

Boundary:
  not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses


Theorem BottiniK3TwoTypeVerbitskyExhaustion:
  IsK3TwoType(X) ->
  H^*(X,Q) = SH(X,Q)

Proof:
  Let X be of K3^[2]-type.

  Start from the K3 Betti numbers
      (b_0,b_1,b_2,b_3,b_4) = (1,0,22,0,1).

  Applying the Göttsche Hilbert-scheme Poincare-polynomial
  generating formula and extracting the q^2 coefficient gives
      P_X(t)
        = 1 + 23 t^2 + 276 t^4 + 23 t^6 + t^8.

  Therefore
      dim_Q H^0(X,Q) = 1,
      dim_Q H^2(X,Q) = 23,
      dim_Q H^4(X,Q) = 276,
      dim_Q H^6(X,Q) = 23,
      dim_Q H^8(X,Q) = 1,
  and the odd rational cohomology groups vanish.

  By Verbitsky's theorem, specialized to n = 2,
      SH^0(X,Q) ~= Sym^0 H^2(X,Q),
      SH^2(X,Q) ~= Sym^1 H^2(X,Q),
      SH^4(X,Q) ~= Sym^2 H^2(X,Q),
      SH^6(X,Q) ~= Sym^1 H^2(X,Q),
      SH^8(X,Q) ~= Sym^0 H^2(X,Q).

  Since dim_Q H^2(X,Q) = 23,
      dim Sym^0 H^2 = 1,
      dim Sym^1 H^2 = 23,
      dim Sym^2 H^2 = 23 * 24 / 2 = 276.

  Hence SH(X,Q) and H^*(X,Q) have equal dimension in every
  cohomological degree.

  By definition SH(X,Q) is a graded subalgebra of H^*(X,Q).
  Each graded inclusion is therefore an inclusion of
  finite-dimensional Q-vector spaces of equal dimension and is
  consequently an equality.

  Thus
      H^*(X,Q) = SH(X,Q).
Qed.

Sources:
  Göttsche Hilbert-scheme Poincare-polynomial formula.
  Verbitsky theorem as stated in Bottini,
  The Looijenga-Lunts-Verbitsky Algebra and Verbitsky's Theorem,
  Definition 4.4, Theorem 5.1, Corollary 5.3.

Boundary:
  Bottini Example 5.4 is no longer imported as the exhaustion result
  the exhaustion conclusion is derived from Göttsche plus Verbitsky
  the underlying Göttsche and Verbitsky theorems remain external inputs
  no K3^[n]-type exhaustion for n >= 3 is claimed

Theorem k3_three_type_degree_four_SH_obstruction:
  For X of K3^[3]-type,
    dim_Q H^4(X,Q) = 299
    and dim_Q SH^4(X,Q) = 276
    and dim_Q (H^4(X,Q) / SH^4(X,Q)) = 23
    and H^*(X,Q) != SH(X,Q)

Proof:
  Let X be of K3^[3]-type.

  Applying the Göttsche Hilbert-scheme Poincare-polynomial
  generating formula and extracting the q^3 coefficient gives
      P_X(t)
        = 1
          + 23 t^2
          + 299 t^4
          + 2554 t^6
          + 299 t^8
          + 23 t^10
          + t^12.

  Therefore
      dim_Q H^2(X,Q) = 23
  and
      dim_Q H^4(X,Q) = 299.

  By Verbitsky's theorem, since 2 <= 3,
      SH^4(X,Q) ~= Sym^2 H^2(X,Q).

  Hence
      dim_Q SH^4(X,Q)
        = dim_Q Sym^2(Q^23)
        = 23 * 24 / 2
        = 276.

  By definition
      SH^4(X,Q) subset H^4(X,Q).

  Therefore
      dim_Q (H^4(X,Q) / SH^4(X,Q))
        = 299 - 276
        = 23.

  In particular SH^4(X,Q) is a proper subspace of H^4(X,Q),
  so
      H^*(X,Q) != SH(X,Q).
Qed.

Boundary:
  exact first obstruction to Verbitsky-component exhaustion occurs at K3^[3] degree 4
  the missing quotient has rational dimension exactly 23
  H^*(X,Q) = SH(X,Q) is abandoned as the closure route for n >= 3
  future n >= 3 work must test required classes against SH and its complement directly


Theorem k3_n_type_degree_four_SH_complement_dimensions:
  For n >= 2 and X of K3^[n]-type,
    dim_Q SH^4(X,Q) = 276
    and
    (n = 2 ->
      dim_Q (H^4(X,Q) / SH^4(X,Q)) = 0)
    and
    (n = 3 ->
      dim_Q (H^4(X,Q) / SH^4(X,Q)) = 23)
    and
    (n >= 4 ->
      dim_Q (H^4(X,Q) / SH^4(X,Q)) = 24)

Proof:
  Start from the K3 Betti numbers
    b_0 = 1, b_1 = 0, b_2 = 22, b_3 = 0, b_4 = 1.

  Göttsche's Hilbert-scheme Poincare generating function is
    sum_{n >= 0} P_t(K3^[n]) q^n
      =
    product_{m >= 1}
      1 /
      ((1 - t^(2m-2) q^m)
       (1 - t^(2m) q^m)^22
       (1 - t^(2m+2) q^m)).

  Extracting the coefficient of t^4 gives
    sum_{n >= 0} b_4(K3^[n]) q^n
      =
    (q + 275 q^2 + 23 q^3 + q^4) / (1 - q).

  Hence
    b_4(K3^[2]) = 276,
    b_4(K3^[3]) = 299,
    and b_4(K3^[n]) = 300 for every n >= 4.

  For every K3^[n]-type manifold with n >= 2,
    dim_Q H^2(X,Q) = 23.

  Verbitsky's degree-four component gives
    SH^4(X,Q) ~= Sym^2 H^2(X,Q).

  Therefore
    dim_Q SH^4(X,Q)
      = dim_Q Sym^2(Q^23)
      = binomial(24,2)
      = 276.

  Since SH^4(X,Q) is a subspace of H^4(X,Q),
    dim_Q (H^4(X,Q) / SH^4(X,Q))
      = dim_Q H^4(X,Q) - dim_Q SH^4(X,Q).

  Thus the quotient dimensions are
    276 - 276 = 0 for n = 2,
    299 - 276 = 23 for n = 3,
    300 - 276 = 24 for n >= 4.
Qed.

Sources:
  Göttsche, The Betti numbers of the Hilbert scheme of points
  on a smooth projective surface, Math. Ann. 286 (1990), 193-207.
  Verbitsky theorem for the H^2-generated component,
  as organized in Bottini's LLV/Verbitsky treatment.

Boundary:
  this is a dimension theorem only
  no basis of the complementary quotient is selected
  no required-class index is constructed
  no geometric H^4 class is declared required
  no quotient projection of a required class is evaluated
  no ZeroDayClosure theorem for n >= 3 is claimed
  novelty is not asserted; this is an exact structural consequence
  of the stated Göttsche and Verbitsky inputs


ExternalResult KapferDegreeFourIntegralCupCokernelProfile(S,n) :=
  For S a projective K3 surface,

    n = 2 ->
      H^4(S^[2],Z) / Sym^2 H^2(S^[2],Z)
        ~= (Z/2Z)^23 direct_sum Z/5Z

    n = 3 ->
      H^4(S^[3],Z) / Sym^2 H^2(S^[3],Z)
        ~= Z/3Z direct_sum Z^23

    n >= 4 ->
      H^4(S^[n],Z) / Sym^2 H^2(S^[n],Z)
        ~= Z^24

Source:
  Simon Kapfer,
  Computing cup products in integral cohomology of Hilbert schemes
  of points on K3 surfaces,
  LMS J. Comput. Math. 19 (2016), Proposition 2.2.
  For n >= 4, Kapfer also records Markman's independent freeness result.

Theorem k3_hilbert_degree_four_integral_saturation_profile:
  For S a projective K3 surface,

    n = 2 ->
      Sym^2 H^2(S^[2],Z) is not saturated in H^4(S^[2],Z)
      and
      Sym^2 H^2(S^[2],Q) = H^4(S^[2],Q)

    n = 3 ->
      Sym^2 H^2(S^[3],Z) is not saturated in H^4(S^[3],Z)
      and
      dim_Q (
        H^4(S^[3],Q) / Sym^2 H^2(S^[3],Q)
      ) = 23

    n >= 4 ->
      Sym^2 H^2(S^[n],Z) is saturated in H^4(S^[n],Z)
      and
      dim_Q (
        H^4(S^[n],Q) / Sym^2 H^2(S^[n],Q)
      ) = 24

Proof:
  Apply KapferDegreeFourIntegralCupCokernelProfile.

  For n = 2, the cokernel is finite and nonzero.
  Therefore the integral image is not saturated,
  while tensoring with Q kills the entire cokernel.

  For n = 3, the cokernel is
    Z/3Z direct_sum Z^23.
  Its nonzero torsion proves non-saturation,
  and tensoring with Q leaves Q^23.

  For n >= 4, the cokernel is Z^24.
  A free quotient is torsion-free, hence the image is saturated,
  and tensoring with Q gives Q^24.
Qed.

Boundary:
  this theorem concerns the integral cup-product lattice
  it does not select any required-class index
  it does not identify a geometric generator of the free quotient
  it does not evaluate a required-class quotient projection
  it does not reopen the stopped K3^[3] inventory branch
  deformation transfer from S^[n] to an arbitrary K3^[n]-type X
  is not asserted here
  novelty is not asserted for the Kapfer-Markman input


ExternalResult K3nIntegralCohomologyRingDeformationTransport(X,S,n) :=
  If X is of K3^[n]-type and S is a K3 surface, then deformation
  equivalence from S^[n] to X induces a graded integral cohomology-ring
  isomorphism

    Phi : H^*(S^[n],Z) ~= H^*(X,Z)

  satisfying

    Phi(H^2(S^[n],Z)) = H^2(X,Z)

  and therefore

    Phi(Sym^2 H^2(S^[n],Z))
      = Sym^2 H^2(X,Z).

Sources:
  Ehresmann deformation transport for smooth proper families.
  Markman, monodromy operators on the integral cohomology ring of
  manifolds deformation equivalent to Hilbert schemes of K3 surfaces.

Boundary:
  the transport is not asserted canonical
  no preferred quotient basis or generator is transported
  only the isomorphism type of the integral cup-product cokernel is used


Theorem k3_n_type_integral_degree_four_saturation_profile:
  For n >= 2 and X of K3^[n]-type,

    n = 2 ->
      H^4(X,Z) / Sym^2 H^2(X,Z)
        ~= (Z/2Z)^23 direct_sum Z/5Z
      and
      Sym^2 H^2(X,Z) is not saturated in H^4(X,Z)
      and
      Sym^2 H^2(X,Q) = H^4(X,Q)

    n = 3 ->
      H^4(X,Z) / Sym^2 H^2(X,Z)
        ~= Z/3Z direct_sum Z^23
      and
      Sym^2 H^2(X,Z) is not saturated in H^4(X,Z)
      and
      dim_Q (
        H^4(X,Q) / Sym^2 H^2(X,Q)
      ) = 23

    n >= 4 ->
      H^4(X,Z) / Sym^2 H^2(X,Z)
        ~= Z^24
      and
      Sym^2 H^2(X,Z) is saturated in H^4(X,Z)
      and
      dim_Q (
        H^4(X,Q) / Sym^2 H^2(X,Q)
      ) = 24

Proof:
  Choose a K3 surface S and a deformation from S^[n] to X.

  Apply K3nIntegralCohomologyRingDeformationTransport(X,S,n).

  The resulting graded ring isomorphism identifies
    H^4(S^[n],Z) with H^4(X,Z)
  and identifies
    Sym^2 H^2(S^[n],Z)
  with
    Sym^2 H^2(X,Z).

  Hence it induces an isomorphism of cokernels

    H^4(S^[n],Z) / Sym^2 H^2(S^[n],Z)
      ~=
    H^4(X,Z) / Sym^2 H^2(X,Z).

  Transfer the three cases of
    k3_hilbert_degree_four_integral_saturation_profile.

  Saturation is preserved under the integral group isomorphism,
  and tensoring the transported cokernel with Q gives the stated
  rational quotient dimensions.
Qed.

Boundary:
  the former Hilbert-scheme-only restriction is removed
  no canonical deformation transport is claimed
  no quotient basis or geometric generator is selected
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


ExternalResult GreenKimLazaRoblesK3ThreeReducedLLVDegreeFour(X) :=
  If X is of K3^[3]-type, then for the reduced LLV algebra
    g_bar ~= so(3,20),

    H^4(X,Q)
      ~= Sym^2 H^2(X,Q) direct_sum H^2(X,Q)

  as g_bar-modules.

  Consequently

    H^4(X,Q) / Sym^2 H^2(X,Q)
      ~= H^2(X,Q)

  as the 23-dimensional standard reduced-LLV module.

Source:
  Green, Kim, Laza, Robles,
  The LLV decomposition of hyper-Kahler cohomology,
  Remark 3.3, equations (3.4)-(3.5).


ExternalResult MarkmanK3nDegreeFourQuotientLatticeStructure(X,n) :=
  For n >= 4 and X of K3^[n]-type, define

    Q4(X,Z) :=
      H^4(X,Z) / Sym^2 H^2(X,Z).

  Then

    Q4(X,Z)
      ~= E8(-1)^2 direct_sum U^4

  as a rank-24 unimodular lattice.

  Let

    gamma_X := (1/2) [c2(X)] in Q4(X,Z).

  Then

    gamma_X is nonzero and primitive
    q_Q(gamma_X) = 2n - 2

  and there exists a Hodge isometry

    e_X :
      H^2(X,Z) ~= gamma_X^perp in Q4(X,Z).

  For every monodromy operator sigma,

    sigma_Q(gamma_X) = gamma_X

  and

    sigma_Q(e_X(alpha))
      =
    tau(sigma) * e_X(sigma_2(alpha)),

  where tau is the discriminant character.

Source:
  Markman, degree-four quotient theorem for K3^[n]-type,
  n >= 4.
  The monodromy formula with tau equal to the discriminant
  character is the refined form of the same structure.

Boundary:
  gamma_X is a quotient class, not a required-class inventory element
  e_X is not asserted canonical
  no preferred basis of Q4(X,Z) is chosen


Theorem k3_n_type_degree_four_quotient_representation_profile:
  For n >= 2 and X of K3^[n]-type,

    n = 2 ->
      H^4(X,Q) / Sym^2 H^2(X,Q) = 0

    and

    n = 3 ->
      H^4(X,Q) / Sym^2 H^2(X,Q)
        ~= H^2(X,Q)
      as the standard reduced-LLV module

    and

    n >= 4 ->
      Q4(X,Q)
        =
      Q * gamma_X
        direct_sum
      e_X(H^2(X,Q))

      with gamma_X monodromy-fixed
      and e_X(H^2(X,Q)) carrying the
      discriminant-character-twisted H^2 monodromy action.

  After restriction to the connected reduced-LLV Lie algebra,
  the finite character tau disappears, so for n >= 4

    Q4(X,Q)
      ~= Q direct_sum H^2(X,Q)

  as reduced-LLV modules.

Proof:
  For n = 2, apply the already-derived rational exhaustion
    Sym^2 H^2(X,Q) = H^4(X,Q).

  For n = 3, apply
    GreenKimLazaRoblesK3ThreeReducedLLVDegreeFour(X)
  and quotient by the Sym^2 H^2(X,Q) summand.

  For n >= 4, apply
    MarkmanK3nDegreeFourQuotientLatticeStructure(X,n).

  Since q_Q(gamma_X) = 2n - 2 is nonzero,
    Q4(X,Q)
      =
    Q * gamma_X direct_sum gamma_X^perp_Q.

  Transport gamma_X^perp_Q through e_X to H^2(X,Q).

  The monodromy formula gives the tau-twisted standard action.
  Since tau has finite image {+1,-1}, its differential is zero.
  Hence the connected reduced-LLV Lie algebra acts trivially on
  Q * gamma_X and by the standard representation on H^2(X,Q).
Qed.

Boundary:
  n = 3 has no trivial quotient line
  n >= 4 acquires exactly one trivial rational quotient line
  generated by gamma_X = (1/2)[c2(X)]
  the remaining 23 dimensions form the standard H^2 representation
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


ExternalResult GottScheSoergelK3nDegreeFourHodgeProfile(X,n) :=
  For n >= 2 and X of K3^[n]-type, the degree-four Hodge numbers,
  ordered as

    (h^(4,0), h^(3,1), h^(2,2), h^(1,3), h^(0,4)),

  are

    n = 2 : (1,21,232,21,1)
    n = 3 : (1,22,253,22,1)
    n >= 4 : (1,22,254,22,1).

Proof datum:
  Apply the Göttsche-Soergel Hilbert-scheme Hodge generating formula
  to the K3 Hodge diamond

    h^(0,0) = 1,
    h^(2,0) = 1,
    h^(1,1) = 20,
    h^(0,2) = 1,
    h^(2,2) = 1,

  and use deformation invariance of Hodge numbers for K3^[n]-type.

  In total cohomological degree four the relevant generating series are

    sum h^(4,0)(K3^[n]) q^n
      = q^2 / (1-q),

    sum h^(3,1)(K3^[n]) q^n
      = (21 q^2 + q^3) / (1-q),

    sum h^(2,2)(K3^[n]) q^n
      = (q + 231 q^2 + 21 q^3 + q^4) / (1-q),

  together with Hodge symmetry for h^(1,3) and h^(0,4).

Sources:
  Göttsche-Soergel Hilbert-scheme Hodge-number formula.
  Deformation invariance of Hodge numbers in smooth proper families.

Boundary:
  this records Hodge multiplicities only
  no individual quotient class is selected


Theorem sym2_h2_degree_four_hodge_profile:
  For n >= 2 and X of K3^[n]-type,

    Sym^2 H^2(X,Q)

  has degree-four Hodge profile

    (1,21,232,21,1).

Proof:
  H^2(X,Q) has Hodge profile

    h^(2,0) = 1,
    h^(1,1) = 21,
    h^(0,2) = 1.

  Therefore Sym^2 H^2 has

    h^(4,0) = 1,
    h^(3,1) = 21,
    h^(2,2) = binomial(22,2) + 1 = 232,
    h^(1,3) = 21,
    h^(0,4) = 1.
Qed.


Theorem k3_n_type_degree_four_quotient_hodge_profile:
  For n >= 2 and X of K3^[n]-type, let

    Q4_Q(X) :=
      H^4(X,Q) / Sym^2 H^2(X,Q).

  Then the quotient Hodge profile

    (h_Q^(4,0), h_Q^(3,1), h_Q^(2,2),
     h_Q^(1,3), h_Q^(0,4))

  is

    n = 2 :
      (0,0,0,0,0)

    n = 3 :
      (0,1,21,1,0)

    n >= 4 :
      (0,1,22,1,0).

Proof:
  Apply GottScheSoergelK3nDegreeFourHodgeProfile(X,n).

  Apply sym2_h2_degree_four_hodge_profile.

  Since Sym^2 H^2(X,Q) is a Hodge substructure of H^4(X,Q),
  quotient Hodge multiplicities are obtained degree-by-degree
  by subtraction.

  For n = 2,

    (1,21,232,21,1)
      -
    (1,21,232,21,1)
      =
    (0,0,0,0,0).

  For n = 3,

    (1,22,253,22,1)
      -
    (1,21,232,21,1)
      =
    (0,1,21,1,0).

  For n >= 4,

    (1,22,254,22,1)
      -
    (1,21,232,21,1)
      =
    (0,1,22,1,0).
Qed.

Corollary k3_n_type_degree_four_quotient_hodge_jump:
  The first rational degree-four quotient appears at n = 3.

  At n = 3 it contains exactly

    one (3,1) direction,
    twenty-one (2,2) directions,
    one (1,3) direction.

  For every n >= 4 the stabilized quotient contains exactly

    one (3,1) direction,
    twenty-two (2,2) directions,
    one (1,3) direction.

  Thus the transition n = 3 -> n = 4 adds exactly one
  quotient (2,2) direction and no new off-diagonal Hodge direction.

Proof:
  Immediate from k3_n_type_degree_four_quotient_hodge_profile.
Qed.

Boundary:
  the quotient Hodge multiplicities are exact
  the n = 3 quotient has rank 23
  the n >= 4 quotient has rank 24
  stabilization from n = 3 to n = 4 adds exactly one (2,2) direction
  no geometric representative of that direction is selected here
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


Theorem k3_n_type_degree_four_c2_hodge_jump:
  For n >= 4 and X of K3^[n]-type, let

    Q4_Q(X) :=
      H^4(X,Q) / Sym^2 H^2(X,Q)

  and let

    gamma_X := (1/2) [c2(X)] in Q4_Q(X).

  Then gamma_X has degree-four Hodge type (2,2),

    Q4_Q(X)
      =
    Q * gamma_X
      direct_sum
    e_X(H^2(X,Q)),

  and the shifted Hodge decomposition of the second summand is

    e_X(H^(2,0)(X)) subset Q4_Q^(3,1)(X),
    e_X(H^(1,1)(X)) subset Q4_Q^(2,2)(X),
    e_X(H^(0,2)(X)) subset Q4_Q^(1,3)(X).

  Consequently

    Q4_Q^(2,2)(X)
      =
    Q * gamma_X
      direct_sum
    e_X(H^(1,1)(X,Q))

  with

    dim_Q Q4_Q^(2,2)(X) = 1 + 21 = 22.

Proof:
  The second Chern class c2(X) is a Hodge class of type (2,2).
  Therefore its nonzero quotient class gamma_X is also of type (2,2).

  Apply
    k3_n_type_degree_four_quotient_representation_profile.

  Its n >= 4 decomposition gives

    Q4_Q(X)
      =
    Q * gamma_X
      direct_sum
    e_X(H^2(X,Q)).

  Apply
    k3_n_type_degree_four_quotient_hodge_profile.

  The quotient Hodge profile is

    (h_Q^(3,1), h_Q^(2,2), h_Q^(1,3))
      =
    (1,22,1).

  The H^2 factor has Hodge profile

    (h^(2,0), h^(1,1), h^(0,2))
      =
    (1,21,1).

  Since gamma_X contributes one additional (2,2) line,
  the H^2 factor occurs in degree four with Hodge shift (1,1).

  Hence

    dim_Q e_X(H^(1,1)(X,Q)) = 21

  and

    dim_Q Q4_Q^(2,2)(X)
      =
    1 + 21
      =
    22.
Qed.


Corollary k3_three_to_four_degree_four_hodge_jump_is_c2_line:
  Comparing the rational degree-four quotient structures,

    K3^[3] :
      standard shifted H^2 factor only,

    K3^[n], n >= 4 :
      Q * gamma_X direct_sum shifted H^2 factor,

  where

    gamma_X = (1/2) [c2(X)]

  is of Hodge type (2,2).

  Therefore the unique Hodge-number jump

    h_Q^(2,2) : 21 -> 22

  from n = 3 to the stabilized n >= 4 profile is exactly
  the appearance of the distinguished gamma_X line.

  No new quotient (3,1) or (1,3) direction appears.

Proof:
  Combine
    k3_n_type_degree_four_quotient_representation_profile
  with
    k3_n_type_degree_four_quotient_hodge_jump
  and
    k3_n_type_degree_four_c2_hodge_jump.
Qed.

Boundary:
  the c2/2 line is identified only in the degree-four quotient for n >= 4
  gamma_X is not declared a required-class inventory element
  no individual vector in the 21-dimensional shifted H^(1,1) factor is selected
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


ExternalResult MarkmanK3nMonodromyZariskiClosure(X,n) :=
  For n >= 3 and X of K3^[n]-type,

    Mon(X) ~= Mon^2(X)
      = tilde_O^+(H^2(X,Z)),

  and the Zariski closure of Mon(X) in the complex
  cohomology representation is

    O(H^2(X,C)) x Z/2Z.

  The second factor records the discriminant character

    tau : Mon^2(X) -> {+1,-1}.

Sources:
  Markman, monodromy of moduli spaces of sheaves on K3 surfaces,
  Lemma 4.11.
  Markman, integral constraints on the monodromy group of
  K3 Hilbert schemes.

Boundary:
  this is an external monodromy input
  no Hodge class is declared required
  no required-class inventory element is introduced


Theorem k3_n_type_degree_four_monodromy_fixed_line:
  For n >= 4 and X of K3^[n]-type, let

    Q4_Q(X) :=
      H^4(X,Q) / Sym^2 H^2(X,Q)

  and

    gamma_X := (1/2) [c2(X)] in Q4_Q(X).

  Then

    Q4_Q(X)^Mon(X)
      =
    Q * gamma_X.

  Since gamma_X has Hodge type (2,2),

    Q4_Q^(2,2)(X) intersection Q4_Q(X)^Mon(X)
      =
    Q * gamma_X.

  Hence Q * gamma_X is the unique nonzero rational line
  whose vectors are fixed pointwise by every monodromy operator
  in the degree-four quotient.

Proof:
  Apply
    MarkmanK3nDegreeFourQuotientLatticeStructure(X,n).

  Over Q,

    Q4_Q(X)
      =
    Q * gamma_X
      direct_sum
    e_X(H^2(X,Q)).

  For every monodromy operator sigma,

    sigma_Q(gamma_X) = gamma_X

  and

    sigma_Q(e_X(alpha))
      =
    tau(sigma) * e_X(sigma_2(alpha)).

  Thus Q * gamma_X is fixed pointwise.

  Now let

    e_X(alpha) in e_X(H^2(X,Q))

  be fixed by every monodromy operator.

  Then for every sigma in Mon(X),

    tau(sigma) * sigma_2(alpha) = alpha.

  Complexify this relation.

  By MarkmanK3nMonodromyZariskiClosure(X,n),
  Mon(X) is Zariski dense in

    O(H^2(X,C)) x Z/2Z.

  Therefore alpha is fixed by the algebraic representation

    (g,epsilon) |-> epsilon * g

  on H^2(X,C).

  The standard representation of O(H^2(X,C))
  has no nonzero fixed vector.

  Hence

    alpha = 0.

  Therefore the twisted H^2 summand contributes no
  monodromy-fixed vector, and

    Q4_Q(X)^Mon(X)
      =
    Q * gamma_X.

  Finally apply
    k3_n_type_degree_four_c2_hodge_jump

  to obtain that gamma_X has Hodge type (2,2).
Qed.


Corollary k3_n_type_degree_four_unique_monodromy_fixed_hodge_line:
  For n >= 4 and X of K3^[n]-type, the distinguished line

    Q * (1/2)[c2(X)]

  is the complete pointwise monodromy-fixed rational subspace
  of the degree-four quotient and is contained in Hodge type (2,2).

  The remaining quotient dimensions

    one (3,1),
    twenty-one (2,2),
    one (1,3)

  lie in the twisted standard H^2 factor and contribute
  no nonzero vector fixed by the full monodromy group.

Proof:
  Combine
    k3_n_type_degree_four_monodromy_fixed_line
  with
    k3_n_type_degree_four_c2_hodge_jump.
Qed.

Boundary:
  uniqueness means pointwise fixed under the full monodromy group
  it does not identify gamma_X as a required-class inventory element
  it does not select any vector in the remaining 23-dimensional factor
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


Theorem k3_n_type_degree_four_finite_monodromy_orbit_classification:
  For n >= 4 and X of K3^[n]-type, let

    Q4_Q(X) :=
      H^4(X,Q) / Sym^2 H^2(X,Q)

  and

    gamma_X := (1/2) [c2(X)] in Q4_Q(X).

  Then for every v in Q4_Q(X),

    FiniteOrbit_Mon(X)(v)
      iff
    exists a : Q,
      v = a * gamma_X.

  Equivalently, the vectors with finite full-monodromy orbit
  are exactly the distinguished rational line

    Q * gamma_X.

Proof:
  Apply
    MarkmanK3nDegreeFourQuotientLatticeStructure(X,n).

  Write uniquely

    v
      =
    a * gamma_X + e_X(alpha)

  with

    a in Q
    and
    alpha in H^2(X,Q).

  If alpha = 0, then

    v = a * gamma_X.

  Since every monodromy operator fixes gamma_X pointwise,
  the orbit of v is a singleton and hence finite.

  Conversely, suppose

    FiniteOrbit_Mon(X)(v).

  Then the stabilizer

    Gamma_v :=
      { sigma in Mon(X) // sigma_Q(v) = v }

  has finite index in Mon(X).

  Since gamma_X is fixed by every monodromy operator,
  every sigma in Gamma_v also satisfies

    sigma_Q(e_X(alpha))
      =
    e_X(alpha).

  Complexify.

  By
    MarkmanK3nMonodromyZariskiClosure(X,n),

  the Zariski closure of Mon(X) is

    G :=
      O(H^2(X,C)) x Z/2Z.

  Because Gamma_v has finite index in Mon(X),
  the Zariski closure of Gamma_v contains the identity component

    G^0
      =
    SO(H^2(X,C)) x {1}.

  Indeed a finite-index subgroup has Zariski closure of the
  same dimension as the ambient Zariski closure, hence contains
  its identity component.

  On the twisted H^2 summand the restriction to G^0 is the
  ordinary standard representation

    g |-> g

  of SO(H^2(X,C)).

  The standard representation has no nonzero invariant vector.

  Therefore

    alpha = 0.

  Hence

    v = a * gamma_X.

  This proves both implications.
Qed.


Corollary k3_n_type_rank23_quotient_factor_has_no_nonzero_finite_orbit:
  For n >= 4 and X of K3^[n]-type and every

    alpha in H^2(X,Q),

  the vector

    e_X(alpha)

  has finite full-monodromy orbit if and only if

    alpha = 0.

  In particular every nonzero rational vector in the
  remaining rank-23 quotient factor has infinite monodromy orbit.

Proof:
  Apply
    k3_n_type_degree_four_finite_monodromy_orbit_classification.

  The direct-sum decomposition

    Q4_Q(X)
      =
    Q * gamma_X direct_sum e_X(H^2(X,Q))

  has zero intersection between its two summands.

  Thus e_X(alpha) belongs to Q * gamma_X exactly when alpha = 0.
Qed.


Corollary k3_n_type_finite_orbit_equals_fixed_subspace:
  For n >= 4 and X of K3^[n]-type,

    { v in Q4_Q(X) // FiniteOrbit_Mon(X)(v) }
      =
    Q4_Q(X)^Mon(X)
      =
    Q * (1/2)[c2(X)].

Proof:
  Combine
    k3_n_type_degree_four_finite_monodromy_orbit_classification
  with
    k3_n_type_degree_four_monodromy_fixed_line.
Qed.

Boundary:
  finite-orbit classification is for the full monodromy action
  every nonzero vector in the rank-23 factor has infinite orbit
  the only finite-orbit vectors form the c2/2 line
  no required-class inventory element is inferred from finite orbit behavior
  no required-class index is constructed
  no required-class quotient projection is evaluated
  the stopped K3^[3] inventory branch remains stopped
  no ZeroDayClosure theorem for n >= 3 is claimed


K3nDegreeFourQuotient(X) :=
  H^4(X,Q) / SH^4(X,Q)

K3nDegreeFourQuotientProjection(X,c) :=
  pi4_X(c) in K3nDegreeFourQuotient(X)


Theorem k3_n_type_degree_four_finite_orbit_SH_dichotomy:
  For n >= 4 and X of K3^[n]-type and c in H^4(X,Q), let

    gamma_X := (1/2) [c2(X)]
      in K3nDegreeFourQuotient(X).

  If

    FiniteOrbit_Mon(X)(pi4_X(c)),

  then exactly one of the following holds:

    c in SH^4(X,Q)

  or

    exists a : Q,
      a != 0
      and
      pi4_X(c) = a * gamma_X.

Proof:
  In degree four, Verbitsky gives

    SH^4(X,Q)
      =
    Sym^2 H^2(X,Q).

  Therefore K3nDegreeFourQuotient(X) is the same rational
  quotient used in
    k3_n_type_degree_four_finite_monodromy_orbit_classification.

  Apply that classification to pi4_X(c).

  There exists a : Q such that

    pi4_X(c) = a * gamma_X.

  If a = 0, then

    pi4_X(c) = 0,

  hence c belongs to the kernel of the quotient projection,

    c in SH^4(X,Q).

  If a != 0, the second alternative holds.

  The alternatives are mutually exclusive:
  if c lies in SH^4(X,Q), then pi4_X(c) = 0.
  Since gamma_X is nonzero, an identity

    0 = a * gamma_X

  forces a = 0.
Qed.


K3nFiniteOrbitDegreeFourClosureReduction(X) :=
  non_degree_four_required_classes_in_SH :
    forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
      degree(i) != 2 ->
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
        in SH^(2 * degree(i))(X,Q)

  degree_four_required_quotients_have_finite_orbit :
    forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
      degree(i) = 2 ->
      FiniteOrbit_Mon(X)(
        pi4_X(
          ZeroDayRequiredK3nHodgeClasses(X).class(i)
        )
      )

  degree_four_required_classes_have_zero_c2_obstruction :
    forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
      degree(i) = 2 ->
      forall a : Q,
        pi4_X(
          ZeroDayRequiredK3nHodgeClasses(X).class(i)
        ) = a * gamma_X ->
        a = 0


Theorem k3_n_type_finite_orbit_degree_four_reduction_implies_required_subset_SH:
  For n >= 4 and X of K3^[n]-type,

    K3nFiniteOrbitDegreeFourClosureReduction(X)
      ->
    RequiredClassesSubsetSH(X).

Proof:
  Let R : K3nFiniteOrbitDegreeFourClosureReduction(X).

  Let i : ZeroDayRequiredK3nHodgeClasses(X).I.

  Split on degree(i) = 2.

  Case degree(i) != 2:
    apply R.non_degree_four_required_classes_in_SH(i).

  Case degree(i) = 2:
    apply
      k3_n_type_degree_four_finite_orbit_SH_dichotomy
    to
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
    using
      R.degree_four_required_quotients_have_finite_orbit(i).

    The non-SH alternative would provide a != 0 with

      pi4_X(
        ZeroDayRequiredK3nHodgeClasses(X).class(i)
      ) = a * gamma_X.

    But
      R.degree_four_required_classes_have_zero_c2_obstruction(i,a)
    forces a = 0, contradiction.

    Hence the class lies in SH^4(X,Q).

  Therefore every required class lies in its corresponding
  Verbitsky component.
Qed.


Theorem k3_n_type_finite_orbit_degree_four_reduction_implies_zero_day_closure:
  For n >= 4 and X of K3^[n]-type,

    K3nFiniteOrbitDegreeFourClosureReduction(X)
      ->
    ZeroDayClosure(X).

Proof:
  Apply
    required_classes_subset_SH_implies_zero_day_closure.

  Apply
    k3_n_type_finite_orbit_degree_four_reduction_implies_required_subset_SH.
Qed.

Boundary:
  this is a genuine closure reduction, not a new quotient classification
  degree-four required classes are reduced to one scalar c2/2 obstruction
  no degree-four required class is asserted to exist
  finite monodromy orbit of a required quotient is not asserted
  zero c2/2 obstruction for any required class is not asserted
  non-degree-four required classes are not proved to lie in SH
  no required-class inventory element is manufactured
  the stopped K3^[3] inventory branch remains stopped
  unconditional ZeroDayClosure for n >= 4 is not claimed


K3ThreeTypeDegreeFourInputSurface(X) :=
  type : IsK3ThreeType(X)
  ambient : H^4(X,Q)
  verbitzky_component : SH^4(X,Q)
  quotient : H^4(X,Q) / SH^4(X,Q)
  ambient_dimension : dim_Q H^4(X,Q) = 299
  verbitzky_dimension : dim_Q SH^4(X,Q) = 276
  quotient_dimension : dim_Q (H^4(X,Q) / SH^4(X,Q)) = 23

Boundary:
  no required class is selected
  no quotient projection of a required class is asserted
  no basis of the 23-dimensional quotient is chosen
  this surface records only the exact ambient degree-four obstruction data


K3ThreeTypeDegreeFourRequiredClassSelection(X) :=
  I4 :=
    { i : ZeroDayRequiredK3nHodgeClasses(X).I
      // degree(i) = 2 }
  selected_class :
    forall i : I4,
      H^4(X,Q)
  selected_class(i) :=
    ZeroDayRequiredK3nHodgeClasses(X).class(i.val)

SelectionRule:
  select exactly those existing required-class indices whose degree is 2

Boundary:
  does not assert I4 is nonempty
  does not introduce a new required class
  does not choose an arbitrary element of H^4(X,Q)
  does not assert selected_class(i) lies outside SH^4(X,Q)
  does not define or evaluate any quotient projection



Theorem k3_two_type_one_required_class_in_SH:
  IsK3TwoType(X) ->
  forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
    ZeroDayRequiredK3nHodgeClasses(X).class(i)
      in SH^(2 * degree(i))(X,Q)

Proof:
  Let X be of K3^[2]-type.
  Let i : ZeroDayRequiredK3nHodgeClasses(X).I.

  By ZeroDayRequiredK3nHodgeClasses.class,
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
        in H^(2 * degree(i))(X,Q).

  By BottiniK3TwoTypeVerbitskyExhaustion(X),
      H^*(X,Q) = SH(X,Q).

  Taking the degree-(2 * degree(i)) graded component gives
      H^(2 * degree(i))(X,Q)
        = SH^(2 * degree(i))(X,Q).

  Therefore
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
        in SH^(2 * degree(i))(X,Q).
Qed.

Boundary:
  one arbitrary required-class membership only
  RequiredClassesSubsetSH(X) not yet derived
  K3^[n]-type with n >= 3 not discharged


Theorem k3_two_type_required_classes_subset_SH:
  IsK3TwoType(X) ->
  RequiredClassesSubsetSH(X)

Proof:
  Let X be of K3^[2]-type.
  Unfold RequiredClassesSubsetSH(X).
  Let i : ZeroDayRequiredK3nHodgeClasses(X).I.
  Apply k3_two_type_one_required_class_in_SH(X,i).
Qed.

Boundary:
  this is only forall-i closure of the proved one-class membership
  depends on BottiniK3TwoTypeVerbitskyExhaustion(X)
  K3^[n]-type with n >= 3 is not discharged
  ZeroDayClosure(X) is not invoked


Theorem k3_two_type_zero_day_closure:
  IsK3TwoType(X) ->
  ZeroDayClosure(X)

Proof:
  Let X be of K3^[2]-type.
  Apply required_classes_subset_SH_implies_zero_day_closure(X).
  Apply k3_two_type_required_classes_subset_SH(X).
Qed.

Boundary:
  K3^[2]-type closure depends on BottiniK3TwoTypeVerbitskyExhaustion(X)
  the Bottini result is imported from external literature
  no K3^[n]-type closure for n >= 3 is claimed
  not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses
