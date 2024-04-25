{
N = 314159263;

lenn = #digits(N);
dmax = 10^(lenn - lenn\2) - 1;
v = List();
for (d = 1, dmax,
    vd = digits(d); vdrev = Vecrev(vd);
    dd = fromdigits(concat(vd, vdrev));
    if (dd <= N, listput(v, dd));
    dd = fromdigits(concat(vd, vdrev[2..-1]));
    if (dd <= N, listput(v, dd));
);
v = vecsort(Vec(v));
lenv = #v;

count = 0;
for (ix = 1, lenv,
    x = v[ix];
    if (3*x > N, break);
    for (iy = ix, lenv,
        y = v[iy];
        if (x + 2*y > N, break);
        z = N - x - y;
        if (vecsearch(v, z),
            count++;
            [xx, yy, zz] = [x, y, z];
            printf("[%d]    %d  %d  %d\n", count, x, y, z);
        );
    );
);
printf("%d,%d,%d,%d\n", count, xx, yy, zz);    \\ 33721,69866896,69877896,174414471
}
