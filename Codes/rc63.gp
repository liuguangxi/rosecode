/*
ans = Catalan number C(N - 1)
*/


{
N = 26;
x = vector(N);
x[1] = x[2] = 1;
for (i = 3, N, for (j = 1, i - 1,
    x[i] += x[j] * x[i - j];
));
print(x[N]);
}
