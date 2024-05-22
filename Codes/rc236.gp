f(p, e) = (p^(e+1)-1) / (p-1);


getpe(n) = {
    my(a, emax, p);
    a = List();
    if (n <= 2, return(a));
    emax = floor(log(n+1)/log(2)-1);
    for (e = 1, emax,
        p = round(solve(x = 2, n, f(x, e) - n));
        if (f(p, e) == n && isprime(p),
            listput(a, p); listput(a, e);
        );
    );
    return(a);
}


dfs(k, rest) = {
    my(imin, d, n, pe, vp);
    if (k == 1, imin = 1, imin = Didx[k-1]+1);
    for (i = imin, LD,
        d = D[i];
        if (rest % d == 0,
            if (k == 1, print("d = ", d));
            Didx[k] = i;
            if (d == rest,
                vp = List();
                for (x = 1, k, listput(vp, mapget(Md, D[Didx[x]])[1]));
                if (#Set(vp) != k, next);
                n = 1;
                for (x = 1, k, pe = mapget(Md, D[Didx[x]]); n *= pe[1]^pe[2]);
                Cntn++; Sumn += n;
                ,
                dfs(k + 1, rest / d);
            );
        );
    );
}


{
N = 13!;

Md = Map();
fordiv (N, d,
    a = getpe(d);
    if (#a > 0, mapput(Md, d, a));
);
print("Md complete");

D = Vec(Md); LD = #D;
Didx = vector(LD);
Cntn = 0; Sumn = 0;
dfs(1, N);

printf("Cntn = %d\n", Cntn);
printf("Sumn = %d\n", Sumn);    \\ 198296834540354
}
