\\ f(n) = (((2*n+1)!!+1)/2 - (n+1)!) mod 10^20
f(n) = {
    my(s1, s2, s1_5, s1_2, s0, q, r, sr, s);

    s0 = prod(k = 0, 2^20-1, Mod(2*k+1, 2^21));
    q = n \ 2^20; r = n % 2^20;
    sr = prod(k = 0, r, Mod(2*k+1, 2^21));
    s1_2 = s0^q * sr + 1;
    s1_2 = lift(s1_2) / 2;

    if (n < 100,
        s1_5 = (prod(k = 1, n, Mod(2*k+1, 5^20)) + 1) / Mod(2, 5^20),
        s1_5 = Mod(1, 5^20) / Mod(2, 5^20);
    );

    s1 = chinese(Mod(s1_2, 2^20), s1_5);

    if (n < 100, s2 = Mod((n+1)!, 10^20), s2 = Mod(0, 10^20));

    s = lift(s1 - s2);
    return(s);
}


{
N = 10^10;
s = f(N);
printf("%020d\n", s);
}
