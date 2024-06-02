\\ 0 <= d1, d2 < 1
dist(d1, d2) = {
    my(d);
    d = abs(d1 - d2);
    if (d > 1/2, d = 1 - d);
    return(d);
}


{
n = 10;
v = [13, 163, 353, 389, 487, 491, 563, 797, 857, 881];

d = vector(n, i, 1/v[i]);
lonely = vector(n);
x = vector(n);
t = 0;
while (1,
    t++;
    for (i = 1, n, x[i] += d[i]; if (x[i] > 1, x[i] -= 1));
    rest = 0;
    for (i = 1, n, if (lonely[i] == 0,
        rest++;
        islonely = 1;
        for (j = 1, n, if (j != i,
            if (dist(x[i], x[j]) < 1/n, islonely = 0; break);
        ));
        if (islonely,
            lonely[i] = 1;
            print(t, "  ", x);
            printf("Runner %d is lonely\n", i);
        );
    ));
    if (rest == 0, break);
);
print(t - 1);
}
