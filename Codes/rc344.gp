f(Num, Value) = {
    my(v, vnew, k2, u);
    v = vector(Num, i, []); v[1] = [Value];
    for (k = 2, Num,
        vnew = List();
        for (k1 = 1, k-1,
            k2 = k-k1; v1 = v[k1]; v2 = v[k2];
            for (i = 1, #v1, for (j = 1, #v2,
                listput(vnew, v1[i] + v2[j]);
                listput(vnew, v1[i] - v2[j]);
                listput(vnew, v1[i] * v2[j]);
                if (v2[j] != 0, listput(vnew, v1[i] / v2[j]);)
            ));
        );
        v[k] = Set(vnew);
    );
    vn = select(x -> x>0 && denominator(x) == 1, v[Num]);
    u = 1; while (vn[u] == u, u++);
    return(u);
}


{
u4 = f(8, 4);
u5 = f(8, 5);
printf("%d,%d\n", u4, u5);
}
