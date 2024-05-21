/*
m^4 + n^4/4 = (m^2 - m*n + n^2/2) * (m^2 + m*n + n^2/2)

Let m = 3^4^4, n = 2^((5^6+1)/2) =>
N = 3^4^5 + 4^5^6 = m^4 + n^4/4
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
m = 3^4^4;
n = 2^((5^6+1)/2);
F1 = m^2 - m*n + n^2/2;
F2 = m^2 + m*n + n^2/2;
printf("%s,%s\n", repr(F1), repr(F2));
}
