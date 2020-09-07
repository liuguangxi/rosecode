/*
S_k(n) = sum(x = 1, n, moebius_k(x))
moebius_k(n) is multiplicative and moebius_k(p^e) = (-1)^e*binomial(k, e)

S3(10000000) = 143905
S5(10000000) = 5473563
S5(1000000000000) = 2073417938
*/


dfs(n, coef = 1, ipmin = 1) = {
    my(s = 0, p, q, nnew, coefnew, e);
    for (i = ipmin, Lvp,
        p = Vp[i]; q = p*p; e = 1;
        if (n < q, break);
        nnew = n \ p;
        coefnew = coef * (-K);
        if (nnew <= Nsqrt,
            s += coefnew * (-K) * (smalls[nnew] - smalls[p]),
            s += coefnew * (-K) * (larges[N\nnew] - smalls[p]);
        );
        if (nnew > q, s += dfs(nnew, coefnew, i + 1));
        e++; coefnew = coef * C[e];
        while (coefnew != 0,
            s += coefnew;
            if (nnew >= q,
                nnew \= p;
                if (nnew <= Nsqrt,
                    s += coefnew * (-K) * (smalls[nnew] - smalls[p]),
                    s += coefnew * (-K) * (larges[N\nnew] - smalls[p]);
                );
                if (nnew > q, s += dfs(nnew, coefnew, i + 1)),
                break;
            );
            e++; coefnew = coef * C[e];
        );
    );
    return(s);
}


{
K = 5;
N = 10^12;

Nsqrt = sqrtint(N);
C = vector(K+1, i, (-1)^i*binomial(K, i));

Vp = primes([1, Nsqrt]);
Lvp = #Vp;

smalls = vector(Nsqrt, i, i-1);    \\ primepi(i)
larges = vector(Nsqrt, i, N\i-1);    \\ primepi(N\i)
for (p = 2, Nsqrt,
    if (smalls[p-1] == smalls[p], next);
    pcnt = smalls[p-1];
    q = p*p;
    end = min(Nsqrt, N\q);
    for (i = 1, end,
        d = i*p;
        if (d <= Nsqrt,
            larges[i] -= larges[d] - pcnt,
            larges[i] -= smalls[N\d] - pcnt;
        );
    );
    forstep (i = Nsqrt, q, -1,
        smalls[i] -= smalls[i\p] - pcnt;
    );
);
print("init done");

sn = 1 + (-K)*larges[1] + dfs(N, 1, 1);
printf("S%d(%d) = %d\n", K, N, sn);
}
