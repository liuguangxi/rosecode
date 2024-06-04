#include <bits/stdc++.h>
#include <gmpxx.h>
using namespace std;


using i8 = signed char;
using ll = long long;

constexpr ll N = 123456789123456789LL;
constexpr int Nsqrt = 351364183;    // floor(sqrt(N))
constexpr int NN = Nsqrt;
constexpr int NNpi = 18872790;    // pi(NN)

bool check[NN + 1];
int prime[NNpi];
i8 mu[NN + 1];


// floor(x^(1/2)), x > 0
int sqrt2int(ll x)
{
    ll r = (int)sqrt((double)x - 0.1);
    while (r * r <= x)    r++;
    return (int)(r - 1);
}


void init()
{
    int tot = 0;
    mu[1] = 1;
    for (int i = 2; i <= NN; i++) {
        if (!check[i]) {
            prime[tot++] = i;
            mu[i] = -1;
        }
        for (int j = 0; j < tot; j++) {
            if (i * prime[j] > NN)    break;
            check[i * prime[j]] = true;
            if (i % prime[j] == 0) {
                mu[i * prime[j]] = 0;
                break;
            } else {
                mu[i * prime[j]] = -mu[i];
            }
        }
    }
}


ll calc(ll n)
{
    ll s = 0;
    int xmax = sqrt2int(n);

    for (int x = 1; x <= xmax; x++)
        s += mu[x] * (n / x / x);

    return s;
}


void solve()
{
    init();
    printf("S(%lld) = %lld\n", N, calc(N));
}


int main()
{
    solve();
    return 0;
}
