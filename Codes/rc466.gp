/*
a^2 + b1^2 = 2*c1^2 =>
a = abs(m^2-n^2-2*m*n), b1 = m^2-n^2+2*m*n, c1 = m^2+n^2
where 0 < n < m, gcd(m, n) = 1, mod(m - n, 2) = 1
and special solution a = 1, b1 = 1, c1 = 1
*/


{
T = 10^7;
C1max = T \ 2;
Nmax = sqrtint(C1max \ 2);
cnt = 0; sa = 0; sb = 0;
for (n = 1, Nmax,
    forstep (m = n + 1, C1max, 2,
        c1 = m^2 + n^2;
        if (c1 > C1max, break);
        if (gcd(m, n) > 1, next);
        a = abs(m^2-n^2-2*m*n);
        b1 = m^2-n^2+2*m*n;
        cnt += 2;
        sa += a + b1;
        sb += 2*(b1 + a);
    );
);
cnt++; sa++; sb += 2;
printf("%d,%d,%d\n", cnt, sa, sb);
}
