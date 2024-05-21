fuse(a, b) = {
    if (abs(a - b) < 1, return((a + b + 1) / 2), return(-1));
}


{
R = 111/64;
N = 13;

v = vector(N);
v[1] = List(); listput(v[1], [0, "0"]);
for (i = 2, N,
    v[i] = List();
    for (j = 1, i - 1,
        k = i - j;
        len1 = #v[j]; len2 = #v[k];
        for (i1 = 1, len1, for (i2 = 1, len2,
            x1 = v[j][i1][1]; x2 = v[k][i2][1];
            c = fuse(x1, x2);
            if (c > 0,
                str1 = v[j][i1][2]; str2 = v[k][i2][2];
                if (i < N,
                    str = concat(["(", str1, "~", str2, ")"]),
                    str = concat([str1, "~", str2]);
                );
                listput(v[i], [c, str]);
            );
        ));
    );
);

vsol = List();
for (i = 1, #v[N],
    if (v[N][i][1] == R,
        listput(vsol, v[N][i][2]);
    );
);
listsort(vsol);
for (i = 1, #vsol, printf("[%d]  %s\n", i, vsol[i]));
}
