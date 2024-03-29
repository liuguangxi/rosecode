{
Swamp = [
".......XXX......XX.....X.X.XX.",
"XK....XXXXXXXX..XX............",
"X......XXXXX....XX.X.X.X....X.",
".......XXX....XX..............",
"..............XX...........XX.",
"...........................XX.",
"...XX....XX................XX.",
"..XXXX.....................X..",
"..XXXX........................",
"...XX.........XX....X....XXX..",
"........XX....XX.X..X..X.XGX..",
".......XX................XXX.."
];

Nr = #Swamp; Nc = #Swamp[1];
S = vector(Nr, i, Vec(Swamp[i]));
for (r = 1, Nr, for (c = 1, Nc,
    if (S[r][c] == "K", start = [r, c]; S[r][c] = "X");
    if (S[r][c] == "G", goal = [r, c]; S[r][c] = "X");
));

D = [[1, 0], [0, 1], [-1, 0], [0, -1]];
dir = matrix(Nr, Nc);
t = matrix(Nr, Nc, r, c, 10^9); t[start[1], start[2]] = 0;
queue = List(); listput(queue, start);
while (#queue > 0,
    pos = queue[1]; listpop(queue, 1);
    for (k = 1, 4,
        cudir = D[k];
        cur = pos + cudir; hop = 1;
        while (cur[1] >= 1 && cur[1] <= Nr && cur[2] >= 1 && cur[2] <= Nc,
            if (S[cur[1]][cur[2]] == "X",
                tnew = t[pos[1],pos[2]] + 1 + (hop-1)^2;
                if (dir[pos[1],pos[2]] != 0 && cudir != dir[pos[1],pos[2]], tnew++);
                if (tnew < t[cur[1],cur[2]],
                    t[cur[1],cur[2]] = tnew;
                    dir[cur[1],cur[2]] = cudir;
                    listput(queue, cur);
                );
            );
            cur += cudir; hop++;
        );
    );
);

print(t[goal[1], goal[2]]);
}
