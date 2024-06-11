/* 990915569557225,0.999999999451 */


areapoly(v) = {
    my(lenv = #v, s = 0, x1, y1, x2, y2);
    if (lenv < 3, return(0));
    for (i = 1, lenv - 1,
        [x1, y1] = v[i]; [x2, y2] = v[i + 1];
        s += x1 * y2 - x2 * y1;
    );
    s = abs(s) / 2;
    return(s);
}


R_bf(n) = {
    my(vpt, y, r);
    vpt = List(); listput(vpt, [0, 0]);
    for (x = 0, n,
        if (issquare(n^2 - x^2, &y), listput(vpt, [x, y]));
    );
    vpt = Vec(vpt);
    r = (areapoly(vpt) * 4) / (Pi * n^2);
    return(r);
}


getxy(n) = {
    my(xmax, y);
    xmax = floor(sqrt(n/2));
    for (x = 1, xmax,
        if (issquare(n - x^2, &y), return([x, y]));
    );
}


gen(z1, z2) = [z1[1]*z2[2]+z1[2]*z2[1], abs(z1[1]*z2[1]-z1[2]*z2[2])];


solvexy(n) = {
    my(fa, lenfa, v1, p, e, v2, x0, y0, x1, y1, x2, y2);
    fa = factor(n); lenfa = #fa[,1];
    v1 = [[0, 1]];
    for (i = 1, lenfa,
        p = fa[i,1]; e = 2 * fa[i,2];
        [x0, y0] = getxy(p);
        for (j = 1, e,
            v2 = List();
            for (k = 1, #v1,
                [x2, y2] = gen(v1[k], [x0, y0]);
                listput(v2, [x2, y2]);
                listput(v2, [y2, x2]);
                [x2, y2] = gen(v1[k], [y0, x0]);
                listput(v2, [x2, y2]);
                listput(v2, [y2, x2]);
            );
            v1 = Set(v2);
        );
    );
    return(v1);
}


R(n) = {
    my(vpt, r);
    vpt = concat([[0,0]], solvexy(n));
    r = (areapoly(vpt) * 4) / (Pi * n^2);
    return(r);
}


{
maxa = 0; maxr = 0;
for (a = 1, 100,
    ra = R_bf(a);
    if (ra > maxr, maxa = a; maxr = ra);
    print(a, "    ", ra);
);
printf("R(%d) = %.12f\n", maxa, maxr);
}


{
A = 5^3*13*17*29*37*41*53*61*73; printf("R(%d) = %.12f\n", A, R(A));
A = 5^3*13*17*29*37*41*53*61*89; printf("R(%d) = %.12f\n", A, R(A));
A = 5^2*13^2*17*29*37*41*53*61*73; printf("R(%d) = %.12f\n", A, R(A));
A = 5^2*13^2*17*29*37*41*53*61*89; printf("R(%d) = %.12f\n", A, R(A));
A = 5^2*13^2*17*29*37*41*53*61*97; printf("R(%d) = %.12f\n", A, R(A));
}
