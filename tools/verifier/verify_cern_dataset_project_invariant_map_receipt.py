#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("artifacts/status/cern_dataset_project_invariant_map_receipt_2026_07_08.json")
if not path.exists():
    raise SystemExit("MISSING_OBJECT := artifacts/status/cern_dataset_project_invariant_map_receipt_2026_07_08.json")

data = json.loads(path.read_text())

required_pairs = {
    "receipt": "CERNDatasetProjectInvariantMapReceipt",
    "classification": "EXTERNAL_EMPIRICAL_INVARIANT_MAP_ONLY",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
    "parent_receipt": "CERNOpenDataExternalEvidenceReceipt",
    "source_receipt": "artifacts/status/cern_open_data_external_evidence_receipt_2026_07_08.json",
    "integration_status": "MAP_ONLY_ISOLATED_FROM_THEOREM_AND_CLOSURE_PATHS",
}

for key, expected in required_pairs.items():
    actual = data.get(key)
    if actual != expected:
        raise SystemExit(f"CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := {key} expected {expected!r} got {actual!r}")

source_receipt = Path(data["source_receipt"])
if not source_receipt.exists():
    raise SystemExit(f"MISSING_OBJECT := {source_receipt}")

source_data = json.loads(source_receipt.read_text())
source = source_data.get("source")
dataset = data.get("dataset")
if not isinstance(source, dict) or not isinstance(dataset, dict):
    raise SystemExit("CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := source/dataset object missing")

for key in ["provider", "collaboration", "record", "doi", "dataset"]:
    if dataset.get(key) != source.get(key):
        raise SystemExit(
            f"CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := dataset.{key} does not match source receipt"
        )

rows = data.get("project_invariant_map")
if not isinstance(rows, list) or not rows:
    raise SystemExit("CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := nonempty project_invariant_map")

required_fields = {"provider", "record", "doi", "dataset"}
seen = set()
for row in rows:
    if not isinstance(row, dict):
        raise SystemExit("CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := invariant row object")
    field = row.get("dataset_field")
    if field in required_fields:
        seen.add(field)
    if row.get("status") != "MAPPED_NOT_USED_AS_PROOF":
        raise SystemExit("CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := invariant map status")

missing = sorted(required_fields - seen)
if missing:
    raise SystemExit(f"CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := missing mapped fields {missing!r}")

required_non_claims = {
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
    raise SystemExit(f"CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := missing non_claims {missing_non_claims!r}")

serialized = json.dumps(data, sort_keys=True)
for forbidden in [
    "ZeroDayClosure proved",
    "unrestricted ZeroDayClosure proved",
    "RestrictedCompositionTarget constructed",
    "RestrictedCompositionTarget -> ZeroDayClosure constructed",
    "LiftSourceChainCompositionGap discharged",
    "restricted-to-unrestricted lift proved",
    "theorem rule added",
    "closure constructor added",
]:
    if forbidden in serialized:
        raise SystemExit(f"CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_FAILED := forbidden claim {forbidden!r}")

print("CERN_DATASET_PROJECT_INVARIANT_MAP_RECEIPT_OK")
