{
\\ y = SOD(x) = [1..SODMax], SOD(n - y) = y

NExp = 2222222222224;
NTail = 10000000000002;
SODMax = 9*(NExp+1);
vx = List();

\\ (1) 1 <= y <= NTail
lendy = #digits(NTail);
for (y = 1, 1+9*lendy,
    if (y > NTail, break);
    if (1 + sumdigits(NTail - y) == y,
        printf("SOD(x) = %d\n", y);
        listput(vx, y);
    );
);

\\ (2) NTail < y <= SODMax
leny = #digits(SODMax-NTail);
y0 = 9*(NExp-leny);
for (y = y0, y0+9*lendy,
    if (y0 + sumdigits(10^leny + NTail - y) == y,
        printf("SOD(x) = %d\n", y);
        listput(vx, y);
    );
);

\\ Results
listsort(vx);
for (i = 1, #vx-1, printf("%d,", vx[i]));
printf("%d\n", vx[#vx]);
}
