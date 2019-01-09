/*
4-ellipse in 3D
foci: (sqrt(3)/3, 0, -sqrt(6)/12), (-sqrt(3)/6, 1/2, -sqrt(6)/12),
      (-sqrt(3)/6, -1/2, -sqrt(6)/12), (0, 0, sqrt(6)/4)
sum of distances from 4 foci is 4
*/


f(r, t, p) = {
    my(x, y, z, s);
    [x, y, z] = [r*sin(t)*cos(p), r*sin(t)*sin(p), r*cos(t)];
    s = sqrt((x-sqrt(3)/3)^2+y^2+(z+sqrt(6)/12)^2) +
        sqrt((x+sqrt(3)/6)^2+(y-1/2)^2+(z+sqrt(6)/12)^2) +
        sqrt((x+sqrt(3)/6)^2+(y+1/2)^2+(z+sqrt(6)/12)^2) +
        sqrt(x^2+y^2+(z-sqrt(6)/4)^2) - 4;
}

f_volume(t, p) = {
    my(r);
    r = solve(r = 0, 1, f(r, t, p));
    return(r^3/3*sin(t));
}

f_area(t, p) = {
    my(dt, tt, dp, pp, r, rt, rp, drt, drp);
    dt = 1e-8; tt = t + dt;
    dp = 1e-8; pp = p + dp;
    r = solve(r = 0, 1, f(r, t, p));
    rt = solve(r = 0, 1, f(r, tt, p));
    rp = solve(r = 0, 1, f(r, t, pp));
    drt = (rt - r)/dt;
    drp = (rp - r)/dp;
    return(r*sqrt(drp^2+(sin(t))^2*(drt^2+r^2)));
}


{
tab_p = intnuminit(0, Pi/3);
tab_t = intnuminit(0, Pi);
volume = intnum(t = 0, Pi, intnum(p = 0, Pi/3, f_volume(t, p), tab_p), tab_t) * 6;
area = intnum(t = 0, Pi, intnum(p = 0, Pi/3, f_area(t, p), tab_p), tab_t) * 6;
printf("volume = %.6f\narea = %.6f\n", volume, area);
}
