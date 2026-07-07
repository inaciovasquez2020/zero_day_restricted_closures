#!/usr/bin/env python3
import json
from pathlib import Path
R=Path(__file__).resolve().parents[2]
def j(p):
    q=R/p
    if not q.exists(): raise SystemExit(f"MISSING_OBJECT := {p}")
    return json.loads(q.read_text())
def has(o,s): return s in json.dumps(o,sort_keys=True)
def req(c,m):
    if not c: raise SystemExit("NON_TOY_STRUCTURE_SOURCE_WITNESS_TARGET_FAIL: "+m)
def main():
    t=j("core/non_toy_structure_source_witness_target_surface.json"); r=j("core/non_toy_structure_source_witness_next_dependency_receipt_2026_07_07.json")
    f=j("core/f_physical_equals_f_toy_forbidden_shortcut_fixture_2026_07_07.json")
    o=j("core/f_physical_derivation_input_witness_obligation_surface.json"); g=j("core/f_physical_missing_derivation_input_gap_ranking_receipt_2026_07_07.json")
    p=j("core/physical_system_context_witness_target_surface.json"); v=j("core/variable_domain_and_guards_witness_target_surface.json")
    for n,x in {"target":t,"receipt":r,"fixture":f,"obligation":o,"ranking":g,"physical":p,"variable":v}.items():
        req(has(x,"physical_time_dilation"),n+" missing boundary")
        req(has(x,"derived_non_toy_law_replacing_F_toy_x_eq_1_plus_x"),n+" missing upstream object")
    req(p.get("available") is False and v.get("available") is False,"prior witnesses became available")
    req(has(o,"non_toy_structure_source_witness") and has(g,"non_toy_structure_source_witness"),"rank-3 missing from base surfaces")
    req(t.get("status")=="witness_target_surface_uninhabited","target status")
    req(t.get("target")=="non_toy_structure_source_witness","target name")
    req(t.get("rank")==3,"target rank")
    for k in ["available","inhabited","witness_present","constructor_present","theorem_present"]: req(t.get(k) is False,k+" changed")
    req(t.get("boundary")=="not(physical_time_dilation)","target boundary")
    req(r.get("status")=="next_dependency_receipt_only","receipt status")
    n=r.get("next_ranked_missing_input",{})
    req(n.get("rank")==3 and n.get("name")=="non_toy_structure_source_witness" and n.get("available") is False,"receipt rank-3")
    req(has(t,"F_physical := F_toy") and has(r,"F_physical := F_toy"),"shortcut rejection")
    req(has(t,"does_not_identify_F_toy_with_F_physical") and has(r,"does_not_identify_F_toy_with_F_physical"),"no-identification")
    req(f.get("candidate_shortcut")=="F_physical := F_toy" and f.get("expected_verdict")=="rejected","fixture changed")
    print("NON_TOY_STRUCTURE_SOURCE_WITNESS_TARGET_OK")
if __name__=="__main__": main()
