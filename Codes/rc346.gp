{
\\ for (n = 1, 10^8, if (numdiv(n) == 720, x = n; print(n); break));
x = 61261200;
for (i = 1, x,
    if (x % i != 0, se = i - 1; break);
);
printf("%d,%d,%d\n", x, 1, se);
}
