{
M = 1000000007;
A = Mod([1, 1; 1, 0], M);
x0 = Mod([0, 1]~, M);
fordiv (M^2-1, d,
    if (A^d == A^0, p = d; break)
);
printf("Period = %d\n", p);
n = fibonacci(1000000) % p;
xn = A^n*x0;
ans = lift(xn[1]);
print(ans);
}
