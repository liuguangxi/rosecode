/*
P_n(x) = x^5 + F_{2n}*x^4 + 2(F_{2n}-2*F_{n+1}^2)*x^3 + 2*F_{2n}*(F_{2n}-2*F_{n+1}^2)*x^2 + F_{2n}^2*x + F_{2n}^3
       = (x^2 - F_{x}^2) * (x^2 - (F_{2n}/F_{n})^2) * (x + F_{2n})
=>
The largest positive root is F_{2n}/F_{n} = F_{n-1} + F_{n+1}
*/


{
n = 1000;
m = 10^10;
M = Mod([1, 1; 1, 0], m);
ans = [0, 1]*M^(n-1)*[1, 0]~ + [0, 1]*M^(n+1)*[1, 0]~;
print(lift(ans));
}
