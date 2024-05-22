#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr ll N = 100000000000LL;
set<ll> Sn;


void solve()
{
    int bmax = (int)sqrt((double)N);
    ll bpow, x, n;

    for (int b = 2; b <= bmax; b++) {
        bpow = (ll)b * (ll)b;
        x = 1 + (ll)b + bpow;
        if (x > N)    break;
        while (x <= N) {
            for (int d = 1; d < b; d++) {
                n = (ll)d * x;
                if (n <= N)    Sn.insert(n);
                else    break;
            }
            bpow *= (ll)b;
            x += bpow;
        }
    }

    printf("S(%lld) = %d\n", N, (int)Sn.size());
}


int main()
{
    solve();
    return 0;
}
