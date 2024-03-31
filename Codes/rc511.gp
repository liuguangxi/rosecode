/*
a(n+1) = (a(n)^4 + 6*a(n)^2 + 1) / (4*a(n)*(a(n)^2+1)) =>
(a(n+1) + 1) / (a(n+1) - 1) = ((a(n) + 1) / (a(n) - 1))^4 =>
let b(n) = (a(n) + 1) / (a(n) - 1) => b(n+1) = b(n)^4 =>
b(n) = b(1)^4^(n-1) =>
a(n) = ((a(1)+1)^4^(n-1) + (a(1)-1)^4^(n-1)) / ((a(1)+1)^4^(n-1) - (a(1)-1)^4^(n-1))
*/


Q(n, p) = {
    my(a1 = 17, t, t1, t2, ans);
    t = lift(Mod(4, p-1)^(n-1));
    t1 = Mod(a1+1, p)^t;
    t2 = Mod(a1-1, p)^t;
    ans = (t1 + t2) / (t1 - t2);
    return(lift(ans));
}


{
N = 1234567891011121314;
Pmin = 2*10^9;
Pmax = 2*10^9+10^5;
s = 0;
forprime (p = Pmin, Pmax, s += Q(N, p));
print(s);
}