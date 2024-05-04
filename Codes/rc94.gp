{
V = List();
for (i1 = 1, 6, for (j1 = i1 + 1, 7,
    v1 = [1..7];
    t = v1[i1]; v1[i1] = v1[j1]; v1[j1] = t;
    for (i2 = 1, 6, for (j2 = i2 + 1, 7,
        v2 = v1;
        t = v2[i2]; v2[i2] = v2[j2]; v2[j2] = t;
        listput(V, v2);
    ));
));
s = #Set(V);
print(s);
}
