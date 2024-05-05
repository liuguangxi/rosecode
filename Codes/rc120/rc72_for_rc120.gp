getshortest(start) = {
    my(goal, mst, pos, queue, node, d, level, pos2, d2, t);

    goal = [4, 5, 3, 0, 7, 1, 2, 8, 6];
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
Puzzle = [674823510,048726351,286407351,274683510,637082451,037826451,268307451,237684510];

N = #Puzzle;
s = vector(N);
for (i = 1, N,
    x = digits(Puzzle[i]);
    if (#x == 8, x = concat(0, x));
    shortest = getshortest(x);
    s[i] = shortest;
);

for (i = 1, N - 1, printf("%d,", s[i])); printf("%d\n", s[N]);    \\ 21,25,29,19,24,25,27,19
}
