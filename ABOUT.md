# zero_day_restricted_closures

This repository records bounded, verifier-guarded surfaces for restricted zero-day closure experiments.

## Current status

The repository does not prove unrestricted zero-day closure.

Current locked status:

- `RestrictedClosureSurface` is the restricted closure surface.
- `RestrictedToUnrestrictedLiftBoundarySurface` records the conditional lift boundary.
- `RestrictedCoverageSource` records the conditional coverage source.
- `DomainErasureSource` records the conditional domain-erasure source.
- `LiftAdmissibilitySource` records the conditional lift-admissibility source.
- `NoEscapeBoundary` guards against any `ZeroDayClosure` escape that is not tied to the lift sources.

## Boundary

BOUNDARY := ¬ unrestricted ZeroDayClosure

## Verification

Run:

```sh
python3 verification/anti_unconditional_rule.py
Expected result:
ANTI_UNCONDITIONAL_RULE_OK
