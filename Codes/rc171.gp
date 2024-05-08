{
N = 1234;
vf = vector(8, k, sum(i = 0, N\k, x^(i*k)));
f = prod(i = 1, 8, vf[i]);
s = polcoef(f, N);
print(s);
}
