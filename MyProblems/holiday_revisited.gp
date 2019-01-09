d(n, i) = binomial(i, n-i) / binomial(n-1, i-1);

c(n, i) = (d(n, i) - d(n, i-1)) * binomial(n-1, i-1) * (i-1)!;

m(n, k) = {
    my(fx, gx, gxpow);
    fx = prod(i = 1, k, Mod(1 - i*x, M));
    gx = Polrev(Vec(fx));
    gxpow = lift(Mod(x, gx)^(n+k-1));
    return(polcoeff(gxpow, k-1));
}


{
N = 1000; D = 10^12;
M = 1000000007;
s = Mod(0, M);
for (i = ceil(N/2), N-1,
    ci = Mod(c(N, i), M);
    mi = m(D-i, i-1);
    s += ci * mi;
);
s *= N;
printf("f(%d, %d) mod %d = %d\n", N, D, M, lift(s));
}
