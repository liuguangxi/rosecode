check(n) = {
    my(fa = factor(n));
    for (i = 1, #fa[,1],
        if (fa[i,1] % 4 == 3 && fa[i,2] % 2 == 1, return(0));
    );
    return(1);
}


{
N = 100000;
count = 0; sumz = 0;
xmax = floor(sqrt(N^2/3));
for (x = 1, xmax,
    sum2 = (N - x)*(N + x);
    if (check(sum2),
        for (y = x, floor(sqrt(sum2/2)),
            if (issquare(sum2 - y^2, &z),
                print([x, y, z]);
                count++; sumz += z;
            );
        );
    );
);
printf("%d,%d\n", count, sumz);
}
