{
N = 1000;
e = vector(N, i, 1); e[1] = 2;
forstep (i = 3, N, 3, e[i] = i / 3 * 2);
c = contfracpnqn(e, #e);
ans = sumdigits(c[1, N]);
print(ans);
}
