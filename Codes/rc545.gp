/*
R(1000000000000000000000, 7400249944258160101211) = 7400249944141114712974021357248838194808446
*/


/* numbers of 2 ~ n which is not perfect power */
h(n) = {
    my(kmax, s = 0);
    kmax = logint(n, 2);
    s = sum(k = 1, kmax, moebius(k) * (sqrtnint(n, k) - 1));
    return(s);
}


/*
Number of integers in the range 1..n not divisible by any integer in v.
Integers in v must be pairwise coprime. v is sorted in descending order.
*/
ndiv_coprime(n, v, i) = {
    my(res);
    if (i == 0 || n < v[i], return(n));
    res = n;
    for (j = 1, i, res -= ndiv_coprime(n \ v[j], v, j - 1));
    return(res);
}


/* Number of integers in the range 1..n not divisible by any integer in v */
ndiv(n, v) = {
    my(x, y, vr, pmax, flg, vd, vc, vb, a1, a2, vl, res);
    if (#v == 0, return(n));
    vr = [];
    for (ix = 1, #v,
        flg = 1; x = v[ix];
        for (iy = 1, #v,
            y = v[iy];
            if (x > y && x % y == 0, flg = 0; break);
        );
        if (flg, vr = concat(vr, x));
    );
    pmax = vecmax(vr);
    forprime (p = 2, pmax,
        vd = select(x->(x % p == 0), vr);
        if (#vd > 1,
            vc = select(x->(x % p != 0), vr);
            vb = vd \ p;
            a1 = ndiv(n, vc) - ndiv(n \ p, vc);
            a2 = ndiv(n \ p, Set(concat(vb, vc)));
            return(a1 + a2);
        );
    );
    vl = vecsort(vr,,4);
    if (mapisdefined(Tab, [vl, n]), return(mapget(Tab, [vl, n])));
    res = ndiv_coprime(n, vl, #vl);
    mapput(Tab, [vl, n], res);
    return(res);
}


/*
A_k = {x | 1 <= x <= k*m and k | x}
f(e) = #setunion(k = 1, e, A_k)
*/
f(e, m) = {
    my(res = 0, vx, c);
    for (i = 1, e,
        vx = []; for (j = i + 1, e, vx = concat(vx, j / gcd(i, j)));
        c = ndiv(m, vx);
        printf("    f: i = %d, c = %d\n", i, c);
        res += c;
    );
    return(res);
}


{
\\N = 5; M = 5;
\\N = 10^2; M = 10^3;
\\N = 10^5; M = 10^6;
N = 10^21; M = 11^21;

Tab = Map();
s = 0;
emax = logint(N, 2);
for (e = 1, emax,
    cnt = h(sqrtnint(N, e)) - h(sqrtnint(N, e + 1));
    if (cnt == 0, next);
    se = f(e, M);
    printf("se = %d    (e = %d, cnt = %d)\n", se, e, cnt);
    s += cnt * se;
);
printf("R(%d, %d) = %d\n", N, M, s);
printf(s % 10^20);
}
