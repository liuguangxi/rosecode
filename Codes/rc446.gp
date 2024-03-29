/* sum(k = 1, m, sum(x = 1, n, x^k * floor(Pi*x/k)^k)) */
Sref(m, n) = sum(k = 1, m, sum(x = 1, n, x^k * floor(Pi*x/k)^k));


/* Find p/q with abs(x - p/q) < 1/q^2 and q > n, x must be irrational */
ratappr(x, n) = {
    my(bnd, xappr);
    bnd = n;
    while (1,
        xappr = bestappr(x, bnd);
        p = numerator(xappr); q = denominator(xappr);
        if (q > n, break, bnd *= 2);
    );
    return([p, q]);
}


/* S_k(n) = h_{k+1}*n^{k+1} + ... + h_2*n^2 + h_1*n */
init_h(kmax, p) = {
    my(m, v, h);
    for (k = 1, kmax,
        m = matrix(k + 1, k + 1, i, j, j^i);
        v = vector(k + 1, i, 1);
        for (i = 2, k + 1, v[i] = v[i - 1] + i^k);
        h = Mod(v, p) / Mod(m, p);
        Vh[k] = h;
    );
}


/* sum(x = 1, n, x^k) mod p */
Spow(k, n, p) = {
    my(s = 0, h);
    if (k == 0, h = [Mod(1, p)], h = Vh[k]);
    forstep (i = k + 1, 1, -1, s = (s + h[i]) * Mod(n, p));
    return(s);
}


/* sum(x = 1, n, x^k1 * floor((a*x+c)/b)^k2) mod p, c = 0 or -1 */
S0(n, a, b, c, k1, k2, p) = {
    my(s, m, q, r, c1, h, z);

    if (n == 0, return(0));
    if (a == 0,
        m = c \ b;
        if (m == 0, return(Mod(0, p)), return(Mod(m, p)^k2 * Spow(k1, n, p)));
    );
    if (k2 == 0, return(Spow(k1, n, p)));

    if (mapisdefined(Mparam, [n, a, b, c, k1, k2], &z), return(z));
    if (a >= b,
        q = a \ b; r = a % b;
        s = sum(i = 0, k2, Mod(binomial(k2, i), p) * Mod(q, p)^i * S0(n, r, b, c, k1+i, k2-i, p)),

        c1 = -1 - c; m = (a*n + c)\b;
        if (k1 == 0, h = [Mod(1, p)], h = Vh[k1]);
        s = Mod(m, p)^k2 * Spow(k1, n, p);
        for (i = 0, k2 - 1, for (j = 1, k1 + 1,
            if (h[j] != 0,
                s += (-1)^(k2-i)*Mod(binomial(k2, i), p) * h[j] * S0(m, b, a, c1, i, j, p);
            );
        ));
    );
    mapput(Mparam, [n, a, b, c, k1, k2], s);
    return(s);
}


/* sum(k = 1, m, sum(x = 1, n, x^k * floor(Pi*x/k)^k)) */
S(m, n, p) = {
    my(s = 0, a, b);
    for (k = 1, m,
        [a, b] = ratappr(Pi/k, n);
        s += S0(n, a, b, 0, k, k, p);
    );
    return(lift(s));
}


{
default(realprecision, 100);

M = 20; N = 10^20; P = 1000000007;

Vh = vector(2*M); init_h(2*M, P);
Mparam = Map();

sn = S(M, N, P);
printf("S(n) = %d\n", sn);    \\ S(n) = 396804717

/*srefn = Sref(M, N) % P;
printf("Sref(n) = %d\n", srefn);
if (sn == srefn, print("OK"), print("ERROR"));*/
}
