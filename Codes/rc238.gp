\\ Whether x*(1/2) + y*(sqrt(5)/2) >= 0
chkge(x, y) = {
    if (x >= 0,
        if (y >= 0, return(1), return(x^2 >= 5*y^2)),
        if (y >= 0, return(x^2 <= 5*y^2), return(0));
    );
}


\\ phi^k = x_k*(1/2) + y_k*(sqrt(5)/2)
\\ x_0 = 2, y_0 = 0; x_1 = 1, y_1 = 1
\\ x_{k+2} = x_{k+1} + x_k, y_{k+2} = y_{k+1} + y_k
phisum(n) = {
    my(xr, yr, x1, y1, x2, y2, xt, yt, k, m);

    xr = 2*n; yr = 0;
    x1 = -1; y1 = 1; x2 = 2; y2 = 0;

    k = 0;
    while (chkge(xr - x2, yr - y2),
        k++;
        xt = x1 + x2; yt = y1 + y2;
        x1 = x2; x2 = xt; y1 = y2; y2 = yt;
    );
    k--; m = k; xr -= x1; yr -= y1;

    while (xr != 0 || yr != 0,
        k--;
        xt = x2 - x1; yt = y2 - y1;
        x2 = x1; x1 = xt; y2 = y1; y1 = yt;
        if (chkge(xr - x1, yr - y1),
            m += k; xr -= x1; yr -= y1;
        );
    );

    return(m);
}


{
N = 10^7;
M = vectorsmall(N);
for (i = 1, N,
    if (i % 100000 == 0, print("i = ", i));
    M[i] = phisum(i);
);
Mmin = 10^8; nmin = 0; Mmax = -10^8; nmax = 0;
for (i = 1, N,
    if (M[i] < Mmin, Mmin = M[i]; nmin = i);
    if (M[i] > Mmax, Mmax = M[i]; nmax = i);
);
printf("%d,%d,%d,%d\n", Mmin, nmin, Mmax, nmax);
}
