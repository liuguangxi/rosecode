P(n) = {
    my(s = 0, d);
    while (n >= 10,
        d = digits(n); n = prod(i = 1, #d, d[i]); s++;
    );
    return(s);
}


dfs(k, r, xmin, kmax) = {
    my(rnew, ans);
    for (x = xmin, 9,
        if (r % x != 0, next);
        vd[k] = x; rnew = r / x;
        if (rnew == 1,
            ans = concat(vd[1..k], vector(D - kmax, i, 7));
            if (k < kmax, ans = concat(ans, vector(kmax - k, i, 1)));
            ans = fromdigits(vecsort(ans));
            count++; s += ans;
            print(ans),
            if (k < kmax, dfs(k + 1, rnew, x, kmax));
        );
    );
}


search(v) = {
    my(lenv = #v, p = 1, len7 = lenv);
    print(v);
    for (i = 1, lenv, if (v[i] != 7, p *= v[i]; len7--));
    dfs(1, p, 2, D - len7);
}


{
D = 25;
T = 10^D-1;
sol = List(); vd = vector(D);
count = 0; s = 0;

E2 = logint(T, 2); E3 = logint(T, 3); E5 = logint(T, 5); E7 = logint(T, 7);
for (e2 = 0, E2, for (e3 = 0, E3, for (e7 = 0, E7,
    x = 2^e2 * 3^e3 * 7^e7;
    if (x > T, break);
    if (P(x) == 10,
        d = concat(concat(vector(e2, i, 2), vector(e3, i, 3)), vector(e7, i, 7));
        listput(sol, d);
    );
)));
for (e3 = 0, E3, for (e5 = 0, E5, for (e7 = 0, E7,
    x = 3^e3 * 5^e5 * 7^e7;
    if (x > T, break);
    if (P(x) == 10,
        d = concat(concat(vector(e3, i, 3), vector(e5, i, 5)), vector(e7, i, 7));
        listput(sol, d);
    );
)));

for (i = 1, #sol, search(sol[i]));

printf("%d,%d\n", count, s);
}
