/*
x = k * (2*n*m - n^2), y = k * (n^2 - m^2)
where 0 < m < n < 2*m and (m + n) mod 3 != 0 and gcd(m, n) = 1
s = x + y = k * (2*m*n - m^2)
*/


{
N = 10^7;
v = vector(N);
for (m = 1, sqrtint(N),
    for (n = m + 1, 2 * m - 1,
        s = m * (2 * n - m);
        if (s > N, break);
        if ((m + n) % 3 == 0 || gcd(m, n) != 1, next);
        forstep (ks = s, N, s, v[ks]++);
    );
);
t = 0; l = 0; d = 0;
for (i = 1, N,
    s = v[i];
    if (s > 0, t++);
    if (s >= d, l = i; d = s);
);
printf("%d,%d,%d\n", t, l, d);
}
