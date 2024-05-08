# n^2 - n*m - m^2 = 1 =>
# x^2 - 5*y^2 = 4, where x = 2*n-m, y = m


from sympy.solvers.diophantine.diophantine import diop_DN


# Main
B = 10**15
(p, q) = diop_DN(5, 1)[0]
sol = diop_DN(5, 4)

sol_mn = []
for x0, y0 in sol:
    print("Basic solution:", (x0, y0))
    if (x0 + y0) % 2 == 0:
        n, m = (x0 + y0) / 2, y0
        print("(n, m) =", (n, m))
        sol_mn.append((n, m))

    xn, yn = x0, y0
    while True:
        xn, yn = p * xn + 5*q * yn, q * xn + p * yn
        if (xn + yn) % 2 == 0:
            n, m = (xn + yn) / 2, yn
            if n >= B or m >= B: break
            print("(n, m) =", (n, m))
            sol_mn.append((n, m))

    print()

sol_mn.sort()
for nn, mm in sol_mn:
    print("n = %d, m = %d, n^2 + m^2 = %d" % (nn, mm, nn**2+mm**2))
