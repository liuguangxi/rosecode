{
p = 200000039;
p2 = p^2;
r = prod(i = 1, p - 1, Mod(i, p2)) + 1;
w = lift(r) / p;
if (w >= p / 2, w -= p);
print(w);
}
