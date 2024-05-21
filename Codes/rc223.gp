fuse(a, b) = {
    if (abs(a - b) < 1, return((a + b + 1) / 2), return(-1));
}


fusetostr(x) = {
    my(s, p, q);
    p = numerator(x);
    q = logint(denominator(x), 2);
    s = Strprintf("%d.%d", p, q);
}


{
v = [0]; lv = #v;
for (n = 1, 7,
    vv = List();
    for (i = 1, lv, for (j = 1, lv,
        c = fuse(v[i], v[j]);
        if (c > 0, listput(vv, c));
    ));
    v = Set(concat(v, Vec(vv))); lv = #v;
);
v = vecsort(v);
vs = select(x -> x > 1/2 && x < 5/4, v); lvs = #vs;
printf("%s", fusetostr(vs[1]));
for (i = 2, lvs, printf(",%s", fusetostr(vs[i])););
}
