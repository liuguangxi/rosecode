{
M = 1000000007;
K = 3^4^5;
A = Mod([K, -1; 1, 0], M);
s = lift(A^(K-1)*[1;0]);
x = s[2,1]; y = s[1,1];
printf("%d,%d\n", x, y);
}
