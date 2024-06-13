/*
A(0, 0), B(xb, yb), C(xc, yc), D(xc - xb, yc - yb) =>
Mk: (xb - (xb-xc)*k/N, yb - (yb-yc)*k/N), k = 1..N =>
Line AMk: y = (yb - (yb-yc)*k/N)) / (xb - (xb-xc)*k/N) * x
Line BD: (y - yd) / (x - xd) = (yb - yd) / (xb - xd)
=>
cross points: ((N*xb + k*(xc - xb)) / (N + k), (N*yb + k*(yc - yb)) / (N + k)) =>
(xc - 2*xb) * k/(N+k) and (yc - 2*yb) * k/(N+k) are both integers for k = 1..N =>
Let L be least positive integer s.t. L * k/(N+k) is integer for k = 1..N =>
xc = L + 2*xb, yc = L + 2*yb
Area(ABCD) = abs(yb*(xb-xc) - xb*(yb-yc)) = L * abs(xb - yb) >= L
*/


{
N = 1000;
L = lcm(vector(N, k, denominator(k/(N+k))));
print(L % 10^9);
}
