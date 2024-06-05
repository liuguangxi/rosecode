f(rn, rm) = rm^2 * rn / (rm*rn - rn + 1);


{
M = 19; N = 23;

v = vector(M + N, i, 1 + fibonacci(i) % 5);
TM = vecsum(v[1..M]); TN = vecsum(v[M+1..M+N]);
vrm = vector(M); vrn = vector(N);
vrm[1] = v[1]; for (i = 2, M, vrm[i] = vrm[i - 1] + v[i]); vrm /= TM;
vrn[1] = v[M + 1]; for (i = 2, N, vrn[i] = vrn[i - 1] + v[M + i]); vrn /= TN;

a = List();
for (i = 1, N, for (j = 1, M,
    s1 = f(vrn[i], vrm[j]);
    if (i == 1, s2 = 0, s2 = f(vrn[i - 1], vrm[j]));
    if (j == 1, s3 = 0, s3 = f(vrn[i], vrm[j - 1]));
    if (i == 1 || j == 1, s4 = 0, s4 = f(vrn[i - 1], vrm[j - 1]));
    s = s1 - s2 - s3 + s4;
    listput(a, s);
));

a_sort = vecsort(Vec(a));
len_a = #a_sort;
area_first = a_sort[1];
area_last = a_sort[len_a];
if (len_a % 2 == 1,
    area_median = a_sort[(len_a + 1) / 2],
    area_median = (a_sort[len_a / 2] + a_sort[len_a / 2 + 1]) / 2;
);
printf("%s,%s,%s\n", area_first, area_median, area_last);
}
