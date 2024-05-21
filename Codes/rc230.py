from itertools import *


w = 'anticonstitutionnellement'
s = set()
for k in range(len(w) + 1):
    print('k =', k)
    for x in combinations(w, k):
        t = ''.join(x)
        s.add(t)
print(len(s))
