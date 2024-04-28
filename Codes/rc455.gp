/*
Let y = x + d1, z = y + d2, then d1, d2 are both non-negative integers
N = x^3 + y^3 + z^3 - 3*x*y*z
  = (x + 2*d1 + d2) * (d1^2 + d1*d2 + d2^2)
*/


D(x, y, z) = x^3 + y^3 + z^3 - 3*x*y*z;


get_d1d2(n) = {
    my(fa, vp, ve, c, v, d1max, t);
    fa = factor(n); vp = fa[,1]; ve = fa[,2];
    c = 1; v = List();
    for (i = 1, #vp,
        if (vp[i] == 2 || vp[i] % 6 == 5,
            if (ve[i] % 2 != 0, return(v), c *= vp[i]^ve[i]),
            if (vp[i] == 3, c *= vp[i]^(ve[i]\2*2));
        );
    );
    n /= c; c = sqrtint(c);
    d1max = sqrtint(n \ 3);
    for (d1 = 0, d1max,
        if (!issquare(4*n - 3*d1^2, &t), next);
        d2 = (t - d1) \ 2;
        listput(v, c*[d1, d2]);
        if (d1 != d2, listput(v, c*[d2, d1]));
    );
    return(v);
}


{
\\N = D(1, 2, 3) * D(11, 12, 13);
N = D(34040, 34238, 35404) * D(34551, 34564, 34567);

cnt = 0; sumz = 0;
fordiv (N, d,
    v = get_d1d2(d); lenv = #v;
    if (lenv == 0, next);
    for (i = 1, lenv,
        [d1, d2] = v[i];
        x3 = N/d - (2*d1 + d2);
        if (x3 % 3 != 0, next);
        x = x3 / 3; y = x + d1; z = y + d2;
        cnt++; sumz += z;
        printf("(%d  %d  %d)\n", x, y, z);
    )
);
printf("%d,%d\n", cnt, sumz);
}
