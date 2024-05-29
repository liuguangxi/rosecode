def ilog2(n):
  return 0 if n <= 0 else n.bit_length() - 1

def nimber_lv(n):
  if n <= 1:
    return 0
  return ilog2(ilog2(n)) + 1

def nimber_combine(n, a, b):
  return (b << (1 << n)) | a

def nimber_split(n, a):
  t = 1 << n
  return a & ((1 << t) - 1), a >> t

def nimber_product_half(n, a):
  if n == 0:
    return a
  if a == 0:
    return 0
  lo, hi = nimber_split(n - 1, a)
  lo, hi = \
    nimber_product_half(n - 1, nimber_product_half(n - 1, hi)), \
    nimber_product_half(n - 1, hi ^ lo)
  return nimber_combine(n - 1, lo, hi)

def nimber_square(a):
  if a <= 1:
    return a
  lv = nimber_lv(a)
  lo, hi = nimber_split(lv - 1, a)
  lo = nimber_square(lo)
  hi = nimber_square(hi)
  lo = nimber_product_half(lv - 1, hi) ^ lo
  return nimber_combine(lv - 1, lo, hi)

def nimber_product(a, b):
  if a == b:
    return nimber_square(a)

  if a < b:
    a, b = b, a

  if a <= 1:
    return a & b

  lv_a = nimber_lv(a)
  lv_b = nimber_lv(b)

  a_lo, a_hi = nimber_split(lv_a - 1, a)
  if lv_a > lv_b:
    hi = nimber_product(a_hi, b)
    lo = nimber_product(a_lo, b)
    return nimber_combine(lv_a - 1, lo, hi)

  b_lo, b_hi = nimber_split(lv_a - 1, b)
  w0 = nimber_product(a_lo, b_lo)
  w1 = nimber_product(a_lo ^ a_hi, b_lo ^ b_hi)
  w2 = nimber_product_half(lv_a - 1, nimber_product(a_hi, b_hi))
  return nimber_combine(lv_a - 1, w0 ^ w2, w0 ^ w1)

def nimber_mul(a, b):
  return nimber_product(a, b)

def nimber_sqrt(n):
  if n <= 1:
    return n
  lv = nimber_lv(n)
  lo, hi = nimber_split(lv - 1, n)
  lo = nimber_sqrt(nimber_product_half(lv - 1, hi) ^ lo)
  hi = nimber_sqrt(hi)
  return nimber_combine(lv - 1, lo, hi)

def nimber_inv(n):
  """
  Since (hi + lo) * c + hi * d = 0 and hi * H * c + lo * d = 0,
    c = hi * (1 / (hi * hi * H + lo * (hi + lo))) and
    d = (hi + lo) * (1 / (hi * hi * H + lo * (hi + lo))).
  """
  if n <= 1:
    return n
  lv = nimber_lv(n)
  lo, hi = nimber_split(lv - 1, n)

  t = nimber_product(lo ^ hi, lo)
  t ^= nimber_product_half(lv - 1, nimber_square(hi))
  t = nimber_inv(t)

  lo = nimber_product(lo ^ hi, t)
  hi = nimber_product(hi, t)
  return nimber_combine(lv - 1, lo, hi)

def nimber_pow(base, e):
  ret = 1
  while e:
    if e & 1:
      ret = nimber_mul(ret, base)
    e >>= 1
    if not e:
      break
    base = nimber_square(base)
  return ret

class Nimber():
  def __init__(self, n):
    if isinstance(n, (int)):
      self.n = n
    elif isinstance(n, Nimber):
      self.n = n.n
    else:
      raise ValueError("Invalid value.")

  def __trunc__(self):
    return self.n

  def __add__(self, rhs):
    if isinstance(rhs, (int)):
      return Nimber(self.n ^ rhs)
    else:
      return Nimber(self.n ^ rhs.n)

  def __radd__(self, lhs):
    return self + lhs

  def __sub__(self, rhs):
    return self + rhs

  def __rsub__(self, lhs):
    return lhs + self

  def __mul__(self, rhs):
    if isinstance(rhs, (int)):
      return Nimber(nimber_mul(self.n, rhs))
    else:
      return Nimber(nimber_mul(self.n, rhs.n))

  def __rmul__(self, lhs):
    return self * lhs

  def __pow__(self, rhs):
    return Nimber(nimber_pow(self.n, rhs))

  def __str__(self):
    return str(self.n)

  def __repr__(self):
    return "Nimber(%d)" % self.n

  def __truediv__(self, rhs):
    if isinstance(rhs, (int)):
      return self * Nimber(nimber_inv(rhs))
    else:
      return self * Nimber(nimber_inv(rhs.n))

  def __rdiv__(self, lhs):
    return Nimber(lhs) / self

  def __lt__(self, rhs):
    if isinstance(rhs, (int)):
      return self.n < rhs
    else:
      return self.n < rhs.n

  def __eq__(self, rhs):
    if isinstance(rhs, (int)):
      return self.n == rhs
    else:
      return self.n == rhs.n

  def sqrt(self):
    return Nimber(nimber_sqrt(self.n))

  @staticmethod
  def _solve_quad(c):
    if c <= 1:
      return c * 2
    lv = nimber_lv(c)
    s = 1 << (lv - 1)
    f = 1 << (s - 1)
    lo, hi = nimber_split(lv - 1, c)
    if f & hi:
      return (f << (s + 1)) | Nimber._solve_quad(c ^ (f << s))
    x1 = Nimber._solve_quad(hi)
    lo ^= nimber_product_half(lv - 1, nimber_square(x1))
    x0 = Nimber._solve_quad(lo)
    return nimber_combine(lv - 1, x0, x1)

  @staticmethod
  def solve_quad(a, b, c):
    if int(a) == 0:
      raise ValueError("a should be nonzero.")

    a, b, c = map(Nimber, [a, b, c])
    b /= a
    c /= a

    if b == 0:
      x1 = c.sqrt()
    else:
      x1 = Nimber(Nimber._solve_quad(int(c / b ** 2))) * b

    x2 = x1 + b
    if x1 > x2:
      x1, x2 = x2, x1
    return x1, x2

# problem 311
# 1061,50205,57082,2917995060,1236498,5124681407284001
# 0.194 sec.
def prob311():
  ABC = [
    [1881, 1923, 1938],
    [6273, 2935220086, 2831770815],
    [6273, 12997147727796204837, 11460394964710426743]
  ]
  ans = []
  for a, b, c in ABC:
    x, y = Nimber.solve_quad(a, b, c)
    ans.append(x)
    ans.append(y)
  print(",".join(map(str, ans)))

prob311()
