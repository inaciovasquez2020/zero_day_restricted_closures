Standalone canonical-module restriction for the Cohen--Macaulay e=6 endpoint of the homogeneous q=4, height-three order-13 branch.

SCOPE:
  This file starts from

    order13_q4_height3_e6_koszul_annihilator_reduction.v
    order13_q4_height3_e6_type2_annihilator_reduction.v

  and treats only the multiplicity-six Cohen--Macaulay four-quadric core.

This is pseudo-formal mathematical documentation.  It is not Coq and does not assert generic F_13 algebraicity.

Setup:
  S := C[x1,x2,x3,x4],
  Q subset S generated minimally by four quadrics,
  ht(Q)=3,
  B:=S/Q one-dimensional Cohen--Macaulay,
  e(B)=6.

The preceding type-two file proves the forced minimal resolution

  0 -> S(-5)^2
    -> S(-3)^2 + S(-4)^3
    -> S(-2)^4
    -> S
    -> B
    -> 0

and type(B)=2.

Localize at the homogeneous maximal ideal and again write B for the localization.  Choose the regular first cut f from the preceding Koszul reduction and put

  C0:=B/(f).

Let g be the second cut and define

  A:=C0/(g),
  D:=0:_(C0) g.

Then

  length(A)=length(D)=N,

and a dangerous candidate must satisfy

  dim_C Hom_A(D,A)>=N+20.

Notation:
  omega_B := canonical module of B,
  omega_C0 := canonical module of C0,
  D^vee := Hom_C(D,C).

Theorem canonical_module_has_two_generator_forced_presentation:
  As a graded S-module before localization, omega_B has a presentation

    S(-1)^2 + S^3 -> S(1)^2 -> omega_B -> 0.

  In particular

    mu_B(omega_B)=2.

Proof:
  Apply Hom_S(-,S(-4)) to the forced minimal resolution of B.  Since B is Cohen--Macaulay of codimension three,

    omega_B = Ext^3_S(B,S(-4)).

  The last two dual free modules are

    Hom_S(S(-3)^2+S(-4)^3,S(-4))
      = S(-1)^2+S^3

  and

    Hom_S(S(-5)^2,S(-4))
      = S(1)^2.

  Thus omega_B is the cokernel of the displayed map.  Minimality of the original resolution makes this a minimal presentation at the homogeneous maximal ideal, so omega_B requires exactly two generators.
Qed.

Theorem dual_annihilator_is_canonical_module_restricted_to_A:
  There are natural A-module isomorphisms

    D^vee
      ~= omega_C0 / g*omega_C0
      ~= omega_B / (f,g)*omega_B
      ~= omega_B tensor_B A.

Proof:
  The preceding type-two reduction dualizes

    0 -> D -> C0 --g--> C0 -> A -> 0

  over C and obtains

    D^vee ~= omega_C0/g*omega_C0.

  Since f is B-regular and B is Cohen--Macaulay,

    omega_C0 ~= omega_B/f*omega_B

  as local canonical modules.  Quotienting once more by g gives

    D^vee
      ~= (omega_B/f*omega_B)/g(omega_B/f*omega_B)
      ~= omega_B/(f,g)*omega_B
      ~= omega_B tensor_B A.
Qed.

Corollary dual_annihilator_is_exactly_two_generated:
  One has

    mu_A(D^vee)=2.

Proof:
  The ideal (f,g) is contained in the maximal ideal of B.  Therefore passage from omega_B to

    omega_B/(f,g)*omega_B

  does not change the dimension of the generator space modulo the maximal ideal:

    (omega_B/(f,g)omega_B) / m_A(omega_B/(f,g)omega_B)
      ~= omega_B/m_B*omega_B.

  The right-hand side has C-dimension two by the forced canonical presentation.  Hence D^vee requires exactly two A-generators.
Qed.

Corollary dual_annihilator_has_five_relation_two_generator_presentation:
  Reducing the canonical presentation modulo (f,g) gives a right-exact A-presentation

    A^5 -> A^2 -> D^vee -> 0.

  No injectivity of the first map is asserted.
Qed.

Corollary dangerous_module_is_not_an_arbitrary_type_two_module:
  Any dangerous e=6 candidate must produce an annihilator module D satisfying simultaneously

    length(D)=length(A)=N>=32,
    dim_C Soc_A(D)=2,
    mu_A(D^vee)=2,
    D is noncyclic,
    D^vee ~= omega_B tensor_B A,
    dim_C Hom_A(D,A)>=N+20,

  where omega_B comes from the forced four-quadric type-two canonical presentation above.
Qed.

IMPORTANT_NONCONCLUSION:
  The canonical restriction does not by itself prove

    dim Hom_A(D,A)<N+20.

  It also does not force D to be cyclic.  No such statement is assumed.

  The q=4 height-three e<=5 cases, the q=4 height-two branch, homogeneous q<=3, and the unrestricted nonhomogeneous local deviation-two frontier remain untouched.

BOUNDARY:
  The e=6 endpoint is reduced to controlling Hom_A(D,A) for the specific noncyclic equal-length annihilator module whose dual is the restriction of the forced two-generated canonical module omega_B.

NEXT_BOUNDED_OBJECT:
  use the explicit 2-by-5 canonical presentation (equivalently, the transpose of the last differential in the forced Betti resolution) to test whether the two higher-degree cuts can ever produce Hom_A(D,A) of dimension at least N+20.  Stop if this requires a general classification of noncyclic annihilators in type-two Artin rings.