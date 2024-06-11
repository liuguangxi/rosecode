#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int N = 100000000;
bool isprime[N + 1];
int mu[N + 1];
int lpf[N + 1];


void init()
{
    for (int i = 1; i <= N; i++) {
        isprime[i] = true;
        mu[i] = 1;
        lpf[i] = i;
    }

    for (int i = 2; i <= N; i++) {
        if (isprime[i]) {
            mu[i] = -1;
            for (int j = i * 2; j <= N; j += i) {
                isprime[j] = false;
                int s = ((j / i) % i == 0) ? 0 : -1;
                mu[j] *= s;
                if (lpf[j] == j)    lpf[j] = i;
            }
        }
    }
}


int f(int n)
{
    int s = 4;
    if (n == 1)    return s;
    while (n > 1) {
        int p = lpf[n];
        int e = 0;
        while (n % p == 0) {
            n /= p;
            e++;
        }
        if (p % 4 == 1)    s *= 2 * e + 1;
    }
    return s;
}


ll h(int m)
{
    ll s = 0;
    for (int i = 1; i <= m; i++) {
        int mui = mu[i];
        if (mui != 0)
            s += mui * (ll)(m / i) * (ll)(m / i);
    }
    return s;
}


void solve()
{
    init();

    map<int, ll> Mh;
    ll s = 0;
    for (int i = 1; i <= N; i++) {
        if (i % 1000000 == 0)    printf("i = %d\n", i);
        ll hni;
        if (Mh.count(N / i)) {
            hni = Mh[N / i];
        } else {
            hni = h(N / i);
            Mh[N / i] = hni;
        }
        s += f(i) * hni;
    }
    printf("S(%d) = %lld\n", N, s);
}


int main()
{
    solve();
    return 0;
}
