T(n) = n*(n+1)/2;


{
N = 400000;
K1 = 123456789101112;
K2 = 123456654321;

G = vector(N); G[1] = 1;
idxh = 2; idxt = 2; num = 2; len = 2;
while (idxt <= N,
    idxt_end = min(idxt + len - 1, N);
    for (i = idxt, idxt_end, G[i] = num);
    idxh++; num++; len = G[idxh]; idxt = idxt_end + 1;
);
G2 = G; for (i = 2, N, G2[i] += G2[i - 1]);

\\ m = G_K
s = 0;
for (i = 1, N,
    s += i * G[i];
    if (s >= K1, idx = i; break);
);
m = G2[idx] - (s - K1) \ idx;
printf("G(%d) = %d\n", K1, m);

\\ G_n = K2
\\ n = G(1) + G(2) + ... + G(K2 - 1) + 1
s = 0;
for (i = 1, N,
    s += i * G[i];
    if (s >= K2 - 1, idx = i; break);
);
n = 1 + sum(i = 2, idx, i * (T(G2[i]) - T(G2[i - 1])));
ds = s - (K2 - 1); idx1 = G2[idx];
q = ds \ idx; r = ds % idx;
n -= idx * (T(idx1) - T(idx1 - q));
n -= r * (idx1 - q);
n++;
printf("G(%d) = %d\n", n, K2);

printf("%d,%d\n", m, n);
}
