dfs(k) = {
    my(use, s);
    for (x = 1, N,
        if (Used[x], next);
        Data[k] = x; Used[x] = 1;

        if (k == 1, dfs(k + 1));
        if (k == 2,
            Data[6] = Sum - Data[1] - Data[2];
            if (Data[6] >= 1 && Data[6] <= N && Used[Data[6]] == 0,
                Used[Data[6]] = 1;
                dfs(k + 1);
                Used[Data[6]] = 0;
            );
        );
        if (k == 3,
            Data[7] = Sum - Data[1] - Data[3];
            if (Data[7] >= 1 && Data[7] <= N && Used[Data[7]] == 0,
                Used[Data[7]] = 1;
                dfs(k + 1);
                Used[Data[7]] = 0;
            );
        );
        if (k == 4,
            Data[9] = Sum - Data[2] - Data[4];
            Data[10] = Sum - Data[3] - Data[4];
            Data[8] = Sum - Data[7] - Data[9];
            if (Data[9] >= 1 && Data[9] <= N && Used[Data[9]] == 0,
                Used[Data[9]] = 1;
                if (Data[10] >= 1 && Data[10] <= N && Used[Data[10]] == 0,
                    Used[Data[10]] = 1;
                    if (Data[8] >= 1 && Data[8] <= N && Used[Data[8]] == 0 && Data[8] == Sum - Data[6] - Data[10],
                        Used[Data[8]] = 1;
                        dfs(k + 1);
                        Used[Data[8]] = 0;
                    );
                    Used[Data[10]] = 0;
                );
                Used[Data[9]] = 0;
            );
        );
        if (k == 5,
            use = Used;
            Data[27] = Sum - Data[1] - Data[5];
            if (Data[27] >= 1 && Data[27] <= N && use[Data[27]] == 0, use[Data[27]] = 1, Used[x] = 0; next);
            Data[25] = Sum - Data[2] - Data[5];
            if (Data[25] >= 1 && Data[25] <= N && use[Data[25]] == 0, use[Data[25]] = 1, Used[x] = 0; next);
            Data[21] = Sum - Data[3] - Data[5];
            if (Data[21] >= 1 && Data[21] <= N && use[Data[21]] == 0, use[Data[21]] = 1, Used[x] = 0; next);
            Data[19] = Sum - Data[4] - Data[5];
            if (Data[19] >= 1 && Data[19] <= N && use[Data[19]] == 0, use[Data[19]] = 1, Used[x] = 0; next);

            Data[20] = Sum - Data[19] - Data[21];
            if (Data[20] >= 1 && Data[20] <= N && use[Data[20]] == 0, use[Data[20]] = 1, Used[x] = 0; next);
            Data[22] = Sum - Data[19] - Data[25];
            if (Data[22] >= 1 && Data[22] <= N && use[Data[22]] == 0, use[Data[22]] = 1, Used[x] = 0; next);
            Data[24] = Sum - Data[21] - Data[27];
            if (Data[24] >= 1 && Data[24] <= N && use[Data[24]] == 0, use[Data[24]] = 1, Used[x] = 0; next);
            Data[26] = Sum - Data[25] - Data[27];
            if (Data[26] >= 1 && Data[26] <= N && use[Data[26]] == 0, use[Data[26]] = 1, Used[x] = 0; next);
            Data[23] = Sum - Data[22] - Data[24];
            if (Data[23] >= 1 && Data[23] <= N && use[Data[23]] == 0 && Data[20] + Data[23] + Data[26] == Sum && Data[8] + Data[5] + Data[23] == Sum,
                use[Data[23]] = 1, Used[x] = 0; next);

            Data[11] = Sum - Data[1] - Data[19];
            if (Data[11] >= 1 && Data[11] <= N && use[Data[11]] == 0, use[Data[11]] = 1, Used[x] = 0; next);
            Data[12] = Sum - Data[6] - Data[20];
            if (Data[12] >= 1 && Data[12] <= N && use[Data[12]] == 0, use[Data[12]] = 1, Used[x] = 0; next);
            Data[13] = Sum - Data[2] - Data[21];
            if (Data[13] >= 1 && Data[13] <= N && use[Data[13]] == 0 && Data[11] + Data[12] + Data[13] == Sum, use[Data[13]] = 1, Used[x] = 0; next);
            Data[14] = Sum - Data[7] - Data[22];
            if (Data[14] >= 1 && Data[14] <= N && use[Data[14]] == 0, use[Data[14]] = 1, Used[x] = 0; next);
            Data[15] = Sum - Data[9] - Data[24];
            if (Data[15] >= 1 && Data[15] <= N && use[Data[15]] == 0 && Data[14] + Data[5] + Data[15] == Sum, use[Data[15]] = 1, Used[x] = 0; next);
            Data[16] = Sum - Data[3] - Data[25];
            if (Data[16] >= 1 && Data[16] <= N && use[Data[16]] == 0 && Data[11] + Data[14] + Data[16] == Sum, use[Data[16]] = 1, Used[x] = 0; next);
            Data[17] = Sum - Data[10] - Data[26];
            if (Data[17] >= 1 && Data[17] <= N && use[Data[17]] == 0 && Data[12] + Data[5] + Data[17] == Sum, use[Data[17]] = 1, Used[x] = 0; next);
            Data[18] = Sum - Data[4] - Data[27];
            if (Data[18] >= 1 && Data[18] <= N && use[Data[18]] == 0 && Data[16] + Data[17] + Data[18] == Sum && Data[13] + Data[15] + Data[18] == Sum,
                use[Data[18]] = 1, Used[x] = 0; next);

            Count++;
            s = [
                Data[1], Data[6], Data[2], Data[7], Data[8], Data[9], Data[3], Data[10], Data[4],
                Data[11], Data[12], Data[13], Data[14], Data[5], Data[15], Data[16], Data[17], Data[18],
                Data[19], Data[20], Data[21], Data[22], Data[23], Data[24], Data[25], Data[26], Data[27]
            ];
            print("(", Count, ")    ", s);
            listput(Sol, s);
        );

        Used[x] = 0;
    );
}


{
N = 27;
Sum = 42;
Data = vector(N);
Used = vector(N);
Count = 0;
Sol = List();
dfs(1);
listsort(Sol);

Rank123 = Sol[123];
printf("%d:", Count);
for (i = 1, N - 1, printf("%d,", Rank123[i]));
printf("%d\n", Rank123[N]);
}
