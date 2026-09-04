Standalone saturation reduction for the H01-C4 branch in the homogeneous q=4,
height-two multiplicity-one, depth-one order-13 deviation-two program.

SCOPE:
  Retain

    S = C[x1,x2,x3,x4],
    Q = (q1,q2,q3,q4),
    B = S/Q,
    Qsat = Q^sat,
    Ccore = S/Qsat,
    T = Qsat/Q,
    P = (l1,l2),
    D = P/Qsat,

  in H01 with

    ht(Q)=2,
    e(B)=e(Ccore)=1,
    depth_m(Ccore)=1,
    Q_2=(Qsat)_2,
    T_1=T_2=0.

The exact H01 Artinian classification gives, for some m>=2,

    Hilb_D(t)=(2*t+t^2+...+t^m)/(1-t),

hence

    dim_C D_n=n+1  for 2<=n<=m,
    dim_C D_n=m+1  for n>=m.

Stay only in the nonminimal cubic branch H01-C4:

    m>=3,
    sigma=4,
    tau_3=0,
    Q_3=(Qsat)_3.

Thus

    dim_C B_3=8.

This file performs one bounded task only: use the next Macaulay values to
reduce H01-C4 to its unique possible chain length and determine the full
saturation defect.  No coefficient-matrix classification, tangent estimate,
H01 m=2 branch, q<=3 branch, or full order-13 closure is entered.

This is pseudo-formal mathematical documentation.  It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. CORE HILBERT VALUES IN DEGREE FOUR
--------------------------------------------------------------------------

The line quotient S/P ~= C[s,t] has degree-n value n+1.  From

    0 -> D -> Ccore -> S/P -> 0

one obtains:

If m=3, then D_4=4, so

    dim_C Ccore_4=4+5=9.

If m>=4, then D_4=5, so

    dim_C Ccore_4=5+5=10.

Since B -> Ccore is surjective with kernel T,

    dim_C B_4 = dim_C Ccore_4 + dim_C T_4.

--------------------------------------------------------------------------
2. MACAULAY EXCLUDES EVERY m>=4 C4 CHAIN
--------------------------------------------------------------------------

In H01-C4 one has

    dim_C B_3=8.

Its third Macaulay expansion is

    8=binom(4,3)+binom(3,2)+binom(1,1),

so

    8^{<3>}=binom(5,4)+binom(4,3)+binom(2,2)=10.

Hence Macaulay growth gives

    dim_C B_4<=10.

Assume m>=4.  The core already has value ten in degree four, so

    10<=dim_C B_4<=10.

Therefore

    dim_C B_4=10=8^{<3>}.

Because Q is generated entirely in degree two, standard Gotzmann persistence
applies to this maximal growth from degree three to degree four.  The
persistent successor profile is

    dim_C B_n=2*n+2  for every n>=3,

so B has multiplicity two.

But saturation changes Q only by the finite-length module T, hence B and
Ccore have the same Hilbert polynomial and the same multiplicity.  The H01
standing hypothesis gives

    e(Ccore)=1.

Contradiction.

Theorem H01_C4_mge4_is_empty:
  No H01-C4 state with m>=4 exists.
Qed.

Corollary H01_C4_forces_m3:
  Every surviving H01-C4 state has

    m=3.
Qed.

--------------------------------------------------------------------------
3. THE m=3 C4 STATE HAS NO QUARTIC SATURATION DEFECT
--------------------------------------------------------------------------

Now m=3.  Then

    dim_C Ccore_4=9,

so

    dim_C B_4=9+tau_4.

The degree-three Macaulay bound gives B_4<=10, hence tau_4 is zero or one.

If tau_4=1, then

    dim_C B_4=10=8^{<3>},

and the same Gotzmann argument as above forces multiplicity two, contradicting
multiplicity one.

Therefore

    tau_4=0,
    B_4=9,
    Q_4=(Qsat)_4.

Theorem H01_C4_m3_no_quartic_defect:
  In the surviving H01-C4 state,

    T_4=0.
Qed.

--------------------------------------------------------------------------
4. THE m=3 C4 STATE HAS NO QUINTIC SATURATION DEFECT
--------------------------------------------------------------------------

For m=3 the residual module is constant of value four from degree three on.
Thus

    dim_C Ccore_5=4+6=10.

Hence

    dim_C B_5>=10.

The fourth Macaulay expansion of nine is

    9=binom(5,4)+binom(4,3),

so

    9^{<4>}=binom(6,5)+binom(5,4)=11.

Therefore

    10<=dim_C B_5<=11.

Assume B_5=11.  Then growth from degree four to degree five is maximal.  Since
Q is generated in degree two, Gotzmann persistence gives the successor profile

    dim_C B_n=2*n+1  for every n>=4,

again of multiplicity two.  This contradicts e(B)=1.

Hence

    dim_C B_5=10,
    T_5=0,
    Q_5=(Qsat)_5.

Theorem H01_C4_m3_no_quintic_defect:
  In the surviving H01-C4 state,

    T_5=0.
Qed.

--------------------------------------------------------------------------
5. DEGREE SIX STARTS MULTIPLICITY-ONE GOTZMANN PERSISTENCE
--------------------------------------------------------------------------

Still m=3.  One has

    dim_C Ccore_6=4+7=11.

Since B -> Ccore is surjective,

    dim_C B_6>=11.

The fifth Macaulay expansion of ten is

    10
      =binom(6,5)+binom(4,4)+binom(3,3)+binom(2,2)+binom(1,1),

so

    10^{<5>}
      =binom(7,6)+binom(5,5)+binom(4,4)+binom(3,3)+binom(2,2)
      =11.

Macaulay therefore gives

    dim_C B_6<=11.

Thus

    dim_C B_6=11=10^{<5>}.

This is maximal growth from degree five to degree six.  Since Q is generated
in degree two, Gotzmann persistence yields

    dim_C B_n=n+5  for every n>=5.

But for m=3 the core already has

    dim_C Ccore_n
      = dim_C D_n + dim_C(S/P)_n
      = 4 + (n+1)
      = n+5

for every n>=3.

Hence

    dim_C B_n=dim_C Ccore_n

for every n>=5, and therefore

    T_n=0

for every n>=5.

Together with

    T_1=T_2=0,
    T_3=0,
    T_4=0,
    T_5=0,

and the trivial degree-zero equality, this gives

    T=0.

Therefore

    Q=Qsat.

Theorem H01_C4_saturation_defect_vanishes:
  Every surviving H01-C4 state satisfies

    m=3,
    T=0,
    Q=Qsat.
Qed.

--------------------------------------------------------------------------
6. EXACT SURVIVING HILBERT PROFILE
--------------------------------------------------------------------------

The surviving C4 endpoint, if realizable, is therefore saturated and has

    dim_C B_0=1,
    dim_C B_1=4,
    dim_C B_2=6,
    dim_C B_n=n+5  for every n>=3.

Equivalently,

    B=Ccore,
    Hilb_D(t)=(2*t+t^2+t^3)/(1-t).

No geometric classification of Q is claimed here.

--------------------------------------------------------------------------
7. SHARP BOUNDARY
--------------------------------------------------------------------------

NEWLY_PROVED:
  q4_height2_multiplicity_one_depth_one_H01_C4_mge4_empty.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_no_quartic_defect.
  q4_height2_multiplicity_one_depth_one_H01_C4_m3_no_quintic_defect.
  q4_height2_multiplicity_one_depth_one_H01_C4_saturation_defect_vanishes.

REDUCED_ENDPOINT:
  H01-C4 can survive only as

    m=3,
    sigma=4,
    tau_3=0,
    Q=Qsat,
    Hilb_B(0,1,2,3,4,5,6,...)
      =(1,4,6,8,9,10,11,...).

IMPORTANT_NONCONCLUSION:
  This file does NOT exclude the saturated m=3 C4 endpoint.
  It does NOT classify the four-by-four linear syzygy matrix.
  It does NOT prove a tangent carrier or tangent-space estimate.
  It does NOT treat the distinct H01 m=2 cubic states.
  It does NOT close all H01.
  It does NOT close every q=4 height-two branch.
  It does NOT enter q<=3.
  It does NOT prove full order-13 closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  q4_height2_multiplicity_one_depth_one_H01_C5_closed.
  q4_height2_multiplicity_one_depth_one_H01_C4_reduced_to_saturated_m3.
  not q4_height2_multiplicity_one_depth_one_H01_closed.
  not q4_height2_full_closure.
  not homogeneous_q_le_3_closure.
  not full_order13_closure.

MISSING_OBJECT:
  Stay only in the saturated H01-C4 m=3 endpoint.  Use the exact Hilbert
  numerator and the four linear first syzygies to determine the weakest
  possible graded Betti table or coefficient-matrix normal form before any
  tangent estimate.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow run for this commit.
