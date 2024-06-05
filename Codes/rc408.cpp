#include <bits/stdc++.h>
using namespace std;


constexpr int N = 1200000000;
constexpr int M = 9876;

vector<bool> isprime(N + 1);
vector<signed char> mu(N + 1);


// floor(x^(1/2)), x > 0
int sqrt2int(int x)
{
    int r = (int)sqrt((double)x - 0.1);
    while (r * r <= x)    r++;
    return (int)(r - 1);
}


void init()
{
    for (int i = 1; i <= N; i++) {
        isprime[i] = true;
        mu[i] = 1;
    }

    int nsqrt = sqrt2int(N);
    for (int i = 2; i <= nsqrt; i++) {
        if (isprime[i]) {
            mu[i] = -1;
            for (int j = i * 2; j <= N; j += i) {
                isprime[j] = false;
                signed char s = ((j / i) % i == 0) ? 0 : -1;
                mu[j] *= s;
            }
        }
    }
    for (int i = nsqrt + 1; i <= N; i++) {
        if (isprime[i]) {
            for (long long j = i; j <= (long long)N; j += (long long)i)
                mu[(int)j] *= -1;
        }
    }

    printf("init done\n");
}


void calc()
{
    int s = 0;
    bool flag1 = false, flag2 = false;
    int idx_i = 0, idx_j = 0;

    for (int i = 1; i <= N; i++) {
        s += (int)mu[i];
        if (s == -M && !flag1) {
            flag1 = true;
            idx_i = i;
            printf("M[%d] = %d\n", i, -M);
        }
        if (s == M && !flag2) {
            flag2 = true;
            idx_j = i;
            printf("M[%d] = %d\n", i, M);
        }
    }
    printf("%d,%d\n", idx_i, idx_j);
}


int main()
{
    init();
    calc();
    return 0;
}
