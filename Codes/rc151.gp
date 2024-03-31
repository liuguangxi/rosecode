{
x1 = (-1 + sqrt(5))/2;
x2 = (-3333333333 + sqrt(55555555553333333333))/6666666666;
\\ minimum integer q s.t. ceil(q*x1) <= floor(q*x2);
q = 1; while(ceil(q*x1) > floor(q*x2), q++);
p = ceil(q*x1);

a = p^3; b = p^2*q; c = p*q^2; d = q^3;
print(a + b + c);
}
