#!/usr/bin/env python3
import json
from pathlib import Path

path = Path("artifacts/status/cern_open_data_external_evidence_receipt_2026_07_08.json")
if not path.exists():
    raise SystemExit("MISSING_OBJECT := artifacts/status/cern_open_data_external_evidence_receipt_2026_07_08.json")

data = json.loads(path.read_text())

required_pairs = {
    "receipt": "CERNOpenDataExternalEvidenceReceipt",
    "classification": "EXTERNAL_EMPIRICAL_EVIDENCE_ONLY",
    "boundary": "BOUNDARY := ¬ unrestricted ZeroDayClosure",
    "provenance_status": "SPECIFIC_CERN_RECORD_AND_DOI_NAMED",
    "integration_status": "ISOLATED_FROM_THEOREM_AND_CLOSURE_PATHS",
}

for key, expected in required_pairs.items():
    actual = data.get(key)
    if actual != expected:
        raise SystemExit(f"CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_FAILED := {key} expected {expected!r} got {actual!r}")

source = data.get("source")
if not isinstance(source, dict):
    raise SystemExit("CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_FAILED := source object missing")

required_source_pairs = {
    "provider": "CERN Open Data Portal",
    "collaboration": "CMS collaboration",
    "record": "https://opendata.cern.ch/record/14",
    "dataset": "/Mu/Run2010B-Apr21ReReco-v1/AOD",
    "doi": "10.7483/OPENDATA.CMS.B8MR.C4A2",
    "dataset_type": "Collision CMS 7TeV pp CERN-LHC",
    "format": "AOD",
    "recorded": "2010",
    "published": "2014",
}

for key, expected in required_source_pairs.items():
    actual = source.get(key)
    if actual != expected:
        raise SystemExit(f"CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_FAILED := source.{key} expected {expected!r} got {actual!r}")

required_non_claims = {
    "does not prove ZeroDayClosure",
    "does not prove unrestricted ZeroDayClosure",
    "does not construct RestrictedCompositionTarget",
    "does not construct RestrictedCompositionTarget -> ZeroDayClosure",
    "does not discharge LiftSourceChainCompositionGap",
    "does not prove the restricted-to-unrestricted lift",
    "does not add a theorem rule",
    "does not add a closure constructor",
    "does not use CERN data as proof evidence",
}

non_claims = set(data.get("non_claims", []))
missing = sorted(required_non_claims - non_claims)
if missing:
    raise SystemExit(f"CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_FAILED := missing non_claims {missing!r}")

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
        raise SystemExit(f"CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_FAILED := forbidden claim {forbidden!r}")

print("CERN_OPEN_DATA_EXTERNAL_EVIDENCE_RECEIPT_OK")
