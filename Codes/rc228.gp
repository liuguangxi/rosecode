{
PMAX = 180000;
NP = primepi(PMAX);
Pri = primes(NP);

\\ i = 2
for (j = 3, NP - 1,
    p1 = Pri[2]; p2 = Pri[j]; p3min = Pri[j + 1];
    n = sqrtint(p1 * p2 + p3min);
    if (n % 2 == 1, n++);
    while (1,
        p3 = n^2 - p1 * p2;
        if (p3 > PMAX, break);
        if (p3 > p2 && isprime(p3),
            if (issquare(p2 * p3 + p1) && issquare(p3 * p1 + p2),
                printf("%d,%d,%d\n", p1, p2, p3);
            );
        );
        n += 2;
    );
);

\\ i >= 3
for (i = 3, NP - 2,
    p1 = Pri[i];
    for (j = i + 1, NP - 1,
        p2 = Pri[j];
        p3min = Pri[j + 1];
        n = sqrtint(p1 * p2 + p3min);
        if (n % 2 == 1, n++);
        while (1,
            p3 = n^2 - p1 * p2;
            if (p3 > PMAX, break);
            if (p3 > p2 && isprime(p3),
                if (issquare(p2 * p3 + p1) && issquare(p3 * p1 + p2),
                    printf("%d,%d,%d\n", p1, p2, p3);
                );
            );
            n += 2;
        );
    );
);
}
