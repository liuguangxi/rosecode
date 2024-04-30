{
N = 30000;

L = 8*9^2; V = vector(L);
for (n = 1, L,
    x = n;
    while (x != 1 && x != 4, x = digits(x) * digits(x)~);
    if (x == 1, V[n] = 1);
);

t = 0; s = 0;
forprime (p = 1, 10^8,
    x = digits(p) * digits(p)~;
    if (V[x],
        t++; s += p;
        if (t == N, break);
    )
);
if (t == N, print("OK"));
print(s);
}
