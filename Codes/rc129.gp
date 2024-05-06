/*
number of available teams at day i (https://oeis.org/A059851) =>
1, 1, 3, 2, 4, 4, 6, 4, 7, 7, ...
modulo 2 =>
1,1,1, 0,0,0,0,0, 1,1,1,1,1,1,1, ...
run length is =>
3,5, 7,9, 11,13, ...
*/


{
N = 10^18;
kmax = ceil((-4 + sqrt(16+16*N)) / 8);
nlast = N - 4*(kmax-1)*kmax;
k = kmax - 1;
s = 2*k*(k+1) - k;
s += min(4*kmax-1, nlast);
print(s);
}
