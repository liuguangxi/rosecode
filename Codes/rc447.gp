{
K = 100; P = 1000000007;
m = matrix(K + 1, K + 1, i, j, Mod(j, P)^i);
v = vector(K + 1, i, Mod(1, P));
for (i = 2, K + 1, v[i] = v[i - 1] + Mod(i, P)^K);
h = v / m;
s = 0; n = Mod(10, P)^1000;
forstep (i = K + 1, 1, -1, s = (s + h[i]) * n);
print(lift(s));
}
