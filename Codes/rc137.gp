/*
a^3 + b^3 + c^3 - 3*a*b*c
= (a + b + c) * (a^2 + b^2 + c^2 - a*b - b*c - c*a)
*/


{
a = 6^58; b = 9^77; c = 10^107;
n = a^3 + b^3 + c^3 - 3*a*b*c;
p1 = a + b + c;
p2 = n / p1;
vp = concat(factor(p1)[,1]~, factor(p2)[,1]~);
p = vecmax(vp);
ans = concat(Vec(Str(p))[1..15]);
print(ans);
}
