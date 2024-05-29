check(x0, y0, z0, a, b, c) = {
    my(x, y, z, lp = List());

    \\ S1
    x = a/c*z0; y = b/c*z0; z = z0;
    if (x >= x0 && x <= x0+1 && y >= y0 && y <= y0+1, listput(lp, [x, y, z]));

    \\ S2
    x = a/c*(z0+1); y = b/c*(z0+1); z = z0+1;
    if (x >= x0 && x <= x0+1 && y >= y0 && y <= y0+1, listput(lp, [x, y, z]));

    \\ S3
    x = x0; y = b/a*x0; z = c/a*x0;
    if (y >= y0 && y <= y0+1 && z >= z0 && z <= z0+1, listput(lp, [x, y, z]));

    \\ S4
    x = x0+1; y = b/a*(x0+1); z = c/a*(x0+1);
    if (y >= y0 && y <= y0+1 && z >= z0 && z <= z0+1, listput(lp, [x, y, z]));

    \\ S5
    x = a/b*y0; y = y0; z = c/b*y0;
    if (z >= z0 && z <= z0+1 && x >= x0 && x <= x0+1, listput(lp, [x, y, z]));

    \\ S6
    x = a/b*(y0+1); y = y0+1; z = c/b*(y0+1);
    if (z >= z0 && z <= z0+1 && x >= x0 && x <= x0+1, listput(lp, [x, y, z]));

    return(#Set(lp) == 2);
}


{
A = 1313; B = 1547; C = 1729;
g = gcd([A, B, C]);
a = A/g; b = B/g; c = C/g;
cnt = 0;
for (x = 0, a - 1, for (y = 0, b - 1, for (z = 0, c - 1,
    if (check(x, y, z, a, b, c), cnt++);
)));
cnt *= g;
print(cnt);
}
