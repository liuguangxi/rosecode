/*
p = a + b, q = b - a, 0 < a <= b <= c, p > c
16*A^2 = (p+c)*(p-c) * (c+q)*(c-q)
(p+c)*(p-c) * (c+q)*(c-q) = 4*a*b
*/


{
count = 0; suma = sumb = sumc = 0;

for (A = 10000000, 10001000,
    found = 0;
    d = divisors(16*A^2); ld = #d;
    for (i = 1, ld,
        x = d[i];    \\ (p+c)*(p-c)
        y = 16*A^2/x;    \\ (c+q)*(c-q)
        if ((x + y) % 4 != 0, next);
        r = (x + y) / 4;    \\ a*b
        for (j = 1, ld,
            psubc = d[j];
            if (psubc^2 >= x, break);
            if (x % psubc != 0, next);
            paddc = x / psubc;
            if ((psubc + paddc) % 2 != 0, next);
            p = (paddc + psubc) / 2;
            c = (paddc - psubc) / 2;
            delta = p^2 - 4*r;
            if (delta < 0, next);
            if (issquare(delta) == 0, next);
            delta_sqrt = sqrtint(delta);
            if ((p + delta_sqrt) % 2 != 0, next);
            a = (p - delta_sqrt) / 2;
            b = (p + delta_sqrt) / 2;
            if (b <= c,
                count++; suma += a; sumb += b; sumc += c;
                printf("%d  %d  %d  -> %d\n", a, b, c, A);
            );
        );
    );
);
printf("%d,%d,%d,%d\n", count, suma, sumb, sumc);
}
