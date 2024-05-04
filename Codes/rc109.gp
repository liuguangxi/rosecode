P(n) = {
    my(s = 0);
    if (n <= 3, return(1));
    for (x1 = 0, 3, for (x2 = 0, 3, for (x3 = 0, 3, for (x4 = 0, 3, for (x5 = 0, 3, for (x6 = 0, 3,
        if (x1 + x2 + x3 + x4 + x5 + x6 == n,
            s += n!/(x1!*x2!*x3!*x4!*x5!*x6!);
        );
    ))))));
    s /= 6^n;
    return(s);
}


{
s = 0;
for (k = 0, 18,
    pk = P(k);
    s += pk;
    print("P(", k, ") = ", pk);
);
print(s);
}
