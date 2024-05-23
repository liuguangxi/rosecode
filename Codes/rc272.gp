/*
Let a < -1
0 < x1 < x2, s.t. f(x1) = a, f(x2) = 1/a =>
f(x1) * f(f(x1) + 1/x1) = 1 => f(a + 1/x1) = 1/a => a + 1/x1 = x2
f(x2) * f(f(x2) + 1/x2) = 1 => f(1/a + 1/x2) = a => a + 1/x2 = x1
=>
x1 = (-1/a)*(sqrt(5)-1)/2 < (sqrt(5)-1)/2
x2 = (-a)*(sqrt(5)-1)/2 > (sqrt(5)-1)/2
=>
x2 = (-a)*(sqrt(5)-1)/2 = 1
=> a = -2/(sqrt(5)+1) i.e. f(1) = a
*/


{
ans = -2/(sqrt(5)+1);
printf("%.10f\n", ans);
}
