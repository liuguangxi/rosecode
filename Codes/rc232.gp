init(n) = {
    my(xmax, ymax);

    \\ Calculate X2Y1
    ymax = sqrtint(n);
    for (y = 1, ymax, X2Y1[y^2] += 2);
    xmax = sqrtint(n \ 2);
    for (x = 1, xmax,
        X2Y1[2*x^2] += 2;
        ymax = sqrtint(n - 2*x^2);
        for (y = 1, ymax, X2Y1[2*x^2 + y^2] += 4);
    );

    \\ Calculate X4Y1
    ymax = sqrtint(n);
    for (y = 1, ymax, X4Y1[y^2] += 2);
    xmax = sqrtint(n \ 4);
    for (x = 1, xmax,
        X4Y1[4*x^2] += 2;
        ymax = sqrtint(n - 4*x^2);
        for (y = 1, ymax, X4Y1[4*x^2 + y^2] += 4);
    );
}


\\ A(n) = #{(x, y, z) in Z^3 | n = 2*x^2 + y^2 + 32*z^2}
A(n) = {
    my(s, zmax, xy);
    s = X2Y1[n];
    zmax = sqrtint(n \ 32);
    for (z = 1, zmax,
        xy = n - 32*z^2;
        if (xy == 0, s += 2, s += 2*X2Y1[xy]);
    );
    return(s);
}


\\ B(n) = #{(x, y, z) in Z^3 | n = 2*x^2 + y^2 + 8*z^2}
B(n) = {
    my(s, zmax, xy);
    s = X2Y1[n];
    zmax = sqrtint(n \ 8);
    for (z = 1, zmax,
        xy = n - 8*z^2;
        if (xy == 0, s += 2, s += 2*X2Y1[xy]);
    );
    return(s);
}


\\ C(n) = #{(x, y, z) in Z^3 | n = 8*x^2 + 2*y^2 + 64*z^2 = 2*(4*x^2 + y^2 + 32*z^2)}
C(n) = {
    my(s, zmax, xy);
    n \= 2;
    s = X4Y1[n];
    zmax = sqrtint(n \ 32);
    for (z = 1, zmax,
        xy = n - 32*z^2;
        if (xy == 0, s += 2, s += 2*X4Y1[xy]);
    );
    return(s);
}


\\ D(n) = #{(x, y, z) in Z^3 | n = 8*x^2 + 2*y^2 + 16*z^2 = 2*(4*x^2 + y^2 + 8*z^2)}
D(n) = {
    my(s, zmax, xy);
    n \= 2;
    s = X4Y1[n];
    zmax = sqrtint(n \ 8);
    for (z = 1, zmax,
        xy = n - 8*z^2;
        if (xy == 0, s += 2, s += 2*X4Y1[xy]);
    );
    return(s);
}


iscong(n) = {
    if (!issquarefree(n), return(0));
    if (n % 2 == 1, return(2*A(n) == B(n)), return(2*C(n) == D(n)));
}


{
N1 = 10^7; N2 = 10^7+1000;

X2Y1 = vector(N2); X4Y1 = vector(N2);
init(N2);
print("init done");

count = 0; s = 0;
for (n = N1, N2,
    if (iscong(n),
        count++; s+= n;
        print(n);
    );
);
printf("%d,%d\n", count, s % 10^7);
}
