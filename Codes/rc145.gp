f(x, y, z) = {
    my(s2, s);
    s2 = ((3*(x - y + z) * (y - x + z) * (x + y - z) * (x + y + z))^(1/2) + x^2 + y^2 + z^2) / 2;
    s = sqrt(s2);
    return(s);
}


chk(x, y, z, s) = {
    my(r, a, b, c, TH);
    TH = Pi + 1e-4;
    a = acos((x^2+y^2-s^2)/2/x/y);
    b = acos((y^2+z^2-s^2)/2/y/z);
    c = acos((z^2+x^2-s^2)/2/z/x);
    if (a + b > TH && b + c > TH && c + a > TH, return(1), return(0));
}


{
N = 100;
cnt = 0; sums = 0;
for (x = 1, N - 1, for (y = x, N - 1, for (z = y, N - 1,
    if (z >= x + y, break);
    s = f(x, y, z);
    if (chk(x, y, z, s),
        cnt++; sums += s;
    );
)));
printf("%d,%.3f\n", cnt, sums);
}
