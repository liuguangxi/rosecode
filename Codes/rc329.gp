/*
r > 0, rt = r, rb = 2*r
V = 1/3*Pi*h*(r^2 + r*(2*r) + (2*r)^2) = 7*Pi/3*h*r^2 = 1000 =>
h = 3000/(7*Pi*r^2) =>
S = Pi*sqrt(r^2+h^2)*(r+2*r) + Pi*r^2 + Pi*(2*r)^2
  = 5*Pi*r^2 + 3*Pi*r*sqrt(r^2+h^2)
  = 5*Pi*r^2 + 3*Pi*r*sqrt(r^2 + 9000000/(49*Pi^2*r^4))
=> dS/dr = 0 =>
r = (5*2^(1/3)*21^(2/3)*(s*sqrt(13)-5)*(52565*sqrt(13)+189071)^(1/6)) / (189*Pi^(1/3))
*/


{
r = (5*2^(1/3)*21^(2/3)*(2*sqrt(13)-5)*(52565*sqrt(13)+189071)^(1/6)) / (189*Pi^(1/3));
rt = r;
rb = 2*r;
h = 3000/(7*Pi*r^2);
printf("%.3f,%.3f,%.3f\n", h, rb, rt);
}
