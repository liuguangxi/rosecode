/*
x_k = q / p, y_k = x_k * p =>
y_{k+1} mod p^(e-1) = (y_k mod p^e) * ((y_k mod p^e - (y_k mod p^e) mod p) / p + 1) mod p^(e-1)
=>
y_k mod p = 0 <=> x_k is integer
*/


calc(x, e) = {
    my(p, y, pe, step = 0);
    p = denominator(x); y = x * p; pe = p^e;
    for (i = 1, e,
        step++; pe /= p;
        y = y * ((y - y % p) / p + 1) % pe;
        printf("(%d)  %d\n", step, y % p);
        if (y % p == 0, return(step));
    );
    return(0);
}


{
Emax = 5500;
x0 =  3012/3011;
s = calc(x0, Emax);
if (s == 0, print("No solution!"), print(s));
}
