{
cnt = 0; s = 0;
for (k = 2, 6,
    A0 = k; B0 = 1;
    x1min = B0 \ (A0-B0) + 1;
    x1max = ceil(1/((A0/B0)^(1/6)-1)) - 1;
    for (x1 = x1min, x1max,
        A1 = A0 * x1; B1 = B0 * (x1+1);
        x2min = max(x1 + 1, B1\(A1-B1) + 1);
        x2max = ceil(1/((A1/B1)^(1/5)-1)) - 1;
        for (x2 = x2min, x2max,
            A2 = A1 * x2; B2 = B1 * (x2+1);
            x3min = max(x2 + 1, B2\(A2-B2) + 1);
            x3max = ceil(1/((A2/B2)^(1/4)-1)) - 1;
            for (x3 = x3min, x3max,
                A3 = A2 * x3; B3 = B2 * (x3+1);
                x4min = max(x3 + 1, B3\(A3-B3) + 1);
                x4max = ceil(1/((A3/B3)^(1/3)-1)) - 1;
                for (x4 = x4min, x4max,
                    A4 = A3 * x4; B4 = B3 * (x4+1);
                    x5min = max(x4 + 1, B4\(A4-B4) + 1);
                    x5max = ceil(1/((A4/B4)^(1/2)-1)) - 1;
                    for (x5 = x5min, x5max,
                        A5 = A4 * x5; B5 = B4 * (x5+1);
                        if ((B5-1) % (A5-B5) == 0,
                            x6 = (B5-1) / (A5-B5);
                            cnt++;
                            s += x1 + x2 + x3 + x4 + x5 + x6 + 6;
                            printf("[k = %d]    %d, %d, %d, %d, %d, %d\n",
                                k, x1+1, x2+1, x3+1, x4+1, x5+1, x6+1);
                        );
                    );
                );
            );
        );
    );
);
printf("%d,%d\n", cnt, s);
}
