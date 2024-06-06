isirreducible(n) = {
    my(fa, p);
    fa = factor(n^2 + 1)[,1];
    p = fa[#fa];
    return(p >= 2 * n);
}


geti(p) = {
    my(x, y, a, b, d, z);
    [x, y] = qfbsolve(Qfb(1, 0, 1), p);
    x = abs(x); y = abs(y);
    [a, b, d] = gcdext(x, y);
    z = (abs(a)*y + abs(b)*x) % p;
    if (2 * z < p, return(z), return(p - z));
}


printdecomp(n, v) = {
    printf("[%d] = ", n);
    for (k = 1, #v,
        if (k == 1,
            if (v[k][3] == 1, print1(" "), print1(" -")),
            if (v[k][3] == 1, print1(" + "), print1(" - "));
        );
        if (v[k][2] == 1,
            printf("[%d]", v[k][1]),
            printf("%d*[%d]", v[k][2], v[k][1]);
        );
    );
}


reduction(n) = {
    my(vred, s, x, y, fa, lenfa, p, i, c, sgn, residue, d);

    vred = List();    \\ {[D], c, sgn} -> sgn * c * arctan(1/D)
    x = n; y = 1;
    while (1,
        if (x == 0 || y == 0 || x^2 + y^2 == 2,
            s = atan(1/n);
            for (k = 1, #vred, s -= vred[k][3]*vred[k][2]*atan(1/vred[k][1]));
            c = round(s / atan(1)); sgn = sign(c); c = abs(c);
            if (c > 0, listput(vred, [1, c, sgn]));
            break;
        );
        fa = factor(x^2 + y^2); lenfa = #fa[,1];
        p = fa[lenfa,1]; c = fa[lenfa,2];
        i = geti(p);
        if ((x + y * i) % p == 0, sgn = -1, sgn = 1);
        listput(vred, [i, c, sgn]);
        residue = (x + y*I) * (i - sgn*I)^c;
        x = real(residue); y = imag(residue); d = gcd(x, y);
        [x, y] = [x, y] / d;
    );
    listsort(vred);

    \\ Conservative check
    s = atan(1/n);
    for (k = 1, #vred, s -= vred[k][3]*vred[k][2]*atan(1/vred[k][1]));
    if (abs(s) > 1e-10, print(n, "  ERROR"));
    for (k = 1, #vred,
        if (!isirreducible(vred[k][1]), print(n, "  ERROR"));
        if (vred[k][2] == 0, print(n, "  ERROR"));
    );

    return(vred);
}


{
N = 20000; T = 10;

vc = List();    \\ {C(n), n}
for (n = 1, N - 1,
    if (isirreducible(n), next);
    vr = reduction(n);
    if (vr[1][1] != 1, next);
    c = 1/n + sum(k = 2, #vr, 1/vr[k][1]);
    listput(vc, [c, n]);
);
vc = vecsort(Vec(vc));

for (k = 1, T,
    num = vc[k][2];
    printf("C(%d) = %.10f  ->  ", num, vc[k][1]);
    printdecomp(num, reduction(num)); print;
);
print;
for (k = 1, T - 1, printf("%d,", vc[k][2]));
printf("%d\n", vc[T][2]);
}
