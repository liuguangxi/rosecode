{
d1 = vecsum([0, 5, 6, 7, 8, 9]) * 6;
c1 = 10!/2!/3!/4!;
d2 = vecsum(c1 * [1/10, 2/10*2, 3/10*3, 4/10*4]);
c2 = 6^2;

s = 0;
for (i1 = 0, 10, for (i2 = i1 + 1, 11,
    s += c1 * d1 * (10^i1 + 10^i2);
    v = setminus([0..11], [i1, i2]);
    s += c2 * d2 * sum(i = 1, 10, 10^v[i]);
));
print(s);
}
