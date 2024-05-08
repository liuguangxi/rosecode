f(v) = {
    my(len, t, rep);
    len = #v;
    t = 1; rep = 1;
    forstep (i = len, 1, -1,
        t *= Vd[v[i]] - (len - i);
        if (i < len,
            if (v[i] == v[i + 1],
                rep++,
                t /= rep!; rep = 1;
            );
        );
    );
    t /= rep!;
    print(v, "  ", t);
    return(t);
}


{
N = 1001;
VecCol = [
    [6], [1, 5], [2, 4], [3, 3], [1, 1, 4], [1, 2, 3], [2, 2, 2],
    [1, 1, 1, 3], [1, 1, 2, 2], [1, 1, 1, 1, 2], [1, 1, 1, 1, 1, 1]
];
VecNum = [1, 1, 2, 2, 2, 3, 6, 5, 8, 15, 30];
Vd = vector(6, i, (N - i) \ 6 + 1);
forstep (i = 6, 2, -1, Vd[i - 1] += Vd[i]);
s = sum(i = 1, #VecCol, VecNum[i] * f(VecCol[i]));
printf("F(%d) = %d\n", N, s);
}
