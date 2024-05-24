farey(n, z) = {
    my(p, x1, y1, x2, y2);
    p = List();
    x1 = 0; y1 = 1;
    while (1,
        listput(p, [x1, y1] * z);
        if ([x1, y1] == [1, 1], break);
        [x2, y2, g] = gcdext(y1, -x1);
        r = (n - y2) \ y1; x2 += r * x1; y2 += r * y1;
        [x1, y1] = [x2, y2];
    );
    return(p);
}


{
T = 2000;
n = 1;
while (1,
    pnz = farey(n, 2);
    area = sum(i = 1, #pnz-1, abs(pnz[i][1]*pnz[i+1][2] - pnz[i+1][1]*pnz[i][2])) / 2;
    outer = sum(i = 1, #pnz-1, gcd(pnz[i+1][1]-pnz[i][1], pnz[i+1][2]-pnz[i][2]));
    outer += gcd(pnz[1][1], pnz[1][2]) + gcd(pnz[#pnz][1], pnz[#pnz][2]);
    inner = area + 1 - outer/2;
    print("P[", n, "]    area = ", area, "    outer = ", outer, "    inner = ", inner);
    if (inner > T, break);
    n++;
);
printf("%d,%d\n", n, inner);
}
