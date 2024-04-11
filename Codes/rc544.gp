{
N = 1000;
M = 100000009;
vd = divisors(N); lenvd = #vd;
s = 0;
for (i1 = 1, lenvd, for (i2 = 1, lenvd, for (i3 = 1, lenvd, for (i4 = 1, lenvd,
    if (vd[i1] * vd[i2] * vd[i3] * vd[i4] == N,
        s++;
        print([vd[i1], vd[i2], vd[i3], vd[i4]]);
    );
))));
s = s * N! % M;
print(s);
}
