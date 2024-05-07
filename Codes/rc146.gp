{
N = 10^8;
cnt = 0; sumz = 0; sums = 0;
mmax = sqrtint(3*N);
for (m = 1, mmax,
    if (m % 1000 == 0, print("m = ", m));
    nmax = min(floor(sqrt(3)*m), 3*N\m);
    for (n = m + 1, nmax,
        if (gcd(m, n) != 1, next);
        s = 2*m*n; r = 3*m^2 - n^2; z2 = 3*m^2 + n^2;
        g = gcd([s, r, z2]);
        s /= g; r /= g; z2 /= g;
        if ((s + r) % 2 == 1 || z2 % 2 == 1, s *= 2; r *= 2; z2 *= 2);
        z = z2 / 2;
        if (s < N,
            k = (N - 1) \ s; k2 = k * (k + 1) / 2;
            cnt += k; sumz += z * k2; sums += s * k2;
        );
    );
);
printf("%d,%d,%d\n", cnt, sumz, sums);
}
