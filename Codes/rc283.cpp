/* https://oeis.org/A166945 */


#include <bits/stdc++.h>
using namespace std;


using ll = long long;


void solve()
{
    constexpr int T = 32;
    int tot = 0;
    ll s1 = 2, s2 = 0;
    ll n = 1;
    ll d = 2;
    ll currmax = 0;

    while (tot < T) {
        n++;
        if (n & 1)
            s2 = s1 + __gcd(s1, n - 2);
        else
            s2 = s1 + __gcd(s1, n);
        d = s2 - s1;
        if (d > currmax) {
            currmax = d;
            tot++;
            printf("M(%d) = %lld    (n = %lld)\n", tot, d, n);
        }
        s1 = s2;
    }
}


int main()
{
    solve();
    return 0;
}
