/*
(x^2 + y^2) = p * (x - y)
where x and y are positive integers, p is a prime with 4*k+1 form
=>
xx^2 + yy^2 = p * ((xx - yy) / g) = p * m
g = gcd(x, y), xx = x / g; yy = y / g
m = 1 or 2
=>
x = xx * (xx - yy) / m
y = y * (xx - yy) / m
*/


{
p = 1234567891011121613;
Q = Qfb(1, 0, 1);
[xx, yy] = qfbsolve(Q, p);
xx = abs(xx); yy = abs(yy);
if (xx < yy, t = xx; xx = yy; yy = t);

sol = List();

\\ m = 1
g1 = xx - yy;
x1 = xx * g1; y1 = yy * g1;
listput(sol, [x1, y1]);

\\ m = 2
[xx2, yy2] = [xx + yy, xx - yy];
g2 = (xx2 - yy2) / 2;
x2 = xx2 * g2; y2 = yy2 * g2;
listput(sol, [x2, y2]);

sol = vecsort(Vec(sol));
printf("%d,%d/%d,%d\n", sol[1][1], sol[1][2], sol[2][1], sol[2][2]);
}
