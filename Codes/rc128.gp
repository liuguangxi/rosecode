A(n) = {
    my(x, z);
    if (mapisdefined(Ms, n, &z), return(z));
    if (n <= 1,
        x = n,
        if (n % 2 == 0, x = A(n / 2), x = A(n \ 2) + A(n \ 2 + 1));
    );
    mapput(Ms, n, x);
    return(x);
}


{
N = 1234567891011121314;
Ms = Map();
s = A(N + 1);
print(s);
}
