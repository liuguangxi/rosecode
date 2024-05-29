printstr() = {
    my(s);
    s = vector(2 * N, i, Vstr[num[i]]);
    print(concat(s));
}


dfs(k) = {
    my(iempty);
    if (found, return);
    for (i = 1, 2 * N, if (num[i] == 0, iempty = i; break));
    forstep (x = N, 1, -1,
        if (used[x], next);
        if (iempty + x + 1 > 2 * N, next);
        if (num[iempty + x + 1] != 0, next);
        used[x] = 1; num[iempty] = x; num[iempty + x + 1] = x;
        if (k == N, printstr(); found = 1, dfs(k + 1));
        used[x] = 0; num[iempty] = 0; num[iempty + x + 1] = 0;
    );
}


{
N = 27;
Vstr = Vec("ABCDEFGHIJKLMNOPQRSTUVWXYZ_");
used = vector(N);
num = vector(2 * N);
found = 0;
dfs(1);
}
