{
K = 26;
pxorq = 2^K-1; pmin = 2^K; qmax = 2^(K+1)-1;
count = 0;
firstp = firstq = 0;
for (p = pmin, qmax - 1,
    q = bitxor(pxorq, p);
    if (q <= p, break);
    if ((isprime(p) && issquare(q)) || (isprime(q) && issquare(p)),
        count++;
        printf("p = %d, q = %d\n", p, q);
        if (firstp == 0 && firstq == 0, firstp = p; firstq = q);
    );
);
printf("%d,%d,%d\n", count, firstp, firstq);
}
