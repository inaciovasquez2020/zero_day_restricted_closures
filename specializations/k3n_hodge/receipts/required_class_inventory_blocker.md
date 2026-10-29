# Required K3^[n] Hodge-Class Inventory — Blocking Input Receipt

Date: 2026-10-29

## Inspection result

The current schema at `specializations/k3n_hodge/schema/required_classes.json` declares only an abstract finite-indexed surface:

- `I`: finite index type;
- `degree : I -> Nat`;
- `class(i) : H^(2 * degree(i))(X,Q)`;
- `class(i) in H^(degree(i),degree(i))(X)`;
- each listed class is required by `ZeroDayDefectWitnessRequires`.

It does not enumerate the index type, instantiate a degree, define a concrete class, or supply a witness that any index exists. The proof interface in `specializations/k3n_hodge/proofs/conditional_closure.v` explicitly says that defect-witness construction existence is not asserted, degree (2) is not asserted, and no geometric class or quotient projection is selected.

Repository search for the required-class surface, concrete degree-four required classes, and `ZeroDayDefectWitnessRequires` returned only the abstract schema and conditional proof interfaces; no independently specified concrete inventory was found in the searched repository content.

## Mathematical consequence

No actual required class can currently be tested for membership in `SH^(2d)(X,Q)`. In particular, there is no justified class to project into
`H^4(X,Q) / SH^4(X,Q)`, and no scalar `c2/2` obstruction can be evaluated for an actual required degree-four class.

This is an **input-specification blocker**, not evidence that a required class fails to lie in `SH`, and not a counterexample to closure.

## Required input to resume

The project specification must provide, from its independently justified defect-witness semantics:

1. the intended geometric class (X) and the relevant (K3^{[n]})-type case;
2. the concrete required-class index set (or a finite, explicit list);
3. for every index (i), the degree (d(i)), the actual rational cohomology class (c_i), and a justification of (c_i in H^{d(i),d(i)}(X));
4. the independent reason each (c_i) is required by a defect witness, rather than merely being a convenient Hodge class;
5. for degree-four entries, a well-defined quotient projection and enough data to evaluate or prove vanishing of the relevant obstruction.

Do not fill this input with an arbitrary class such as (c_2(X)), invent an index, or infer necessity from membership in a Hodge group.

## Preserved boundaries

- No unrestricted closure theorem.
- No unconditional completeness theorem for required (K3^{[n]}) Hodge classes.
- No assertion that any actual required class lies outside (SH).
- No claim that Markman's Hodge-isometry/correspondence theorem establishes required-class membership.
- The (n=3) degree-four branch remains stopped until an independently specified degree-four required-class index exists.
- For (n \geq 4), the finite-inventory/monodromy-equivariance assumptions, non-degree-four (SH)-membership, and degree-four scalar-vanishing obligations remain unproved.
- No new theorem or novelty claim is asserted by this receipt.
