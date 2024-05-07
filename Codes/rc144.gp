/*
a = 1, 2, 3, 5, 8, 3, 11, 14, 25, 39, 64, 25, 89, 114, 203, 317, 520, 203, 723, 926, ... =>
a[1]  = 1
a[2]  = 2
a[3]  = a[2]  + a[1]
a[4]  = a[3]  + a[2]
a[5]  = a[4]  + a[3]
a[6]  = a[5]  - a[4]    !
a[7]  = a[6]  + a[5]
a[8]  = a[7]  + a[6]
a[9]  = a[8]  + a[7]
a[10] = a[9]  + a[8]
a[11] = a[10] + a[9]
a[12] = a[11] - a[10]    !
a[13] = a[12] + a[11]
a[14] = a[13] + a[12]
a[15] = a[14] + a[13]
a[16] = a[15] + a[14]
a[17] = a[16] + a[15]
a[18] = a[17] - a[16]    !
a[19] = a[18] + a[17]
a[20] = a[19] + a[18]
*/


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
a = vector(50);
a[1] = 1; a[2] = 2;
for (i = 3, 50, a[i] = if (i % 6 == 0, a[i - 1] - a[i - 2], a[i - 1] + a[i - 2]));

N = 10^100; M = 10^9;
c = find_linear_recurrence(a);
ans = lift(linear_recurrence(Mod(c, M), Mod(a[1..#c], M), N));
print(ans);
}
