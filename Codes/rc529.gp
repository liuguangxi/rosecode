s1(n) = n * (n + 1) / 2;


{
N = 25000000;

mmax = sqrtint(N);
nmax = sqrtint(2 * N);
v = List();
for (m = 1, mmax,
    if (m % 100 == 0, print("m = ", m));
    for (n = 1, nmax,
        if (2*m^2 + 6*n*m + n^2 > 6*N, break);
        if (gcd(m, n) > 1, next);
        a = -2*m^2 + 4*m*n + n^2;
        b = 2*m^2 + 2*m*n - n^2;
        c = 2*m^2 + n^2;
        g = gcd([a, b, c]);
        sol = vecsort(abs([a, b, c])/g);
        if (vecsum(sol) > N, next);
        if (sol[1] + sol[2] <= sol[3], next);
        listput(v, sol);
    );
);
print("#(List v) = ", #v);
v = Set(v); lenv = #v;
print("#(Set v) = ", lenv);

count = 0; sump = 0;
for (i = 1, lenv,
    p = vecsum(v[i]);
    count += N \ p;
    sump += p * s1(N \ p);
);
printf("%d,%d\n", count, sump);    \\ 33285999,427424790369497
}
