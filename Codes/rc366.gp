{
n = 3000000;
count = 0; sumx = sumy = sumz = 0;
for (x = 1, floor(sqrt(n/3)), for (y = x, n,
    if (y*(y+2*x) > n, break);
    if ((n-x*y) % (x+y) == 0,
        z = (n-x*y) / (x+y);
        count++; sumx += x; sumy += y; sumz += z;
    );
));
printf("%d,%d,%d,%d\n", count, sumx, sumy, sumz);
}
