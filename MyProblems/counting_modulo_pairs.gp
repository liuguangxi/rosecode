Sref(n) = sum(x = 1, n, x / factorback(factor(x)[,1]));

init_primes(n) = primes(primepi(n));


/*
S'(X) = sum(1 <= p <= X, p^0) = primepi(X)
where X = 1, 2, ..., sqrtint(n), n\1, n\2, ..., n\sqrtint(n)
*/
init_fpsum() = {
    my(vs_s, vs_l, p, q, imax, d);
    vs_s = vector(Nsqrt, i, i-1);    \\ primepi(i)
    vs_l = vector(Nsqrt, i, N\i-1);    \\ primepi(N\i)
    for (ip = 1, Lvp,
        p = Vp[ip]; q = p*p;
        imax = min(Nsqrt, N\q);
        for (i = 1, imax,
            d = i*p;
            if (d <= Nsqrt,
                vs_l[i] -= vs_l[d] - vs_s[p-1],
                vs_l[i] -= vs_s[N\d] - vs_s[p-1]
            );
        );
        forstep (i = Nsqrt, q, -1,
            vs_s[i] -= vs_s[i\p] - vs_s[p-1];
        );
    );
    return([vs_s, vs_l]);
}

S(n, fm = 1, ipmin = 1) = {
    my(s = 0, p, q, nnew, fmnew);
    for (i = ipmin, Lvp,
        p = Vp[i]; q = p*p;
        if (n < q, break);
        nnew = n \ p;
        if (nnew <= Nsqrt,
            s += fm * (Vs_s[nnew] - Vs_s[p]),
            s += fm * (Vs_l[N\nnew] - Vs_s[p])
        );
        if (nnew > q, s += S(nnew, fm, i+1));
        fmnew = fm;
        while (1,
            fmnew *= p;
            s += fmnew;
            if (nnew >= q,
                nnew \= p;
                if (nnew <= Nsqrt,
                    s += fmnew * (Vs_s[nnew] - Vs_s[p]),
                    s += fmnew * (Vs_l[N\nnew] - Vs_s[p])
                );
                if (nnew > q, s += S(nnew, fmnew, i+1)),
                break;
            );
        );
    );
    return(s);
}


default(parisize, 10^8);

{
N = 10^6;
Nsqrt = sqrtint(N);

Vp = init_primes(Nsqrt);
Lvp = #Vp;
[Vs_s, Vs_l] = init_fpsum();
print("init_fpsum done.");

sn = 1 + Vs_l[1] + S(N);
printf("S(%d) = %d\n", N, sn);

srefn = Sref(N);
printf("Sref(%d) = %d\n", N, srefn);
if (sn == srefn, print("OK"), print("ERROR"));
}
