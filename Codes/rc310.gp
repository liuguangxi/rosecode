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


nimsqrt(x) = {
    if (x == 0,
        return(0),
        return(nimadd(x, nimsqrt(nimadd(x, nimmul(x, x)))));
    );
}


{
TMpow2 = matrix(32, 32);    \\ nimmul(2^(i-1), 2^(i-2))
for (i = 1, 32, for (j = i, 32,
    m = nimmul0(2^(i-1), 2^(j-1));
    TMpow2[i,j] = TMpow2[j,i] = m;
));

n1 = fromdigits([1, 0, 0, 0, 0, 0], 16);
n2 = fromdigits([1, 1, 0, 0, 0, 0], 16);
s = 0;
for (n = n1, n2,
    if (n % 256 == 0, print("n = ", n));
    f = nimsqrt(nimmul(n, niminv(nimadd(n, nimsqrt(n)))));
    s += f;
);
print(s);
}
