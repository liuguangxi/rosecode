/*
e(k, n) = 2/n * sum(i = 1, n, j = i, n, (j - i)^k)
s(n) = e(1, n) + e(2, n) + e(3, n) = 1/30 * (-8 - 5*n + 5*n^2 + 5*n^3 + 3*n^4)
=>
n = 0 (mod 15) =>
    s(n) = num(n) / 15, num(n) = s(n)*15 = 1/2 * (-8 - 5*n + 5*n^2 + 5*n^3 + 3*n^4)
n = 5, 10 (mod 15) =>
    s(n) = num(n) / 5, num(n) = s(n)*5 = 1/6 * (-8 - 5*n + 5*n^2 + 5*n^3 + 3*n^4)
n = 3, 6, 9, 12 (mod 15) =>
    s(n) = num(n) / 3, num(n) = s(n)*5 = 1/10 * (-8 - 5*n + 5*n^2 + 5*n^3 + 3*n^4)
n = 1, 2, 4, 7, 8, 11, 13, 14 (mod 15) =>
    s(n) = num(n) / 3, num(n) = s(n) = 1/30 * (-8 - 5*n + 5*n^2 + 5*n^3 + 3*n^4)
*/


Sref(n) = {
    my(ans = 0, t);
    for (k = 1, n,
        t = 1/30 * (-8 - 5*k + 5*k^2 + 5*k^3 + 3*k^4);
        ans += numerator(t);
    );
    return(ans);
}


S(n) = {
    my(ans = 0, kmax);

    \\ n = 15*k
    kmax = n \ 15;
    ans += kmax * (-19682 + 18975*kmax + 237750*kmax^2 + 320625*kmax^3 + 121500*kmax^4) / 8;

    \\ n = 15*k + 1
    kmax = (n - 1) \ 15 + 1;
    ans += kmax * (-1 + kmax) * (1034 - 1715*kmax -8325*kmax^2 + 8100*kmax^3) / 8;

    \\ n = 15*k + 2
    kmax = (n - 2) \ 15 + 1;
    ans += kmax * (-598 + 3657*kmax + 2590*kmax^2 - 13725*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 3
    kmax = (n - 3) \ 15 + 1;
    ans += kmax * (-274 + 11499*kmax - 2130*kmax^2 - 33075*kmax^3 + 24300*kmax^4) / 8;

    \\ n = 15*k + 4
    kmax = (n - 4) \ 15 + 1;
    ans += kmax * (398 + 3421*kmax - 3290*kmax^2 - 8325*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 5
    kmax = (n - 5) \ 15 + 1;
    ans += kmax * (4006 + 12825*kmax - 25750*kmax^2 - 28125*kmax^3 + 40500*kmax^4) / 8;

    \\ n = 15*k + 6
    kmax = (n - 6) \ 15 + 1;
    ans += kmax * (3206 + 4227*kmax - 18870*kmax^2 - 8775*kmax^3 + 24300*kmax^4) / 8;

    \\ n = 15*k + 7
    kmax = (n - 7) \ 15 + 1;
    ans += kmax * (1170 + 97*kmax - 6710*kmax^2 - 225*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 8
    kmax = (n - 8) \ 15 + 1;
    ans += kmax * (1094 - 1227*kmax - 6410*kmax^2 + 2475*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 9
    kmax = (n - 9) \ 15 + 1;
    ans += kmax * (2546 - 7257*kmax - 16170*kmax^2 + 15525*kmax^3 + 24300*kmax^4) / 8;

    \\ n = 15*k + 10
    kmax = (n - 10) \ 15 + 1;
    ans += kmax * (2306 - 16675*kmax - 18250*kmax^2 + 39375*kmax^3 + 40500*kmax^4) / 8;

    \\ n = 15*k + 11
    kmax = (n - 11) \ 15 + 1;
    ans += kmax * (-22 - 3831*kmax - 1190*kmax^2 + 10575*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 12
    kmax = (n - 12) \ 15 + 1;
    ans += kmax * (-1606 - 11289*kmax + 5970*kmax^2 + 39825*kmax^3 + 24300*kmax^4) / 8;

    \\ n = 15*k + 13
    kmax = (n - 13) \ 15 + 1;
    ans += kmax * (-994 - 2987*kmax + 5890*kmax^2 + 15975*kmax^3 + 8100*kmax^4) / 8;

    \\ n = 15*k + 14
    kmax = (n - 14) \ 15 + 1;
    ans += kmax * (1 + kmax) * (-1294 - 65*kmax + 10575*kmax^2 + 8100*kmax^3) / 8;

    return(ans);
}


{
N = 12345678987654321;
/*sref = Sref(N);
printf("Sref(%d) = %d\n", N, sref);*/
s = S(N);
printf("S(%d) = %d\n", N, s);
print(s % 1000000007);
/*if (sref == s, print("OK"), print("ERROR"));*/
}
