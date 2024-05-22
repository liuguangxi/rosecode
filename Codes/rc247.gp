calc(p) = {
    my(vrun, kp, vedge, r, lenvedge, crossings = 0, nestings = 0);
    vrun = List(); kp = 1;
    for (k = 2, N, if (p[k] < p[k - 1], listput(vrun, p[kp..k-1]); kp = k));
    listput(vrun, p[kp..N]);
    vedge = List();
    for (i = 1, #vrun,
        r = vrun[i];
        for (j = 1, #r - 1, listput(vedge, [r[j], r[j + 1]]));
    );
    listsort(vedge);
    lenvedge = #vedge;
    for (i = 1, lenvedge - 1, for (j = i + 1, lenvedge,
        if (vedge[j][1] < vedge[i][2],
            if (vedge[j][2] < vedge[i][2], nestings++, crossings++),
            break;
        );
    ));
    return([crossings, nestings]);
}


{
N = 10;
Cross = 4; Nest = 8;

count = 0; permlast = 0;
for (i = 0, N! - 1,
    p = numtoperm(N, i);
    [c, n] = calc(p);
    if (c == Cross && n == Nest,
        count++; permlast = p;
        print(p);
    );
);

printf("%d/", count);
for (i = 1, N - 1, printf("%d,", permlast[i]));
printf("%d\n", permlast[N]);
}
