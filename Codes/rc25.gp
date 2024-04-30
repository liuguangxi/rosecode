{
N = 1000;
k = N * (N - 1) / 2;
p1 = prime(k + 1); pn = prime(k + N);
s = 0; forprime(p = p1, pn, s += p);
print(s);
}
