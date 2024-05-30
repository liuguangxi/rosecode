chk(x, y, R) = {
    my(x0);
    x0 = x \ 2;
    return(sqrtint(R^2-x0^2) + sqrtint(R^2-(x-x0)^2) >= y);
}


calc(x, y) = {
    my(x1, y1, x2, y2, x3, y3, p, s);
    x1 = x; y1 = y;
    [u, v, d] = gcdext(x1, -y1);
    if (u <= 0 || v <= 0,
        x2 = v + x1; y2 = u + y1,
        x2 = v; y2 = u;
    );
    x3 = x1 - x2; y3 = y1 - y2;
    p = sqrt(x2^2+y2^2) + sqrt(x3^2+y3^2);
    s = [x2, y2, x3, y3];
    return([p, s]);
}


{
R = 10^8;
bestp = 0; bests = 0;
xmin = floor(sqrt(2)*R);
forstep (x = 2*R-1, xmin, -1,
    if (x % 10^6 == 0, print("x = ", x));
    y = sqrtint(4*R^2 - x^2);
    while (y > 0 && (gcd(x, y) != 1 || chk(x, y, R) == 0), y--);
    [p, s] = calc(x, y);
    if (p > bestp,
        bestp = p; bests = s;
        printf("(%d, %d), p = %.16f, s = %d\n", x, y, p, s);
    );
);
printf("%d,%d,%d,%d\n", bests[1], bests[2], bests[3], bests[4]);
}
