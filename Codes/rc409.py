from itertools import count
from math import sqrt
from fractions import Fraction


def isqrt(n):
    x = int(sqrt(n*(1+1e-14)))
    while True:
        y = (x + n // x) >> 1
        if y >= x: return x
        x = y


def binomial_seq(n):
    size = n
    seq = [1] * (size + 1)
    s = 1
    for i in range(1, size + 1):
        s = s * (n + 1 - i) // i
        seq[i] = s
    return seq


def poly_mul(poly1, poly2):
    ret = [0] * (len(poly1) + len(poly2) - 1)
    for i in range(len(poly2)):
        if poly2[i] == 0:
            continue
        coef = poly2[i]
        for j in range(len(poly1)):
            ret[i + j] += coef * poly1[j]
    return ret


def interpolate(xs, ys):
    n = len(xs)
    cs = [0] * n
    for i in range(n):
        x = Fraction(xs[i])
        y = Fraction(ys[i])
        for j in range(i):
            y = (y - cs[j]) / (x - xs[j])
        cs[i] = y
    ret = [cs[-1]]
    for i in range(len(cs) - 2, -1, -1):
        ret = poly_mul(ret, [1, -xs[i]])
        ret[-1] += cs[i]
    return ret


def evaluate_poly(poly, x):
    ret = 0
    for i in range(len(poly)):
        ret = ret * x + poly[i]
    return ret


# Calculate sum(i = 1, n, pre[i] * i**k)
def solve(n, k):
    if (n, k) in memo: return memo[(n, k)]

    if n <= L:
        ret = 0
        for i in range(1, n + 1):
            if pre[i]: ret += i**k
        memo[(n, k)] = ret
        return ret

    ret = 2**k    # pre[1..2] = [0, 1] => sum(i = 1, 2, pre[i] * i**k) = 2**k

    v = (isqrt(1+8*(n-3))-1) // 2
    r = 1+(n-3)-v*(v+1)//2
    bins = binomial_seq(k)
    for e in range(0, k + 1):
        E = k - e
        if not E in poly_memo:
            xs = []
            ys = []
            for x in range(1, 2*E+3):
                xs.append(x + 1)
                ys.append((x*(x-1)//2+2)**E)
                if x >= 2: ys[-1] += ys[-2]
            poly = interpolate(xs, ys)
            poly_memo[E] = tuple(poly[::-1])
        poly = list(poly_memo[E])
        poly[0] -= evaluate_poly(poly[::-1], v + 1)
        t = 0
        for f, d in enumerate(poly):
            t -= d * solve(v, e + f)
        ret += bins[e] * t

    # sum(i = M+1, M+r, pre[i] * i**k) = sumi = 1, r, pre[i] * (i+M)**k
    # (i+M)**k = sum(e = 0, k, binomial(k,e)*i**k*M**(k-e)) =>
    # = sum(e = 0, k, binomial(k,e)*M**(k-e) * S(r, k))
    M = v*(v+1)//2+2
    for e in range(0, k + 1):
        ret += bins[e]*M**(k-e)*solve(r, e)
    memo[(n, k)] = ret
    return ret


def rc409(N):
    return solve(N, 0)


# Main
poly_memo = {}
memo = {}
L = 3000
pre = [0, 1]
for c in count(1):
    if len(pre) > L: break
    pre += pre[:c]
pre = [1] + pre[:L]

N = 10**18
CN = rc409(N)
print(f'C({N}) = {CN}')
