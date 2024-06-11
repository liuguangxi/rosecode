/*
Let (a, b, c) be a Pythagorean triple, 0 < a < b < c
t > 0, 0 < aa < bb < cc
a^2 + t = aa^2, b^2 + t = bb^2, c^2 + t = cc^2 =>
b^2 - a^2 = (bb - aa) * (bb + aa)
c^2 - b^2 = cc^2 - bb^2
c^2 - a^2 = cc^2 - aa^2
*/


check(a, b, c) = {
    my(s = b^2 - a^2, d2, aa, bb, cc, t, cc2);
    my(ans_cnt = 0, ans_st = 0);
    fordiv (s, d1,
        d2 = s / d1;
        if (d1 >= d2, break);
        if ((d2 - d1) % 2 == 1, next);
        aa = (d2 - d1) / 2; bb = (d2 + d1) / 2;
        t = aa^2 - a^2;
        if (t <= 0 || bb^2 - b^2 != t, next);
        cc2 = c^2 - b^2 + bb^2;
        if (issquare(cc2),
            cc = sqrtint(cc2);
            ans_cnt++; ans_st += t;
        );
    );
    return([ans_cnt, ans_st]);
}



{
N = 2000000 - 1;
cnt = 0; st = 0;
mmax = sqrtint(N) \ 2;
nmax = sqrtint(N);
for (m = 1, mmax,
    print("m = ", m);
    forstep (n = m + 1, nmax, 2,
        abc = 2*n*(m+n);
        if (abc > N, break);
        if (gcd(m, n) != 1, next);
        if (n^2 - m^2 <= 2*m*n,
            a = n^2 - m^2; b = 2*m*n,
            b = n^2 - m^2; a = 2*m*n;
        );
        c = n^2 + m^2;
        for (k = 1, N \ abc,
            [a1, b1, c1] = [k*a, k*b, k*c];
            [s_cnt, s_st] = check(a1, b1, c1);
            if (s_cnt > 0,
                cnt += s_cnt; st += s_st;
            );
        );
    );
);
printf("%d,%d\n", cnt, st);    \\ 6862,185818933915972917
}
