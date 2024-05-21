st2val(st) = {
    my(last, b, g);
    last = st \ 41^2;
    b = st % 41^2 \ 41;
    g = st % 41;
    return([last, b, g]);
}


val2st(last, b, g) = last*41^2 + b*41 + g;


{
N = 40;
L = 4*41^2;

/* G -> 0, B -> 1 */
f = vector(L);
f[val2st(2, 0, 1) + 1] = 1;
f[val2st(3, 1, 0) + 1] = 1;
for (n = 2, N,
    \\print("n = ", n);
    ff = vector(L);
    for (x = 0, L - 1,
        val = f[x + 1]; if (val == 0, next);
        [last, b, g] = st2val(x);
        if (last == 0,    \\ GG
            if (g < N, ff[val2st(0, b, g + 1) + 1] += val);
            if (b < N, ff[val2st(1, b + 1, g) + 1] += val);
        );
        if (last == 1,    \\ GB
            if (g < N, ff[val2st(2, b, g + 1) + 1] += val);
            if (b < N, ff[val2st(3, b + 1, g) + 1] += val);
        );
        if (last == 2,    \\ BG
            if (g < N, ff[val2st(0, b, g + 1) + 1] += val);
        );
        if (last == 3,    \\ BB
            if (g < N, ff[val2st(2, b, g + 1) + 1] += val);
            if (b < N, ff[val2st(3, b + 1, g) + 1] += val);
        );
    );
    f = ff;
);

s = 0;
for (x = 0, L - 1,
    [last, b, g] = st2val(x);
    if (last != 2, s += f[x + 1]);
);
print(s);
}
