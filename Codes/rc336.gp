pownum(n, p) = {
    my(ret = 0, x = p);
    while (x <= n, ret += n \ x; x *= p);
    return(ret);
}


\\ F(n!) mod m
Fmod(n, m) = {
    my(s, e);
    s = Mod(1, m);
    forprime (p = 1, n,
        e = pownum(n, p);
        s *= (Mod(p, m)^(2*e+1) + 1) / (Mod(p, m) + 1);
    );
    return(s);
}


{
N = 12345678;
M = 10000004400000259;
s = Fmod(N, M);
print(lift(s));
}
