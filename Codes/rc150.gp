/*
a1,a2,a3,...,an    1:peg-1, 2:peg-2, 3:peg-3
*/


plot_moving() = {
    printf("Step: %d\n", T);
    printf("Peg-1: "); for (i = 1, N, if (a[i] == 1, printf("%d ", i))); print();
    printf("Peg-2: "); for (i = 1, N, if (a[i] == 2, printf("%d ", i))); print();
    printf("Peg-3: "); for (i = 1, N, if (a[i] == 3, printf("%d ", i))); print();
}


\\ Moving first n disks from peg-p1 to peg-p2, remaining t steps
moving(n, t, p1, p2) = {
    if (n == 1, a[n] = p2; return);
    if (t <= 2^(n-1) - 1,
        moving(n - 1, t, p1, 6 - p1 - p2); return,
        for (i = 1, n - 1, a[i] = 6 - p1 - p2);
    );
    a[n] = p2;
    if (t == 2^(n-1), return);
    moving(n - 1, t - 2^(n-1), 6 - p1 - p2, p2);
}


{
N = 70;
T = 123456789101112131415;    \\ 1 <= T <= 2^N-1

a = vector(N, i, 1);
moving(N, T, 1, 3);
plot_moving();

v = List();
for (n = 1, 3,
    for (i = 1, N, if (a[i] == n, listput(v, i)));
);
idx = permtonum(Vec(v));
print(idx);
}
