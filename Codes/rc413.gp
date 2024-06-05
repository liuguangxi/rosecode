a(n, k) = {
    my(b, c, z, ret);
    if (n == 0, return(1));
    b = logint(n, 2);
    z = Mod(2, M)^b;
    c = n - z + 1;
    if (k % 2 == 1,
        ret = ((z+c)^k + (z-c)^k) / (2*z),
        ret = ((z+c)^k + (z-c)^k - 2*c^k) / (2*z) + a(n - 2^b, k);
    );
    return(ret);
}


S(n) = {
    my(ret = 0);
    for (i = 1, n, for (j = 1, n,
        ret += a(fibonacci(i) - 1, fibonacci(j));
    ));
    return(ret);
}


{
N = 92;
M = 10^9+7;
s = lift(S(N));
print(s);
}
