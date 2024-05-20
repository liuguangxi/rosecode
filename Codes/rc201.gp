/* Number of integers can be divided by t with sod = t in range [1, 10^K-1] */
calc(t) = {
    my(f1, f2, ret, sir);
    f1 = matrix(Sod, t);
    for (d = 1, 9, f1[d,d%t+1] = 1);
    ret = f1[t,1];
    for (k = 2, K,
        f2 = matrix(Sod, t);
        for (d = 0, 9, for (i = 1, Sod - d, for (r = 0, t - 1,
            f2[i+d,(r*10+d)%t+1] += f1[i,r+1];
        )));
        f1 = f2;
        ret += f1[t,1];
    );
    printf("C(%d) = %d\n", t, ret);
    return(ret);
}


{
K = 15;
Sod = 9*K;
s = sum(i = 1, Sod, calc(i));
print(s);
}
