#!/usr/bin/env python3
import json
import sys
from decimal import Decimal
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SURFACE = ROOT / "core" / "hubble_law_linear_velocity_distance_surface.json"

REQUIRED_NON_CLAIMS = {
    "does_not_claim_cosmology_closure",
    "does_not_claim_real_observational_fit",
    "does_not_claim_unrestricted_zero_day_closure",
    "does_not_supply_terminal_composite_witness_candidate",
    "does_not_construct_restricted_composition_target",
}

def main() -> None:
    data = json.loads(SURFACE.read_text())

    assert data["surface"] == "HubbleLawLinearVelocityDistanceSurface"
    assert data["status"] == "TOY_FIXED_SAMPLE_VERIFIER_ONLY"
    assert data["law"] == "v = H0 * d"

    non_claims = set(data.get("non_claims", []))
    missing = REQUIRED_NON_CLAIMS - non_claims
    if missing:
        raise AssertionError(f"missing non_claims: {sorted(missing)}")

    h0 = Decimal(data["H0"])
    samples = data.get("fixed_samples", [])
    if not samples:
        raise AssertionError("fixed_samples must be nonempty")

    for sample in samples:
        d = Decimal(sample["d"])
        v = Decimal(sample["v"])
        if v != h0 * d:
            raise AssertionError(f"bad sample: {sample}")

    print("HUBBLE_LAW_LINEAR_VELOCITY_DISTANCE_SURFACE_OK")

if __name__ == "__main__":
    main()
