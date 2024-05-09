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
A = 123456789101112;
M = 2/(sqrt(5)-1);
C = A*(M^2)/(M^2-1);
F1 = sum_floor(1/M, C) + floor(C + 1);
F2 = sum_floor(M, C-A) + floor(C-A);
F = F1 - F2;
print(F);
}
