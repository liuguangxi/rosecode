#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int N = 50;
constexpr int W[] = {
    8737, 1458, 1629, 5104, 8634, 9493, 1380,  898, 3036, 5012, 2405,
    5697, 6520, 4777, 4031, 3752, 7848, 7540, 2624, 2436, 4598,
    1020, 9050, 7031, 8692,   48, 396, 2747, 4224, 9760, 8525,
     391,  714, 4590, 1455, 5437, 4039, 6210, 7036, 5152, 4300,
    3511, 2484,  449, 5683, 9809, 4691, 3968, 3950, 5605, 1983
};


void solve()
{
    constexpr ll Cmax = 0x7fffffffffffffffLL;
    vector<vector<ll>> cost(N, vector<ll>(N, Cmax));
    for (int i = 0; i < N; i++)    cost[i][i] = 0;
    for (int l = 2; l <= N; l++) {
        for (int i = 0; i <= N - l; i++) {
            int j = i + l - 1;
            for (int k = i; k < j; k++)
                cost[i][j] = min(cost[i][j], cost[i][k] + cost[k+1][j] + (ll)W[i]*(ll)W[k+1]*(ll)W[j+1]);
        }
    }
    ll s = cost[0][N-1];
    cout << s << endl;
}


int main()
{
    solve();
    return 0;
}
