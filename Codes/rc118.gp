dfs(k) = {
    my(xmin, s3, strd);
    if (k < 4,
        xmin = if (k == 0, 1, 0);
        forstep (x = 9, xmin, -1,
            Cnt[x + 1]--; Data[k] = x;
            dfs(k + 1);
            Cnt[x + 1]++;
        );
        ,
        s3 = Data[k - 3] + Data[k - 2] + Data[k - 1];
        forstep (x = 9, 0, -1,
            if (Cnt[x + 1] > 0,
                if (issquare(s3 + x),
                    Cnt[x + 1]--; Data[k] = x;
                    if (k >= 41,
                        strd = concat(vector(k, i, Str(Data[i])));
                        print("digits = ", k, "    ", strd);
                    );
                    if (k <= 49, dfs(k + 1));
                    Cnt[x + 1]++;
                );
            );
        );
    );
}


{
Cnt = vector(10, i, 5);
Data = vector(50);
dfs(1);
}
