/*
L = i^i^i... => i^L = L
Let L = a + b*i =>
a + b*i = exp(i*Pi/2*(a+b*i))
        = (cos(Pi/2*a) + i*sin(Pi/2*a)) * exp(-Pi/2*b)
=>
a = cos(Pi/2*a) * exp(-Pi/2*b)
b = sin(Pi/2*a) * exp(-Pi/2*b)
=>
b = tan(Pi/2*a)*a
=>
a - cos(Pi/2*a) * exp(-Pi/2*tan(Pi/2*a)*a) = 0
*/


f(a) = a - cos(Pi/2*a) * exp(-Pi/2*tan(Pi/2*a)*a);


{
a = solve(a = 0, 0.5, f(a));
b = tan(Pi/2*a)*a;
printf("%.20f,%.20f\n", a, b);
}
