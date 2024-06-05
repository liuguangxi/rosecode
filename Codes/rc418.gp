\\ p is prime and p mod 4 = 3
F(p) = {
    my(m, hp, x);
    m = (p - 1) / 2;
    hp = qfbhclassno(p);
    x = lift(Mod(2, p)^m);
    if (x > 1, x = -1);
    n = (m - (2-x)*hp) / 2;
    if (n % 2 == 0, return(1), return(p - 1));
}


{
N = 10^18; M = 32;
s = 0; p = N;
for (i = 1, M,
    p++;
    while (1,
        p = nextprime(p);
        if (p % 4 == 3, break, p++);
    );
    print("p = ", p);
    s += F(p);
);
printf("S(%d, %d) = %d\n", N, M, s);
}
