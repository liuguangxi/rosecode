PQa(D) = {
    my(a0 = sqrtint(D), a = a0, an, P = 0, Pn, Q = 1, Qn, r = 0);
    while (a != 2*a0,
        Pn = a * Q - P; Qn = (D - Pn^2) / Q;
        an = (a0 + Pn) \ Qn; a = an;
        P = Pn; Q = Qn; r++;
    );
    return(r);
}


{
N = 5000000;
s = 0;
for (n = 1, N,
    if (n % 10000 == 0, print("n = ", n));
    if (!issquare(n), if (PQa(n) % 2 == 1, s++));
);
print(s);    \\ 480190
}
