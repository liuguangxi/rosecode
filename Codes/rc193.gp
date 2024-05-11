{
[p1, p2, p3] = factor(27126986671934931497)[,1]~;
v1 = List();
for (x = 0, p1 - 2,
    if (lift(11 + Mod(105, p1)^x) == 0, listput(v1, Mod(x, p1 - 1)));
);
v1 = Vec(v1); lv1 = #v1;
v2 = List();
for (x = 0, p2 - 2,
    if (lift(11 + Mod(105, p2)^x) == 0, listput(v2, Mod(x, p2 - 1)));
);
v2 = Vec(v2); lv2 = #v2;
v3 = List();
for (x = 0, p3 - 2,
    if (lift(11 + Mod(105, p3)^x) == 0, listput(v3, Mod(x, p3 - 1)));
);
v3 = Vec(v3); lv3 = #v3;

v = List();
for (i1 = 1, lv1, for (i2 = 1, lv2, for (i3 = 1, lv3,
    z = iferr(chinese([v1[i1], v2[i2], v3[i3]]), E, -1);
    if (lift(z) != -1, listput(v, lift(z)));
)));
v = vecsort(Vec(v)); lv = #v;

N = 10^4; M = 10^9;
r = N % lv;
if (r == 0,
    q = N / lv - 1; r = lv,
    q = N \ lv;
);
s = q * lcm([p1-1,p2-1,p3-1]) + v[r];
print(s % M);
}
