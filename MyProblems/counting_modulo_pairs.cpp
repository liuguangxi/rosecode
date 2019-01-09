/*
S(1000000000000) = 226813942335644
Elapsed time is 6.817 s

S(10000000000000) = 3060884528938088
Elapsed time is 37.658 s

S(100000000000000) = 40848001214717808
Elapsed time is 202.940 s
*/


#include <cstdio>
#include <cmath>
#include <cstring>
#include <ctime>
#include <algorithm>

using namespace std;


typedef long long ll;


const ll N = 100000000000000LL;
const int Nsqrt = 10000000;    // sqrtint(N)
const int NsqrtPi = 664579;    // primepi(Nsqrt)

bool check[Nsqrt + 1];
int prime[NsqrtPi];
ll vs_s[Nsqrt + 1];
ll vs_l[Nsqrt + 1];


void init_primes()
{
    int tot = 0;
    for (int i = 2; i <= Nsqrt; ++i) {
        if (!check[i])    prime[tot++] = i;
        for (int j = 0; j < tot; ++j) {
            if (i * prime[j] > Nsqrt)    break;
            check[i * prime[j]] = true;
            if (i % prime[j] == 0)    break;
        }
    }
}


void init_fpsum()
{
    for (int i = 1; i <= Nsqrt; ++i) {
        vs_s[i] = i - 1;
        vs_l[i] = N / i - 1;
    }
    for (int ip = 0; ip < NsqrtPi; ++ip) {
        int p = prime[ip];
        ll q = (ll)p * (ll)p;
        int imax = min((ll)Nsqrt, N/q);
        for (int i = 1; i <= imax; ++i) {
            ll d = (ll)i * (ll)p;
            if (d <= Nsqrt)
                vs_l[i] -= vs_l[d] - vs_s[p - 1];
            else
                vs_l[i] -= vs_s[N / d] - vs_s[p - 1];
        }
        for (int i = Nsqrt; i >= q; --i)
            vs_s[i] -= vs_s[i / p] - vs_s[p - 1];
    }
}


ll s_fun(ll n, ll fm, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < NsqrtPi; ++i) {
        int p = prime[i];
        ll q = (ll)p * (ll)p;
        if (n < q)    break;
        ll nnew = n / p;
        if (nnew <= Nsqrt)    s += fm * (vs_s[nnew] - vs_s[p]);
        else    s += fm * (vs_l[N / nnew] - vs_s[p]);
        if (nnew > q)    s += s_fun(nnew, fm, i + 1);
        ll fmnew = fm;
        while (1) {
            fmnew *= p;
            s += fmnew;
            if (nnew >= q) {
                nnew /= p;
                if (nnew <= Nsqrt)    s += fmnew * (vs_s[nnew] - vs_s[p]);
                else    s += fmnew * (vs_l[N / nnew] - vs_s[p]);
                if (nnew > q)    s += s_fun(nnew, fmnew, i + 1);
            } else
                break;
        }
    }
    return s;
}


int main()
{
    clock_t t0 = clock();

    init_primes();
    init_fpsum();
    ll s = 1 + vs_l[1] + s_fun(N, 1, 0);
    printf("S(%lld) = %lld\n", N, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
