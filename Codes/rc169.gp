J(n) = if (n == 1, 1, if (n % 2 == 1, 2*J(n\2)+1, 2*J(n\2)-1));


{
N = 9*10^29;
ans = J(N);
print(ans);
}
