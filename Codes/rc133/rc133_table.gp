f(m, n) = {
    my(n2 = 2^n, mc = matrix(n2, n2), bvi, bvj, x, flag, v, vnew);

    for (i = 0, n2 - 1,
        bvi = binary(i + n2);
        for (j = 0, n2 - 1,
            bvj = binary(j + n2);
            x = 0; flag = 1;
            for (k = 2, n + 1,
                x = 2 - x - bvi[k] - bvj[k];
                if (x < 0 || x > 1, flag = 0; break);
            );
            mc[i + 1, j + 1] += flag;
            x = 1; flag = 1;
            for (k = 2, n + 1,
                x = 2 - x - bvi[k] - bvj[k];
                if (x < 0 || x > 1, flag = 0; break);
            );
            mc[i + 1, j + 1] += flag;
        );
    );

    v = vector(n2, i, 1);
    for (i = 1, m,
        vnew = vector(n2);
        for (j = 1, n2, for (k = 1, n2,
            vnew[j] += v[k] * mc[j, k];
        ));
        v = vnew;
    );
    return(vecsum(v));
}


{
N = 8;
for (M = 1, 72,
    printf("f(%d, %d) = %d\n", M, N, f(M, N));
);
}
