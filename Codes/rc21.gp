{
N = 100000;
t = 0; s = 0;
for (x = 1, 10^7,
    x10 = fromdigits(binary(x));
    if (x10 % 19 == 0,
        t++; s += x10;
        if (t == N, break);
    );
);
if (t == N, print("OK"));
print(s);
}
