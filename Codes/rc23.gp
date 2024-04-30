{
N = 100000000;
d = lcm([1..15]);
s = 0;
forstep (n = 8, N, 8,
    if (n * (2*n-1) % d == 0, s++);
);
print(s);
}
