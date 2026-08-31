Standalone rank-geography theorem for projective K3 surfaces with totally real cubic Hodge endomorphism field.

This file is independent of ZeroDayClosure, required_classes.I,
ActuallyRequired, and inventory semantics.

Setup:
  Let S be a smooth complex projective K3 surface.
  Let
    T := T(S)_Q,
    E := End_Hdg(T),
    rho := rank NS(S).

  Assume E/Q is totally real cubic:
    [E:Q] = 3.

  Put
    m := dim_E T.

ExternalResult VanGeemenRealMultiplicationDimensionBound:
  For a simple Hodge structure of K3 type with totally real Hodge
  endomorphism field E, one has

    dim_E T >= 3.

  Equivalently, in the totally real case the parameter m is at least 3.

Sources:
  Bert van Geemen,
  Real multiplication on K3 surfaces and Kuga-Satake varieties,
  Lemma 3.2 / the real-multiplication period-domain construction.

  Eva Bayer-Fluckiger, Bert van Geemen, Matthias Schuett,
  K3 surfaces with real or complex multiplication,
  Theorem A and Lemma 11.1.

Theorem cubic_rm_transcendental_rank_is_multiple_of_three:
  rank_Q T = 3*m.

Proof:
  T is an E-vector space of dimension m and [E:Q]=3.
Qed.

Theorem cubic_rm_picard_rank_geography:
  The only possible Picard ranks are

    rho in {13, 10, 7, 4, 1}.

  More precisely,

    rho = 22 - 3*m

  with

    m in {3,4,5,6,7}.

Proof:
  For a K3 surface,

    rank H^2(S,Z) = 22,
    rank_Q T = 22-rho.

  By cubic_rm_transcendental_rank_is_multiple_of_three,

    22-rho = 3*m.

  VanGeemenRealMultiplicationDimensionBound gives m>=3.

  Since S is projective, rho>=1, so

    3*m = 22-rho <= 21,

  hence m<=7.

  Therefore m is one of 3,4,5,6,7 and the corresponding values of rho are

    13,10,7,4,1.
Qed.

ExternalResult CubicRMExistenceFamilies:
  Let E be any totally real cubic field and let m>=3 with 3*m<=21.
  Then there exists an (m-2)-dimensional family of complex projective K3
  surfaces whose very general member S has

    End_Hdg(T(S)_Q) ~= E,
    dim_E T(S)_Q = m.

Source:
  Eva Bayer-Fluckiger, Bert van Geemen, Matthias Schuett,
  K3 surfaces with real or complex multiplication,
  Theorem A / Theorem 12.2.

Corollary cubic_rm_rank_geography_is_realized:
  Every rank in

    {13,10,7,4,1}

  actually occurs for projective K3 surfaces with a prescribed totally real
  cubic Hodge endomorphism field E.

  The corresponding family dimensions are

    rho=13, m=3  -> dimension 1,
    rho=10, m=4  -> dimension 2,
    rho=7,  m=5  -> dimension 3,
    rho=4,  m=6  -> dimension 4,
    rho=1,  m=7  -> dimension 5.
Qed.

Corollary minimal_cubic_rm_family_is_a_curve:
  The smallest possible transcendental rank in the cubic-RM case is

    rank_Q T = 9,

  equivalently

    m=3,
    rho=13.

  The corresponding existence family is one-dimensional.

  Bayer-Fluckiger--van Geemen--Schuett note that the real-multiplication
  moduli in the m=3 case are Shimura curves.
Qed.

ExternalResult SixLineK3PicardRank:
  The standard family obtained from double covers of P^2 branched over six
  lines is a family of K3 surfaces of Picard rank at least 16; its general
  member has Picard rank 16.

Sources:
  Adrian Clingher, Andreas Malmendier, Tony Shaska,
  Six line configurations and string dualities.

  Ulrich Schlickewei,
  The Hodge conjecture for self-products of certain K3 surfaces.

Theorem six_line_kuga_satake_route_cannot_contain_cubic_rm:
  No K3 surface in the six-line double-cover family can have totally real
  cubic Hodge endomorphism field as its full Hodge endomorphism field.

Proof:
  Such a surface has rho>=16, hence

    rank_Q T = 22-rho <= 6.

  But cubic real multiplication requires

    rank_Q T = 3*m >= 9.

  Contradiction.
Qed.

Corollary schlickewei_geometric_kuga_satake_closure_is_disjoint_from_cubic_frontier:
  Schlickewei's geometric Kuga-Satake proof of the Hodge conjecture for
  self-products of six-line double-cover K3 surfaces does not settle the
  cubic real-multiplication frontier isolated on this branch.

  The obstruction is structural rather than a missing specialization:
  the relevant Picard/transcendental ranks are incompatible.
Qed.

Corollary picard16_kuga_satake_results_do_not_hit_cubic_rm:
  Any theorem restricted to projective K3 surfaces of Picard rank 16 has
  transcendental rank 6 and therefore cannot realize E as a totally real
  cubic full Hodge endomorphism field, since that would force m=2, contrary
  to the real-multiplication bound m>=3.
Qed.

First bounded geometric target:
  The first cubic-RM geometry worth attacking is therefore not a Picard-16
  Kuga-Satake family. It is the minimal

    m=3,
    rho=13,
    rank_Q T=9

  one-dimensional RM Shimura-curve case.

  On that locus, the remaining missing object from
  projective_k3_cubic_real_multiplication_exact_frontier.v is still:

    one algebraic codimension-two correspondence on S x S inducing one
    generator e in E\Q.

Boundary:
  this file does not construct that correspondence
  it does not infer algebraicity from the existence of the RM Shimura curve
  it only proves the exact Picard-rank geography and eliminates the standard
    Picard-16/six-line geometric Kuga-Satake route from the cubic problem
  no ZeroDayClosure semantics are used
  no required-class index is used
  this .v file is pseudo-formal mathematical documentation, not a Coq proof
