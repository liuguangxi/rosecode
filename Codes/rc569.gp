bigger(v1, v2) = {
    my(lenv1 = #v1, lenv2 = #v2);
    if (lenv1 < lenv2, return(0));
    if (lenv1 > lenv2, return(1));
    return(sum(i = 1, lenv1, i*v1[i]) > sum(i = 1, lenv2, i*v2[i]));
}


{
N = 100;

mpf = vector(N, i, if (i == 1, 1, vecmax(factor(i)[,1])));
me = Map(); mapput(me, 0, Vecsmall([]));
forstep (p = N, 2, -1,
    if (!isprime(p), next);
    print("p = ", p);

    for (x = 2, N,
        if (mpf[x] != p, next);
        me2 = me;
        mate = Mat(me); key = mate[,1]; val = mate[,2];
        for (i = 1, #key,
            key2 = key[i] + 1/x; if (key2 > 1, next);
            val2 = vecsort(concat(Vecsmall([x]), val[i]));
            if (mapisdefined(me2, key2, &v),
                if (bigger(val2, v), mapput(me2, key2, val2)),
                mapput(me2, key2, val2);
            );
        );
        me = me2;
    );

    mate = Mat(me); key = mate[,1]~; val = mate[,2]~;
    me2 = Map();
    for (i = 1, #key,
        key2 = key[i];
        if (denominator(key2) % p != 0, mapput(me2, key2, val[i]));
    );
    me = me2;
    print("Size = ", #me);
);

ve = mapget(me, 1);
MN = #ve; T = sum(i = 1, #ve, i * ve[i]);
print(Vec(ve));
printf("%d,%d\n", MN, T);
}
