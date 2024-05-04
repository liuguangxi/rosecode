{
N = 1000;
c = binomial(N);
s = sum(i = 0, N, i * (N - i) * c[i + 1]) / 2^N;
print(round(s));
}
