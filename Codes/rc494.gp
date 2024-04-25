/*
(x^4 + y^4 + z^4)^2 = 2*(x^8 + y^8 + z^8) =>
(-x^2 + y^2 + z^2) * (x^2 + y^2 - z^2) * (x^2 - y^2 + z^2) * (x^2 + y^2 + z^2) = 0
0 < x < y < z and (x, y, z) coprime =>
x^2 + y^2 = z^2 =>
(x, y, z) = (n^2-m^2, 2*m*n, n^2+m^2),
where 0 < m < n and gcd(m, n) = 1 and (n - m) mod 2 = 1
*/


{
N = 123456789;
s = 0;
mmax = sqrtint(N \ 2);
for (m = 1, mmax,
    nmax = sqrtint(N - m^2);
    forstep (n = m + 1, nmax, 2,
        if (gcd(m, n) == 1, s++);
    );
);
print(s);
}
