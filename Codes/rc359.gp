\\ sqrt(23) < b / a < sqrt(24)


{
for (a = 1, 10000,
    bmin = ceil(sqrt(23)*a);
    bmax = floor(sqrt(24)*a);
    for (b = bmin, bmax,
        area = b^3 * (a + b) / (2 * (a^2 + a*b + b^2));
        if (frac(area) == 0,
            printf("%d,%d,%d\n", a, b, area);
            break(2);
        );
    );
);
}
