/*
88205 =
-1+2*(-3^4+56*789)
*/


findsol(n, i, j) = {
    for (k = i, j - 1,
        v1 = f[i,k]; v2 = f[k+1,j];
        for (i1 = 1, #v1, for (i2 = 1, #v2,
            x = v1[i1]; y = v2[i2];
            if (abs(x + y) == n, print([i, j, k], "  ", x, " + ", y); return);
            if (abs(x - y) == n, print([i, j, k], "  ", x, " - ", y); return);
            if (abs(x * y) == n, print([i, j, k], "  ", x, " * ", y); return);
            if (y != 0 && abs(x / y) == n, print([i, j, k], "  ", x, " / ", y); return);
            if (x <= 20 && y <= 20 && x^y == n, print([i, j, k], "  ", x, " ^ ", y); return);
        ));
    );
}


{
f = matrix(9, 9);
for (i = 1, 9, f[i,i] = [i]);
for (l = 2, 9, for (i = 1, 10 - l,
    j = i + l - 1;
    v = List();
    for (k = i, j - 1,
        v1 = f[i,k]; v2 = f[k+1,j];
        for (i1 = 1, #v1, for (i2 = 1, #v2,
            x = v1[i1]; y = v2[i2];
            listput(v, abs(x + y));
            listput(v, abs(x - y));
            listput(v, abs(x * y));
            if (y != 0 && x % y == 0, listput(v, abs(x / y)));
            if (x <= 20 && y <= 20 && x^y < 10^6, listput(v, x ^ y));
        ));
    );
    listput(v, fromdigits([i..j]));
    f[i,j] = Set(v);
));

findsol(88205, 1, 9);
findsol(88206, 2, 9);
findsol(44103, 3, 9);
findsol(44184, 5, 9);
}
