dfsL(k, r, x) = {
    my(xnew);
    if (Found, return);
    if (k == 9,
        xnew = x; for (j = 1, r, xnew = xnew * 10 + k);
        if (isprime(xnew), L = xnew; Found = 1),
        for (i = 1, r - (9 - k),
            xnew = x; for (j = 1, i, xnew = xnew * 10 + k);
            dfsL(k + 1, r - i, xnew);
        );
    );
}


dfsS(k, r, x) = {
    my(xnew);
    if (Found, return);
    if (k == 9,
        xnew = x; for (j = 1, r, xnew = xnew * 10 + k);
        if (isprime(xnew), S = xnew; Found = 1),
        forstep (i = r - (9 - k), 1, -1,
            xnew = x; for (j = 1, i, xnew = xnew * 10 + k);
            dfsS(k + 1, r - i, xnew);
        );
    );
}


{
N = 30;
S = 0; L = 0;
Found = 0; dfsL(1, N, 0);
Found = 0; dfsS(1, N, 0);
printf("%d,%d\n", S, L);
}
