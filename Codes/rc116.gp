chk(n) = {
    my(fa);
    fa = factor(n);
    for (i = 1, #fa[,1],
        if (fa[i,1] % 4 == 3 && fa[i,2] % 2 == 1, return(0));
    );
    return(1);
}


gen(x1, x2) = [x1[1]*x2[2]+x1[2]*x2[1], abs(x1[1]*x2[1]-x1[2]*x2[2])];


getab(n) = {
    my(y2);
    for (x = 1, floor(sqrt(n/2)),
        y2 = n - x^2;
        if (issquare(y2),
            y = sqrtint(y2);
            return([x, y]);
        );
    );
}


{
R = 10^10+19;
n = R^2;
k = 1;
until (k == 100,
    n--;
    if (chk(n), k++);
);

sumx = 0; sumy = 0;
fa = factor(n);
z0 = [0, 1];
if (fa[1,1] == 2,
    if (fa[1,2] % 2 == 0,
        z0 = gen(z0, [0, 2^(fa[1,2]/2)]),
        z0 = gen(z0, [2^((fa[1,2]-1)/2), 2^((fa[1,2]-1)/2)]);
    );
);

vp = List();
for (i = 1, #fa[,1],
    if (fa[i,1] % 4 == 1, listput(vp, fa[i,1]));
    if (fa[i,1] % 4 == 3, z0 = gen(z0, [0, fa[i,1]^(fa[i,2]/2)]));
);
lenv = #vp;
vpab = List();
for (i = 1, lenv, listput(vpab, getab(vp[i])));

for (k = 0, 2^(lenv-1)-1,
    z = vpab[lenv]; kk = k;
    for (i = 1, lenv - 1,
        r = kk % 2; kk \= 2;
        if (r == 0, z = gen(z, vpab[i]), z = gen(z, [vpab[i][2], vpab[i][1]]));
    );
    z = gen(z, z0);
    if (z[1] < z[2], x = z[1]; y = z[2], x = z[2]; y = z[1]);
    sumx += x; sumy += y;
    printf("(%d, %d)\n", x, y);
);

printf("%d,%d,%d\n", sumx, sumy, 2*n);
}
