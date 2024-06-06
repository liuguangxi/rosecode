#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int N = 16268;


void solve()
{
    ll idxn = N - 1;
    ll iter = 0;
    while (idxn != iter) {
        if (idxn > 2 * iter)
            idxn--;
        else if (idxn > iter)
            idxn = 2 * (idxn - iter - 1);
        else
            idxn = 2 * (iter - idxn) - 1;
        iter++;
    }
    ll s = iter + 1;
    printf("O(%d) = %lld\n", N, s);
}


int main()
{
    solve();
    return 0;
}
