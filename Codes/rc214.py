import numpy as np
from itertools import combinations
from array import array

def classify_numbers(N: int):
    """
    S1: primes in [1..N]
    S2: semiprimes in [1..N] (Omega(n) == 2, counted with multiplicity)
    S3: all others in [1..N]
    """
    spf = list(range(N + 1))
    spf[0] = 0
    if N >= 1:
        spf[1] = 1

    # smallest prime factor sieve
    for i in range(2, int(N**0.5) + 1):
        if spf[i] == i:  # i is prime
            for j in range(i * i, N + 1, i):
                if spf[j] == j:
                    spf[j] = i

    primes, semiprimes, others = [], [], []
    for x in range(1, N + 1):
        if x >= 2 and spf[x] == x:
            primes.append(x)
        else:
            # Omega(x): number of prime factors with multiplicity
            t = x
            omega = 0
            while t > 1:
                p = spf[t]
                omega += 1
                t //= p
                if omega > 2:
                    break
            if omega == 2:
                semiprimes.append(x)
            else:
                others.append(x)

    return primes, semiprimes, others


def compute_AB_prefix_for_sum(s: int, A_counts: np.ndarray, B_counts: np.ndarray, N: int):
    """
    AB_prefix[c] = # of (A,B) with:
      sum(A)=sum(B)=s,
      min(A) < min(B) < c
    """
    A_row = A_counts[s].astype(np.uint64)
    B_row = B_counts[s].astype(np.uint64)

    # A_less[b] = sum_{a < b} A_row[a]
    A_less = np.empty(N + 1, dtype=np.uint64)
    A_less[0] = 0
    A_cum = np.cumsum(A_row, dtype=np.uint64)
    A_less[1:] = A_cum[:-1]

    prod = B_row * A_less
    cumsum_prod = np.cumsum(prod, dtype=np.uint64)

    # AB_prefix[c] = sum_{b < c} prod[b]  => AB_prefix[1:] = cumsum_prod
    AB_prefix = np.zeros(N + 2, dtype=np.uint64)
    AB_prefix[1:] = cumsum_prod
    return AB_prefix


def contributions_for_sum(arr: array, AB_prefix: np.ndarray):
    """
    arr holds packed 4-sets from S3 with the same sum:
      arr = [a,b,c,d, a,b,c,d, ...] where a<b<c<d
    Count solutions contributed by this sum:
      choose (A,B) with min(A)<min(B)<min(C),
      and ordered (C,D) disjoint with min(C)<min(D).
    """
    k = len(arr) // 4
    if k < 2:
        return 0

    # element_bits[x] is a bitset (python int) marking which S3-sets contain x
    element_bits = {}

    # Because we built buckets from combinations in lex order, within a bucket
    # the first element (min) is nondecreasing, so we can find min-groups in one pass.
    mins = []
    gstart = []
    gend = []
    gmask = []
    gsize = []

    curr_min = None
    curr_start = 0
    curr_mask = 0

    # Pass 1: build element_bits and min-groups with their masks
    for idx in range(k):
        base = idx * 4
        a = arr[base]
        b = arr[base + 1]
        c = arr[base + 2]
        d = arr[base + 3]

        bit = 1 << idx  # compute once per set

        element_bits[a] = element_bits.get(a, 0) | bit
        element_bits[b] = element_bits.get(b, 0) | bit
        element_bits[c] = element_bits.get(c, 0) | bit
        element_bits[d] = element_bits.get(d, 0) | bit

        if a != curr_min:
            if curr_min is not None:
                mins.append(curr_min)
                gstart.append(curr_start)
                gend.append(idx)
                gmask.append(curr_mask)
                gsize.append(idx - curr_start)
            curr_min = a
            curr_start = idx
            curr_mask = bit
        else:
            curr_mask |= bit

    # flush last group
    if curr_min is not None:
        mins.append(curr_min)
        gstart.append(curr_start)
        gend.append(k)
        gmask.append(curr_mask)
        gsize.append(k - curr_start)

    g = len(mins)

    # suffix_or[i] = OR of group masks from i..end
    # suffix_cnt[i] = total #sets from i..end
    suffix_or = [0] * (g + 1)
    suffix_cnt = [0] * (g + 1)
    for i in range(g - 1, -1, -1):
        suffix_or[i] = suffix_or[i + 1] | gmask[i]
        suffix_cnt[i] = suffix_cnt[i + 1] + gsize[i]

    total = 0

    # Pass 2: for each min-group i, count ordered disjoint pairs (C in group i, D in later groups)
    for i in range(g):
        later_count = suffix_cnt[i + 1]
        if later_count == 0:
            continue

        cm = mins[i]
        AB = int(AB_prefix[cm])  # # (A,B) with min(A)<min(B)<cm
        if AB == 0:
            continue

        later_mask = suffix_or[i + 1]
        pair_count = 0

        for idx in range(gstart[i], gend[i]):
            base = idx * 4
            a = arr[base]
            b = arr[base + 1]
            c = arr[base + 2]
            d = arr[base + 3]

            # sets in later_mask that intersect this C-set:
            overlap = ((element_bits[a] | element_bits[b] | element_bits[c] | element_bits[d]) & later_mask).bit_count()

            # disjoint Ds among later sets:
            pair_count += later_count - overlap

        total += AB * pair_count

    return total


def count_solutions(N: int = 256) -> int:
    primes, semiprimes, others = classify_numbers(N)

    MAXSUM = 4 * N

    # Count A and B 4-sets by (sum, min)
    A_counts = np.zeros((MAXSUM + 1, N + 1), dtype=np.uint32)
    B_counts = np.zeros((MAXSUM + 1, N + 1), dtype=np.uint32)

    for a, b, c, d in combinations(primes, 4):
        A_counts[a + b + c + d, a] += 1

    for a, b, c, d in combinations(semiprimes, 4):
        B_counts[a + b + c + d, a] += 1

    # Buckets for S3 4-sets, stored compactly as uint16:
    # buckets[s] = [a,b,c,d,a,b,c,d,...] (all 4-sets in S3 summing to s)
    buckets = [array('H') for _ in range(MAXSUM + 1)]
    for a, b, c, d in combinations(others, 4):
        s = a + b + c + d
        arr = buckets[s]
        arr.append(a); arr.append(b); arr.append(c); arr.append(d)

    # Sum contributions over all sums
    total = 0
    for s in range(MAXSUM + 1):
        arr = buckets[s]
        if not arr:
            continue
        AB_prefix = compute_AB_prefix_for_sum(s, A_counts, B_counts, N)
        total += contributions_for_sum(arr, AB_prefix)

    return total


if __name__ == "__main__":
    ans = count_solutions(256)
    print(ans)
