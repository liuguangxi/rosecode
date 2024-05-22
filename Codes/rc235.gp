/*
n / phi(n) = phi(n) / phi(phi(n)) = >

n = 1 or p1^a1 * ... * pr^ar * q1^b1 * ... * qs^bs
s.t.
r >= 0, s >= 1
pi and qj are primes, ai >= 1, bj >= 2
for any pi, exist pi | pj-1 or pi | qk-1
for any qi, not exist qi | pj-1 or qi | qk-1
*/


enum(s) = {
    my(f, cand, lenc, p, c);
    f = factor(s)[,1]~;
    cand = List(s); lenc = #cand;
    for (i = 1, #f,
        p = f[i];
        for (j = 1, lenc,
            c = cand[j] * p;
            while (c <= N, listput(cand, c); c *= p);
        );
        lenc = #cand;
    );
    return(lenc);
}


rec(s, pmax) = {
    my(ret, snew);
    ret = enum(s);
    forprime (p = 2, pmax,
        if (s * p^2 > N, break);
        if (s % p == 0, next);
        if (mapget(kernels, p) == 0, next);
        snew = lcm(s, mapget(kernels, p)) * p^2;
        if (snew > N, next);
        ret += rec(snew, p - 1);
    );
    return(ret);
}


{
N = 10^15;

pmax = sqrtint(N \ 2);
kernels = Map();
forprime (p = 2, pmax,
    k = 1;
    vq = factor(p - 1)[,1]~;
    for (i = 1, #vq,
        q = vq[i];
        if (mapget(kernels, q) == 0, k = 0; break);
        k = lcm(k, mapget(kernels, q));
        if (k > N, k = 0; break);
        k = lcm(k, q);
        if (k > N, k = 0; break);
    );
    mapput(kernels, p, k);
);

C = rec(1, pmax);
printf("C(%d) = %d\n", N, C);    \\ C(1000000000000000) = 4459623
}
