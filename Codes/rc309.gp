{
g = 10^100;

n1 = 0;
for (e = 1, 10000,
    if (lift(Mod(5, 2^e)^g) != 1, n1 = e - 2; break);
);

n2 = 0;
for (e = 1, 10000,
    if (lift(Mod(5, 2^e)^(8*g)) != 1, n2 = e - 2; break);
);

printf("%d,%d\n", n1, n2);
}
