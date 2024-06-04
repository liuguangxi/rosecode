Li(n) = intnum(x = 1, n, 1/log(x));


{
default(realprecision, 300);
N = 10^200;
p = solve(x = 2, 10^300, Li(x) - N);
p = round(p);
print("p ~ ", p);
p30 = p \ 10^(#Str(p)-30);
print(p30);
}
