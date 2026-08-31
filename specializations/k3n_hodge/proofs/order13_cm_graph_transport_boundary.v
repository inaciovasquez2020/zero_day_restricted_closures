Standalone correction and sharpening of the order-13 / degree-six RM boundary.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let
    F_13 := Q(zeta_13 + zeta_13^(-1)),
    alpha_13 := zeta_13 + zeta_13^(-1).

  The previous file order13_degree6_rm_exact_boundary.v concerns the abstract
  maximal one-dimensional family whose very general member has

    End_Hdg(T)_Q = F_13,
    rho = 4,
    rank_Q T = 18.

  It correctly records that van Geemen--Schuett do not provide an order-13
  Dickson/dihedral K3 family realizing alpha_13 by their Section 4.8 graph
  construction.

  There is, however, a different order-13 K3 surface carrying an explicit
  graph correspondence.  This file separates that special CM surface from
  the generic F_13-RM family.

ExternalResult UniqueOrder13NonSymplecticK3:
  Artebani--Sarti--Taki, following Kondo and Oguiso--Zhang, prove that the
  moduli space of pairs (X,sigma) with sigma a non-symplectic automorphism of
  order 13 is zero-dimensional and consists of one isomorphism class.

  One elliptic model is

    X_13 : y^2 = x^3 + t^5*x + t,

  with an order-13 automorphism

    sigma(x,y,t) = (zeta_13^5*x, zeta_13*y, zeta_13^2*t).

  The invariant lattice has rank 10; its orthogonal complement T(sigma) has
  rank 12.

Source:
  Michela Artebani, Alessandra Sarti, Shingo Taki,
  K3 surfaces with non-symplectic automorphisms of prime order,
  Section 8 / Theorem 8.4 and Table 5.

Theorem order13_special_surface_has_transcendental_rank12:
  For X_13,

    rank_Q T(X_13) = 12,
    rho(X_13) = 10.

Proof:
  For a non-symplectic automorphism of order 13, T(X_13) is a nonzero module
  over Q(zeta_13), whose Q-degree is phi(13)=12.  Thus rank_Q T is a positive
  multiple of 12.

  Since T(X_13) is contained in T(sigma), and rank T(sigma)=12, one obtains

    rank_Q T(X_13)=12.

  Hence rho=22-12=10.
Qed.

Theorem order13_special_surface_is_CM_by_Qzeta13:
  The Hodge endomorphism field of T(X_13)_Q is

    End_Hdg(T(X_13)_Q) = Q(zeta_13).

Proof:
  The automorphism sigma induces the faithful Q(zeta_13)-action on T.
  The field Q(zeta_13) already has degree 12, equal to dim_Q T.
  A Hodge endomorphism field containing it cannot have larger degree while
  acting faithfully on this 12-dimensional simple K3-type Hodge structure.
Qed.

Define the algebraic correspondence

  C_13_CM := Graph(sigma) + Graph(sigma^(-1))

in CH^2(X_13 x X_13)_Q.

Theorem order13_special_graph_realizes_alpha13:
  On T(X_13)_Q, the action induced by C_13_CM is multiplication by

    alpha_13 = zeta_13 + zeta_13^(-1).

Proof:
  Graph(sigma) acts by sigma^*, and Graph(sigma^(-1)) acts by
  (sigma^(-1))^*.  On the Q(zeta_13)-module T, these are multiplication by
  zeta_13 and zeta_13^(-1), respectively, after fixing the primitive
  eigenvalue convention.  Their sum is multiplication by alpha_13.
Qed.

Corollary order13_generator_exists_algebraically_at_a_CM_point:
  There exists an explicit projective K3 surface on which the primitive
  generator alpha_13 of F_13 is induced by an algebraic codimension-two
  correspondence.

  Thus the order-13 obstruction is NOT the nonexistence of an algebraic
  alpha_13 graph correspondence anywhere in K3 geometry.
Qed.

Theorem special_CM_graph_does_not_close_generic_F13_RM_family:
  The preceding graph correspondence does not by itself prove algebraicity of
  alpha_13 on the generic maximal F_13-RM family.

Reason:
  The two Hodge-theoretic situations have different generic rank data:

    isolated order-13 CM surface:
      rho = 10,
      rank T = 12,
      End_Hdg(T) = Q(zeta_13) (CM, degree 12);

    maximal F_13-RM family:
      rho = 4,
      rank T = 18,
      End_Hdg(T) = F_13 (totally real, degree 6) very generally.

  No cited theorem identifies the isolated order-13 surface with a fiber of
  the specific maximal F_13-RM family together with a compatible extension of
  the alpha_13 correspondence.

  Even if such a specialization were exhibited, algebraicity of a Hodge class
  on one special fiber does not automatically imply algebraicity of its flat
  continuation on the generic fiber.  That implication is the content of a
  variational-Hodge type statement and is not available here without further
  hypotheses.
Qed.

Theorem order13_graph_cannot_deform_as_an_order13_automorphism_graph:
  The correspondence C_13_CM cannot be spread along a positive-dimensional
  family merely by deforming the pair (X_13,sigma) while retaining an order-13
  non-symplectic automorphism.

Proof:
  The moduli space of order-13 non-symplectic pairs is zero-dimensional.
  Hence there is no positive-dimensional deformation of the pair carrying the
  same order-13 automorphism structure.
Qed.

ExternalBoundary VariationalHodgeTransport:
  Grothendieck's variational Hodge conjecture predicts that an algebraic cycle
  class on one fiber whose cohomology class extends flatly as a Hodge class
  should remain algebraic on the other fibers.  This is not a general theorem
  for codimension-two cycles on self-products of arbitrary K3 families.

  Special semiregularity results prove variational Hodge statements only under
  additional hypotheses not established for C_13_CM here.

Sources:
  Grothendieck, variational Hodge conjecture.
  Dan--Kaur, Semi-regular varieties and variational Hodge conjecture.

Corollary corrected_order13_first_missing_object:
  The first missing object for the generic maximal F_13-RM family is now
  sharpened to one of the following equivalent-strength targets:

    (A) a family-level algebraic correspondence whose generic action on T is
        multiplication by a primitive generator of F_13;

    (B) an algebraic correspondence on the generic F_13-RM K3 surface inducing
        alpha_13;

    (C) a valid deformation/spread theorem carrying an algebraic alpha_13
        correspondence from a compatible special fiber to the generic fiber.

  Merely exhibiting Graph(sigma)+Graph(sigma^(-1)) on the isolated CM surface
  does not satisfy (A), (B), or (C).
Qed.

Boundary:
  this file corrects only the interpretation of the order-13 graph boundary
  it does NOT claim the isolated CM surface lies on the chosen maximal RM curve
  it does NOT claim variational Hodge transport
  it does NOT close rational degree-four Hodge algebraicity for generic F_13 RM
  the special CM graph correspondence is algebraic and explicit
  no integral Hodge conjecture is claimed
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
