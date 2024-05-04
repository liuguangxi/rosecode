getshortest(start) = {
    my(goal, mst, pos, queue, node, d, level, pos2, d2, t);

    goal = [2, 5, 3, 1, 7, 6, 4, 0, 8];
    if (start == goal, return(0));

    mst = Map();
    mapput(mst, fromdigits(goal), 1);
    queue = List();
    for (i = 1, 9, if (start[i] == 0, pos = i));
    listput(queue, concat(start, [pos, 0]));

    while (#queue > 0,
        node = queue[1]; listpop(queue, 1);
        d = node[1..9]; pos = node[10]; level = node[11] + 1;

        \\ Left
        if ((pos % 3 == 0) || (pos % 3 == 2),
            pos2 = pos - 1;
            d2 = d; t = d2[pos2]; d2[pos2] = d2[pos]; d2[pos] = t;
            if (d2 == goal, return(level));
            if (!mapisdefined(mst, fromdigits(d2)),
                mapput(mst, fromdigits(d2), 1);
                listput(queue, concat(d2, [pos2, level]));
            );
        );

        \\ Right
        if ((pos % 3 == 1) || (pos % 3 == 2),
            pos2 = pos + 1;
            d2 = d; t = d2[pos2]; d2[pos2] = d2[pos]; d2[pos] = t;
            if (d2 == goal, return(level));
            if (!mapisdefined(mst, fromdigits(d2)),
                mapput(mst, fromdigits(d2), 1);
                listput(queue, concat(d2, [pos2, level]));
            );
        );

        \\ Up
        if (pos >= 4,
            pos2 = pos - 3;
            d2 = d; t = d2[pos2]; d2[pos2] = d2[pos]; d2[pos] = t;
            if (d2 == goal, return(level));
            if (!mapisdefined(mst, fromdigits(d2)),
                mapput(mst, fromdigits(d2), 1);
                listput(queue, concat(d2, [pos2, level]));
            );
        );

        \\ Down
        if (pos <= 6,
            pos2 = pos + 3;
            d2 = d; t = d2[pos2]; d2[pos2] = d2[pos]; d2[pos] = t;
            if (d2 == goal, return(level));
            if (!mapisdefined(mst, fromdigits(d2)),
                mapput(mst, fromdigits(d2), 1);
                listput(queue, concat(d2, [pos2, level]));
            );
        );
    );
    print("No solution!"); return(-1);
}


{
Puzzle = [
253648107,275136408,317420658,123045867,513042786,203156478,503274186,207135486,203451786,503276148,
253170486,723056148,203156478,123068475,736120458,253746108,253746108,723618504,125078463,265173408,
253416708,253871406,203156478,512780463,253160478,543026718,253016478,203456718,207136458,536240187,
265173408,573016428,125486703,236015478,236015478,537281406,253076148,205173486,536278104,253847106,
275130486,128360475,203156478,125073486,203156478,268153407,513268407,103526478,253160478,236018457,
123560478,253187406,103528467,125863407,503276148,376024185,173026458,253076148,275460831,536278104,
253410786,423068571,561273408,512063478,236150478,723056148,253760148,123456708,307215486,203756148,
823057146,251063478,103576248,123056478,513270486,265138407,425183706,513268407,823157406,103526478,
237185406,123456708,253076148,253076148,275413806,125073486,615073248,425073816,537281406,253168407,
306278154,302165478,275183406,253047816,203467851,253168407,253180467,253176408,572163408,253187406
];

N = #Puzzle;
s = 0;
for (i = 1, N,
    x = digits(Puzzle[i]);
    shortest = getshortest(x);
    s += shortest;
    printf("(%d) %d %d\n", i, x, shortest);
);
smean = s / N;
printf("%.2f\n", smean);
}
