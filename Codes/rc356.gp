{
G = 1415926535897932384626433+7182818284590452353602874*I;
fa = factor(G)[,1]~;
fa[1] *= -I;
fa[2] *= -I;
fa[5] *= -I;
fa[7] *= -I;
for (i = 1, #fa-1, printf("%d,%d/", real(fa[i]), imag(fa[i])));
printf("%d,%d\n", real(fa[#fa]), imag(fa[#fa]));
}
