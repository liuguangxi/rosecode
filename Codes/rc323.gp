chk(n) = {
    my(fa);
    fa = factor(n);
    for (i = 1, #fa[,1],
        if (fa[i,1] % 4 == 3 && fa[i,2] % 2 == 1, return(0));
    );
    return(1);
}


{
R = 87654321;
n = R^2 - 1;
while (!chk(n), n--);
sumx = 0; sumy = 0;
for (x = 1, floor(sqrt(n/2)),
    y2 = n - x^2;
    if (issquare(y2),
        y = sqrtint(y2);
        sumx += x; sumy += y;
        printf("(%d, %d)\n", x, y);
    );
);
printf("%d,%d,%d\n", sumx, sumy, 2*n);
}
