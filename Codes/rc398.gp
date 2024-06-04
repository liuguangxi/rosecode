g(k, x) = {
    my(vx, s = 0);
    if (x < k, return(x));
    vx = Vecrev(digits(x, k));
    for (i = 1, #vx,
        if (vx[i] > 0, s += vx[i] * (k + 1)^g(k, i - 1));
    );
    return(s);
}


{
N = 13; K = 50;
x = N; printf("G%d(%d) = %d\n", 1, N, x);
for (k = 2, K,
    x = g(k, x) - 1;
    printf("G%d(%d) = %d\n", k, N, x);
);
print(x);
}
