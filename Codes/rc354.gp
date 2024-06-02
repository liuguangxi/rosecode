cross(p1, p2) = p1[1]*p2[2] - p2[1]*p1[2];


ptintri(p, a, b, c) = {
    sabc = abs(cross(b - a, c - b));
    sapb = abs(cross(p - a, b - p));
    sbpc = abs(cross(p - b, c - p));
    scpa = abs(cross(p - c, a - p));
    return(sabc == sapb + sbpc + scpa);
}


{
N = 10000;

pn = vector(N * 6);
seed = 641;
for (i = 1, N * 6,
    seed = (214013 * seed + 2531011) % 2147483647;
    pn[i] = seed % 1000;
);

s = 0;
for (i = 0, N - 1,
    if (ptintri([499, 499], [pn[i*6+1], pn[i*6+2]], [pn[i*6+3], pn[i*6+4]], [pn[i*6+5], pn[i*6+6]]),
        s++;
    );
);
print(s);
}
