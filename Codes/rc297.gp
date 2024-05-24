farey_unit(n) = {
    my(p, x1, y1, x2, y2);
    p = List();
    x1 = 0; y1 = 1;
    while (1,
        listput(p, [x1, y1] );
        if ([x1, y1] == [1, 1], break);
        [x2, y2, g] = gcdext(y1, -x1);
        r = (n - y2) \ y1; x2 += r * x1; y2 += r * y1;
        [x1, y1] = [x2, y2];
    );
    return(p);
}


{
/*
N = 100;
pnz = farey_unit(N);
area = sum(i = 1, #pnz-1, abs(pnz[i][1]*pnz[i+1][2] - pnz[i+1][1]*pnz[i][2])) / 2;
print(area);
*/

N = 10000000;
area = sum(i = 1, N, eulerphi(i)) / 2;
print(area);
}
