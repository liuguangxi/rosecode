from sympy.ntheory.primetest import is_square
from sympy.solvers.diophantine.diophantine import diop_DN


# Main
N = 1000
d = 0
x, y = 0, 0
for D in range(2, N):
    if not is_square(D):
        (x0, y0) = diop_DN(D, 4)[0]
        if y0 % 2 == 1: print(D, x0, y0)
        if y0 % 2 == 1 and y0 > y:
            x, y = x0, y0
            d = D

print(f'{x}^2-{d}*{y}^2')
