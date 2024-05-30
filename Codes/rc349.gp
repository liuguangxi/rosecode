{
Q131 = Qfb(1, 3, 1);
p = 10^50;
sumx = sumy = 0;
for (i = 1, 100,
    p = nextprime(p + 1);
    while (p % 5 != 1, p = nextprime(p + 1));
    [x, y] = qfbsolve(Q131, p);
    if ((x < 0 && y > 0) || (x > 0 && y < 0), y = (x^2-p)/y);
    if (x < 0 && y < 0, x = -x; y = -y);
    if (x >= y, [x, y] = [y, x]);
    sumx += x; sumy += y;
    printf("h = %d, x = %d, y = %d\n", p, x, y);
);
printf("%d,%d\n", sumx, sumy);
}
