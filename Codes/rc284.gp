{
B = 10^50;
n = 0;
while (1,
    n += 2;
    s = 1;
    fordiv (n, d,
        p = d + 1;
        if (isprime(p), s *= p);
    );
    if (s > B, break);
);
printf("%d,%d\n", n, s);
}
