{
\\ Init candidates
f = vector(200, i, 1);
for (n = 1, 200,
    flg = 1;
    forprime (p = 37, 200,
        if (n % p == 0, flg = 0);
    );
    if (flg == 0, f[n] = 0);
);
f[13^2] = f[11^2] = f[5^3] = f[2^7] = 0;


\\ Expand using multiples of prime p
vp = primes([1, 36]); lenvp = #vp;
m = Map(); mapput(m, 0, 1);
forstep (i = lenvp, 1, -1,
    p = vp[i];
    vpi = List();
    for (j = 1, 200,
        if (j % p == 0 && f[j] == 1, f[j] = 0; listput(vpi, j));
    );
    vpi = Vec(vpi); lenvpi = #vpi;
    printf("p = %d  v = %d\n", p, vpi);

    for (j = 1, lenvpi,
        x = vpi[j];
        mkey = Vec(m); lenmkey = #mkey;
        m2 = Map();
        for (k = 1, lenmkey,
            sx = mkey[k]; cx = mapget(m, sx);
            if (mapisdefined(m2, sx, &c0),
                mapput(m2, sx, c0 + cx),
                mapput(m2, sx, cx);
            );
            sx += 1/x;
            if (mapisdefined(m2, sx, &c0),
                mapput(m2, sx, c0 + cx),
                mapput(m2, sx, cx);
            );
        );
        m = m2;
    );
    print("before pruning #m = ", #m);

    mkey = Vec(m); lenmkey = #mkey;
    for (k = 1, lenmkey,
        sx = mkey[k];
        if (denominator(sx) % p == 0, mapdelete(m, sx));
    );
    print("after pruning #m = ", #m);
);


\\ Result
s = 0;
if (mapisdefined(m, 2), s += mapget(m, 2));
if (mapisdefined(m, 3), s += mapget(m, 3));
print(s);
}
