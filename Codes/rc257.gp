/*
Grid 3 * 3
 1  2  3
 4  5  6
 7  8  9

Grid 3 * 4
 1  2  3  4
 5  6  7  8
 9 10 11 12
*/


dfs(k, len) = {
    my(dx, dy, len_new);
    for (n = 2, N,
        if (vused[n], next);
        dx = abs(Px[n] - Px[vpath[k - 1]]);
        dy = abs(Py[n] - Py[vpath[k - 1]]);
        if (gcd(dx, dy) > 1, next);
        vpath[k] = n; vused[n] = 1;
        len_new = len + sqrt(dx^2 + dy^2);
        if (k == N,
            count++;
            listput(vlen, len_new); listput(vsol, vpath);
            if (len_new > len_max, len_max = len_new);
            ,
            dfs(k + 1, len_new);
        );
        vused[n] = 0;
    );
}


{
[H, W] = [3, 4];
N = H * W;
Px = vector(N, n, (n - 1) % W);
Py = vector(N, n, (n - 1) \ W);

vpath = vector(N); vpath[1] = 1;
vused = vector(N); vused[1] = 1;
count = 0; len_max = 0;
vlen = List(); vsol = List();
dfs(2, 0);

printf("%d", count);
for (i = 1, count,
    if (abs(vlen[i] - len_max) < 1e-10,
        v = vsol[i]; printf("/");
        for (j = 1, N - 1, printf("%d,", v[j]));
        printf("%d", v[N]);
    );
);
print;
}
