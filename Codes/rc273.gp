gen(x1, x2) = [x1[1]*x2[2]+x1[2]*x2[1], abs(7*x1[1]*x2[1]-x1[2]*x2[2])];


genx(r, x) = {
    mapput(m, r, x);
    printf("2^%d = 7*%d^2 + %d^2\n", r, x[1], x[2]);
    for (k = 1, 10,
        r *= 2; x = gen(x, x);
        while (x % 2 == [0, 0], r -= 2; x /= 2);
        if (r > 200, break);
        mapput(m, r, x);
        printf("2^%d = 7*%d^2 + %d^2\n", r, x[1], x[2]);
    );
}


genxy(rx, x, ry, y) = {
    my(r, z);
    r = rx + ry;
    z = gen(x, y);
    while (z % 2 == [0, 0], r -= 2; z /= 2);
    return([r, z[1], z[2]]);
}


{
mr = Map();
forstep (x = 3, 21, 2,
    r = x;
    lr = List();
    listput(lr, r);
    for (i = 1, 10, r = 2*(r-1); if (r <= 200, listput(lr, r), break));
    mapput(mr, lr[1], lr);
);

m = Map();
genx(3, [1, 1]);
genx(5, [1, 5]);
genx(7, [1, 11]);
genx(9, [7, 13]);
genx(11, [17, 5]);
genx(13, [23, 67]);
genx(15, [1, 181]);
genx(17, [89, 275]);
genx(19, [271, 101]);
genx(21, [457, 797]);

forstep (x = 3, 19, 2, forstep (y = x + 2, 21, 2,
    lrx = mapget(mr, x); lry = mapget(mr, y);
    for (ix = 1, #lrx, for (iy = 1, #lry,
        rx = lrx[ix]; ry = lry[iy];
        res = genxy(rx, mapget(m, rx), ry, mapget(m, ry));
        if (res[1] == 200,
            printf("From rx = %d, ry = %d\n", rx, ry);
            printf("2^%d = 7*%d^2 + %d^2\n", res[1], res[2], res[3]);
            printf("%d,%d\n", res[2], res[3]);
            break(4);
        );
    ));
));
}
