/* Answer: 39,999981 */


{
a = 3; b = 1;

v = vector(100, i, (a + sumdigits(i - 1)) % 11);
v = concat(v,  vector(100, i, (b + sumdigits(i - 1)) % 11));
vidx = List(); for (i = 1, 200, if (v[i] == 0, listput(vidx, i)));
vidx = Vec(vidx);
print(vidx);
h = vecmax(vector(#vidx - 1, i, vidx[i + 1] - vidx[i]));

for (i = 0, 10^8,
    if (sumdigits(i) % 11 == a && sumdigits(i + 1) % 11 == b,
        x = i; break;
    );
);
e = x * 100 + 81;

printf("%d,%d\n", h, e);
}
