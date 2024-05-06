/*
30371738477328116: (10881, 12658) <-> 49517185321335933: (16199, 16227)
49517185321335933: (16199, 16227) <-> 30371738477328116: (10881, 12658)

10881,12658,16199,16227
*/


#include <bits/stdc++.h>
using namespace std;


using ll = long long;
using pli = pair<ll, int>;

constexpr ll P = 79888923798664049LL;
constexpr int T = 18000;
constexpr int L = (T - 1) * (T - 1);
vector<pli> v(L);


ll mulmod(ll a, int b, ll m)
{
    ll ans = 0;
    while (b) {
        if (b & 1) {
            b--;
            ans = (ans + a) % m;
        }
        b >>= 1;
        a = (a + a) % m;
    }
    return ans;
}


void init()
{
    int s = 0;
    ll z;

    for (int x = 1; x < T; x++) {
        z = (ll)x;
        for (int y = 1; y < T; y++) {
            v[s++] = make_pair(z, x * T + y);
            z = mulmod(z, x, P);
        }
    }
    cout << "init array done" << endl;

    sort(v.begin(), v.end(),
        [] (pli x1, pli x2) {return x1.first < x2.first;}
    );
    cout << "sort array done" << endl;
}


void search()
{
    int k2 = L - 1;
    for (int k1 = 0; k1 < L; k1++) {
        while (k2 >= 0 && v[k1].first + v[k2].first >= P) {
            if (v[k1].first + v[k2].first == P) {
                printf("%lld: (%d, %d) <-> %lld: (%d, %d)\n",
                    v[k1].first, v[k1].second / T, v[k1].second % T,
                    v[k2].first, v[k2].second / T, v[k2].second % T
                );
            }
            k2--;
        }
    }
}


int main()
{
    init();
    search();
    return 0;
}
