dfs(n, imax, ivf) = {
    my(x, nnew);
    forstep (i = imax, 1, -1,
        x = F[i];
        if (x > n, next);
        nnew = n - x;
        Vf[ivf] = i - 1;
        if (nnew == 0,
            listput(Sol, Vecrev(Vf[1..ivf])),
            if (i > 1,
                if (nnew > SF[i - 1], break, dfs(nnew, i - 1, ivf + 1));
            );
        );
    );
}


cmpf(v1, v2) = {
    my(lenv1 = #v1, lenv2 = #v2);
    if (lenv1 != lenv2,
        return(lenv1 - lenv2),
        for (i = 1, lenv1,
            if (v1[i] != v2[i], return(v1[i] - v2[i]));
        );
        return(0);
    );
}


{
N = 1234568;

F = List();
for (i = 2, 100,
    x = fibonacci(i);
    if (x <= N, listput(F, x), break);
);
F = Vec(F); LenF = #F;
SF = F; for (i = 2, LenF, SF[i] += SF[i - 1]);

Vf = vector(LenF);
Sol = List();
dfs(N, LenF, 1);

Sol = vecsort(Vec(Sol), cmpf); count = #Sol;
indexes = Sol[count\2+1]; lenidx = #indexes;
printf("%d/", count);
for (i = 1, lenidx-1, printf("%d,", indexes[i]));
printf("%d\n", indexes[lenidx]);
}
