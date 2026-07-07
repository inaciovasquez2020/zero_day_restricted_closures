#!/usr/bin/env python3
import json
from pathlib import Path
R=Path(__file__).resolve().parents[2]
def j(p):
    q=R/p
    if not q.exists():
        raise SystemExit(f"MISSING_OBJECT := {p}")
    return json.loads(q.read_text(encoding="utf-8"))
def has(o,s): return s in json.dumps(o,sort_keys=True)
def req(c,m):
    if not c: raise SystemExit("DERIVATION_EVIDENCE_FOR_F_PHYSICAL_WITNESS_TARGET_FAIL: "+m)
def main():
    t=j("core/derivation_evidence_for_F_physical_witness_target_surface.json"); r=j("core/derivation_evidence_for_F_physical_witness_next_dependency_receipt_2026_07_07.json")
    f=j("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json"); g=j("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    p=j("core/physical_system_context_witness_target_surface.json"); v=j("core/variable_domain_and_guards_witness_target_surface.json"); n=j("core/non_toy_structure_source_witness_target_surface.json")
    for name,o in {"target":t,"receipt":r,"fixture":f,"ranking":g,"rank1":p,"rank2":v,"rank3":n}.items():
        req(has(o,"physical_time_dilation"),name+" missing boundary")
        req(has(o,"derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"),name+" missing upstream object")
    ranked=g.get("ranked_gaps_weakest_first",[])
    req(len(ranked)>=4 and ranked[3].get("rank")==4 and ranked[3].get("gap")=="derivation_evidence_for_F_physical_witness","rank-4 gap changed")
    for obj,name,rank in [(p,"physical_system_context_witness",1),(v,"variable_domain_and_guards_witness",2),(n,"non_toy_structure_source_witness",3)]:
        req(obj.get("target")==name,"prior target changed: "+name)
        req(obj.get("available") is False and obj.get("inhabited") is False,"prior target became available: "+name)
    req(t.get("status")=="witness_target_surface_uninhabited","target status changed")
    req(t.get("target")=="derivation_evidence_for_F_physical_witness","target name changed")
    req(t.get("rank")==4,"target rank changed")
    for field in ["available","inhabited","witness_present","constructor_present","theorem_present"]:
        req(t.get(field) is False,field+" changed")
    req(t.get("depends_on_prior_missing_inputs")==["physical_system_context_witness","variable_domain_and_guards_witness","non_toy_structure_source_witness"],"prior chain changed")
    req(r.get("status")=="next_dependency_receipt_only","receipt status changed")
    nxt=r.get("next_ranked_missing_input",{})
    req(nxt.get("rank")==4 and nxt.get("name")=="derivation_evidence_for_F_physical_witness" and nxt.get("available") is False,"receipt rank-4 changed")
    req(has(t,"F_physical := F_toy") and has(r,"F_physical := F_toy"),"shortcut rejection missing")
    req(has(t,"does_not_identify_F_toy_with_F_physical") and has(r,"does_not_identify_F_toy_with_F_physical"),"no-identification missing")
    req(f.get("candidate_shortcut")=="F_physical := F_toy" and f.get("expected_verdict")=="rejected","forbidden shortcut fixture changed")
    print("DERIVATION_EVIDENCE_FOR_F_PHYSICAL_WITNESS_TARGET_OK")
if __name__=="__main__": main()
