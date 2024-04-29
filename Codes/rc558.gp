/*
0 < z <= y <= x, x^2 − y^2 − z^2 − x*y − y*z − z*x = 0 =>
0 < m <= n, gcd(m, n) = 1, m^2 + m*n - n^2 > 0
[x, y, z] = [m^2 + m*n + n^2, -m^2 + m*n + n^2, m^2 + m*n - n^2]

T = 10^13 => 475444225496,967027710
*/


/*
c = #{n : n1 <= n <= n2, gcd(m, n) = 1}
s = Sum{m^2 + 3*n*m + n^2 : n1 <= n <= n2, gcd(m, n) = 1}
*/
fmn(m, n1, n2) = {
    my(s1(x) = x * (x + 1) / 2);
    my(s2(x) = x * (x + 1) * (2*x + 1) / 6);
    my(c = 0, s = 0, k1, k2, mud);
    fordiv (m, d,
        k1 = (n1 - 1) \ d; k2 = n2 \ d;
        mud = moebius(d);
        c += mud * (k2 - k1);
        s += mud * (m^2*(k2-k1) + 3*m*d*(s1(k2)-s1(k1)) + d^2*(s2(k2)-s2(k1)));
    );
    return([c, s]);
}


{
T = 10^13;

C = 0; S = 0;
mmax = sqrtint(T \ 3);
for (m = 1, mmax,
    if (m % 10000 == 0, print("m = ", m));
    nmax1 = floor((m + sqrt(5*m^2 - 1))/2);
    nmax2 = floor((sqrt(4*T-3*m^2) - m)/2);
    nmax = min(nmax1, nmax2);
    [c, s] = fmn(m, m, nmax);
    C += c; S += s;
);
printf("%d,%d\n", C, S % 10^9);
}
