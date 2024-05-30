{
N = 4*10^8;
Count = 1; Sum = 3;    \\ ord(10, 3) = 1
forprime (p = 7, N,
    if (znorder(Mod(10, p)) < 100,
        Count++; Sum += p;
        print("p = ", p);
    );
);
printf("%d,%d\n", Count, Sum);
}
