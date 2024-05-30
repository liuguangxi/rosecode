pownum(n, p) = {
    my(ret = 0, x = p);
    while (x <= n, ret += n \ x; x *= p);
    return(ret);
}


{
Pmax = 1000000;
Mp = Map();
forprime (p = 1, Pmax,
    cntp = 1;
    if (p > 2,
        fa = factor(p - 1);
        for (i = 1, matsize(fa)[1], cntp += mapget(Mp, fa[i,1]) * fa[i, 2]);
    );
    mapput(Mp, p, cntp);
);

N = 1000000;    \\ N!
s = 0;
forprime (p = 1, N, s += mapget(Mp, p) * pownum(N, p));
print(s);
}
