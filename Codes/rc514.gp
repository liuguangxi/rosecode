{
N = 11;
s = 0;
for (kk = 0, N!-1,
    if (kk % 100000 == 0, print("kk = ", kk));
    [a, b, c, d, e, f, g, h, i, j, k] = Vec(numtoperm(N, kk)) - vector(N, ii, 1);
    vd = [abs(a - b), abs(b - c), abs(b - d), abs(d - e), abs(d - f),
        abs(a - g), abs(g - h), abs(g - i), abs(i - j), abs(i - k)];
    if (Set(vd) == [1..N-1], s++);
);
print(s);    \\ 3152
}
