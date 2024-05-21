/*
m, n, k is positive integers, n > m, (m+n) mod 2 = 1, gcd(m, n) = 1
a = k*(n^2-m^2), b = k*2*m*n, c = k*(n^2+m^2)
P = 2*k*n*(m+n), A = k^2*m*n*(n^2-m^2), A/P = k*m*(n-m)/2

F(m,n,k) = k*m*(n-m)/2 + u*(2*k*n*(m+n)-N)
dF/dm = 0 => u = (2*m-n)/(4*n)
dF/dn = 0 => u = -m/(4*m+8*n)
=> (2*m-n)/(4*n) = -m/(4*m+8*n) => n/m = 1+sqrt(2)
*/


{
N = 10^17;
ndivm = 1 + sqrt(2);
mmax = floor(sqrt(N/4));
r2max = 0;
for (m = 1, mmax,
    if (m % 10^6 == 0, print("m = ", m));
    n = round(m * ndivm);
    /* (m+n) % 2 == 1 && gcd(m, n) == 1 need not check */
    p0 = 2*n*(m+n); k = N \ p0; r2 = k*m*(n-m);
    if (r2 > r2max,
        r2max = r2;
        a = k*(n^2-m^2); b = k*2*m*n; c = k*(n^2+m^2);
        if (a > b, [a, b] = [b, a]);
        printf("(m, n, k) = (%d, %d, %d)\n", m, n, k);
        print("A/P = ", r2/2);
        printf("a = %d, b = %d, c = %d\n\n", a, b, c);
    );
);
printf("%d,%d,%d\n", a, b, c);
}
