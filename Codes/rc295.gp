{
N = 61;
v = List();
for (x1 = 1, 10, for (x2 = x1, 10, for (x3 = x2, 10, for (x4 = x3, 10,
    a = x1^2 + x2^2 + x3^2 + x4^2 + N - 4;
    b = x1 * x2 * x3 * x4;
    if (a % b == 0,
        listput(v, a / b);
    );
))));
ans = Set(v);
printf("%d\n", ans);
}
