Cref(a, b) = {
    my(s = 0, m = 2 * max(a, b));
    for (x = -m, m, for (y = -m, m,
        if ((b*x - a*y)^2 + (b*y)^2 == b^4, s++);
    ));
    return(s);
}


C(a, b) = {
    my(s = 4, d = gcd(a, b), fa, lfa);
    fa = factor(d)~; lfa = #fa;
    for (i = 1, lfa, if (fa[1,i] % 4 == 1, s *= 2*fa[2,i]+1));
    return(s);
}


Sref(n) = sum(i = 1, n, sum(j = 1, n, C(i, j)));


f(n) = {
    my(s = 4, fa = factor(n)~, lfa = #fa);
    for (i = 1, lfa, if (fa[1,i] % 4 == 1, s *= 2*fa[2,i]+1));
    return(s);
}


href(n, k) = sum(i = 1, n, sum(j = 1, n, gcd(i, j) == k));


h(n, k) = {
    my(m = n \ k);
    return(sum(i = 1, m, moebius(i) * (m \ i)^2));
}


S(n) = sum(i = 1, n, f(i) * h(n, i));


{
N = 10^8;
Mh = Map();
s = 0;
for (i = 1, N,
    if (i % 100000 == 0, print("i = ", i));
    if (mapisdefined(Mh, N \ i, &z),
        hni = z,
        hni = h(N, i); mapput(Mh, N \ i, hni);
    );
    s += f(i) * hni;
);
printf("S(%d) = %d\n", N, s);
}
