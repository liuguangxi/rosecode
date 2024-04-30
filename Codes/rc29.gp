
{
N = 2009;
pmax = sqrtnint(N, 3);

/*
v = vector(N);
for (p = 2, pmax,
    p3 = p^3;
    forstep (x = p3, N, p3, v[x] = 1);
);
s = vecsum(v);
*/

s = sum(p = 2, pmax, -moebius(p) * (N \ p^3));
print(s);
}
