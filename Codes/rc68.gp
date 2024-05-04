{
forstep (x = 100, 1, -1,
    y = x + 12;
    if (y % x == 0, print(x); break);
);
}
