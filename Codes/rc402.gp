/* xi = xi[1]*w^2 + xi[2]*w + xi[3] */
ord_add(x1, x2) = {
    if (x1[1] == 0,
        if (x2[1] != 0,
            return(x2),
            return([0, x1[2]+x2[2], x2[3]]);
        );
    );

    /* x1[1] != 0 */
    if (x2[1] != 0,
        return([x1[1]+x2[1], x2[2], x2[3]]),
        return([x1[1], x1[2]+x2[2], x2[3]]);
    );
}


{
Sigma = [[1, 0, 0], [0, 1, 1], [0, 2, 2], [0, 4, 3], [0, 8, 4]];
v = List();
forperm (5, p,
    x = [0, 0, 0];
    for (i = 1, 5, x = ord_add(x, Sigma[p[i]]));
    listput(v, x);
);
v = Set(v);
cnt = #v;
v1 = v[1]; v17 = v[17];
print(cnt, ",", v1, ",", v17);    \\ 33,w^2,w^2+w.10+2
}
