{
s = 0;
for (x = 0, 9,
    for (y = 0, 9,
        if (x == y, next);
        for (z = 0, 9,
            if (x == z || y == z, next);
            n1 = 10 * x + y; n2 = 10 * y + z;
            if (n1 == 0 || z == 0, next);
            if (n1 * z == n2 * x, s++; print([x, y, z]));
        );
    );
);
print(s);
}
