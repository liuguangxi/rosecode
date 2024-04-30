{
for (i = 1, 1000,
    fi = fibonacci(i);
    if (sumdigits(fi) > 100, print(fi); break);
);
}
