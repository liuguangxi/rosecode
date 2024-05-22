{
N = 11;
S = [26, 22, 26, 22, 14, 16, 22, 26, 22, 24];
for (x1 = 1, N,
    ss = vector(N - 1, i, S[i] - x1);
    v = vector(N); v[1] = x1;
    for (x2 = 1, N,
        v[2] = x2;
        for (i = 3, N, v[i] = ss[i - 2] - v[i - 1]);
        if (v[2] + v[N] != ss[N - 1], next);
        if (Set(v) == [1..N], printf("%d\n", v));
    );
);
}
