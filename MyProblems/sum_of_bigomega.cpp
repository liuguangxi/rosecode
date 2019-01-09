#include <cmath>
#include <ctime>
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;


typedef long long ll;

const ll N = 10000000000000LL;
const int Nsqrt = 3162277;    // sqrtint(N)
int Lenp;

vector<bool> isprime(Nsqrt + 1);
vector<int> prime;
vector<ll> vs_s(Nsqrt + 1);
vector<ll> vs_l(Nsqrt + 1);


void init_primes()
{
    for (int i = 2; i <= Nsqrt; i++)
        isprime[i] = true;
    for (int i = 2; i <= Nsqrt; i++) {
        if (isprime[i]) {
            prime.push_back(i);
            for (int j = i * 2; j <= Nsqrt; j += i)
                isprime[j] = false;
        }
    }
    Lenp = prime.size();
}


void init_fpsum()
{
    for (int i = 1; i <= Nsqrt; ++i) {
        vs_s[i] = i - 1;
        vs_l[i] = N / i - 1;
    }
    for (int ip = 0; ip < Lenp; ++ip) {
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


ll dfs(ll n, ll coef, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < Lenp; ++i) {
        int p = prime[i];
        ll q = (ll)p * (ll)p;
        if (n < q)    break;
        ll nnew = n / p;
        ll coefnew = coef + 1;
        if (nnew <= Nsqrt)
            s += (coefnew + 1) * (vs_s[nnew] - vs_s[p]);
        else
            s += (coefnew + 1) * (vs_l[N / nnew] - vs_s[p]);
        if (nnew > q)
            s += dfs(nnew, coefnew, i + 1);
        coefnew++;
        while (1) {
            s += coefnew;
            if (nnew >= q) {
                nnew /= p;
                if (nnew <= Nsqrt)
                    s += (coefnew + 1) * (vs_s[nnew] - vs_s[p]);
                else
                    s += (coefnew + 1) * (vs_l[N / nnew] - vs_s[p]);
                if (nnew > q)
                    s += dfs(nnew, coefnew, i + 1);
            } else {
                break;
            }
            coefnew++;
        }
    }
    return s;
}


int main()
{
    clock_t t0 = clock();

    init_primes();
    init_fpsum();
    ll s = vs_l[1] + dfs(N, 0, 0);
    printf("S(%lld) = %lld\n", N, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
