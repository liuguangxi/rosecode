{
J1 = 19937; J2 = 23209;
Jgoal = 641; Jm = 19936;

\\ Init
queue = List(); listput(queue, [0, 0, 0]);
mapj = Map(); mapput(mapj, [0, 0], 1);
k = 1;
while (k <= #queue,
    node = queue[k]; levelnew = node[3] + 1;

    \\ Full one jug
    nodenew = [J1, node[2]];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );
    nodenew = [node[1], J2];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );

    \\ Empty one jug
    nodenew = [0, node[2]];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );
    nodenew = [node[1], 0];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );

    \\ Fill one jug with another
    nodenew = [max(0, node[1]+node[2]-J2), min(node[1]+node[2], J2)];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );
    nodenew = [min(node[1]+node[2], J1), max(0, node[1]+node[2]-J1)];
    if (!mapisdefined(mapj, nodenew),
        mapput(mapj, nodenew, 1);
        listput(queue, concat(nodenew, levelnew));
    );

    k++;
);

\\ Search M1
for (i = 1, #queue,
    x = queue[i];
    if (x[1] == Jgoal || x[2] == Jgoal, M1 = x[3]; break);
);

\\ Search C2, M2
vj = vector(Jm);    \\ [moves, capacity]
for (i = 1, #queue,
    x = queue[i];
    if (1 <= x[1] && x[1] <= Jm && vj[x[1]] == [], vj[x[1]] = [x[3], x[1]]);
    if (1 <= x[2] && x[2] <= Jm && vj[x[2]] == [], vj[x[2]] = [x[3], x[2]]);
);
vjsort = vecsort(vj);
[M2, C2] = vjsort[Jm];

\\ Print
printf("%d,%d,%d\n", M1, C2, M2);
}
