{
C = [1, 2, 5, 11, 23, 47, 101, 211];
B = [503, 1009, 2003, 5003, 10007];
MAXNC = 47;
P = 12345;

vc = vector(MAXNC + 1);
vc[1] = 1;
for (i = 0, #C - 1,
    vc1 = vector(MAXNC + 1);
    for (j = 0, MAXNC, for (k = 0, MAXNC - j,
        vc1[j + k + 1] += x^(j*C[i + 1]) * vc[k + 1];
    ));
    vc = vc1;
);
fc = vecsum(vc);
coec = Vecrev(fc);

fb = prod(i = 1, #B, (1 - x^((P \ B[i] + 1) * B[i])) / (1 - x^B[i]));
coeb = Vecrev(fb);

s = sum(i = 1, #coec, coec[i] * coeb[P - i + 2]);
print(s);
}
