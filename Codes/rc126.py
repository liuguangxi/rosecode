from math import comb
from fractions import Fraction
from functools import lru_cache

N = 50
EXACT_SWAPS = 20

# We only need t_min values that are reachable in exactly 20 swaps:
# t_min <= 20 and t_min ≡ 20 (mod 2)  => t_min even, <= 20
# And we need at least 30 moved students; with t_min swaps you can move at most 2*t_min,
# so we must have t_min >= 15. Therefore t_min ∈ {16, 18, 20}.
TMIN_VALUES = (16, 18, 20)

# Precompute factorials up to 50
fact = [1] * (N + 1)
for i in range(2, N + 1):
    fact[i] = fact[i - 1] * i

def poly_mul(a, b, limit):
    """Multiply polynomials a(x), b(x) with Fraction coefficients, truncate to degree <= limit."""
    res = [Fraction(0) for _ in range(limit + 1)]
    for i, ai in enumerate(a):
        if ai == 0:
            continue
        max_j = limit - i
        for j in range(0, min(len(b) - 1, max_j) + 1):
            bj = b[j]
            if bj != 0:
                res[i + j] += ai * bj
    return res

@lru_cache(maxsize=None)
def count_perm_on_M_with_k_cycles_all_ge2(M, k):
    """
    Number of permutations on M labeled elements that decompose into exactly k cycles,
    with all cycle lengths >= 2 (i.e., no fixed points).

    Uses EGF:
      SET_k(CYC_{>=2})  =>  (1/k!) * (sum_{i>=2} x^i/i)^k
    Count = M! * [x^M] (...) .
    """
    if M < 0 or k < 0:
        return 0
    if M == 0:
        return 1 if k == 0 else 0
    if k == 0:
        return 0  # can't cover positive M without cycles
    if 2 * k > M:
        return 0  # each cycle has length at least 2

    # Build P(x) = sum_{i=2..M} x^i / i
    P = [Fraction(0) for _ in range(M + 1)]
    for i in range(2, M + 1):
        P[i] = Fraction(1, i)

    # Compute P(x)^k (truncated to degree M)
    poly = [Fraction(0) for _ in range(M + 1)]
    poly[0] = Fraction(1, 1)
    for _ in range(k):
        poly = poly_mul(poly, P, M)

    coeff = poly[M]  # Fraction
    val = fact[M] * coeff / fact[k]  # should be an integer Fraction
    return val.numerator // val.denominator

def total_queue_options():
    total = 0
    breakdown = {}  # optional: count per t_min
    for tmin in TMIN_VALUES:
        subtot = 0
        # With tmin swaps, moved M can range from 0..2*tmin, but we need M >= 30
        for M in range(30, 2 * tmin + 1):
            k = M - tmin  # cycles among moved elements
            moved_perm_count = count_perm_on_M_with_k_cycles_all_ge2(M, k)
            if moved_perm_count == 0:
                continue
            subtot += comb(N, M) * moved_perm_count
        breakdown[tmin] = subtot
        total += subtot
    return total, breakdown

if __name__ == "__main__":
    total, breakdown = total_queue_options()
    print("Breakdown by t_min (minimum swaps):")
    for tmin in sorted(breakdown):
        print(f"  t_min = {tmin}: {breakdown[tmin]}")
    print(total)
