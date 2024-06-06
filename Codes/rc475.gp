/*
1*  2*  3*  4*
5*  6*  7*  8
9*  10  11  12
13  14  15  16
*/


dfs(k) = {
    for (i = 1, Lvp,
        if (Vuse[i], next);
        x = Vp[i];
        if (k <= 4,
            Vd[k] = x; Vuse[i] = 1;
            if (k == 4,
                Sum = vecsum(Vd[1..4]);
                print(Vd[1..4], " => ", Sum);
            );
            dfs(k + 1);
            Vd[k] = 0; Vuse[i] = 0;
        );
        if (k == 5,
            if (x <= Sum - 3*Pmin,
                Vd[k] = x; Vuse[i] = 1;
                dfs(k + 1);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 6,
            if (x <= Sum - 2*Pmin - Vd[5],
                Vd[k] = x; Vuse[i] = 1;
                dfs(k + 1);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 7,
            if (x <= Sum - Pmin - Vd[5] - Vd[6],
                Vd[k] = x; Vuse[i] = 1;
                dfs(k + 1);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 8,
            if (Vd[5] + Vd[6] + Vd[7] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(k + 1);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 9,
            if (x <= Sum - Pmin - Vd[1] - Vd[5],
                Vd[k] = x; Vuse[i] = 1;
                dfs(13);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 13,
            if (Vd[1] + Vd[5] + Vd[9] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(10);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 10,
            if (Vd[4] + Vd[7] + Vd[13] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(14);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 14,
            if (Vd[2] + Vd[6] + Vd[10] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(11);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 11,
            if (x <= Sum - Pmin - max(max(Vd[3] + Vd[7], Vd[1] + Vd[6]), Vd[9] + Vd[10]),
                Vd[k] = x; Vuse[i] = 1;
                dfs(12);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 12,
            if (Vd[9] + Vd[10] + Vd[11] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(15);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 15,
            if (Vd[3] + Vd[7] + Vd[11] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                dfs(16);
                Vd[k] = 0; Vuse[i] = 0;
            );
        );
        if (k == 16,
            if (Vd[13] + Vd[14] + Vd[15] + x == Sum && Vd[1] + Vd[6] + Vd[11] + x == Sum,
                Vd[k] = x; Vuse[i] = 1;
                printf("\n%d\n", Vd);
                Done = 1;
            );
        );

        if (Done, return);
    );
}


{
Pmin = 101; Pmax = 181;
Vp = primes([Pmin, Pmax]); Lvp = #Vp;
Vd = vector(16);
Vuse = vector(Lvp);
Sum = 0;
Done = 0;
dfs(1);
}
