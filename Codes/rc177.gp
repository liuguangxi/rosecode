f(X, N) =
{
    if ((X-1)%13 == 0,
        return (f((X-1)/13*11, N-1)),
        if (N > 0,
            return (-1),
            return (X)
        );
    );
}


{
n = 13;
/*
k_0 = 13*k_1 + 1, x = 1*k_0 + 0 = 1 (mod 13)
...
k_i = 13*k_(i+1) + a_(i+1), x = b_(i+1)*k_i + c_(i+1) = 1 (mod 13)
...
*/
a = vector(n); b = vector(n); c = vector(n);
a[1] = 1; b[1] = 1; c[1] = 0;
for (i = 1, n-1,
    b[i+1] = 11*b[i];
    c[i+1] = (a[i]*b[i]+c[i]-1)/13*11;
    a[i+1] = lift(Mod(1-c[i+1],13)/Mod(b[i+1],13));
);
x = a[n];
forstep(i = n-1, 1, -1, x = 13*x + a[i]);
print(x);
\\print(f(x, n));
}
