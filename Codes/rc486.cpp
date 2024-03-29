/*
S(1000000000000, 1000000000000) mod 1000000007 = 458443302
Elapsed time is 8.236 s

S(10000000000000, 10000000000000) mod 1000000007 = 844185742
Elapsed time is 44.974 s
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>

using namespace std;


typedef long long ll;

const ll P = 1000000000000LL;
const ll N = 1000000000000LL;
const int M = 1000000007;
const int Psqrt = 1000000;    // sqrtint(P)
const int PsqrtPi = 78498;    // primepi(Psqrt)

int Tab[61];    // Tab[i] = Mod(N+i-1, M) / Mod(i, M)
bool check[Psqrt + 1];
int prime[PsqrtPi];
ll vs_s[Psqrt + 1];
ll vs_l[Psqrt + 1];


int modinv(int a, int m)
{
    int j = 1, i = 0, b = m, c = a, x, y;
    while (c) {
        x = b / c;    y = b - x * c;    b = c;    c = y;
        y = j;    j = i - j * x;    i = y;
    }
    if (i < 0)    i += m;
    return i;
}


void init_table()
{
    for (int i = 1; i <= 60; ++i) {
        ll t = (N + i - 1) % M;
        ll iinv = modinv(i, M);
        Tab[i] = t * iinv % M;
    }
}


void init_primes()
{
    int tot = 0;
    for (int i = 2; i <= Psqrt; ++i) {
        if (!check[i])    prime[tot++] = i;
        for (int j = 0; j < tot; ++j) {
            if (i * prime[j] > Psqrt)    break;
            check[i * prime[j]] = true;
            if (i % prime[j] == 0)    break;
        }
    }
}


void init_fpsum()
{
    for (int i = 1; i <= Psqrt; ++i) {
        vs_s[i] = i - 1;
        vs_l[i] = P / i - 1;
    }
    for (int ip = 0; ip < PsqrtPi; ++ip) {
        int p = prime[ip];
        ll q = (ll)p * (ll)p;
        int imax = min((ll)Psqrt, N/q);
        for (int i = 1; i <= imax; ++i) {
            ll d = (ll)i * (ll)p;
            if (d <= Psqrt)
                vs_l[i] -= vs_l[d] - vs_s[p - 1];
            else
                vs_l[i] -= vs_s[P / d] - vs_s[p - 1];
        }
        for (int i = Psqrt; i >= q; --i)
            vs_s[i] -= vs_s[i / p] - vs_s[p - 1];
    }
}


ll rec(ll n, ll fm, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < PsqrtPi; ++i) {
        int p = prime[i];
        ll q = (ll)p * (ll)p;
        if (n < q)    break;
        ll nnew = n / p;
        ll fmnew = fm * Tab[1] % M;
        ll fmnew_mul_n = fmnew * (N % M) % M;
        if (nnew <= Psqrt)
            s = (s + fmnew_mul_n * ((vs_s[nnew] - vs_s[p]) % M)) % M;
        else
            s = (s + fmnew_mul_n * ((vs_l[P / nnew] - vs_s[p]) % M)) % M;
        if (nnew > q)    s = (s + rec(nnew, fmnew, i + 1)) % M;
        int k = 1;
        while (1) {
            ++k;
            fmnew = fmnew * Tab[k] % M;
            s = (s + fmnew) % M;
            if (nnew >= q) {
                nnew /= p;
                fmnew_mul_n = fmnew * Tab[1] % M;
                if (nnew <= Psqrt)
                    s = (s + fmnew_mul_n * ((vs_s[nnew] - vs_s[p]) % M)) % M;
                else
                    s = (s + fmnew_mul_n * ((vs_l[P / nnew] - vs_s[p]) % M)) % M;
                if (nnew > q)    s = (s + rec(nnew, fmnew, i + 1)) % M;
            } else
                break;
        }
    }
    return s;
}


int main()
{
    clock_t t0 = clock();

    init_table();
    init_primes();
    init_fpsum();
    ll s = 1 + (vs_l[1] % M) * Tab[1] % M;
    s = (s + rec(P, 1, 0)) % M;
    printf("S(%lld, %lld) mod %d = %lld\n", P, N, M, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
