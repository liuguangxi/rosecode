#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr ll N = 1000000000000000000LL;
constexpr int Ncbrt = 1000000;    // sqrtnint(N, 3)
int Lenp;
vector<int> primepi(Ncbrt + 1);
vector<int> prime;


int sqrt3int(ll x)
{
    ll r = (ll)pow(x - 0.1, 0.3333);
    while (r * r * r <= x)    r++;
    return (int)(r - 1);
}


void init_primes()
{
    primepi[1] = 0;
    for (int i = 2; i <= Ncbrt; i++)    primepi[i] = 1;
    for (int i = 2; i <= Ncbrt; i++) {
        if (primepi[i]) {
            prime.push_back(i);
            for (int j = i * 2; j <= Ncbrt; j += i)    primepi[j] = 0;
        }
    }
    for (int i = 2; i <= Ncbrt; i++)    primepi[i] += primepi[i - 1];
    Lenp = (int)prime.size();
}


ll dfs(ll n, int ipmin)
{
    ll s = 0;
    for (int i = ipmin; i < Lenp; i++) {
        int p = prime[i];
        ll p2 = (ll)p * (ll)p;
        ll q = p2 * p2;
        if (n < q)    break;
        ll nnew = n / p;
        s += primepi[sqrt3int(nnew)] - (i + 1);
        if (nnew > q)    s += dfs(nnew, i + 1);
        while (1) {
            s++;
            if (nnew >= q) {
                nnew /= p;
                s += primepi[sqrt3int(nnew)] - (i + 1);
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
    ll s = primepi[Ncbrt] + dfs(N, 0);
    cout << "C(" << N << ") = " << s << endl;    // C(1000000000000000000) = 25417528901
}


int main()
{
    solve();
    return 0;
}
