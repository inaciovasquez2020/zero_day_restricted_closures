Standalone tangent closure of the AP-R carrier inside the rho_Q=1 contained
P-subset-J leaf of the r-in-P LK3-C2 carrier in the saturated H01 minimal-chain
rank-two endpoint of the homogeneous q=4, height-two, multiplicity-one,
depth-one order-13 deviation-two program.

SCOPE:
  Continue only from

    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_determinantal_alignment.v
    order13_q4_height2_depth_one_multiplicity_one_H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_tangent_closure.v

  and retain the exact AP-R normal form

    S=C[r,p,c,t],
    P=(r,p),
    Q=(r^2, r*p, p^2+r*t, p*c),
    B:=S/Q,
    D:=P/Q,
    K=(Q:r)=(r,p,c*t),
    J=(r,p,c).

Let the final homogeneous equations be

    f,g in S,
    d:=deg(f)>=3,
    e:=deg(g)>=3,

and put

    I:=Q+(f,g),
    A:=S/I=B/(f,g),
    N:=length_C(A)>=32.

The necessary order-13 tangent gate is

    t(A):=dim_C Hom_S(I,A) <= N-20.

This file performs one bounded task only: close AP-R at that tangent gate for
all admissible final degrees.  The argument differs from AP-D: the natural
annihilator quotient is a reduced-line plus double-line carrier, and the
residual module embeds in it with a length-two cokernel.  That finite defect is
small enough to force the tangent excess uniformly.

No rho_Q=2, r-not-in-P, LK3-C3, R2-LK2, R2-QK, H01-M2-R1, or q<=3 branch is
entered.  No Oblivion Closure promotion is made.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. AN EXPLICIT AP-R ANNIHILATOR
--------------------------------------------------------------------------

Inside D=P/Q the AP-R relations are

    r^2=0,
    r*p=0,
    p^2=-r*t,
    p*c=0.

Also

    c*(p^2+r*t)-p*(p*c)=r*c*t,

so

    r*c*t=0.

Put

    H_R:=(r, p^2, p*c, c*t).

Then H_R annihilates D.

Indeed r kills both generators r,p of D.  For p^2,

    p^2*r=r*(p^2+r*t)-r^2*t in Q,

and

    p^2*p=p^3=p*(p^2+r*t)-r*p*t in Q.

The generator p*c already belongs to Q.  Finally

    c*t*r=r*c*t in Q,
    c*t*p=t*(p*c) in Q.

Thus

    H_R*D=0.

Moreover Q subset H_R, and

    R_R:=S/H_R
       ~= C[p,c,t]/(p^2,p*c,c*t).

Its reduced support is the union of the c-line and the t-line; the t-line
carries the square-zero p-direction.  Its Hilbert series is

    Hilb(R_R)=(1+2*z)/(1-z).

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_explicit_annihilator:
  H_R=(r,p^2,p*c,c*t) contains Q and annihilates D.
Qed.

--------------------------------------------------------------------------
2. D EMBEDS IN THE ANNIHILATOR QUOTIENT WITH LENGTH-TWO COKERNEL
--------------------------------------------------------------------------

Regard D as an R_R-module.  Let e_r,e_p denote the classes of r,p generating
D.  Since r=0 in R_R, the AP-R relations give the R_R-presentation relations

    p*e_r=0,
    t*e_r+p*e_p=0,
    c*e_p=0.

Define an R_R-linear map

    phi:D -> R_R

by

    phi(e_r)=p+c,
    phi(e_p)=-t.

The displayed relations are respected because in R_R

    p*(p+c)=p^2+p*c=0,

    t*(p+c)+p*(-t)=t*p+t*c-p*t=0,

and

    c*(-t)=-c*t=0.

The image is

    M=(p+c,t) subset R_R.

The quotient is

    R_R/M ~= C[p]/(p^2),

so it has length two and Hilbert series 1+z.

On the other hand

    Hilb(M)
      =Hilb(R_R)-(1+z)
      =(2*z+z^2)/(1-z),

which is exactly the already-established H01 m=2 Hilbert series of D.
Since phi surjects onto M and source and target have the same Hilbert series,
phi is an isomorphism onto M.

Hence there is an exact sequence

    0 -> D -> R_R -> T -> 0,

with

    T ~= C[p]/(p^2),
    length_C(T)=2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_length_two_embedding:
  D identifies with the ideal (p+c,t) in R_R and the cokernel has length two.
Qed.

--------------------------------------------------------------------------
3. THE ANNIHILATOR CUT DIFFERS FROM THE RESIDUAL CUT BY AT MOST TWO
--------------------------------------------------------------------------

As in the preceding contained carriers, the exact sequence

    0 -> D -> B -> S/P -> 0

and the regularity of the final pair on

    S/P ~= C[c,t]

give

    H_1(f,g;B) ~= H_1(f,g;D)

and, writing

    L_D:=length_C D/(f,g)D,

    N=d*e+L_D.

Since H_R annihilates D, its image H_{R,A} in A satisfies

    H_{R,A} subset Ann_A H_1(f,g;B).

Put

    C_R:=length_C S/(H_R,f,g)
       =length_C R_R/(f,g)R_R.

The module T is concentrated in degrees 0 and 1.  Since d,e>=3, both f and g
act by zero on T.  Quotient the exact sequence

    0 -> D -> R_R -> T -> 0

by the ideal (f,g).  The left map need not remain injective, but its kernel has
nonnegative length.  Therefore the resulting right-exact sequence gives

    C_R <= L_D + length_C(T)
        = L_D+2.

Equivalently,

    dim_C H_{R,A}
      =N-C_R
      >=d*e-2.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_cut_defect_two:
  For every admissible final pair,

    length_C S/(H_R,f,g) <= L_D+2,

  and hence

    dim_C H_{R,A} >= d*e-2.
Qed.

--------------------------------------------------------------------------
4. THE RESIDUAL CUT IS AT MOST d*e
--------------------------------------------------------------------------

Let

    Mdeg:=max(d,e).

Because D is the already-established one-dimensional Cohen--Macaulay residual
module of multiplicity three, and D/(f,g)D has finite length, the ideal (f,g)
avoids every associated prime of D collectively.

Over C, choose a homogeneous element

    h in (f,g)

of degree Mdeg which avoids every associated prime of D.  If d=e, take a
generic scalar combination of f and g.  If, say, d<e=Mdeg, choose a generic
form q of degree e-d avoiding the finitely many associated primes where needed
and then take a generic scalar combination

    h=g+lambda*q*f.

Thus h is D-regular.  Since D has multiplicity three,

    length_C D/hD=3*Mdeg.

As h belongs to (f,g), D/(f,g)D is a quotient of D/hD, so

    L_D<=3*Mdeg.

The other final degree is at least three, hence

    d*e>=3*Mdeg.

Therefore

    L_D<=d*e

and

    N=d*e+L_D<=2*d*e.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_residual_cut_bound:
  Every AP-R final pair satisfies

    L_D<=d*e

  and

    N<=2*d*e.
Qed.

--------------------------------------------------------------------------
5. TWO COPIES OF THE ANNIHILATOR IMAGE CLOSE THE TANGENT GATE
--------------------------------------------------------------------------

Put

    E:=Ann_A H_1(f,g;B).

The repository's standard two-copy Koszul-annihilator carrier gives a natural
injection

    E direct_sum E -> Hom_B((f,g)B,A)

and then into

    Hom_S(I,A).

Since H_{R,A} subset E,

    t(A)
      >=2*dim_C H_{R,A}
      >=2*d*e-4.

Using N<=2*d*e,

    t(A)-(N-20)
      >=(2*d*e-4)-(2*d*e-20)
      =16>0.

Therefore

    t(A)>N-20

for every admissible final pair, contradicting the necessary order-13 tangent
gate.

Theorem H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_fails_order13_gate:
  Every AP-R instance is tangent-excluded.
Qed.

Corollary H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_closed:
  The AP-R leaf is CLOSED at the necessary order-13 tangent gate.
Qed.

--------------------------------------------------------------------------
6. rho_Q=1 CONTAINED LEAF IS NOW CLOSED
--------------------------------------------------------------------------

The determinantal-alignment file reduced rho_Q=1 to AP-D and AP-R.

AP-D is already tangent-closed for all final degrees.
The present file tangent-closes AP-R for all final degrees.

Hence

    contained r-in-P LK3-C2 rho_Q=1 leaf: CLOSED.

IMPORTANT_NONCONCLUSION:
  This does NOT close rho_Q=2.
  It does NOT close the full contained r-in-P carrier.
  It does NOT close LK3-C2 or R2-LK3.
  It does NOT treat r-not-in-P, LK3-C3, R2-LK2, R2-QK, or H01-M2-R1.
  It does NOT close H01.
  It does NOT enter q<=3.
  It does NOT prove Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_zero_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_D_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_AP_R_closed.
  H01_m2_R2_LK3_C2_r_in_P_contained_rho_one_closed.
  not H01_m2_R2_LK3_C2_r_in_P_contained_closed.
  not H01_m2_R2_LK3_C2_closed.
  not H01_m2_R2_LK3_closed.
  not H01_m2_R2_closed.
  not H01_m2_R1_closed.
  not H01_m2_closed.
  not H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not OC.

MISSING_OBJECT:
  Return to the contained r-in-P rho_Q=2 leaf.  The rho_Q=0 and rho_Q=1
  contained defects are now tangent-closed; only rho_Q=2 remains inside this
  incidence.

NEXT_ACTIONS:
  1. Re-read the exact terminal CI run for this commit.
