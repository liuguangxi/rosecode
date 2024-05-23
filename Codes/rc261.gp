P(n) = {
    my(k, s, x);
    s = 0; k = 1;
    while (1,
        if (moebius(k) != 0,
            x = 1. * moebius(k) / k * log(zeta(k*n));
            s += x;
            if (abs(x) < Eps, break);
        );
        k++;
    );
    return(s);
}


R() = {
    my(p, s, x);
    p = 2; s = 0;
    while (1,
        x = 1. / (p^10 + p^8);
        s += x;
        if (x < Eps, break);
        p = nextprime(p + 1);
    );
    return(s);
}


{
default(realprecision, 100);
Eps = 1e-55;
s = P(2) - P(4) + P(6) - P(8) + R();
vs = Vec(Str(s));
print(concat(vs[1..52]));
}
