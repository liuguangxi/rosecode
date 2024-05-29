{
P = 10000;
P2 = P \ 2;
count = 0; suma = sumb = sumc = 0;
for (a0 = 1, P2 \ 3,
    for (b0 = a0, (P2 - a0) \ 2,
        c0max = min(a0 + b0 - 1, P2 - a0 - b0);
        for (c0 = b0, c0max,
            if (gcd([a0, b0, c0]) != 1, next);
            if (!issquare(2*a0^2 + 2*b0^2 - c0^2), next);
            if (!issquare(2*b0^2 + 2*c0^2 - a0^2), next);
            if (!issquare(2*c0^2 + 2*a0^2 - b0^2), next);
            a = 2*a0; b = 2*b0; c = 2*c0;
            count++; suma += a; sumb += b; sumc += c;
            printf("%d  %d  %d\n", a, b, c);
        );
    );
);
printf("%d,%d,%d,%d\n", count, suma, sumb, sumc);
}
