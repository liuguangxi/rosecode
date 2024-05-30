chk(p) = {
    for (i = 1, #Heegner,
        if (qfbsolve(Qh[i], p) == 0, return(0));
    );
    return(1);
}


{
N = 10^50;
Heegner = [1, 2, 3, 7, 11, 19, 43, 67, 163];
Qh = vector(#Heegner, i, Qfb(1, 0, Heegner[i]));

p = N;
while (1,
    p = nextprime(p + 1);
    if (chk(p), break);
);
print("Prime is ", p);

sumx = sumy = 0;
for (i = 1, #Heegner,
    [x, y] = qfbsolve(Qh[i], p);
    x = abs(x); y = abs(y);
    if (i == 1 && x > y, t = x; x = y; y = t);
    sumx += x; sumy += y;
    printf("h = %d, x = %d, y = %d\n", Heegner[i], x, y);
);
printf("%d,%d,%d\n", p % N, sumx, sumy);
}
