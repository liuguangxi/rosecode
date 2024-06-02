{
N = 10^10;

L4 = sqrtnint(N, 4);
L5 = sqrtnint(N, 5);
IsPow = vector(L4);
for (x = 2, L4,
    xk = x * x;
    while (xk <= L4,
        IsPow[xk] = 1;
        xk *= x;
    );
);

Mcnt = Map();
Mab = Map();

for (ia = 1, L4,
    if (IsPow[ia], next);
    for (ib = 1, L5,
        if (IsPow[ib], next);
        s = ia^4 + ib^5;
        if (s > N, break);
        if (mapisdefined(Mcnt, s),
            mapput(Mcnt, s, mapget(Mcnt, s) + 1);
            mapput(Mab, s, concat(mapget(Mab, s), [[ia, ib]])),
            mapput(Mcnt, s, 1);
            mapput(Mab, s, [[ia, ib]]);
        );
    );
);

vd = Vec(Mcnt); lvd = #vd;
for (i = 1, lvd,
    d = vd[i];
    c = mapget(Mcnt, d);
    if (c > 1,
        ab = mapget(Mab, d);
        printf("%d,%d,%d,%d,%d\n", d, ab[1][1], ab[1][2], ab[2][1], ab[2][2]);
    );
);
}
