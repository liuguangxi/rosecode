{
a = 1033; b = 1553; c = 1973;

count = 0; sump = 0; sumq = 0; sumr = 0;
for (p = 1, c - 1,
    for (q = 1, a - 1,
        t = (c-p)*(a-q)/(p*q);
        tsum = numerator(t) + denominator(t);
        if (b % tsum == 0,
            r = b / tsum * numerator(t);
            count++; sump += p; sumq += q; sumr += r;
            printf("p = %d, q = %d, r = %d\n", p, q, r);
        );
    );
);
printf("%d,%d,%d,%d\n", count, sump, sumq, sumr);
}
