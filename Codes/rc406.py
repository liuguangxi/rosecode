from math import sqrt

def prob404():
  def isqrt(n):
    x = int(sqrt(n * (1 + 1e-14)))
    while True:
      y = (x + n // x) >> 1
      if y >= x:
        return x
      x = y
  
  def icbrt(n):
    if n <= 0:
      return 0

    x = int(n ** (1. / 3.) * (1 + 1e-12))
    while True:
      y = (2 * x + n // (x * x)) // 3
      if y >= x:
        return x
      x = y

  def prime_sieve(N):
    N += 1
    isp = [1] * N
    for i in range(2, N):
      if isp[i]:
        for j in range(i * i, N, i):
          isp[j] = 0
    return [p for p in range(2, N) if isp[p]]

  def moebius_sieve(N):
    N += 1
    ret = [1] * N
    for p in prime_sieve(N - 1):
      for i in range(p, N, p):
        ret[i] = -ret[i]
      for i in range(p * p, N, p * p):
        ret[i] = 0
    ret[0] = 0
    return ret

  N = 10 ** 25

  ans_c = 0
  ans_s = 0
  mu = moebius_sieve(icbrt(isqrt(N)))
  prev_M = -1
  for i in range(1, icbrt(isqrt(N)) + 1):
    if not mu[i]:
      continue
    M = N // i ** 6
    if M != prev_M:
      temp_s = 0
      v = int(M ** 0.200)
      s, c = 0, 0
      for j in range(1, v + 1):
        t = icbrt(M // j ** 2)
        k = t * (t + 1)
        s += j * j * k * k
        c += t
      w = int(icbrt(M // (v + 1) ** 2))
      temp_s += s // 4
      temp_s -= v * (v + 1) * (2 * v + 1) * (w * (w + 1)) ** 2 // 24
      c -= v * w
      s = 0
      for j in range(1, w + 1):
        t = isqrt(M // j ** 3)
        k = t * (t + 1) * (2 * t + 1)
        s += j * j * j * k
        c += t
      temp_s += s // 6
      prev_M = M
    ans_s += mu[i] * i ** 6 * temp_s
    ans_c += mu[i] * c

  print("%d,%d" % (ans_c, ans_s))

prob404()
