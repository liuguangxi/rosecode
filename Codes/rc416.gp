dfs(k) = {
    my(cross(x1, y1, x2, y2) = x1 * y2 - x2 * y1);
    my(idx, c);
    if (k == 1,
        for (d = 1, 9, Vd[k] = d; dfs(k + 1));
    );
    if (k == 2,
        for (d = 0, 9,
            Vd[k] = d; idx = Vd[k-1]*10+Vd[k] + 1;
            Vuse[idx] = 1; dfs(k + 1); Vuse[idx] = 0;
        );
    );
    if (k == 3,
        for (d = 0, 9,
            Vd[k] = d; idx = Vd[k-1]*10+Vd[k] + 1;
            if (Vuse[idx], next);
            Vuse[idx] = 1; dfs(k + 1); Vuse[idx] = 0;
        );
    );
    if (k == 4,
        for (d = 0, 9,
            Vd[k] = d; idx = Vd[k-1]*10+Vd[k] + 1;
            if (Vuse[idx], next);
            c = cross(Vd[2]-Vd[1], Vd[3]-Vd[2], Vd[3]-Vd[2], Vd[4]-Vd[3]);
            if (c == 0, next, Dir = c);
            Count++; Sum += fromdigits(Vd[1..k]);
            Vuse[idx] = 1; dfs(k + 1); Vuse[idx] = 0;
        );
    );
    if (k > 4,
        for (d = 0, 9,
            Vd[k] = d; idx = Vd[k-1]*10+Vd[k] + 1;
            if (Vuse[idx], next);
            if (cross(Vd[k-2]-Vd[k-3], Vd[k-1]-Vd[k-2], Vd[k-1]-Vd[k-2], Vd[k]-Vd[k-1]) * Dir <= 0, next);
            if (cross(Vd[k-1]-Vd[k-2], Vd[k]-Vd[k-1], Vd[1]-Vd[k-2], Vd[2]-Vd[k-1]) * Dir <= 0, next);
            if (cross(Vd[k-1]-Vd[1], Vd[k]-Vd[2], Vd[1]-Vd[2], Vd[2]-Vd[3]) * Dir <= 0, next);
            Count++; Sum += fromdigits(Vd[1..k]);
            Vuse[idx] = 1; dfs(k + 1); Vuse[idx] = 0;
        );
    );
}


{
gettime();
Vd = vector(100); Vuse = vector(100);
Dir = 0; Count = 0; Sum = 0;
dfs(1);
printf("%d,%d\n", Count, Sum);
printf("time = %d ms\n", gettime());
}
