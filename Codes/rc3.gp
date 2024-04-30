{
s = 0;
forprime (p = 1, 1000000,
    if (p == fromdigits(Vecrev(digits(p))), s += p);
);
print(s);
}
