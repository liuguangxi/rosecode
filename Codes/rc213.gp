{
N = 40;

S1 = primes(primepi(N));
S2 = select(x -> vecsum(factor(x)[,2]) == 2, [1..N]);
S3 = setminus([1..N], setunion(S1, S2));
[L1, L2, L3] = [#S1, #S2, #S3];

M1 = vector(N*4, i, List());
for (i1 = 1, L1-3, for (i2 = i1+1, L1-2, for (i3 = i2+1, L1-1, for (i4 = i3+1, L1,
    sum1 = S1[i1] + S1[i2] + S1[i3] + S1[i4];
    listput(M1[sum1], [S1[i1], S1[i2], S1[i3], S1[i4]]);
))));

M2 = vector(N*4, i, List());
for (i1 = 1, L2-3, for (i2 = i1+1, L2-2, for (i3 = i2+1, L2-1, for (i4 = i3+1, L2,
    sum2 = S2[i1] + S2[i2] + S2[i3] + S2[i4];
    listput(M2[sum2], [S2[i1], S2[i2], S2[i3], S2[i4]]);
))));

M3 = vector(N*4, i, List());
for (i1 = 1, L3-3, for (i2 = i1+1, L3-2, for (i3 = i2+1, L3-1, for (i4 = i3+1, L3,
    sum3 = S3[i1] + S3[i2] + S3[i3] + S3[i4];
    listput(M3[sum3], [S3[i1], S3[i2], S3[i3], S3[i4]]);
))));

count = 0;
for (x = 1, N*4,
    if (#M1[x] == 0 || #M2[x] == 0 || #M3[x] <= 1, next);
    printf("Sum = %d\n", x);
    v1 = M1[x]; v2 = M2[x]; v3 = M3[x];
    for (i1 = 1, #v1,
        for (i2 = 1, #v2,
            if (v1[i1][1] >= v2[i2][1], next);
            for (i3 = 1, #v3-1,
                if (v2[i2][1] >= v3[i3][1], next);
                for (i4 = i3+1, #v3,
                    if (v3[i3][1] >= v3[i4][1], next);
                    if (#setintersect(v3[i3], v3[i4]) == 0,
                        count++;
                    );
                );
            );
        );
    );
);
print(count);
}
