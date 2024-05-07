/*
x1 + x2 + x3 = m
profit = max(min(2*x1, 3*x2, 7*x3)) - m
*/


{
m = 614889782588491410;
x1 = (1/2)/(1/2+1/3+1/7) * m;
profit = 2*x1 - m;
print(profit);
}
