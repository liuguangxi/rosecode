digb(digs, presum, d_start) = {
    my(z, steps, d_end, maxd, m, digs_0, m_0, presum_0, d_start_0, d_end_0, steps_0);
    if (mapisdefined(Md, [digs, presum, d_start], &z), return(z));
    if (digs <= 3,
        steps = 0;
        d_end = d_start;
        maxd = 10^digs;
        while (d_end < maxd,
            d_end += presum + sumdigits(d_end);
            steps++;
        );
        ,
        m = 10^digs;
        digs_0 = digs - 1;
        m_0 = 10^digs_0;
        presum_0 = presum + d_start \ m_0;
        d_start_0 = d_start % m_0;
        d_end = d_start;
        steps = 0;
        while (1,
            [d_end_0, steps_0] = digb(digs_0, presum_0, d_start_0);
            steps += steps_0;
            d_end = d_end \ m_0 * m_0 + d_end_0;
            if (d_end >= m, break);
            d_start_0 = d_end % m_0;
            presum_0 = presum + sumdigits(d_end \ m_0);
        );
    );
    mapput(Md, [digs, presum, d_start], [d_end, steps]);
    return([d_end, steps]);
}


calc(n) = {
    my(a, m, d_start, presum, d_end, steps);
    a = 1;
    forstep (digs = 17, 5, -1,
        m = 10^digs;
        while (1,
            d_start = a % m;
            presum = sumdigits(a \ m);
            [d_end, steps] = digb(digs, presum, d_start);
            if (steps <= n,
                n -= steps; a = a \ m * m + d_end,
                break;
            );
        );
    );
    for (k = 0, n - 1, a += sumdigits(a));
    return(a);
}


{
N = 10^17;
Md = Map();
s = calc(N - 1);
printf("x(%d) = %d\n", N, s);
}
