f(k) = 2*k*(6*k+1)*(6*k+2);


{
s = 0;
for (x = 0, 2009,
    for (y = 0, 2009 - x,
        s += 2010 - y + 1;
    );
);
print("#sol = ", s);

k = round(solve(x = 1, 10^3, f(x) - s));
print(k);
}
