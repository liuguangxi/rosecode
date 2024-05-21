/*
Hook length formula
For a 2*3 rectangle:
  4  3  2
  3  2  1
6!/(4*3*2*3*2*1) = 5
*/


repr(x) = {
    my(vx = digits(x), lenvx = #vx, strx);
    if (lenvx <= 20, return(Str(x)));
    if (lenvx > 20,
        strx = "";
        for (i = 1, 10, strx = concat(strx, Str(vx[i])));
        strx = concat([strx, "[", Str(lenvx - 20), "]"]);
        forstep (i = 9, 0, -1, strx = concat(strx, Str(vx[lenvx - i])));
    );
    return(strx);
}


{
W = 15; H = 20;
s = (W*H)!;
for (w = 1, W, for (h = 1, H,
    s /= W - w + H - h + 1;
));
printf("%s\n", repr(s));
}
