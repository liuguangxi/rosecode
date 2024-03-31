f(n) = 1 + fibonacci(n) % 5;


{
N = 1919;
vN = vector(N, i, f(i));
TN = vecsum(vN);
x = vector(N, i, vN[i]/TN);
for (i = 2, N, x[i] += x[i-1]);
t = vector(N, i, x[i]/(2-x[i]));
forstep (i = N, 2, -1, t[i] -= t[i-1]);
ans = sum(i = 1, N, 1/t[i]);
print(ans);
}
