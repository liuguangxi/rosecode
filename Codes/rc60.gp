{
s = 0;
for (i = 1, 1000000,
    x = lift(Mod(3, 10^9)^i);
    if (Set(digits(x)) == [1..9],
        s += i;
        print(i, " -> ", x);
    );
);
print(s);
}
