{
TA = sqrt(1000^2 + 300^2);
TB = TA - 100;
T = 2*Pi*300 / TA;
AB = sqrt(TA^2 + TB^2 - 2*TA*TB*cos(T));
cosA = (TA^2+AB^2-TB^2)/(2*TA*AB);
u = TA * cosA;
d = AB - u;
printf("%.10f,%.10f\n", u, d);
}
