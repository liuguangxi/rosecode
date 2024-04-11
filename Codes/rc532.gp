{
N = 100;
f = sum(i = 1, 6, x^i)^N;
v = Vec(f);
ways = vecmax(v, &idx);
champion = 6*N-idx+1;
printf("%d,%d\n", champion, ways);
}
