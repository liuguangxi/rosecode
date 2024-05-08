{
P = 42;
n1 = prod(i = 2, P/2, prime(i));
n2 = prod(i = P/2+1, P, prime(i));
N = 2*n1*n2;
T = sqrtint(2*N);
d1 = vecsort(concat(divisors(n1), 4*divisors(n1)));
d2 = divisors(n2);
ymax = 0; k2 = #d2;
for (k1 = 1, #d1,
    while (k2 > 0,
        y = d1[k1] * d2[k2];
        if (y > T, k2--, break);
    );
    if (k2 == 0, break);
    if (y > ymax, ymax = y; print("y = ", ymax));
);
x = 2*N/ymax;
a = (x-ymax+1)/2; b = (x+ymax-1)/2;
printf("%d,%d\n", a, b);
}
