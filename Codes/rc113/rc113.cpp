#include <bits/stdc++.h>
using namespace std;


constexpr int N = 6700417;


void solve()
{
    constexpr unsigned Nmsk = ~N;
    vector<int> v;
    for (int i = 0; i <= N; i++) {
        if ((Nmsk & i) == 0)    v.push_back(i);
    }

    int s = 0;
    for (int k = 0; k <= 2 * N; k++) {
        if (k % 1000000 == 0)    printf("k = %d\n", k);
        int sk = 0;
        int imin = max(k - N, 0);
        int imax = k / 2;
        for (const auto vi : v) {
            if (vi < imin || vi > imax)    continue;
            unsigned msk = ~(N - vi);
            if ((msk & (k - 2*vi)) == 0)    sk++;
        }
        if (sk % 2 == 1)    s++;
    }
    cout << s << endl;
}


int main()
{
    solve();
    return 0;
}
