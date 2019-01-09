Sref(n, m) = {
    my(s = 0, t, r);
    for (x = 1, n,
        t = binomial(2*x, x);
        r = t / factorback(factor(t)[,1]);
        s += r;
    );
    return(s % m);
}


f(n, p) = {
    my(s = 0, x = p);
    while (x <= n, s += n \ x; x *= p);
    return(s);
}


S(n, m) = {
    my(s = 0, t, pmax, e);
    for (x = 1, n,
        t = Mod(1, m);
        pmax = sqrtint(2*n);
        forprime (p = 2, pmax,
            e = f(2*x, p) - 2*f(x, p);
            if (e > 1, t *= Mod(p, m)^(e-1));
        );
        s += t;
    );
    return(lift(s));
}


{
n = 10^6;
m = 1000000007;

sn = S(n, m);
printf("S(n) = %d\n", sn);

/*srefn = Sref(n, m);
printf("Sref(n) = %d\n", srefn);
if (sn == srefn, print("OK"), print("ERROR"));*/
}
