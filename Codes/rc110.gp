/*
S(r, b) = (sum(i=1,r,binomial(r+b-1-i,b-1)*i) + sum(i=1,b,binomial(r+b-1-i,r-1)*i)) / binomial(r+b,r)
        = (binomial(r+b,r-1) + binomial(r+b,r+1)) / binomial(r+b,r)
        = r/(b+1) + b/(r+1)
*/


{
ans = "r/(b+1)+b/(r+1)";
print(ans);
}
