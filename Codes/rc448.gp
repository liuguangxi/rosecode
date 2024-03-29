/*
3-ellipse
foci: (1/sqrt(3), 0), (-1/(2*sqrt(3)), 1/2), (-1/(2*sqrt(3)), -1/2)
sum of distances from 3 foci is 3
*/


f(x, t) = {
    sqrt((x*cos(t)-1/sqrt(3))^2 + (x*sin(t))^2) +
    sqrt((x*cos(t)+1/(2*sqrt(3)))^2 + (x*sin(t)-1/2)^2) +
    sqrt((x*cos(t)+1/(2*sqrt(3)))^2 + (x*sin(t)+1/2)^2) - 3;
}

f_area(t) = {
    my(p);
    p = solve(x = 0, 1, f(x, t));
    return(p^2/2);
}

f_circum(t) = {
    my(dt, tt, p, pp, dp);
    dt = 1e-8; tt = t + dt;
    p = solve(x = 0, 1, f(x, t));
    pp = solve(x = 0, 1, f(x, tt));
    dp = (pp - p)/dt;
    return(sqrt(p^2+dp^2));
}


{
area = intnum(t = 0, Pi/3, f_area(t), 1) * 6;
circum = intnum(t = 0, Pi/3, f_circum(t), 1) * 6;
printf("%.6f,%.6f\n", area, circum);
}
