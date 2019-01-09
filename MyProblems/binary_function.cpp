// g++ -Wall -O3 -march=native -I/usr/local/include/flint -L/usr/local/lib binary_function.cpp -o binary_function -lflint

/*
N = 100000
25501,565446417,1276167011
Elapsed time is 0.016 s

N = 1000000
254933,56473845380,127550790020
Elapsed time is 0.343 s

N = 10000000
2547908,5640334172757,12740634264867
Elapsed time is 4.228 s

N = 50000000
12738578,140985326874513,318469254709907
Elapsed time is 25.319 s
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <vector>
#include <utility>
#include "ulong_extras.h"

using namespace std;


typedef long long ll;
typedef pair<int, int> pii;

const int N = 50000000;
const int L = N / 2;

bool isprime[L + 1];
ll vm[L + 1];
vector<pii> vfact[L + 1];


void update_vfact(int k, int p)
{
    for (int i = k; i <= L; i += p) {
        int e = 0;
        while (vm[i] % p == 0) {
            vm[i] /= p;
            ++e;
        }
        vfact[i].push_back(make_pair(p, e));
    }
}


void calc_pair(int idx, const vector<pii> &v, ll &s, ll &sx, ll &sy)
{
    int sz = (int)v.size();
    int numdiv = 1;
    for (int i = 0; i < sz; ++i)    numdiv *= v[i].second + 1;
    vector<ll> vdiv(numdiv);
    vdiv[0] = 1;
    int len = 1;
    for (int i = 0; i < sz; ++i) {
        int p = v[i].first;
        ll pk = p;
        int e = v[i].second;
        for (int j = 1; j <= e; ++j) {
            for (int k = 0; k < len; ++k)
                vdiv[j * len + k] = vdiv[k] * pk;
            pk *= p;
        }
        len *= e + 1;
    }

    ll m = (ll)idx * (ll)(idx - 1) + 1;
    for (int i = 0; i < numdiv; ++i) {
        ll x = vdiv[i] + idx;
        ll y = m / vdiv[i] + idx;
        if (x <= y && y <= N) {
            ++s;
            sx += x;
            sy += y;
        }
    }
}


void calc()
{
    for (int i = 2; i <= L; ++i)    isprime[i] = true;
    for (int i = 2; i <= L; ++i) {
        if (isprime[i]) {
            for (int j = i * 2; j <= L; j += i)    isprime[j] = false;
        }
    }
    for (int i = 0; i <= L; ++i)    vm[i] = (ll)i * (ll)(i - 1) + 1;

    int p = 3, k = 2;
    update_vfact(k, p);
    for (p = 4; p <= L; ++p) {
        if (!isprime[p])    continue;
        mp_limb_t r = n_sqrtmod(p - 3, p);
        if (r == 0)    continue;
        ll inv2modp = (p + 1) / 2;
        k = (ll)(1 + r) * inv2modp % p;
        update_vfact(k, p);
        k = (ll)(1 + p -  r) * inv2modp % p;
        update_vfact(k, p);
    }

    ll s = 0, sx = 0, sy = 0;
    for (int i = 0; i <= L; ++i)    calc_pair(i, vfact[i], s, sx, sy);

    printf("N = %d\n%lld,%lld,%lld\n", N, s, sx, sy);
}


int main()
{
    clock_t t0 = clock();
    calc();
    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
