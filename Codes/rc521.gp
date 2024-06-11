/*
p is prime, k is positive integer
R(p, k) = prod(i = 1, p-1, i^k+1) mod p
=>
let d = gcd(p-1, k),
when d = 1, R(p, k) = 0
when d = p-1, R(p, k) = 1
when 1 < d < p-1,
    when p mod 4 = 1, R(p, k) = 0
    when p mod 4 = 3, R(p, k) = 2^d mod p
*/


primepi34(n) = {
    my(nsqrt, vs1_s, vs1_l, vs3_s, vs3_l, q, imax, d);

    nsqrt = sqrtint(n);
    vs1_s = vector(nsqrt, i, (i-1)\4);    \\ primepi1(i)
    vs1_l = vector(nsqrt, i, (n\i-1)\4);    \\ primepi1(n\i)
    vs3_s = vector(nsqrt, i, (i-3)\4+1);    \\ primepi3(i)
    vs3_l = vector(nsqrt, i, (n\i-3)\4+1);    \\ primepi3(n\i)

    forprime (p = 3, nsqrt,
        q = p*p;
        imax = min(nsqrt, n\q);
        for (i = 1, imax,
            d = i*p;
            if (p % 4 == 1,
                if (d <= nsqrt,
                    vs1_l[i] -= (vs1_l[d] - vs1_s[p-1]); vs3_l[i] -= (vs3_l[d] - vs3_s[p-1]),
                    vs1_l[i] -= (vs1_s[n\d] - vs1_s[p-1]); vs3_l[i] -= (vs3_s[n\d] - vs3_s[p-1]);
                );
                ,
                if (d <= nsqrt,
                    vs1_l[i] -= (vs3_l[d] - vs3_s[p-1]); vs3_l[i] -= (vs1_l[d] - vs1_s[p-1]),
                    vs1_l[i] -= (vs3_s[n\d] - vs3_s[p-1]); vs3_l[i] -= (vs1_s[n\d] - vs1_s[p-1]);
                );
            );
        );
        forstep (i = nsqrt, q, -1,
            if (p % 4 == 1,
                vs1_s[i] -= (vs1_s[i\p] - vs1_s[p-1]); vs3_s[i] -= (vs3_s[i\p] - vs3_s[p-1]),
                vs1_s[i] -= (vs3_s[i\p] - vs3_s[p-1]); vs3_s[i] -= (vs1_s[i\p] - vs1_s[p-1]);
            );
        );
    );

    return(vs3_l[1]);
}


{
P1 = 2069; P2 = 4877; K = 2*P1*P2;
N = 10^10;

totnump34 = primepi34(N);
printf("#(4m+3 prime) = %d\n", totnump34);

vp = List();
forstep (x = P1 + 1, N, P1, if (isprime(x), listput(vp, x)));
forstep (x = P2 + 1, N, P2, if (isprime(x), listput(vp, x)));
vp = Set(vp); lenvp = #vp;
printf("#vp = %d\n", lenvp);

s = 0;
nump34 = 0;
for (i = 1, lenvp,
    p = vp[i];
    if (p % 4 == 3,
        nump34++;
        d = gcd(p - 1, K);
        sp = lift(Mod(2, p)^d);
        s += sp;
        ,
        if (K % (p - 1) == 0, s++);
    );
);
s += (totnump34 - nump34) * 4 - 3;

printf("S(%d, %d) = %d\n", N, K, s);    \\ S(10000000000, 20181026) = 382376542535532
}
