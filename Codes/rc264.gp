{
N = 10^12;

count = 0; sumz = 0;

mmax = floor(N^(1/3));
for (m = 2, mmax,
    cutoff = floor(m * (sqrt(2) - 1));

    for (n = 1, cutoff,    \\ 2*m*n < m^2-n^2
        if ((m + n) % 2 == 1 && gcd(m, n) == 1,
            a = m^2 - n^2; b = 2*m*n; q = b * (m^2 + n^2);
            if (q > N, break);
            count++;
            sumz += a * b;
        );
    );

    forstep (n = m - 1, cutoff + 1, -1,    \\ 2*m*n > m^2-n^2
        if ((m + n) % 2 == 1 && gcd(m, n) == 1,
            a = m^2 - n^2; b = 2*m*n; q = a * (m^2 + n^2);
            if (q > N, break);
            count++;
            sumz += a * b;
        );
    );
);

printf("%d,%d\n", count, sumz);
}
