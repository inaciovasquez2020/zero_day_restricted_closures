Standalone regular-escape reduction for the residual R2 branch of the
nonreduced homogeneous q=3, height-three complete-intersection core in the
order-13 deviation-two problem.

SCOPE:
  Continue from

    order13_homogeneous_q3_height3_nonreduced_ci_twisted_conormal_reduction.v.

  Let

    B=S/(q1,q2,q3)

  be the one-dimensional standard graded Gorenstein complete intersection of
  three quadrics, and let

    L=(u1,u2,v) subset B,
    A=B/L,
    N=length_C(A),

  be in the residual R2 pattern

    deg(u1)=deg(u2)=d < deg(v)=e.

  Put

    J=(u1,u2),
    D=e-d>0.

  The residual assumption is that the minimal slice

    U=L_d=span_C{u1,u2}

  consists entirely of zero divisors.  The trapped-component reduction proved
  that for every minimal prime q containing U, the generator v escapes q.

This is pseudo-formal mathematical documentation. It is not Coq or Lean and
MACHINE_VERIFICATION_OF_NEW_THEOREM is not claimed.

--------------------------------------------------------------------------
1. THE DEGREE-e SLICE OF L CONTAINS A REGULAR ELEMENT WITH v-COEFFICIENT ONE
--------------------------------------------------------------------------

For every minimal prime q of B, the affine degree-e slice

  v + J_e

is not contained in q.

Proof.
  If q is trapped, so U subset q, then J subset q while v notin q by the R2
  escape property. Hence v+J_e is disjoint from q modulo the proper subspace
  J_e subset q; in particular it is not contained in q.

  If q is not trapped, choose u in U with u notin q. Since B/q is a
  one-dimensional standard graded domain, it contains a nonzero degree-D
  element h. Then h*u lies in J_e and h*u notin q. Therefore J_e is not
  contained in q, so the affine space v+J_e cannot be contained in q.
Qed.

The ring B has only finitely many minimal primes. Over the infinite field C, a
finite union of proper affine linear subspaces cannot cover the affine space
v+J_e. Hence there exists

  j in J_e

such that

  g:=v+j

lies in no minimal prime of B.

Because B is one-dimensional Cohen--Macaulay and therefore has no embedded
associated primes, the zero divisors are exactly the union of its minimal
primes. Thus g is a B-nonzerodivisor.

Theorem R2_has_homogeneous_regular_escape_generator:
  There exists j in J_e such that

    g=v+j

  is homogeneous of degree e and B-regular.
Qed.

Since j lies in J,

  L=(u1,u2,g).

The triangular replacement v -> g=v+j preserves the minimal homogeneous
generating set and the R2 degree pattern d,d,e.

--------------------------------------------------------------------------
2. QUOTIENT BY THE REGULAR ESCAPE
--------------------------------------------------------------------------

Set

  R:=B/(g),

and write u1,u2 also for their images in R. Since B is one-dimensional
Gorenstein and g is homogeneous B-regular of degree e, R is a zero-dimensional
graded Gorenstein algebra.

Its length is the multiplicity of the principal parameter section:

  length_C(R)=e(B)*e=8e.

Equivalently, from

  0 -> B(-e) --g--> B -> R -> 0

and

  Hilb_B(t)=(1+t)^3/(1-t),

one gets

  Hilb_R(t)=(1-t^e)*(1+t)^3/(1-t)
           =(1+t+...+t^(e-1))*(1+t)^3,

whose value at t=1 is 8e.

Since g differs from v by an element of J,

  A=B/(u1,u2,g)
   ~=R/(u1,u2).

Thus the residual R2 candidate is equivalently a quotient

  A=R/J_R

of an Artinian graded Gorenstein algebra R of length 8e by the two equal-degree
generators u1,u2 of degree d.

Theorem R2_reduces_to_two_generator_ideal_in_Artin_Gorenstein_section:
  Every residual R2 candidate admits a presentation

    R=B/(g),
    length_C(R)=8e,
    R Artinian graded Gorenstein,
    A=R/(u1,u2),
    deg(u1)=deg(u2)=d<e.
Qed.

The socle degree of R is

  a(R)=a(B)+e=e+2,

because a(B)=2 and quotient by a homogeneous regular element of degree e adds
e to the a-invariant.

--------------------------------------------------------------------------
3. THE TANGENT PROBLEM DESCENDS TO THE TWO-GENERATOR SECTION
--------------------------------------------------------------------------

Let

  J_R=(u1,u2) subset R.

The quotient map L -> J_R has kernel (g), giving

  0 -> (g) -> L -> J_R -> 0.

Every R-linear map

  J_R -> A

therefore pulls back along L -> J_R to a B-linear map

  L -> A.

Hence there is a natural injection

  Hom_R(J_R,A) -> Hom_B(L,A).

Theorem R2_two_generator_section_tangent_injects:

  dim_C Hom_B(L,A)
    >= dim_C Hom_R(J_R,A).
Qed.

Since A=R/J_R, every R-linear map J_R -> A factors through the conormal
J_R/J_R^2, so

  Hom_R(J_R,A)
    ~= Hom_A(J_R/J_R^2,A).

By Artinian canonical duality, if

  omega_A^R:=Hom_R(A,R)=Ann_R(J_R)

is the canonical A-module induced from the Artinian Gorenstein algebra R, then

  dim_C Hom_R(J_R,A)
    = length_C((J_R/J_R^2) tensor_A omega_A^R).

Therefore it is enough for the order-13 tangent exclusion to prove the
strictly smaller two-generator target

  length_C((J_R/J_R^2) tensor_A omega_A^R) >= N-19.

This does not assert that the bound always holds; it only replaces the
three-generator ideal on the one-dimensional curve by an equivalent bounded
Artinian-Gorenstein section from which tangent maps inject.

--------------------------------------------------------------------------
4. ORDINARY CONORMAL LENGTH FOR THE ORIGINAL THREE-GENERATOR IDEAL
--------------------------------------------------------------------------

There is also an exact independent size statement for the untwisted conormal
of L.  A theorem of Simis--Vasconcelos applies to an m-primary ideal generated
by dim(B)+2 elements in a local Gorenstein ring.  With

  dim(B)=1,
  mu_B(L)=3,

it gives

  length_C(L/L^2)
    = N + length_C(delta(L)),

where

  delta(L)=ker(Sym_B^2(L) -> L^2)

is the syzygetic defect. In particular

  length_C(L/L^2)>=N.

Source:
  A. Simis and W. V. Vasconcelos,
  The Syzygies of the Conormal Module,
  American Journal of Mathematics 103 (1981), Proposition 2.4.

This ordinary-conormal inequality does NOT by itself imply the required
inequality after tensoring with omega_A. No monotonicity of length under that
twist is assumed here.

--------------------------------------------------------------------------
5. UPDATED FRONTIER
--------------------------------------------------------------------------

RESULT:
  R2_has_homogeneous_regular_escape_generator.
  R2_reduces_to_two_generator_ideal_in_Artin_Gorenstein_section.
  R2_two_generator_section_tangent_injects.

IMPORTANT_NONCONCLUSION:
  This file does NOT prove

    dim_C Hom_R(J_R,A)>=N-19.

  It does NOT prove the corresponding twisted-conormal bound.
  It does NOT close R2 or R1.
  It does NOT close the full nonreduced H3-CI child.
  It does NOT close H2-CM, H2-NCM, homogeneous q=3, q<=2, or Oblivion Closure.

PROOF_STATUS:
  pseudo-formal mathematical documentation. The Simis--Vasconcelos conormal
  length formula is an explicitly named external theorem. The new theorem
  statements are not machine-verified.

MACHINE_VERIFICATION_OF_NEW_THEOREM:
  not claimed.

BOUNDARY:
  Residual R2 is reduced to a two-generated equal-degree ideal J_R inside an
  Artinian graded Gorenstein algebra R of exact length 8e and socle degree e+2.
  Its tangent module injects into the original H3 tangent module.

MISSING_OBJECT:
  For the R2 Artinian-Gorenstein section

    R=B/(g),
    A=R/(u1,u2),
    deg(u1)=deg(u2)=d,
    length(R)=8e,
    socdeg(R)=e+2,

  prove

    dim_C Hom_R((u1,u2),A) >= N-19,

  equivalently

    length_C(((u1,u2)/(u1,u2)^2) tensor_A Ann_R(u1,u2)) >= N-19.

NEXT_ACTIONS:
  1. Re-read the exact terminal workflow for this commit.
  2. If green, compute the two-generator Koszul homology of (u1,u2) in the
     Artinian Gorenstein section R.
  3. Use the perfect Gorenstein pairing of R to identify the annihilator and
     conormal dual degree-by-degree.
  4. Prove only the N-19 lower bound for Hom_R((u1,u2),A).
  5. Rebuild immediately after that bounded lemma.
