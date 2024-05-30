/*
length(seq) = N (N >= 2)
find vector c of length K (k >= 1) s.t.
seq(n) = sum(i = 1, K, c(i) * seq(n - i)), for K < n <= N
*/
find_linear_recurrence(seq) = {
    my(N, d, m, cs, bs, inv_bef, dif, cs_dup, r);
    N = #seq;
    if (N < 2, print("Input sequence too short"); return);

    d = 0; m = 0;
    cs = bs = vector(N + 1); cs[1] = bs[1] = seq[1]^0;
    inv_bef = seq[1]^0;
    for (i = 0, N - 1,
        m++;
        dif = seq[i + 1] + sum(j = 1, d, cs[j + 1] * seq[i - j + 1]);
        if (dif != 0,
            cs_dup = cs; r = dif * inv_bef;
            for (j = m, N - 1, cs[j + 1] -= r * bs[j - m + 1]);
            if (2 * d <= i,
                d = i + 1 - d; m = 0; bs = cs_dup; inv_bef = 1 / dif;
            );
        );
    );
    if (d >= ceil(N / 2), print("Warning: result may be WRONG"));
    return(-cs[2..d+1]);
}


/*
length(c) = length(seq) = K (K >= 1)
seq(n) = sum(i = 1, K, c(i) * seq(n - i)), for n > K
find seq(n), for n >= 1
*/
linear_recurrence(c, seq, n) = {
    my(K, Ks, fx, gx, cn, ret);
    K = #c; Ks = #seq;
    if (K == 0 || K != Ks || n <= 0, print("Input error"); return);

    fx = Pol(concat(-c[1]^0, c), 'x);
    gx = Mod('x, fx)^(n - 1);
    cn = Vec(lift(gx)); K = #cn;
    ret = sum(i = 1, K, cn[i] * seq[K + 1 - i]);
    return(ret);
}


{
M = 10^20;
B = 19; ND = 1919^19;

L = 3*B;
f = Mod(matrix(B, 2^B), M);
for (d = 1, B - 1, f[d+1, (1<<d)+1] = Mod(1, M));
sk = 0; vs = vector(L);
for (k = 2, L,
    print("k = ", k);
    ff = Mod(matrix(B, 2^B), M);
    for (d = 0, B - 1, for (u = 0, 2^B - 1,
        c = f[d+1, u+1];
        if (d >= 1,
            dd = d - 1;
            ff[dd+1, bitor(u, 1<<dd)+1] += c;
        );
        if (d < B - 1,
            dd = d + 1;
            ff[dd+1, bitor(u, 1<<dd)+1] += c;
        );
    ));
    f = ff;
    sk += vecsum(f[,2^B]);
    vs[k] = sk;
);

c = find_linear_recurrence(lift(vs));
F = linear_recurrence(Mod(c, M), vs[1..#c], ND);
printf("F(%d, %d) %% 10^20 = %d", B, ND, lift(F));    \\ 11600934945521248639
}
