issubseq(sx, sy) = {
    my(lenx = #sx, leny = #sy, iy);
    iy = 1;
    for (ix = 1, lenx,
        while (iy <= leny && sy[iy] != sx[ix], iy++);
        if (iy > leny, return(0), iy++);
    );
    return(1);
}


dfs1(k) = {
    my(j, ok, str);
    for (x = 1, 2,
        v1[k] = x;
        if (k % 2 == 0 && k > 2,
            j = k / 2; ok = 1;
            for (i = 1, j - 1,
                if (issubseq(v1[i..2*i], v1[j..2*j]), ok = 0; break);
            );
            if (!ok, next);
        );
        if (k > count,
            count = k; str = Strchr(v1[1..k] + vector(k, i, 64));
            printf("[%2d]  %s\n", k, str);
        );
        if (k < T1, dfs1(k + 1));
    );
}


dfs2(k) = {
    my(j, ok, str);
    for (x = 1, 3,
        v2[k] = x;
        if (k % 2 == 0 && k > 2,
            j = k / 2; ok = 1;
            for (i = 1, j - 1,
                if (issubseq(v2[i..2*i], v2[j..2*j]), ok = 0; break);
            );
            if (!ok, next);
        );
        if (k == T2,
            found = 1; seq = Strchr(v2 + vector(T2, i, 64)),
            dfs2(k + 1); if (found, return);
        );
    );
}


{
T1 = 20;
v1 = vector(T1); v1[1] = 1;
count = 0;
dfs1(2);

T2 = 80;
v2 = vector(T2);
seq = "";
found = 0;
dfs2(1);

printf("%d,%s\n", count, seq);
}
