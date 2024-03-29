/*
S(1000000000000) = 226813942335644
Elapsed time is 3.291 s

S(10000000000000) = 3060884528938088
Elapsed time is 11.138 s

S(100000000000000) = 40848001214717808
Elapsed time is 37.939 s
*/


#include <cstdio>
#include <cmath>
#include <cstring>
#include <ctime>
#include <map>
#include <algorithm>

using namespace std;


typedef signed char i8;
typedef long long ll;


const ll N = 100000000000000LL;
const int Nsqrt = 10000000;    // sqrtint(N)
const int NsqrtPi = 664579;    // primepi(Nsqrt)

bool check[Nsqrt + 1];
int prime[NsqrtPi];
i8 mu[Nsqrt + 1];
int mertens[Nsqrt + 1];
int sqf_s[Nsqrt + 1];
int vp[8];    // number of primes of rad(y) <= 8 for N <= 10^16
map<ll, ll> mapsf;


// floor(x^(1/2)), x > 0
int sqrt2int(ll x)
{
    ll r = (int)sqrt((double)x - 0.1);
    while (r * r <= x)    ++r;
    return (int)(r - 1);
}


// floor(x^(1/3)), x > 0
int sqrt3int(ll x)
{
    ll r = (int)pow((double)x - 0.1, 0.333333);
    while (r * r * r <= x)    ++r;
    return (int)(r - 1);
}


// calculate number of squarefree
ll sqf_large(ll n)
{
    ll s = 0;
    int imax = sqrt3int(n);
    int xmax = sqrt2int(n / (imax + 1));

    for (int x = 1; x <= xmax; ++x)
        s += mu[x] * (n / x / x);

    for (int i = 1; i <= imax; ++i)
        s += mertens[sqrt2int(n / i)];

    s -= (ll)imax * mertens[xmax];

    return s;
}


void init()
{
    int tot = 0;
    mu[1] = 1;
    for (int i = 2; i <= Nsqrt; ++i) {
        if (!check[i]) {
            prime[tot++] = i;
            mu[i] = -1;
        }
        for (int j = 0; j < tot; ++j) {
            if (i * prime[j] > Nsqrt)    break;
            check[i * prime[j]] = true;
            if (i % prime[j] == 0) {
                mu[i * prime[j]] = 0;
                break;
            } else {
                mu[i * prime[j]] = -mu[i];
            }
        }
    }

    for (int i = 1; i <= Nsqrt; ++i)
        mertens[i] = mertens[i - 1] + mu[i];

    for (int i = 1; i <= Nsqrt; ++i)
        sqf_s[i] = sqf_s[i - 1] + ((mu[i] == 0) ? 0 : 1);
}


// sf(q, n) = sqf(n) - sum(t|q && t > 1, sf(q, n/t))
ll sf_fun(int lenvp, ll n)
{
    if (n <= 1)    return n;
    if (mapsf.count(n))    return mapsf[n];
    ll s = (n <= Nsqrt) ? sqf_s[n] : sqf_large(n);
    for (int x = 1; x < (1 << lenvp); ++x) {
        ll t = 1;
        for (int i = 0; i < lenvp; ++i)
            if (x & (1 << i))    t *= vp[i];
        s -= sf_fun(lenvp, n / t);
    }
    mapsf[n] = s;
    return s;
}


// S(n) = sum(y * rad(y) <= n, y * sf(rad(y), n/y/rad(y)))
ll s_fun(ll n, ll y, ll rady, int k, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < NsqrtPi; ++i) {
        int p = prime[i];
        ll q = (ll)p * (ll)p;
        if (n < q)    break;
        vp[k] = p;
        ll ynew = y * p;
        ll radynew = rady * p;
        ll nnew = n / q;
        mapsf.clear();
        s += ynew * sf_fun(k + 1, N / ynew / radynew);
        if (nnew > q)    s += s_fun(nnew, ynew, radynew, k + 1, i + 1);
        while (1) {
            ynew *= p;
            nnew /= p;
            if (nnew == 0)    break;
            mapsf.clear();
            s += ynew * sf_fun(k + 1, N / ynew / radynew);
            if (nnew > q)    s += s_fun(nnew, ynew, radynew, k + 1, i + 1);
        }
    }
    return s;
}


int main()
{
    clock_t t0 = clock();

    init();
    ll s = sqf_large(N) + s_fun(N, 1, 1, 0, 0);
    printf("S(%lld) = %lld\n", N, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
