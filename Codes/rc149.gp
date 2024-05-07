getrep(v) = {
    my(lenv = #v, rep = List(), s = 1);
    for (i = 2, lenv,
        if (v[i] == v[i - 1], s++, listput(rep, s); s = 1);
    );
    listput(rep, s);
    return(Vec(rep));
}


dfs_f(k, r, fmin) = {
    fordiv (r, x,
        if (x >= fmin,
            vf[k] = x; r \= x;
            if (r == 1,
                listput(sf, getrep(vf[1..k])),
                if (r >= x, dfs_f(k + 1, r, x));
            );
            r *= x;
        );
    );
}


dfs_p(idx, r, pfac, v, k) = {
    my(s = 0, xmax);
    if (idx == #v,
        if (r <= v[idx], s = k!/pfac/r!),
        xmax = min(v[idx], r);
        for (x = 0, xmax,
            s += dfs_p(idx + 1, r - x, pfac * x!, v, k);
        );
    );
    return(s);
}



\\ Calculate k-permutation P(k; m1, m2, ..., mn), 0 <= k <= sum(mi)
kperm(k, m) = dfs_p(1, k, 1, m, k);


{
\\ Get all decompositions for (4, 3)
d = 2^4 * 3^3; vf = vector(7); sf = List();
dfs_f(1, d, 2);

\\ Get every length of all decompositions for K different primes
K = 20 - 2;
sp = vector(K, i, stirling(K, i, 2));

\\ Calculate total number of decompositions
s = 0;
for (i = 1, #sf,    /* i-th solution of sf */
    sf_i = sf[i];
    num_f = vecsum(sf_i);
    for (j = 0, min(num_f, K),    /* j number(s) to be combined with sf */
        for (k = max(j, 1), K,    /* length k solution of sp */
            s += sp[k] * binomial(k, j) * kperm(j, sf_i);
        );
    );
);
print(s);
}
