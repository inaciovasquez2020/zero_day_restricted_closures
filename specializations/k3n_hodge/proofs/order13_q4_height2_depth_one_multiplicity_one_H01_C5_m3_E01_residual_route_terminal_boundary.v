Standalone terminal-boundary certificate for the residual-annihilator/tangent route
inside the low-embedding-dimension H01-C5 m=3 colon types E0/E1 of the
homogeneous q=4, height-two multiplicity-one, depth-one order-13 deviation-two
program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_C5_m3_E01_residual_multiplicity_five_exclusion.v

  and retain the exact residual reduction already proved there:

    S = C[x1,x2,x3,x4],
    J_res = Ann_S(D) = (Qsat:P),
    R_res = S/J_res,

    e(R_res) in {3,4},

with the three regular-cut types

    R3:
      Jbar=(v,w,u^3),
      r_res<=3;

    R4U:
      Jbar=(v,w,u^4),
      r_res<=3;

    R4S:
      Jbar=(w,u^3,u*v,v^2),
      r_res<=4.

The preceding file gives the residual-cut bounds

    L_res<=3*M  in R3,
    L_res<=4*M  in R4U/R4S,

where

    M=max(d,e),
    s=min(d,e).

It also records the exact statewise tangent exclusions and leaves a residual
small-degree frontier.

This file performs one bounded task only:

  prove that the worst R4S estimate

    L_res<=4*M

  is SHARP under the exact residual-ring/module hypotheses already used by this
  route, by constructing an explicit faithful graded R4S lift whose m=3
  Artinian reduction is exactly the required H01 module and for which one final
  form can be completely invisible on the residual ring/module.

Consequently, no stronger universal cut bound depending only on the currently
recorded residual data can be used to finish the surviving E0/E1 cases.  Any
further closure must import genuinely new structure connecting the residual
ring back to the original four quadrics Q, the line core P, the cyclic
saturation defect T, or an additional restriction on the final forms f,g.

This is a method-boundary theorem only.
It does NOT construct a full H01-C5 four-quadric example.
It does NOT prove that any surviving E0/E1 degree pair is realizable.
It does NOT close E0/E1.
It does NOT enter E2, H01-C4, q<=3, or full order-13 closure.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. AN EXPLICIT R4S ONE-DIMENSIONAL LIFT
--------------------------------------------------------------------------

Work in

    Sstar := C[h,u,v,w]

with all variables of degree one, and define

    Jstar := (w, u*v, v^2, u^3-h^2*v).

Put

    Rstar := Sstar/Jstar.

The defining relations are

    w=0,
    u*v=0,
    v^2=0,
    u^3=h^2*v.

They imply

    u^4=h^2*u*v=0.

Every element of Rstar therefore has a unique expression

    a(h)
      + b(h)*u
      + c(h)*u^2
      + d(h)*v.

Hence Rstar is free over C[h] with homogeneous basis

    1, u, v, u^2

of degrees

    0,1,1,2.

Therefore

    Hilb_Rstar(t)
      = (1+2*t+t^2)/(1-t),

    dim Rstar = 1,
    depth(Rstar)=1,
    e(Rstar)=4,

and h is Rstar-regular.

Theorem terminal_R4S_ring_lift:
  Rstar is a one-dimensional Cohen--Macaulay standard graded algebra of
  multiplicity four with h-vector

    (1,2,1).
Qed.

--------------------------------------------------------------------------
2. THE REGULAR ARTINIAN CUT IS EXACTLY R4S
--------------------------------------------------------------------------

Reduce modulo h.  Then

    Rstar/hRstar
      ~= C[u,v,w]/(w,u*v,v^2,u^3).

Thus the cut ideal is exactly

    (w,u^3,u*v,v^2),

which is the previously classified R4S type.

Its graded basis is

    1, u, v, u^2,

so its Hilbert function is

    1,2,1

and its length is four.

Theorem terminal_R4S_cut_exact:
  The explicit lift Rstar has precisely the R4S regular Artinian cut used by the
  current E0/E1 residual classification.
Qed.

--------------------------------------------------------------------------
3. A FAITHFUL H01 m=3 RESIDUAL MODULE LIFT
--------------------------------------------------------------------------

Define a graded C[h]-free module Dstar with basis

    e0, e1  in degree 1,
    e2      in degree 2,
    e3      in degree 3.

Thus

    Dstar
      ~= C[h](-1)^2
          direct_sum C[h](-2)
          direct_sum C[h](-3)

as a graded C[h]-module.

Define the Sstar-action by letting h act by scalar multiplication, w act by
zero, and setting

    u*e0 = 0,
    u*e1 = e2,
    u*e2 = e3,
    u*e3 = h^3*e0,

and

    v*e0 = 0,
    v*e1 = h*e0,
    v*e2 = 0,
    v*e3 = 0.

The u- and v-actions commute.  Moreover

    u*v = 0,
    v^2 = 0

on Dstar, and

    u^3 = h^2*v

on every basis vector.

Indeed, on e1 one has

    u^3*e1 = h^3*e0 = h^2*v*e1,

while both sides vanish on e0,e2,e3.

Therefore Jstar annihilates Dstar and Dstar is naturally an Rstar-module.

Theorem terminal_R4S_module_is_well_defined:
  The displayed formulas define a graded Rstar-module structure on Dstar.
Qed.

--------------------------------------------------------------------------
4. THE MODULE HAS THE EXACT H01 m=3 HILBERT PROFILE
--------------------------------------------------------------------------

Since Dstar is C[h]-free on generators in degrees 1,1,2,3,

    Hilb_Dstar(t)
      = (2*t+t^2+t^3)/(1-t).

This is exactly the surviving H01-C5 m=3 residual Hilbert series.

Reducing modulo h gives

    Estar := Dstar/hDstar.

The special-fiber action is

    u*e0=0,
    u*e1=e2,
    u*e2=e3,
    u*e3=0,

and

    v*Estar=0,
    w*Estar=0.

Hence

    Estar
      ~= C(-1)
          direct_sum C[u]/(u^3)(-1).

Moreover

    Ann_(C[u,v,w])(Estar)
      = (v,w,u^3),

exactly as in the established H01 m=3 Artinian reduction.

Theorem terminal_R4S_module_special_fiber_exact:
  Dstar has the exact H01 m=3 Hilbert series and exact Artinian reduction module
  used by the residual-annihilator route.
Qed.

--------------------------------------------------------------------------
5. Dstar IS FAITHFUL OVER Rstar
--------------------------------------------------------------------------

Let

    r = a(h)+b(h)*u+c(h)*u^2+d(h)*v

be an arbitrary element of Rstar.

Act on e1.  Using the defining action,

    r*e1
      = a(h)*e1
        + b(h)*e2
        + c(h)*e3
        + d(h)*h*e0.

Because

    e0,e1,e2,e3

are C[h]-linearly independent and h is a nonzerodivisor in C[h], the equality

    r*e1=0

forces

    a=b=c=d=0.

Thus e1 itself has zero annihilator in Rstar.

Theorem terminal_R4S_module_faithful:
  Dstar is faithful over Rstar.

Equivalently,

    Ann_Sstar(Dstar)=Jstar.
Qed.

This is the crucial point: the example does not merely reproduce the R4S
Artinian cut.  It also reproduces the exact global condition

    R_res = S/Ann(D)

used by the current E0/E1 route.

--------------------------------------------------------------------------
6. THE RESIDUAL CUT BOUND 4*M IS ATTAINED
--------------------------------------------------------------------------

Fix arbitrary integers

    3 <= s <= M.

Choose homogeneous forms

    g := w*h^(s-1),
    f := h^M.

Then

    deg(g)=s,
    deg(f)=M.

Because w belongs to Jstar,

    g=0

in Rstar and on Dstar.

Because h is Rstar-regular and Dstar-regular,

    f=h^M

is a nonzerodivisor on both.

Therefore

    Rstar/(f,g)
      = Rstar/(h^M),

so

    length_C Rstar/(f,g)
      = M*e(Rstar)
      = 4*M.

Likewise

    Dstar/(f,g)Dstar
      = Dstar/h^M Dstar

has length

    4*M.

Theorem terminal_R4S_cut_bound_sharp:
  Under the exact residual-ring/module hypotheses used by the current E0/E1
  route, the bound

    L_res <= 4*M

  is sharp for every pair of degrees

    3<=s<=M.

  The lower-degree final form may be completely invisible on the residual
  ring/module.
Qed.

--------------------------------------------------------------------------
7. CONSEQUENCE FOR THE EXISTING TANGENT ROUTE
--------------------------------------------------------------------------

The current R4S tangent carrier uses only

    e(R_res)=4,
    r_res<=4,
    L_res<=4*M,

plus the independent lower bound on the final Artin length.

Section 6 proves that the coefficient four in

    L_res<=4*M

cannot be lowered from the present residual-ring/module hypotheses alone.

In particular, any proposed universal improvement such as

    L_res <= (4-epsilon)*M + O(s)

with epsilon>0, or

    L_res <= 3*M+s,

is false at the level of the residual data currently retained: the explicit
faithful R4S lift above attains

    L_res=4*M

while satisfying the exact m=3 Hilbert profile and exact R4S special fiber.

Corollary terminal_E01_residual_cut_route_exhausted:
  The surviving E0/E1 degree cases cannot be closed merely by sharpening the
  current residual cut estimate from the already recorded R3/R4U/R4S Artinian
  data.

  Any further universal exclusion must use at least one genuinely new input not
  present in the residual-only model.
Qed.

--------------------------------------------------------------------------
8. WHAT NEW INPUT WOULD BE REQUIRED
--------------------------------------------------------------------------

The explicit model does NOT assert compatibility with the full original
four-quadric H01-C5 data.  Therefore it does not prove realizability of a
surviving state.

Instead it isolates the exact missing object.

To continue beyond this point, one must prove an additional theorem tying at
least one of the following back to the original ideal Q:

  * a restriction preventing a lower-degree final form from lying in J_res;
  * a stronger relation between J_res=(Qsat:P) and the five linear syzygies of Q;
  * a coupling between the cyclic saturation defect T and the R4S residual lift;
  * a sharper lower bound on N that uses the same residual degeneration causing
    L_res=4*M;
  * or a direct tangent carrier not factored through K_T*J_res.

None of those statements is currently proved in the repository.

Thus the next step would not be another refinement of the existing residual
estimate.  It would begin a genuinely new structural argument.

--------------------------------------------------------------------------
9. EXACT TERMINAL FRONTIER OF THE CURRENT E0/E1 METHOD
--------------------------------------------------------------------------

Retain the statewise exclusions already proved in the preceding file.

R3 is closed for

    s>=6,

also for

    s=5 and M<=12,

and for

    (s,M)=(4,4).

Hence the present R3 method leaves only

    s=3, M>=3;
    s=4, M>=5;
    s=5, M>=13.

R4U is closed for

    s>=8,

also for

    s=7 and M<=20,

and for

    s=6 and M<=8.

Hence the present R4U method leaves only

    3<=s<=5, M>=s;
    s=6, M>=9;
    s=7, M>=21.

R4S is closed for

    s>=8,

and for

    s=7 and M<=12.

Hence the present R4S method leaves only

    3<=s<=6, M>=s;
    s=7, M>=13.

No surviving pair is claimed realizable.

Theorem terminal_E01_method_frontier_exact:
  The displayed statewise degree sets are the exact unresolved frontier left by
  the current residual-annihilator/two-copy tangent estimates.
Qed.

--------------------------------------------------------------------------
10. PERMANENT STOPPING POINT
--------------------------------------------------------------------------

PERMANENT_STOP_REACHED_FOR_THIS_ROUTE:
  YES.

Reason:
  The residual-annihilator route has reached a sharp model obstruction.  Its
  worst cut constant is attained by an explicit faithful graded R4S lift with
  the exact H01 m=3 special fiber.  Further progress therefore requires a new
  structural theorem linking the residual model back to Q or to the final
  equations, rather than another bounded refinement of the same route.

SAFE_FINAL_STATUS:
  H01-C5 m>=4 is closed.
  H01-C5 m=3 saturation is cyclic.
  H01-C5 m=3 colon types are classified.
  H01-C5 m=3 E0/E1 residual types are classified as R3/R4U/R4S.
  Large and several intermediate final-degree regions are tangent-excluded.
  The exact residual-only surviving degree frontier is listed in Section 9.

IMPORTANT_NONCONCLUSION:
  E0/E1 is NOT fully closed.
  H01-C5 m=3 is NOT fully closed.
  E2 is untouched by this terminal certificate.
  H01-C4 is untouched.
  q<=3 is untouched.
  Full q4 height-two closure is NOT claimed.
  Full order-13 closure is NOT claimed.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
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
