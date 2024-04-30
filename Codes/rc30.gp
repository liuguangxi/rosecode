{
f0 = sum(i = 0, 49, x^(2*i+1)) + O(x^101);
f = f0^26;
s = polcoef(f, 100);
print(s);
}
