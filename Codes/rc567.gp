/*
m, n >= 2 =>
m = a^b, n = c^d, s.t. b, d >= 1, a, c, >= 2 and both not powerful =>
(m, n) is minimum logarithmic iff gcd(b, d) = 1 and (a = c = 2 or a != c)

D(11^111) mod (10^18+3) = 133452402889115241
*/


/*
Snp is set of non-powerful integers in [2, T]
c = #Snp, s = sum(x^E for x in Snp)
*/
nonpower(T, E = 1) = {
    my(c, s, emax = logint(T, 2), mue, xmax);
    c = Mod(T - 1, M); s = subst(Vsumxk[E], X, T) - 1;
    for (e = 2, emax,
        mue = Vmu[e]; if (mue == 0, next);
        xmax = Mod(sqrtnint(T, e), M);
        c += mue * (xmax - 1);
        s += mue * (subst(Vsumxk[e*E], X, xmax) - 1);
    );
    return([c, s]);
}


{
N = 11^111;
M = 10^18+3;

emax = logint(N, 2);
Vsumxk = vector(emax, k, Mod(sumformal(X^k), M));
Vmu = vector(emax, i, moebius(i));
Vc = Vs = vector(emax);
for (k = 1, emax, [Vc[k], Vs[k]] = nonpower(sqrtnint(N, k), k));

/* b = d = 1 */
[c1, s1] = nonpower(N, 1);
S = c1 * s1 * 2 - 2 * (s1 - 2);

/* b != d and gcd(b, d) = 1 */
for (b = 1, emax - 1,
    c1 = Vc[b]; s1 = Vs[b];
    for (d = b + 1, emax,
        if (gcd(b, d) != 1, next);
        c2 = Vc[d]; s2 = Vs[d];
        [c3, s3] = nonpower(sqrtnint(N, d), b);
        S += 2 * (s1 * c2 + s2 * c1 - (s3 - Mod(2, M)^b) - (s2 - Mod(2, M)^d));
    );
);

printf("D(%d) = %d\n", N, lift(S));
}
