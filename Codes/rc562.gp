/*
g(n, a) = sum(i = 1, (n+1)\2, binomial(n+1-i, i)*a^i)
f(n, a) = sum(i = 1, (n+1)\2, binomial(n+1-i, i)*(a^i - (a-1)^i))
        = g(n, a) - g(n, a-1)

m = 2^a_1 * 3^a_2 * ... * p_k^a_k =>
L(m, n) = prod(i = 1, k, f(n, a_i))

L(10^12!, 10^12) = 58370589
*/


g(n, a) = {
    my(A, x0, xn);
    A = Mod([2,a-1,-a; 1,0,0; 0,1,0], M);
    x0 = Mod([2*a, a, 0], M);
    xn = A^n * x0~;
    return(xn[3]);
}


f(n, a) = g(n, a) - g(n, a - 1);


/* For prime p, find maximum e s.t. p^e | n */
factp(n, p) = {
    my(s = 0);
    n \= p;
    while (n > 0, s += n; n \= p);
    return(s);
}


{
N = 10^12;
M = 1000000007;

Nsqrt = sqrtint(N);
smalls = vector(Nsqrt, i, i-1);    \\ primepi(i)
larges = vector(Nsqrt, i, N\i-1);    \\ primepi(N\i)
for (p = 2, Nsqrt,
    if (p % 10^3 == 0, print("p = ", p));
    if (smalls[p-1] == smalls[p], next);
    pcnt = smalls[p-1];
    q = p*p;
    end = min(Nsqrt, N\q);
    for (i = 1, end,
        d = i*p;
        if (d <= Nsqrt, larges[i] -= larges[d] - pcnt, larges[i] -= smalls[N\d] - pcnt);
    );
    forstep (i = Nsqrt, q, -1,
        smalls[i] -= smalls[i\p] - pcnt;
    );
);
print("Init primepi done");

S = Mod(1, M);
forprime (p = 2, Nsqrt,
    a = factp(N, p);
    S *= f(N, a);
);
print("First part done");

kmax = N \ (Nsqrt + 1);
for (k = 1, kmax,
    if (k % 10^4 == 0, print("k = ", k));
    c = larges[k];
    if (k + 1 > Nsqrt,
        c -= smalls[N \ (k + 1)],
        c -= larges[k + 1];
    );
    S *= f(N, k) ^ c;
);
print("Second part done");

printf("L(%d!, %d) = %d\n", N, N, lift(S));
}
