#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int N = 6543;    // number of matrices


void solve()
{
    vector<int> W(N + 1);    // matrix A_i has size of W[i] * W[i+1], i = 0, 1, ..., N-1
    int r = 2;
    for (int i = 0; i <= N; i++) {
        int x = 5000 + r % 1000;
        W[i] = x;
        r = (ll)r * (ll)r % 98765431;
    }

    constexpr ll Cmax = 0x7fffffffffffffffLL;
    vector<vector<ll>> cost(N, vector<ll>(N, Cmax));
    for (int i = 0; i < N; i++)    cost[i][i] = 0;
    for (int l = 2; l <= N; l++) {
        if (l % 100 == 0)    printf("l = %d\n", l);
        for (int i = 0; i <= N - l; i++) {
            int j = i + l - 1;
            for (int k = i; k < j; k++)
                cost[i][j] = min(cost[i][j], cost[i][k] + cost[k+1][j] + (ll)W[i]*(ll)W[k+1]*(ll)W[j+1]);
        }
    }
    ll s = cost[0][N-1];
    printf("C(%d) = %lld\n", N, s);    // C(6543) = 977978554479058
}


int main()
{
    solve();
    return 0;
}
