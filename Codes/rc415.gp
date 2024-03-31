/*
N = a / (b + c) + b / (c + a) + c / (a + b)

E_N = y^2 = x^3 + (4*N^2+12*N-3)*x^2 + 32*(N+3)*x
s = a + b + c
a/s = (8*(N+3)-x+y) / (2*(4-x)*(N+3))
b/s = (8*(N+3)-x-y) / (2*(4-x)*(N+3))
c/s = (-4*(N+3)-(N+2)*x) / ((4-x)*(N+3))
*/

f(x, y) = {
    my(a, b, c, g);
    if (x == 4, return([0, 0, 0]));
    a = (8*(N+3)-x+y) / (2*(4-x)*(N+3));
    b = (8*(N+3)-x-y) / (2*(4-x)*(N+3));
    c = (-4*(N+3)-(N+2)*x) / ((4-x)*(N+3));
    g = lcm([denominator(a), denominator(b), denominator(c)]);
    [a, b, c] = [a, b, c]*g;
    return(vecsort([a, b, c]));
}


{
N = 466;
E = ellinit([0, 4*N^2+12*N-3, 0, 32*(N+3), 0]);
DEN = 2^14*(N+3)^2*(2*N-3)*(2*N+5)^3;

x = 0; y = 0; print([x, y], "  =>  ", f(x, y));
for (x = 1, 1000000,
    y2 = x^3 + (4*N^2+12*N-3)*x^2 + 32*(N+3)*x;
    if (y2 >= 0,
        y = sqrtint(y2);
        if (y^2 == y2, print([x, y], "  =>  ", f(x, y)));
    );

    y2 = -x^3 + (4*N^2+12*N-3)*x^2 + 32*(N+3)*(-x);
    if (y2 >= 0,
        y = sqrtint(y2);
        if (y^2 == y2, print([-x, y], "  =>  ", f(-x, y)));
    );
);
}
