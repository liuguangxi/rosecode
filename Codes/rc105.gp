/*

* * *           1 2 3
  * * *           4 5 6
* *             7 8
  * *             9 X

*/


chk(v) = {
    if (abs(v[1] - v[2]) == 1, return(0));
    if (abs(v[1] - v[4]) == 1, return(0));
    if (abs(v[2] - v[3]) == 1, return(0));
    if (abs(v[2] - v[4]) == 1, return(0));
    if (abs(v[2] - v[5]) == 1, return(0));
    if (abs(v[3] - v[4]) == 1, return(0));
    if (abs(v[3] - v[5]) == 1, return(0));
    if (abs(v[3] - v[6]) == 1, return(0));
    if (abs(v[4] - v[5]) == 1, return(0));
    if (abs(v[4] - v[7]) == 1, return(0));
    if (abs(v[4] - v[8]) == 1, return(0));
    if (abs(v[5] - v[6]) == 1, return(0));
    if (abs(v[5] - v[8]) == 1, return(0));
    if (abs(v[7] - v[8]) == 1, return(0));
    if (abs(v[7] - v[9]) == 1, return(0));
    if (abs(v[8] - v[9]) == 1, return(0));
    if (abs(v[8] - v[10]) == 1, return(0));
    if (abs(v[9] - v[10]) == 1, return(0));
    return(1);
}


{
s = 0;
n = 10;
for (k = 0, k = n! - 1,
    vk = numtoperm(n, k);
    if (chk(vk), s++);
);
print(s);
}
