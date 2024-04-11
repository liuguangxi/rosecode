/*
Input: x, y
    x > y > 0 and gcd(x, y) = 1
Output: x1, y1
    y1/x1 < y/x and x1*y - y1*x = 1
*/
f(x, y) = {
    my(x1, y1, d);
    [x1, y1, d] = gcdext(y, -x);
    if (x1 < 0 || y1 < 0, x1 += x; y1 += y);
    return([x1, y1]);
}


peri(x1, y1, x2, y2) = {
    my(s);
    s = sqrt(x1^2+y1^2) + sqrt(x2^2+y2^2) + sqrt((x1-x2)^2+(y1-y2)^2);
    return(s);
}


s2(x1, y1, x2, y2) = {
    my(s);
    s = (x1^2+y1^2) + (x2^2+y2^2) + ((x1-x2)^2+(y1-y2)^2);
    return(s);
}


check(r, x, y) = {
    my(xh, ym);
    xh = x \ 2;
    forstep (xx = xh, max(xh - 2, 0), -1,
        ym = min(sqrtint(r^2 - xx^2), y);
        if ((x-xx)^2 + (y-ym)^2 <= r^2, return(1));
    );
    return(0);
}


{
R = 123456789;

pmax = 0;
x1opt = 0; y1opt = 0;
x2opt = 0; y2opt = 0;

ymax = floor(sqrt(2)*R);
for (y = 1, ymax,
    xmax = sqrtint(4*R^2 - y^2);
    forstep (x = xmax, y+1, -1,
        if (gcd(x, y) !=1, next);
        [xx, yy] = f(x, y);
        if (check(R, x, y),
            p = peri(x, y, xx, yy);
            if (p > pmax,
                pmax = p;
                x1opt = x; y1opt = y;
                x2opt = xx; y2opt = yy;
                printf("%.10f  ->  (%d, %d)  (%d, %d)\n", p, x, y, xx, yy);
            );
            break;
        );
    );
);
print(s2(x1opt, y1opt, x2opt, y2opt));    \\ 93649378161419608
}
