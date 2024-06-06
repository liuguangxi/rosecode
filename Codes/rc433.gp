/*
Assum unit circle
angle(EOD) = angle(FOD) = a
OD = 1/sqrt(3)
DE = sqrt(OD^2 + 1^2 - 2*1*OD*cos(a)) = sqrt(4/3 - 2/sqrt(3)*cos(a))
EF = 2*sin(a)
DE = EF
*/


{
a = solve(a = 0, Pi/6, sqrt(4/3 - 2/sqrt(3)*cos(a)) - 2*sin(a));
DE = 2*sin(a);
area_DEF = sqrt(3)/4*DE^2;
area_ABC = 1/2*sqrt(3)*1/2*3;
ans = area_ABC / area_DEF;
printf("%.5f\n", ans);
}
