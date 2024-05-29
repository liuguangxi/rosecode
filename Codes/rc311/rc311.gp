nimadd(x1, x2) = bitxor(x1, x2);


nimmul0(x1, x2) = {
    my(e1, e2, ee1, ee2, xore, ande, xxor, e0, t, bx1, bx2, ans);

    if (x1 == 0 || x2 == 0, return(0));
    if (x1 == 1 || x2 == 1, return(x1 * x2));

    e1 = logint(x1, 2); e2 = logint(x2, 2);
    if (2^e1 == x1 && 2^e2 == x2,
        \\ x1 and x2 are both power of 2
        ee1 = logint(e1, 2); ee2 = logint(e2, 2);
        if (2^ee1 == e1 && 2^ee2 == e2,
            \\ x1 and x2 are both Fermat number
            if (x1 == x2, ans = x1*3/2, ans = x1*x2),

            \\ Either x1 or x2 is not Fermat number
            xore = bitxor(e1, e2); ande = bitand(e1, e2);
            xxor = 2^xore;
            ans = 1; e0 = 0; t = 2;
            while (ande > 0,
                if (bittest(ande, 0), ans = nimmul0(ans, t*3/2));
                ande = ande >> 1; e0++; t = t*t;
            );
            ans = nimmul0(xxor, ans);
        ),

        \\ Either x1 or x2 is not power of 2
        ans = 0;
        bx1 = Vecrev(digits(x1, 2)); bx2 = Vecrev(digits(x2, 2));
        for (i = 1, #bx1, if (bx1[i] == 1,
            for (j = 1, #bx2,
                if (bx2[j] == 1, ans = nimadd(ans, nimmul0(2^(i-1), 2^(j-1))));
            );
        ));
    );

    return(ans);
}


nimmul(x1, x2) = {
    my(bx1, bx2, ans = 0);
    if (x1 == 0 || x2 == 0, return(0));
    if (x1 == 1 || x2 == 1, return(x1 * x2));
    bx1 = Vecrev(digits(x1, 2)); bx2 = Vecrev(digits(x2, 2));
    for (i = 1, #bx1, if (bx1[i] == 1,
        for (j = 1, #bx2,
            if (bx2[j] == 1, ans = nimadd(ans, TMpow2[i,j]));
        );
    ));
    return(ans);
}


niminv(x) = {
    my(t = 1, t2);
    while (1,
        t2 = nimmul(t, t);
        t = nimmul(x, t2);
        if (t == 1, return(t2));
    );
}


\\ Solve a*x^2 + b*x + c = 0
solveequ(a, b, c) = {
    my(b1, c1);
    b1 = nimmul(b, niminv(a));
    c1 = nimmul(c, niminv(a));
    for (x = 0, 2^24,
        if (nimmul(x, nimadd(x, b1)) == c1, return([x, nimadd(x, b1)]));
    );
    return([0, 0]);
}


{
TMpow2 = matrix(64, 64);    \\ nimmul(2^(i-1), 2^(i-2))
for (i = 1, 64, for (j = i, 64,
    m = nimmul0(2^(i-1), 2^(j-1));
    TMpow2[i,j] = TMpow2[j,i] = m;
));

[x1, x2] = solveequ(1881, 1923, 1938);
printf("x1 = %d, x2 = %d\n", x1, x2);
[x3, x4] = solveequ(6273, 2935220086, 2831770815);
printf("x3 = %d, x4 = %d\n", x3, x4);
[x5, x6] = solveequ(6273, 12997147727796204837, 11460394964710426743);
printf("x5 = %d, x6 = %d\n", x5, x6);

printf("%d,%d,%d,%d,%d,%d\n", x1, x2, x3, x4, x5, x6);
}
