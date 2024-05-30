G(p, m) = {
    my(vp, mo, s);
    vp = List();
    until (m == 1, listput(vp, m); m = eulerphi(m));
    s = 0;
    forstep (i = #vp, 1, -1,
        mo = vp[i]; s = lift(Mod(p, mo)^(s+mo));
    );
    return(s);
}


{
M = 10^100;
D = 1415;

strd = Vec(Str(D)); lenstrd = #strd;
p = 2;
while (1,
    g = G(p, M);
    printf("G(%d) = %d\n", p, g);
    strg = Vec(Str(g)); lenstrg = #strg;
    idx = 0;
    for (i = 1, lenstrg - lenstrd + 1,
        if (strg[i..i+3] == strd, idx = i; break);
    );
    if (idx > 0, break);
    p = nextprime(p + 1);
);
printf("%d,%s\n", p, concat(strg[idx..lenstrg]));
}
