/*
1,3,6,10,15,21,4,5,11,14,2,7,9,16,20,29,35,65,56,44,37,27,54,46,18,63,58,42,22,59,62,19,30,34,66,55,45,36,64,57,43,38,26,23,13,51,49,32,17,47,53,28,8,41,40,60,61,39,25,24,12,52,48,33,31,50
*/


dfs(k) = {
    my(vx, lvx, xx);
    if (k == 1,
        for (x = 1, N,
            if (Use[x] == 0,
                Use[x] = 1; Data[k] = x;
                dfs(k + 1);
                if (Found == 1, return);
                Use[x] = 0;
            );
        );
        ,
        vx = T[Data[k - 1]]; lvx = #vx;
        for (ix = 1, lvx,
            xx = vx[ix];
            if (Use[xx] == 0,
                Use[xx] = 1; Data[k] = xx;
                if (k == N,
                    Found = 1; return;
                    ,
                    dfs(k + 1);
                );
                if (Found == 1, return);
                Use[xx] = 0;
            );
        );
    );
}


{
N = 66;
Data = vector(N);
Use = vector(N);
T = vector(N, i, []);
for (i = 1, N,
    for (j = 1, N,
        if (j != i && issquare(i + j),
            T[i] = concat(T[i], j);
        );
    );
);
Found = 0;
dfs(1);
if (Found,
    print(Data);
    ans = ""; forstep (i = 1, N, 5, ans = concat(ans, Str(Data[i])));
    print(ans);
);
}
