{
N = 1000000;
ld = 0;
p1 = 2;
forprime (p = 3, N - 2,
    if (!isprime(p + 2), next);
    p2 = p;
    if (p2 - p1 > ld, ld = p2 - p1);
    p1 = p2;
);
print(ld);
}
