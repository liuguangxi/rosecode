/*
f = a^2 / (2*a*b^2 - b^3 + 1) =>

(1) b = 1
f = a/2 => a is even

(2) b >= 2 and b is even
Let b = 2*bb
(2.1) if a = bb => f = bb^2 is integer
(2.2) if a = (8*bb^3-1)*bb => f = bb^2 is integer
*/


{
T = 10^9;
s = T\2;    \\ (1)
s += T\2;    \\ (2.1)
for (bb = 1, T\2,    \\ (2.2)
    if ((8*bb^3-1)*bb <= T, s++, break);
);
print(s);
}
