from itertools import combinations
from fractions import Fraction


w = list(range(26))
c = 0
s = 0
for x in combinations(w, 6):
    s += 1
    flg = True
    for i in range(5):
        if x[i] + 1 == x[i + 1]:
            flg = False
            break
    if flg:
        c += 1
print(Fraction(c, s))
