/*
#mapf = 13258035
S(1000000000000) = 396749333783906
*/


#include <bits/stdc++.h>
using namespace std;


using ll = long long;
using key = pair<ll, int>;

constexpr ll N = 1000000000000LL;
map<key, ll> mapf;


ll dfs(ll n, int k)
{
    ll s = n - k + 1;
    if (k + 1 > n / k)    return s;
    for (int x = k;; x++) {
        ll nnew = n / x;
        int knew = x + 1;
        if (knew > nnew)    break;
        if (knew + 1 > nnew / knew) {
            s += nnew - knew + 1;
        } else {
            if (mapf.find(key(nnew, knew)) == mapf.end())
                s += dfs(nnew, knew);
            else
                s += mapf[key(nnew, knew)];
        }
    }
    mapf[key(n, k)] = s;
    return s;
}


void solve()
{
    ll s = dfs(N, 2);
    cout << "#mapf = " << mapf.size() << endl;
    cout << "S(" << N << ") = " << s << endl;
}


int main()
{
    solve();
    return 0;
}
