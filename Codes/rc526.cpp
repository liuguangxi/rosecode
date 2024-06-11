#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr ll N = 10000000000000000LL;
constexpr int Nsqrt = 100000000;    // sqrtint(N)
int Lenp;
vector<int> primepi(Nsqrt + 1);
vector<int> prime;


int sqrtint(ll x)
{
    return (int)sqrt((long double)x + 0.5);
}


void init_primes()
{
    primepi[1] = 0;
    for (int i = 2; i <= Nsqrt; i++)    primepi[i] = 1;
    for (int i = 2; i <= Nsqrt; i++) {
        if (primepi[i]) {
            prime.push_back(i);
            for (int j = i * 2; j <= Nsqrt; j += i)    primepi[j] = 0;
        }
    }
    for (int i = 2; i <= Nsqrt; i++)    primepi[i] += primepi[i - 1];
    Lenp = (int)prime.size();
}


ll dfs(ll n, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < Lenp; i++) {
        int p = prime[i];
        ll q = (ll)p * (ll)p * (ll)p;
        if (n < q)    break;
        ll nnew = n / p;
        s += primepi[sqrtint(nnew)] - (i + 1);
        if (nnew > q)    s += dfs(nnew, i + 1);
        while (1) {
            s++;
            if (nnew >= q) {
                nnew /= p;
                s += primepi[sqrtint(nnew)] - (i + 1);
                if (nnew > q)    s += dfs(nnew, i + 1);
            } else {
                break;
            }
        }
    }
    return s;
}


void solve()
{
    init_primes();
    ll s = primepi[Nsqrt] + dfs(N, 0);
    cout << "C(" << N << ") = " << s << endl;    // C(10000000000000000) = 200620098563
}


int main()
{
    solve();
    return 0;
}
