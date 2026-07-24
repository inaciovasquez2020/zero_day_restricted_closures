import json
import subprocess
import sys
from pathlib import Path

RECEIPT_PATH = Path("artifacts/status/vasquez_directional_flow_fraction_b_first_edge_endpoint_receipt_2026_07_24.json")
PARENT_SURFACE = Path("core/vasquez_directional_flow_fraction_b_first_edge_instance_surface.json")
PARENT_VERIFIER = Path("verification/verify_vasquez_directional_flow_fraction_b_first_edge_instance.py")

REQUIRED_FALSE_NON_CLAIMS = (
    "second_bounded_edge_instance_constructed",
    "terminal_composition_extracted",
    "restricted_target_to_zero_day_closure_rule_proved",
    "unrestricted_zero_day_closure_proved",
    "zero_day_closure_claimed",
)

REQUIRED_FALSE_LOCKOUTS = (
    "vasquez_directional_flow_first_edge_instance_closes_zero_day",
    "first_edge_endpoint_receipt_constructs_second_edge",
    "first_edge_endpoint_receipt_extracts_terminal_composition",
    "first_edge_endpoint_receipt_proves_restricted_target_to_zero_day",
    "first_edge_endpoint_receipt_proves_unrestricted_zero_day",
)

EXPECTED_GAPS = [
    "second_bounded_edge_instance",
    "downstream_terminal_composition_extraction",
    "restricted_target_to_zero_day_closure_rule",
    "unrestricted_zero_day_closure",
]

def fail(message: str) -> None:
    print(f"VERIFIER ERROR: {message}")
    sys.exit(1)

def require_false(mapping: dict, key: str) -> None:
    if mapping.get(key) is not False:
        fail(f"{key} must be explicitly false")

def require_true(mapping: dict, key: str) -> None:
    if mapping.get(key) is not True:
        fail(f"{key} must be explicitly true")

def main() -> None:
    if not PARENT_SURFACE.exists():
        fail(f"Missing parent surface: {PARENT_SURFACE}")
    if not PARENT_VERIFIER.exists():
        fail(f"Missing parent verifier: {PARENT_VERIFIER}")
    if not RECEIPT_PATH.exists():
        fail(f"Missing receipt: {RECEIPT_PATH}")

    subprocess.run(["python3", str(PARENT_VERIFIER)], check=True)

    data = json.loads(RECEIPT_PATH.read_text())

    metadata = data.get("metadata", {})
    if metadata.get("boundary") != "¬ vasquez_directional_flow_first_edge_instance_closes_zero_day":
        fail("metadata.boundary must preserve first-edge non-closure boundary")

    if metadata.get("parent_surface") != str(PARENT_SURFACE):
        fail("metadata.parent_surface mismatch")

    if metadata.get("parent_verifier") != str(PARENT_VERIFIER):
        fail("metadata.parent_verifier mismatch")

    endpoint = data.get("endpoint_receipt")
    if not isinstance(endpoint, dict):
        fail("endpoint_receipt block must exist")

    if endpoint.get("object_name") != "VasquezDirectionalFlowFractionBFirstEdgeEndpointReceipt":
        fail("endpoint_receipt.object_name mismatch")

    if endpoint.get("current_endpoint") != "first_bounded_edge_instance_only":
        fail("current_endpoint must remain first_bounded_edge_instance_only")

    if endpoint.get("scope") != "bounded_directional_flow_fraction_b_first_edge_only":
        fail("scope must remain bounded_directional_flow_fraction_b_first_edge_only")

    require_true(endpoint, "first_edge_instance_verified")
    require_true(endpoint, "safe_to_stop_here")

    gaps = data.get("ranked_remaining_gaps")
    if not isinstance(gaps, list) or len(gaps) != len(EXPECTED_GAPS):
        fail("ranked_remaining_gaps must contain exactly four gaps")

    for index, expected_gap in enumerate(EXPECTED_GAPS, start=1):
        item = gaps[index - 1]
        if item.get("rank") != index:
            fail(f"{expected_gap} has wrong rank")
        if item.get("gap") != expected_gap:
            fail(f"rank {index} must be {expected_gap}")
        if item.get("status") not in {"not_constructed", "not_extracted", "not_proved", "blocked"}:
            fail(f"{expected_gap} has invalid status")

    non_claims = data.get("non_claims")
    if not isinstance(non_claims, dict):
        fail("non_claims block must exist")

    for key in REQUIRED_FALSE_NON_CLAIMS:
        require_false(non_claims, key)

    lockouts = data.get("verifier_enforced_lockouts")
    if not isinstance(lockouts, dict):
        fail("verifier_enforced_lockouts block must exist")

    for key in REQUIRED_FALSE_LOCKOUTS:
        require_false(lockouts, key)

    print("VASQUEZ_DIRECTIONAL_FLOW_FRACTION_B_FIRST_EDGE_ENDPOINT_RECEIPT_OK")

if __name__ == "__main__":
    main()
