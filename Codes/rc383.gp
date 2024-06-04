dfs(k, p, q) = {
    my(m, PQmod, p1, q1);
    if (Found, return);
    m = 2^k;
    PQmod = PQ % m;
    if (k == Lv,
        while (p * q <= PQ,
            if (p * q == PQ,
                if (p < q, printf("%d,%d\n", p, q), printf("%d,%d\n", q, p));
                Found = 1; return;
                ,
                p += m; q += m;
            );
        );
        ,
        if (Vxor[k + 1] == 0,
            if (p * q % m == PQmod, dfs(k + 1, p, q));
            [p1, q1] = [p + m, q + m];
            if (p1 * q1 % m == PQmod, dfs(k + 1, p1, q1));
            ,
            [p1, q1] = [p + m, q];
            if (p1 * q1 % m == PQmod, dfs(k + 1, p1, q1));
            [p1, q1] = [p, q + m];
            if (p1 * q1 % m == PQmod, dfs(k + 1, p1, q1));
        );
    );
}


{
PQ = 25021280035441905627372198214765572382628368011642948611923288271186128054172457672472582525510063;
PQxor = 10896394514466713067376536898727387282419639480038;
Vxor = Vecrev(binary(PQxor)); Lv = #Vxor;
Found = 0;
dfs(0, 0, 0);
}
