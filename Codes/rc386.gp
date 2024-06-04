fac(n) = {
    my(f, lf, emin, a, vae);
    if (n == 1, return([[1, 1]]));
    vae = List();
    f = factor(n); lf = #f[,1];
    while (1,
        emin = 10^6;
        for (i = 1, lf, if (f[i,2] != 0 && f[i,2] < emin, emin = f[i,2]));
        if (emin == 10^6, break);
        a = 1;
        for (i = 1, lf,
            if (f[i,2] >= emin,
                a *= f[i,1]; f[i,2] -= emin;
            );
        );
        listput(vae, [a, emin]);
    );
    return(Vecrev(vae));
}


sigmap(n) = {
    my(vae, s = 1, a, e);
    if (n == 1, return(2));
    vae = fac(n);
    for (i = 1, #vae,
        [a, e] = vae[i];
        s *= (a^(e+1)-1)/(a-1);
    );
    return(s);
}


{
N = 66;

T = 10^20;
v = List(1);
for (e2 = 1, 30, for (e3 = 0, e2, for (e5 = 0, e3, for (e7 = 0, e5, for (e11 = 0, e7,
    x = 2^e2 * 3^e3 * 5^e5 * 7^e7 * 11^e11;
    if (x > T, break, listput(v, x));
)))));
v = vecsort(Vec(v)); lv = #v;

maxr = 0; k = 0;
for (i = 1, lv,
    n = v[i];
    r = sigmap(n) / n;
    if (r > maxr,
        k++; maxr = r;
        printf("[%d] %d => %.14f\n", k, n, r);
        if (k == N, ans = n; break);
    );
);
print(ans);
}
