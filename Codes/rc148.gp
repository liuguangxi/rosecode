/*
Highly composite numbers: https://oeis.org/A002182
*/


f(n, m) = {
    my(ret = 0, z, d);
    if (m > n, m = n);
    if (mapisdefined(Mf, [n, m], &z), return(z));
    if (n == 1,
        ret = 1,
        for (k = 2, Lvdiv,
            d = Vdiv[k];
            if (d > m, break);
            if (n % d == 0, ret += f(n / d, d));
        );
    );
    mapput(Mf, [n, m], ret);
    return(ret);
}


{
N = 293318625600;
Vdiv = divisors(N); Lvdiv = #Vdiv;
Mf = Map();
s = f(N, N);
printf("%d,%d\n", N, s);
}
