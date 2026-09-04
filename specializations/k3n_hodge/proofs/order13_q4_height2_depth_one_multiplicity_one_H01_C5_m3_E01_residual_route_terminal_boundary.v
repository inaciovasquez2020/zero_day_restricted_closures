Standalone terminal-boundary certificate for the residual-annihilator/tangent route
inside the low-embedding-dimension H01-C5 m=3 E0/E1 branch of the homogeneous
q=4, height-two multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_R3_R4U_exclusion.v

  and the earlier residual-annihilator files.

The live E0/E1 residual state is now uniquely

    R4S:
      J_res = Ann_S(D) = (Qsat:P),
      R_res = S/J_res,
      e(R_res)=4,
      dim_C (J_res)_1=1,
      mu_S(J_res)=4,
      r_res<=4,

and for a general R_res-regular linear form h,

    Jbar=(J_res+(h))/(h)
        =(w,u^3,u*v,v^2).

The two alternative regular-cut types R3 and R4U are already excluded by the
new two-linear-annihilator argument.  They are not part of the terminal
frontier.

For final homogeneous equations f,g of degrees d,e>=3, write

    M=max(d,e),
    s=min(d,e),

and

    L_res=length_C S/(J_res,f,g).

The current R4S tangent route uses

    L_res<=4*M,
    r_res<=4,

and excludes

    s>=8,

as well as

    s=7, M<=12.

Thus its exact surviving degree frontier is

    3<=s<=6, M>=s,

or

    s=7, M>=13.

This file performs one bounded task only:

  prove that the coefficient four in

    L_res<=4*M

  is SHARP under the exact residual-ring/module hypotheses currently used by
  this route.  The proof gives an explicit faithful graded R4S lift with the
  exact H01 m=3 Artinian reduction and with one final form completely invisible
  on the residual ring and module.

Consequently, the surviving R4S degree cases cannot be removed by another
universal sharpening of the same residual cut bound.  Any further closure must
introduce genuinely new structure tying R4S back to the original four quadrics
Q, the line core P, the cyclic saturation defect T, or additional restrictions
on f,g.

This is a method-boundary theorem only.
It does NOT construct a full H01-C5 four-quadric example.
It does NOT prove any surviving degree pair realizable.
It does NOT close R4S or all E0/E1.
It does NOT enter E2, H01-C4, q<=3, or full order-13 closure.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. AN EXPLICIT ONE-DIMENSIONAL R4S LIFT
--------------------------------------------------------------------------

Work in

    Sstar=C[h,u,v,w]

with every variable of degree one, and define

    Jstar=(w,u*v,v^2,u^3-h^2*v).

Put

    Rstar=Sstar/Jstar.

The relations are

    w=0,
    u*v=0,
    v^2=0,
    u^3=h^2*v.

Hence

    u^4=h^2*u*v=0.

Every class in Rstar has a unique expression

    a(h)+b(h)*u+c(h)*u^2+d(h)*v.

Therefore Rstar is a free graded C[h]-module with basis

    1,u,v,u^2

in degrees

    0,1,1,2.

Thus

    Hilb_Rstar(t)=(1+2*t+t^2)/(1-t),

    dim Rstar=1,
    depth Rstar=1,
    e(Rstar)=4,

and h is Rstar-regular.

Theorem terminal_R4S_ring_lift:
  Rstar is a one-dimensional Cohen--Macaulay standard graded algebra of
  multiplicity four with h-vector (1,2,1).
Qed.

--------------------------------------------------------------------------
2. THE REGULAR ARTINIAN CUT IS EXACTLY R4S
--------------------------------------------------------------------------

Reduce modulo h.  Then

    Rstar/hRstar
      ~= C[u,v,w]/(w,u*v,v^2,u^3).

So the special-fiber ideal is exactly

    (w,u^3,u*v,v^2),

and the quotient has basis

    1,u,v,u^2.

Its Hilbert function is therefore

    1,2,1

and its length is four.

Theorem terminal_R4S_cut_exact:
  The explicit lift Rstar has precisely the forced R4S regular Artinian cut.
Qed.

--------------------------------------------------------------------------
3. A FAITHFUL H01 m=3 RESIDUAL MODULE
--------------------------------------------------------------------------

Define a graded C[h]-free module Dstar with basis

    e0,e1  in degree 1,
    e2     in degree 2,
    e3     in degree 3.

Thus

    Dstar
      ~= C[h](-1)^2
          direct_sum C[h](-2)
          direct_sum C[h](-3).

Let h act by scalar multiplication, let w act by zero, and define

    u*e0=0,
    u*e1=e2,
    u*e2=e3,
    u*e3=h^3*e0,

and

    v*e0=0,
    v*e1=h*e0,
    v*e2=0,
    v*e3=0.

The u- and v-actions commute.  Moreover

    u*v=0,
    v^2=0

on Dstar, and

    u^3=h^2*v.

Indeed, on e1,

    u^3*e1=h^3*e0=h^2*v*e1,

and both sides vanish on e0,e2,e3.

Hence Jstar annihilates Dstar and Dstar is an Rstar-module.

Theorem terminal_R4S_module_well_defined:
  The displayed formulas define a graded Rstar-module structure on Dstar.
Qed.

--------------------------------------------------------------------------
4. THE MODULE HAS THE EXACT H01 m=3 PROFILE
--------------------------------------------------------------------------

Because Dstar is C[h]-free on generators in degrees 1,1,2,3,

    Hilb_Dstar(t)
      =(2*t+t^2+t^3)/(1-t).

Reduce modulo h:

    Estar=Dstar/hDstar.

Then

    u*e0=0,
    u*e1=e2,
    u*e2=e3,
    u*e3=0,

while

    v*Estar=0,
    w*Estar=0.

Therefore

    Estar
      ~= C(-1)
          direct_sum C[u]/(u^3)(-1),

and

    Ann_(C[u,v,w])(Estar)=(v,w,u^3).

Theorem terminal_R4S_module_special_fiber_exact:
  Dstar has exactly the H01-C5 m=3 residual Hilbert series and exactly the
  established Artinian reduction module.
Qed.

--------------------------------------------------------------------------
5. Dstar IS FAITHFUL OVER Rstar
--------------------------------------------------------------------------

Let

    r=a(h)+b(h)*u+c(h)*u^2+d(h)*v

be an arbitrary class in Rstar.

Act on e1:

    r*e1
      =a(h)*e1
        +b(h)*e2
        +c(h)*e3
        +d(h)*h*e0.

The four basis vectors are C[h]-linearly independent and h is nonzero in
C[h].  Hence

    r*e1=0

forces

    a=b=c=d=0.

So e1 itself has zero annihilator in Rstar.

Theorem terminal_R4S_module_faithful:
  Dstar is faithful over Rstar.

Equivalently,

    Ann_Sstar(Dstar)=Jstar.
Qed.

Thus this model satisfies the exact global residual identity

    Rstar=Sstar/Ann(Dstar),

not merely the desired special fiber.

--------------------------------------------------------------------------
6. THE CUT BOUND 4*M IS ATTAINED
--------------------------------------------------------------------------

Fix arbitrary integers

    3<=s<=M.

Choose

    g=w*h^(s-1),
    f=h^M.

Then

    deg(g)=s,
    deg(f)=M.

Since w belongs to Jstar,

    g=0

on both Rstar and Dstar.

Since h is regular on both,

    f=h^M

is a nonzerodivisor on both.

Therefore

    Rstar/(f,g)=Rstar/(h^M),

and hence

    length_C Rstar/(f,g)
      =M*e(Rstar)
      =4*M.

Likewise

    Dstar/(f,g)Dstar=Dstar/h^M Dstar

has length

    4*M.

Theorem terminal_R4S_cut_bound_sharp:
  Under the exact residual-ring/module hypotheses retained by the present R4S
  route, the bound

    L_res<=4*M

  is attained for every degree pair

    3<=s<=M.
Qed.

In particular, the lower-degree final form can be completely invisible on the
residual side.

--------------------------------------------------------------------------
7. THE CURRENT R4S CUT ROUTE IS EXHAUSTED
--------------------------------------------------------------------------

The existing R4S tangent carrier uses only

    e(R_res)=4,
    r_res<=4,
    L_res<=4*M,

plus an independent lower bound on the final Artin length N.

Section 6 proves that the coefficient four in the residual cut estimate cannot
be lowered from these residual-ring/module hypotheses alone.

Thus a universal replacement such as

    L_res<4*M,

or

    L_res<=3*M+s,

is false at the level of the retained residual data.

Corollary terminal_R4S_residual_cut_route_exhausted:
  The unresolved R4S degree cases cannot be closed merely by another universal
  refinement of the current residual-cut estimate based only on the forced R4S
  Artinian reduction and faithful H01 m=3 residual module profile.
Qed.

--------------------------------------------------------------------------
8. EXACT MISSING OBJECT FOR ANY FUTURE RETURN
--------------------------------------------------------------------------

The explicit model is deliberately only a residual model.  It is NOT asserted
to arise from a valid original four-quadric H01-C5 ideal Q.

Therefore it establishes a method limitation, not realizability.

Any future continuation must prove at least one new theorem tying R4S back to
the original four-quadric structure, for example:

  * a restriction preventing the lower-degree final form from lying in J_res;
  * a relation between the unique linear generator of J_res and the five linear
    first syzygies of Q;
  * a coupling between the R4S Hilbert--Burch matrix and the cyclic saturation
    defect T;
  * a stronger N lower bound triggered precisely when a final form is invisible
    on the residual ring;
  * or a direct tangent carrier not factoring through K_T*J_res.

None of these inputs is presently proved.

MISSING_OBJECT:
  A repository-native theorem coupling the forced R4S residual lift to the
  original four quadrics strongly enough to rule out, or exactly classify, the
  surviving degree frontier.

--------------------------------------------------------------------------
9. EXACT TERMINAL FRONTIER
--------------------------------------------------------------------------

The concurrent two-linear-annihilator theorem has already proved

    R3 = EMPTY,
    R4U = EMPTY.

Thus only R4S survives.

The current tangent estimate closes R4S for

    s>=8,

and for

    s=7, M<=12.

Therefore the exact terminal frontier of the present E0/E1 method is

    3<=s<=6, M>=s,

or

    s=7, M>=13.

No pair in this set is claimed realizable.

Theorem terminal_E01_method_frontier_exact:
  The displayed R4S degree set is the exact unresolved frontier left by the
  current residual-annihilator/two-copy tangent route.
Qed.

--------------------------------------------------------------------------
10. PERMANENT STOPPING POINT
--------------------------------------------------------------------------

PERMANENT_STOP_REACHED_FOR_THIS_ROUTE:
  YES.

Reason:
  R3 and R4U have been eliminated.  The only residual type R4S admits an
  explicit faithful graded lift with the exact H01 m=3 special fiber for which
  the current residual cut bound is attained.  Further progress therefore
  requires a genuinely new structural bridge back to Q rather than another
  refinement of this route.

SAFE_FINAL_STATUS:
  H01-C5 m>=4 is closed.
  H01-C5 m=3 saturation is cyclic.
  H01-C5 m=3 colon types are classified.
  H01-C5 m=3 E0/E1 residual types R3 and R4U are empty.
  H01-C5 m=3 E0/E1 residual type R4S is the unique survivor.
  R4S is tangent-excluded for s>=8 and for s=7,M<=12.
  The exact residual-route terminal frontier is Section 9.

IMPORTANT_NONCONCLUSION:
  R4S is NOT fully closed.
  E0/E1 is NOT fully closed.
  H01-C5 m=3 is NOT fully closed.
  E2 is untouched by this certificate.
  H01-C4 is untouched.
  q<=3 is untouched.
  Full q4 height-two closure is NOT claimed.
  Full order-13 closure is NOT claimed.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_R3_empty.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_R4U_empty.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_R4S_forced.
  q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_residual_route_terminal.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_E01_all_degrees_closed.
  not q4_height2_multiplicity_one_depth_one_H01_C5_m3_closed.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_multiplicity_one_depth_one_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

NEXT_ACTIONS:
  No admissible next step within the current residual-annihilator route.
