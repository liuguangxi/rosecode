D(n) = {
    my(t);
    if (n % 2 == 1,
        t = atan((n+1)*sin(2*Pi/n)/(n+(n+1)*cos(2*Pi/n))) -
            atan((n-1)*sin(2*Pi/n)/(n+(n-1)*cos(2*Pi/n))),
        t = atan(n*sin(2*Pi/n)/(n-1+n*cos(2*Pi/n))) -
            atan(n*sin(2*Pi/n)/(n+1+n*cos(2*Pi/n)));
    );
    t = t/Pi*180;
    return(t);
}


{
N = 2018;
s = sum(n = 3, N, D(n));
printf("%.10f\n", s);
}
