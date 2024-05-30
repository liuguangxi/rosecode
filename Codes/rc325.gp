check(n) = {
    my(fa = factor(n));
    for (i = 1, #fa[,1],
        if (fa[i,1] % 4 == 3 && fa[i,2] % 2 == 1, return(0));
    );
    return(1);
}


{
R2 = 2*2;
k = 1;
until (k == 50,
    R2++;
    if (check(R2),
        k++;
        printf("[%d] %d\n", k, R2);
        R2 *= 2;
    );
);
}
