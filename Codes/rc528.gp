{
N = 1000;
count = 0; suma = 0; sumb = 0; sumc = 0;
for (a = 1, N, for (b = 1, N, for (c = 1, N,
    if (gcd([a, b, c]) > 1, next);
    t2 = (b^2 + c^2) * (b^2 + (a + c)^2);
    if (!issquare(t2), next);
    t = sqrtint(t2);
    if (t % (2 * b) == 0,
        r = t / (2 * b);
        count++; suma += a; sumb += b; sumc += c;
        printf("[%d]  a = %d, b = %d, c = %d\n", count, a, b, c);
    );
)));
printf("%d,%d,%d,%d\n", count, suma, sumb, sumc);    \\ 1386,593304,414866,404368
}
