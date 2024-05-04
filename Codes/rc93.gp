{
s = 0;
for (p1 = 0, 63, for (p2 = p1 + 1, 63, for (p3 = p2 + 1, 63,
    r1 = p1 \ 8; c1 = p1 % 8;
    r2 = p2 \ 8; c2 = p2 % 8;
    r3 = p3 \ 8; c3 = p3 % 8;
    if (r1 == r2 || c1 == c2, next);
    if (r1 == r3 || c1 == c3, next);
    if (r2 == r3 || c2 == c3, next);
    s++;
)));
print(s);
}
