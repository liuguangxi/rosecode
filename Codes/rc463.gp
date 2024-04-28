{
A = [2, 15]; B = [7, 2];

a = atan(4/9);
AC = cos(a);
vAC = AC * [-sin(a), -cos(a)];
C = A + vAC;

b = atan(9/9);
BD = 2*cos(b);
vBD = BD * [-sin(b), cos(b)];
D = B + vBD;

vCD = C - D;
s = AC + BD + sqrt(vCD[1]^2 + vCD[2]^2);
printf("%.10f\n", s);
}
