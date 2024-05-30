pownum(n, p) = {
    my(ret = 0, x = p);
    while (x <= n, ret += n \ x; x *= p);
    return(ret);
}


{
N = 10^9;    \\ N!
M = 10^20;
s = Mod(1, M);
c2 = 0; c5 = 0;
forprime (p = 1, N \ 2,
    e = pownum(N, p) \ 2 + 1;
    while (e % 2 == 0, e /= 2; c2++);
    while (e % 5 == 0, e /= 5; c5++);
    s *= e;
);
ans = lift(s * Mod(2, M)^(c2 - c5));
printf("%020d\n", ans);
}
