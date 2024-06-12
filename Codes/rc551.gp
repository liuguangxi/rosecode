{
N = 10^20; M = 11^20; K = 500;
P = 10^18+3;

vp = ve = vector(K);
for (k = 1, K,
    pk = sumformal(Mod(n, P)^k);
    vp[k] = subst(pk, n, M) - subst(pk, n, N - 1);
);
ve[1] = vp[1];
for (k = 2, K,
    t = Mod(0, P);
    for (i = 1, k - 1,
        t += (-1)^(i+1) * ve[i] * vp[k - i];
    );
    ve[k] = (vp[k] - t) / (-1)^(k+1) / Mod(k, P);
);
S = lift(vecsum(ve));
print(S);
}
