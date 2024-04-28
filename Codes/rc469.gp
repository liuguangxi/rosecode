dfs(k, s, xrest, xmin) = {
    my(snew);
    for (x = xmin, xrest\2,
        V[k] = x; dfs(k + 1, lcm(s, x), xrest - x, x);
    );
    V[k] = xrest; snew = lcm(s, xrest);
    if (snew > MaxOrder,
        MaxOrder = snew; MaxPart = V[1..k];
        printf("%d  ", MaxOrder);
        for (i = 1, k - 1, printf("%d,", MaxPart[i])); printf("%d\n", MaxPart[k]);
    );
}


{
N = 85;
V = vector(N); MaxOrder = 0; MaxPart = [];
dfs(1, 1, N, 1);
perm = vector(N); k = 0;
for (i = 1, #MaxPart,
    c = MaxPart[i];
    for (j = k+1, k+c-1, perm[j] = j+1); perm[k+c] = k+1;
    k += c;
);
idx = permtonum(perm);
printf("%d,%d\n", MaxOrder, idx%10^9);
}
