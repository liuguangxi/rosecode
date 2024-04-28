/*
Sum of sigma0 of number in [1, N] is
sum(i = 1, N, N\i) = 2 * sum(i = 1, sqrtint(N), N\i) - sqrtint(N)^2

f(n) is counter of number of divisors of cubic-free number in [1, n]
f(n), g(n), h(n) are all multiplicative function

(1) f(p^k) = k + 1 (for k <= 2); 0 (for k > 2)
(2) g(p^k) = k + 1 (g(n) = sigma0(n))
(3) h(p^k) = 1 (for k == 0); -4 (for k == 3); 3 (for k == 4); 0 (otherwise)
    h(n) != 0 only when n is powerful

f = g * h

Counter of cubic-free number in [1, N] is
sum(i = 1, sqrtnint(N, 3), moebius(i) * (N\i^3))

A non-cubic-free number n has unique representation n = d^3*q,
where d > 1 and q is cubic-free
*/


#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr ll N = 12345678987654321LL;
constexpr int Nsqrt = (int)sqrt((long double)N + 0.5);
constexpr int Ncbrt = (int)cbrt((long double)N + 0.5);

bool isprime[Nsqrt + 1];
int mu[Nsqrt + 1];
vector<int> plist;
int lpf[Ncbrt + 1];


void init()
{
    for (int i = 1; i <= Nsqrt; i++) {
        isprime[i] = true;
        mu[i] = 1;
    }
    for (int i = 1; i <= Ncbrt; i++)    lpf[i] = i;

    for (int i = 2; i <= Nsqrt; i++) {
        if (isprime[i]) {
            plist.push_back(i);
            mu[i] = -1;
            for (int j = i * 2; j <= Nsqrt; j += i) {
                isprime[j] = false;
                int s = ((j / i) % i == 0) ? 0 : -1;
                mu[j] *= s;
                if (j <= Ncbrt && lpf[j] == j)    lpf[j] = i;
            }
        }
    }
    plist.push_back(Nsqrt + 1);

    cout << "init done" << endl;
}


ll sg(ll n)
{
    int nsqrt = (int)sqrt((long double)n + 0.5);
    ll s = 0;
    for (int i = 1; i <= nsqrt; i++)    s += n / i;
    s = s * 2 - (ll)nsqrt * (ll)nsqrt;
    return s;
}


ll cal(int i, ll n)
{
    ll ret = sg(n);
    for (int j = 0; j < i; j++) {
        ll p = plist[j];
        ll m = n / p / p;
        if (m == 0)    break;
        for (int k = 2; m >= 1; k++, m /= p) {
            int hk = (k == 3) ? -4 : (k == 4) ? 3 : 0;
            if (hk != 0)    ret += hk * cal(j, m);
        }
    }
    return ret;
}


ll scf(ll n)
{
    int ncbrt = (int)cbrt((long double)n + 0.5);
    ll s = 0;
    for (int i = 1; i <= ncbrt; i++) {
        int m = mu[i];
        if (m != 0)    s += m * (n / i / i / i);
    }
    return s;
}


int numdiv2(int n)
{
    int s = 1;
    while (n > 1) {
        int p = lpf[n];
        int e = 0;
        while (n % p == 0) {
            n /= p;
            e++;
        }
        s *= 2*e + 1;
    }
    return s;
}


void solve()
{
    ll s = cal(plist.size(), N);
    for (int d = 2; d <= Ncbrt; d++) {
        int c = numdiv2(d);
        s += c * scf(N / d / d / d);
    }
    cout << "S(" << N << ") = " << s << endl;
}


int main()
{
    init();
    solve();
    return 0;
}
