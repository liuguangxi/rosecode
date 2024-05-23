/*
a = 10^100!
b = E^E^E^79
c = 2^3^4^5^6
d = 6^5^4^3^2
e = 4!!!!
f = p_{10^100}#
=>
log(log(log(a))) ~= log(log(10^100*log(10^100/E))) ~= 5.5
log(log(log(b))) = 79
log(log(log(c))) ~= 15625*log(4)
log(log(log(d))) ~= 9*log(4)
log(log(log(e))) ~= 24
p(n) ~= n + n*log(n/E) =>
f ~= prod(n = 1, 10^100, n*(1+log(n/E))) ~= a*228^(10^100) =>
log(log(log(f))) ~= log(log(log(a))) + log(100*log(10)) ~= 10.9
=>
a < f < d < e < b < c
*/


{
ans = "a,f,d,e,b,c";
print(ans);
}
