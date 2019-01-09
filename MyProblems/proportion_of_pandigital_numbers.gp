pan_num(n) = {
    my(Pow2 = vector(10, i, 2^(i-1)));
    my(vn = digits(n), ndig = #vn, s = 0, f, f2, mask = 0, kmin, kmax);

    \\ [1, 10^(ndig-1)-1]
    f = vector(1023);
    for (x = 1, 9, f[Pow2[x+1]] = 1);
    for (i = 2, ndig - 1,
        f2 = vector(1023);
        for (j = 1, 1023,
            if (f[j] == 0, next);
            for (k = 0, 9, f2[bitor(j, Pow2[k+1])] += f[j]);
        );
        f = f2;
        s += f[1023];
    );

    \\ [10^(ndig-1), N]
    f = vector(1023);
    for (i = 1, ndig,
        if (i == 1, kmin = 1, kmin = 0);
        if (i == ndig, kmax = vn[i], kmax = vn[i] - 1);
        for (k = kmin, kmax, f[bitor(mask, Pow2[k+1])]++);
        if (i < ndig,
            f2 = vector(1023);
            for (j = 1, 1023,
                if (f[j] == 0, next);
                for (k = 0, 9, f2[bitor(j, Pow2[k+1])] += f[j]);
            );
            f = f2;
            mask = bitor(mask, Pow2[vn[i]+1]);
        );
    );
    s += f[1023];

    return(s);
}


{
S = 0;
n0 = 2*10^26;
for (i = 2, 100,
    niter = 0;
    while (1,
        niter++;
        s0 = pan_num(n0);
        d = n0 * (i-1) - s0 * i;
        if (d <= 0, break);
        n0 += d;
    );
    S += n0;
    printf("#Iter = %d    G(%d, %d) = %d\n", niter, i, i - 1, n0);
);
printf("S = %d\n", S);
printf("S mod 1000000033 = %d\n", S % 1000000033);
}
