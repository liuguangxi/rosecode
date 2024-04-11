{
K = 404;
KK = K*K;
for (A = 1, 10^6,
    AA = A*A;
    delta = sqrt(KK + 4*(AA - 1)*K);
    x = floor((K + delta)/2);
    for (ii = -1, 1,
        t = x + ii;
        tt = t*t;
        z1 = K*(AA + t);
        z2 = (tt + A);
        if (z1 == z2, print(A));
    );
);
}

/*
Reduce[404*A^2 - A + 40804 == m^2 && A > 0 && m > 0 && A < 10^16, A, Integers]

(m == 14776513 && A == 735159) ||
(m == 16319792 && A == 811940) ||
(m == 2387914053623 && A == 118803164519) ||
(m == 2637311026582 && A == 131211127680)


A = 118803164519
V2VsbCBkb25lISBUaGUgYW5zd2VyIGlzIDM3MzkxNDc5ODUgKHRvIGJlIGVudGVyZWQgaW4gbG93ZXJjYXNlIGhleCkA

Base64 decoded:
Well done! The answer is 3739147985 (to be entered in lowercase hex)
*/
