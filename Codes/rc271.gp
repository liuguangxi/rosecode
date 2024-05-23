f(a, b, c) = {
    my(p, q, x, y, PQ, s);
    p = (a + b + c) / 2;
    q = b * c / 2;
    PQ = sqrt((a + b + c) * (3*a - b - c))/2;
    x = (p + sqrt(p^2-4*q))/2;
    y = p - x;
    s = List();
    printf("x = %.5f, y = %.5f, c = %d, b = %d\n", x, y, c, b);
    if (x < c && y < b, listput(s, PQ));
    if (y < c && x < b, listput(s, PQ));
    return(s);
}


{
s = concat([f(7182, 8182, 8459), f(8182, 8459, 7182), f(8459, 7182, 8182)]);
listsort(s);
for (i = 1, #s-1, printf("%.5f,", s[i]));
printf("%.5f\n", s[#s]);
}
