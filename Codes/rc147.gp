T(x, y, z) = {
    my(m, t, t1, t2, t3);
    if (x <= y, return([y, 0]));
    if (mapisdefined(MT, [x, y, z], &m),
        return(m),
        t1 = T(x-1, y, z); t2 = T(y-1, z, x); t3 = T(z-1, x, y);
        t = T(t1[1], t2[1], t3[1]);
        m = [t[1], 1+t1[2]+t2[2]+t3[2]+t[2]];
        mapput(MT, [x, y, z], m);
        return(m);
    );
}


{
N = 100;
MT = Map();
T(N, 0, N + 1);
E = mapget(MT, [N, 0, N + 1])[2];
printf("E(%d) = %d\n", N, E);
printf("SOD(E(%d)) = %d\n", N, sumdigits(E));
}
