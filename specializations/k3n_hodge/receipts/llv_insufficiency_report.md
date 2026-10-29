# LLV/Markman-Nearby Input Insufficiency Receipt

BOUNDARY := not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses

Negative receipt:

LLVMarkmanNearbyInputInsufficiencyReceipt :=
  {
    llv_markman_nearby_input : LLVMarkmanNearbyInputSurface,
    missing_bridge :
      not ProvenFrom LLVMarkmanNearbyInputSurface
        (forall X, RequiredClassesSubsetSH(X)),
    preserved_boundary :
      not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses
  }

This receipt does not assert a counterexample class. It records only the weaker structural insufficiency:
LLVMarkmanNearbyInputSurface does not by itself prove forall X, RequiredClassesSubsetSH(X).

## Markman theorem-to-inventory mapping (reviewed 2026-10-29)

Source: Eyal Markman, “Rational Hodge isometries of hyper-Kähler varieties of K3^[n] type are algebraic,” arXiv:2204.00516, published in Compositio Mathematica 160 (2024), 1261–1303.
- arXiv: https://arxiv.org/abs/2204.00516
- Published article: https://doi.org/10.1112/S0010437X24007048

### Exact theorem scope

For compact hyper-Kähler manifolds X and Y deformation equivalent to Hilbert schemes of length n subschemes of K3 surfaces, Markman starts with a rational Hodge isometry
f : H^2(X,Q) -> H^2(Y,Q)
for the Beauville–Bogomolov–Fujiki pairings. The theorem constructs an analytic correspondence inducing f and lifts it to an analytic correspondence on total rational cohomology that is a Hodge isometry for the Mukai pairings, with grading preserved or reversed as specified by the theorem. When X and Y are projective, the correspondences are algebraic.

The theorem's input is a Hodge isometry, and its output is a correspondence/isometry. It is not a theorem that every rational Hodge class on X is algebraic, nor that every such class is in the image of Sym_Q(H^2(X,Q)) under cup product.

### Mapping against every field in required_classes.json

The current schema blob is 32071f478d7d2160e4e0cf86f69e179179f5f832. It declares an abstract finite index type I, degree : I -> Nat, class(i) in H^(2 degree(i))(X,Q), the Hodge condition class(i) in H^(degree(i),degree(i))(X), and the predicate ZeroDayDefectWitnessRequires(X,class(i)). It contains no concrete index, degree value, class constructor, or explicit required-class list.

| Inventory field / condition | What Markman establishes | Result |
|---|---|---|
| Finite index type I | No inventory or index set is considered | NO_MATCH |
| degree(i) and the degree of a particular class | No inventory index or per-class degree is supplied | NO_MATCH |
| class(i) as an arbitrary rational Hodge class | The theorem concerns Hodge isometries of H^2 and their inducing correspondences, not arbitrary individual Hodge classes | NO_MATCH |
| Hodge condition class(i) in H^(d,d) | Hodge-theoretic structure is assumed for f; no arbitrary inventory element is thereby shown to have the required cup-product representation | NO_MATCH |
| ZeroDayDefectWitnessRequires(X,class(i)) | Defect witnesses and repository inventory membership are not part of the theorem | NO_MATCH |
| class(i) in SH^(2d)(X,Q) | No theorem that an inventory class is in the image of Sym_Q^d(H^2) under cup product | NO_MATCH |

Thus **no individual required inventory class is established to lie in SH by Markman's theorem alone**. This is a scope result, not a claim that such membership is false. Since the inventory is abstract and contains no concrete indexed classes, a genuine per-class theorem application cannot be performed yet. Do not invent an index or select a representative class to fill this gap.

### Degree-four obstruction checked separately

By the repository's stated Göttsche/Verbitsky degree-four calculations, for K3^[n]-type X:
- n = 3: dim H^4(X,Q) = 299, dim SH^4(X,Q) = 276, so dim(H^4/SH^4) = 23. The repository also records the quotient as the standard 23-dimensional reduced-LLV module.
- n >= 4: dim H^4(X,Q) = 300 and dim SH^4(X,Q) = 276, so dim(H^4/SH^4) = 24. The repository records the quotient structure with the distinguished quotient line gamma_X = (1/2)[c2(X)] and a rank-23 factor.

Markman's Hodge-isometry/correspondence theorem does not remove either degree-four quotient and does not prove that a required class has zero projection to it. For n >= 4, the quotient description reduces a finite-orbit class's possible obstruction to the c2/2 line only under the repository's separately stated hypotheses; it does not establish those hypotheses or the vanishing of a required class's scalar obstruction. For n = 3, no required-class index is supplied whose quotient projection could be tested.

### Additional evidence required

For an actual inventory class c_i, first exhibit the concrete index i, degree(i), and class(i). Then prove c_i in SH^(2 degree(i))(X,Q), for example by an explicit cup-product preimage or a valid class-specific argument that its quotient projection vanishes. In degree four, compute or prove the relevant quotient projection; do not substitute algebraicity of a correspondence for this membership proof. For n >= 4, any use of the c2/2 quotient-line reduction must separately prove its hypotheses and the zero scalar obstruction for the particular required class. Non-degree-four classes also need their own SH-membership arguments.

### Preserved non-claims

- No unrestricted closure theorem.
- No unconditional completeness theorem for the required K3^[n] Hodge classes.
- No claim that Markman proves RequiredClassesSubsetSH(X).
- No claim that Markman's correspondence theorem proves degree-four SH membership.
- No concrete required-class index or geometric class is manufactured.
- The K3^[3] degree-four inventory branch remains stopped until an independently specified inventory supplies an actual degree-four required-class index; do not choose c2(T_X) or another class as a substitute.
- No unconditional ZeroDayClosure theorem for n >= 3 is claimed.
- No novelty claim is made for the degree-four dimension/quotient facts.
