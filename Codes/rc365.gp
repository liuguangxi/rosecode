{
n = 2091129587;
count = 0; sumx = sumy = 0;
fordiv (n, x0, fordiv (n, y0,
    if (x0 <= y0 && n % (x0*y0) == 0,
        g = n*(x0+y0)/(x0*y0);
        x = g*x0; y = g*y0;
        count++; sumx += x; sumy += y;
        printf("1/%d + 1/%d = 1/%d\n", x, y, n);
    );
));
printf("%d,%d,%d\n", count, sumx, sumy);
}
