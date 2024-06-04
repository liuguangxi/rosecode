{
A = readvec("d392.txt");
lb = A[1]; rb = A[1] + 1;
for (n = 1, #A,
    l = A[n] / n; r = l + 1/n;
    lb = max(lb, l); rb = min(rb, r);
);
a = (lb + rb) / 2;
a = floor(a * 10^6) / 10^6;
printf("%.6f\n", a);    \\ 4.669201
}
