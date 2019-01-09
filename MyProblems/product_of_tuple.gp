/*
S'(X) = sum(1 <= p <= X, p^0) = primepi(X)
where X = 1, 2, ..., sqrtint(n), n\1, n\2, ..., n\sqrtint(n)
*/
init_fpsum() = {
    my(vs_s, vs_l, p, q, imax, d);
    vs_s = vector(Psqrt, i, i-1);    \\ primepi(i)
    vs_l = vector(Psqrt, i, P\i-1);    \\ primepi(P\i)
    for (ip = 1, Lvp,
        p = Vp[ip]; q = p*p;
        imax = min(Psqrt, P\q);
        for (i = 1, imax,
            d = i*p;
            if (d <= Psqrt,
                vs_l[i] -= vs_l[d] - vs_s[p-1],
                vs_l[i] -= vs_s[P\d] - vs_s[p-1]
            );
        );
        forstep (i = Psqrt, q, -1,
            vs_s[i] -= vs_s[i\p] - vs_s[p-1];
        );
    );
    return([vs_s, vs_l]);
}

rec(n, fm = Mod(1, M), ipmin = 1) = {
    my(s = 0, p, q, nnew, fmnew, k);
    for (i = ipmin, Lvp,
        p = Vp[i]; q = p*p;
        if (n < q, break);
        nnew = n \ p;
        fmnew = fm * Mod(N, M);
        if (nnew <= Psqrt,
            s += fmnew * Mod(N, M) * (Vs_s[nnew] - Vs_s[p]),
            s += fmnew * Mod(N, M) * (Vs_l[P\nnew] - Vs_s[p])
        );
        if (nnew > q, s += rec(nnew, fmnew, i+1));
        k = 1;
        while (1,
            k++;
            fmnew *= Mod(N+k-1, M) / Mod(k, M);
            s += fmnew;
            if (nnew >= q,
                nnew \= p;
                if (nnew <= Psqrt,
                    s += fmnew * Mod(N, M) * (Vs_s[nnew] - Vs_s[p]),
                    s += fmnew * Mod(N, M) * (Vs_l[P\nnew] - Vs_s[p])
                );
                if (nnew > q, s += rec(nnew, fmnew, i+1)),
                break;
            );
        );
    );
    return(s);
}


default(parisize, 5*10^8);

{
P = 10^12;
N = 10^12;
M = 1000000007;

Psqrt = sqrtint(P);
Vp = primes(primepi(Psqrt));
Lvp = #Vp;
[Vs_s, Vs_l] = init_fpsum();
S = 1 + Mod(N, M) * Vs_l[1] + rec(P);
printf("S(%d, %d) mod %d = %d\n", P, N, M, lift(S));
}
