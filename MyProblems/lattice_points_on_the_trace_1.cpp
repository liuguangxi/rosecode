#include <bits/stdc++.h>

using namespace std;


using ll = long long;

const int N = 100000000;
vector<bool> isprime(N + 1, true);
vector<int> mu(N + 1, 1);
vector<int> fn(N + 1, 4);


int sqrtint(int x)
{
    int r = (int)sqrt((double)x - 0.1);
    while (r * r <= x)
        ++r;
    return (int)(r - 1);
}


ll h(ll n)
{
    ll s = 0;
    int imax = sqrtint(n);
    int xmax = n / (imax + 1);
    for (int i = 1; i <= imax; i++)
        s += (ll)(mu[i] - mu[i - 1]) * (n / i) * (n / i);
    for (int x = 1; x <= xmax; x++)
        s += (ll)(mu[n / x] - mu[n / (x + 1)]) * x * x;
    return s;
}


void calc()
{
    int Nsqrt = sqrtint(N);
    for (int i = 2; i <= N; i++) {
        if (!isprime[i])
            continue;
        if (i <= Nsqrt) {
            for (int j = i * i; j <= N; j += i)
                isprime[j] = false;
        }

        for (int j = i; j <= N; j += i)
            mu[j] = -mu[j];
        if (i <= Nsqrt) {
            int isqr = i * i;
            for (int j = isqr; j <= N; j += isqr)
                mu[j] = 0;
        }

        if (i % 4 == 1) {
            for (int j = i; j <= N; j += i) {
                int x = j;
                int t = 1;
                while (x % i == 0) {
                    x /= i;
                    t += 2;
                }
                fn[j] *= t;
            }
        }
    }

    mu[0] = 0;
    for (int i = 1; i <= N; i++)
        mu[i] += mu[i - 1];

    ll s = 0;
    for (int i = 1; i <= N; i++)
        s += (ll)fn[i] * h(N / i);
    cout << "S(" << N << ") = " << s << endl;
}


int main()
{
    calc();
    return 0;
}
