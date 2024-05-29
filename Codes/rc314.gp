f(a, b) = 5/4 - (2^(1/2)*cos(b))/2 - (2^(1/2)*sin(a)*sin(b))/2 - cos(a)/2;

fa(a, b) = sin(a)/2 - (2^(1/2)*cos(a)*sin(b))/2;

fb(a, b) = (2^(1/2)*sin(b))/2 - (2^(1/2)*cos(b)*sin(a))/2;


{
a = Pi/4;
for (k = 1, 50,
    b = solve(b = 0, Pi/2, fb(a, b));
    a = solve(a = 0, Pi/2, fa(a, b));
    d = sqrt(f(a, b));
);
print("d = ", d);
p = algdep(d, 4);
v = Vec(p);
print(p);
printf("%d\n", v);
}
