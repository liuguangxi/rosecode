P(x) = x^19 + 6;


{
d = polresultant(P(X), P(X+1));
p = d;    \\ d is prime
g = znprimroot(p);
n0 = Mod(-6, p)^(1/19);
t = g^(eulerphi(p) / 19);
vn = vector(19, i, lift(n0 * t^(i-1)));
vn = vecsort(vn);
for (i = 1, 18,
    if (vn[i] + 1 == vn[i + 1], print(vn[i]));
);
}
