#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("artifacts/status/cern_downstream_benchmark_use_guard_receipt_2026_07_08.json")
if not path.exists():
    raise SystemExit("MISSING_OBJECT := artifacts/status/cern_downstream_benchmark_use_guard_receipt_2026_07_08.json")

data = json.loads(path.read_text())

required_pairs = {
    "receipt": "CERNDownstreamBenchmarkUseGuardReceipt",
    "classification": "EXTERNAL_EMPIRICAL_BENCHMARK_USE_GUARD_ONLY",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
    "integration_status": "GUARD_ONLY_NOT_A_BENCHMARK_SURFACE",
}

for key, expected in required_pairs.items():
    actual = data.get(key)
    if actual != expected:
        raise SystemExit(f"CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_FAILED := {key} expected {expected!r} got {actual!r}")

for source in data.get("source_receipts", []):
    source_path = Path(source)
    if not source_path.exists():
        raise SystemExit(f"MISSING_OBJECT := {source}")

required_allowed = {
    "external empirical benchmark metadata",
    "dataset provenance pin",
    "bounded anomaly-surface input candidate",
}
allowed = set(data.get("allowed_use", []))
missing_allowed = sorted(required_allowed - allowed)
if missing_allowed:
    raise SystemExit(f"CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_FAILED := missing allowed_use {missing_allowed!r}")

required_forbidden = {
    "theorem proof evidence",
    "ZeroDayClosure proof",
    "unrestricted ZeroDayClosure proof",
    "RestrictedCompositionTarget construction",
    "RestrictedCompositionTarget -> ZeroDayClosure construction",
    "LiftSourceChainCompositionGap discharge",
    "restricted-to-unrestricted lift proof",
}
forbidden = set(data.get("forbidden_use", []))
missing_forbidden = sorted(required_forbidden - forbidden)
if missing_forbidden:
    raise SystemExit(f"CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_FAILED := missing forbidden_use {missing_forbidden!r}")

required_non_claims = {
    "does not add a CERN benchmark surface",
    "does not prove ZeroDayClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not construct RestrictedCompositionTarget",
    "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
    "does not discharge LiftSourceChainCompositionGap",
    "does not prove the restricted-to-unrestricted lift",
    "does not use CERN data as proof evidence",
    "does not add a theorem rule",
    "does not add a closure constructor",
}
non_claims = set(data.get("non_claims", []))
missing_non_claims = sorted(required_non_claims - non_claims)
if missing_non_claims:
    raise SystemExit(f"CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_FAILED := missing non_claims {missing_non_claims!r}")

serialized = json.dumps(data, sort_keys=True)
for forbidden_claim in [
    "ZeroDayClosure proved",
    "unrestricted ZeroDayClosure proved",
    "RestrictedCompositionTarget constructed",
    "RestrictedCompositionTarget -> ZeroDayClosure constructed",
    "LiftSourceChainCompositionGap discharged",
    "restricted-to-unrestricted lift proved",
    "theorem rule added",
    "closure constructor added",
]:
    if forbidden_claim in serialized:
        raise SystemExit(f"CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_FAILED := forbidden claim {forbidden_claim!r}")

print("CERN_DOWNSTREAM_BENCHMARK_USE_GUARD_OK")
