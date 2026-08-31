#!/usr/bin/env python3
"""Exact tangent-space checks for concrete six-generator deviation-two families.

Family A, for a in {4,5}:

  I_a = (x^a, y^a, z^a, w^a, x*y + z*w, x*z + y*w).

Family B, for a in {14,16}:

  J_a = (x^2, y^2, z^2, x*y + z*w, x*z + y*w, w^a).

The second family is the first maximal-quadratic-count shape left after the
quadratic-generator reduction: five quadratic minimal generators plus one
higher-degree generator, with lengths already above the N>=32 frontier.

For every tested member the verifier checks, over QQ:
  * all six displayed generators are minimal;
  * the claimed finite length;
  * dim Soc = 4, hence non-Gorenstein;
  * using a Groebner basis, standard S-pair/Schreyer syzygies, and exact
    rational linear algebra, dim Hom_P(I,A) = 4*length(A);
  * therefore the order-13 necessary gate t(A) <= N-20 fails strongly.

No claim is made outside the explicitly tested parameters, nor is
smoothability inferred from t=4N.
"""

from __future__ import annotations

import itertools
from functools import lru_cache

import sympy as sp

x, y, z, w = sp.symbols("x y z w")
VARS = (x, y, z, w)


def monomial(exp, gens=VARS):
    out = sp.Integer(1)
    for var, power in zip(gens, exp):
        out *= var ** power
    return out


def standard_monomials(G: sp.GroebnerBasis):
    leading = [tuple(p.LM(order=G.order).exponents) for p in G.polys]
    n = len(G.gens)
    bounds = []
    for i in range(n):
        pure = [
            e[i]
            for e in leading
            if e[i] > 0 and all(e[j] == 0 for j in range(n) if j != i)
        ]
        if not pure:
            raise AssertionError(f"no pure-power leading monomial for variable {i}")
        bounds.append(min(pure))

    mons = [
        e
        for e in itertools.product(*[range(b) for b in bounds])
        if not any(all(e[i] >= lm[i] for i in range(n)) for lm in leading)
    ]
    mons.sort(key=lambda e: (sum(e), e))
    return mons


def schreyer_pair_syzygies(G: sp.GroebnerBasis):
    """Return standard S-pair syzygies on the Groebner basis G.

    By Schreyer's theorem, these generate the first syzygy module of G.
    """
    r = len(G.polys)
    gens = G.gens
    exprs = [p.as_expr() for p in G.polys]
    lms = [tuple(p.LM(order=G.order).exponents) for p in G.polys]
    lcs = [p.LC(order=G.order) for p in G.polys]
    syzygies = []

    for i in range(r):
        for j in range(i + 1, r):
            lcm = tuple(max(lms[i][k], lms[j][k]) for k in range(len(gens)))
            ci = monomial(tuple(lcm[k] - lms[i][k] for k in range(len(gens))), gens) / lcs[i]
            cj = monomial(tuple(lcm[k] - lms[j][k] for k in range(len(gens))), gens) / lcs[j]
            s_poly = sp.expand(ci * exprs[i] - cj * exprs[j])

            if s_poly == 0:
                quotients = [sp.Integer(0)] * r
            else:
                quotients, remainder = G.reduce(s_poly)
                if sp.expand(remainder) != 0:
                    raise AssertionError(f"nonzero S-pair remainder for pair {(i, j)}")
                quotients = list(quotients) + [sp.Integer(0)] * (r - len(quotients))

            syz = [-sp.expand(q) for q in quotients]
            syz[i] = sp.expand(syz[i] + ci)
            syz[j] = sp.expand(syz[j] - cj)

            check = sp.expand(sum(syz[k] * exprs[k] for k in range(r)))
            if check != 0:
                raise AssertionError(f"invalid syzygy for pair {(i, j)}")
            syzygies.append(syz)

    return syzygies


def analyze_generators(label: str, a: int, original, expected_N: int):
    for i, f in enumerate(original):
        H = sp.groebner(
            original[:i] + original[i + 1 :],
            *VARS,
            order="grevlex",
            domain=sp.QQ,
        )
        if sp.expand(H.reduce(f)[1]) == 0:
            raise AssertionError(f"generator {i} is redundant for {label}, a={a}")

    G = sp.groebner(original, *VARS, order="grevlex", domain=sp.QQ)
    mons = standard_monomials(G)
    index = {e: i for i, e in enumerate(mons)}
    N = len(mons)
    if N != expected_N:
        raise AssertionError(
            f"length mismatch for {label}, a={a}: got {N}, expected {expected_N}"
        )

    def nf_entries(expr):
        if expr == 0:
            return {}
        remainder = G.reduce(sp.expand(expr))[1]
        if remainder == 0:
            return {}
        p = sp.Poly(remainder, *VARS, domain=sp.QQ)
        return {index[e]: sp.Rational(c) for e, c in p.terms()}

    @lru_cache(maxsize=None)
    def mult_entries_cached(coeff_repr: str):
        coeff = sp.sympify(coeff_repr, locals={"x": x, "y": y, "z": z, "w": w})
        entries = {}
        for col, e in enumerate(mons):
            for row, value in nf_entries(coeff * monomial(e)).items():
                entries[(row, col)] = value
        return entries

    def mult_entries(coeff):
        return mult_entries_cached(str(sp.expand(coeff)))

    variable_matrices = [
        sp.MutableSparseMatrix(N, N, mult_entries(v)) for v in VARS
    ]
    socle_dim = len(sp.Matrix.vstack(*variable_matrices).nullspace())
    if socle_dim != 4:
        raise AssertionError(
            f"socle mismatch for {label}, a={a}: got {socle_dim}, expected 4"
        )

    syzygies = schreyer_pair_syzygies(G)
    r = len(G.polys)

    entries = {}
    row_offset = 0
    for syz in syzygies:
        for generator_index, coeff in enumerate(syz):
            if coeff == 0:
                continue
            for (row, col), value in mult_entries(coeff).items():
                pos = (row_offset + row, generator_index * N + col)
                entries[pos] = entries.get(pos, sp.Integer(0)) + value
        row_offset += N

    constraints = sp.MutableSparseMatrix(row_offset, r * N, entries)
    rank = constraints.rank()
    tangent_dim = r * N - rank

    if tangent_dim != 4 * N:
        raise AssertionError(
            f"tangent mismatch for {label}, a={a}: got {tangent_dim}, expected {4*N}"
        )
    if not tangent_dim > N - 20:
        raise AssertionError(
            f"order-13 tangent gate unexpectedly passed for {label}, a={a}"
        )

    return {
        "label": label,
        "a": a,
        "N": N,
        "socle": socle_dim,
        "gb_generators": r,
        "syzygies_checked": len(syzygies),
        "constraint_rank": rank,
        "tangent": tangent_dim,
        "gate": N - 20,
    }


def analyze_balanced(a: int):
    original = [x**a, y**a, z**a, w**a, x * y + z * w, x * z + y * w]
    return analyze_generators("balanced", a, original, (2 * a - 1) ** 2)


def analyze_five_quadratic(a: int):
    original = [x**2, y**2, z**2, x * y + z * w, x * z + y * w, w**a]
    return analyze_generators("five_quadratic", a, original, 2 * a + 5)


def main():
    rows = [analyze_balanced(a) for a in (4, 5)]
    rows += [analyze_five_quadratic(a) for a in (14, 16)]
    for row in rows:
        print(
            "ORDER13_DEVIATION2_FAMILY "
            f"kind={row['label']} a={row['a']} N={row['N']} "
            f"socle={row['socle']} gb={row['gb_generators']} "
            f"syzygies={row['syzygies_checked']} rank={row['constraint_rank']} "
            f"tangent={row['tangent']} gate={row['gate']} status=REJECTED"
        )
    print("ORDER13_DEVIATION2_SIX_GENERATOR_EXPLICIT_FAMILIES_REJECTED")


if __name__ == "__main__":
    main()
