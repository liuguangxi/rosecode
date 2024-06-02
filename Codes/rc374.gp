/*
f(x) = 2*x+5
f^n(x) = 2^n*x + (2^n-1)*5 = 2^n*(x+5) - 5
*/
fn(x, n) = 2^n*(x+5) - 5;


{
s1 = fn(4, 5);
s2 = fn(s1 + 2, s1 + 3) + 1;
print(s2);
}
