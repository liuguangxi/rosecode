/*
Let k is positive integer
x = a_{k-1}a_{k-2}...a_1a_0 (12)
y = a_0a_{k-1}a_{k-2}...a_1 (12)
y = 8*x
Let u = a_{k-1}a_{k-2}...a_1 (12) =>
a_0*12^(k-1) + u = 8 * (u*12 + a_0) =>
u = a_0*(12^(k-1) - 8)/95, u >= 12^(k-2)
*/


{
for (k = 2, 20,
    for (a0 = 1, 9,
        t = a0*(12^(k-1) - 8);
        if (t % 95 != 0, next, u = t / 95);
        if (u < 12^(k-2), next);
        x = u*12 + a0;
        vx = digits(x, 12);
        ok = 1;
        for (i = 1, #vx, if (vx[i] >= 10, ok = 0; break));
        if (ok,
            print(fromdigits(digits(x, 12), 10));
            break(2);
        );
    );
);
}
