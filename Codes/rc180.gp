\\ sum(n = 1, N, floor(a * n))    (a is irrational, N is positive real)
sum_floor(a, N) = {
    my(m, s, k, b, n, t);
    m = floor(N); s = 0; k = 0;
    while (m > 0,
        b = a - floor(a);
        n = floor(m * b);
        t = floor(a) * m * (m + 1) / 2;
        s += (-1)^k * (m*n + t);
        k++; m = n;
        if (b != 0, a = 1 / b);
    );
    return(s);
}


{
default(realprecision, 50);
K = (sqrt(5)-1)/2;
A = 10^16+1;
F = sum_floor(K, A) + floor(A + 1);
print(F);
}
