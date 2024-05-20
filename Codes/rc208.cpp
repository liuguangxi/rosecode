/*
https://en.wikipedia.org/wiki/Laver_table
https://oeis.org/A098820
*/


#include <bits/stdc++.h>
using namespace std;


constexpr int N = (1 << 23);
vector<vector<int>> T(N, vector<int>(1));


void solve()
{
    for (int i = 1; i < N; i++)    T[i][0] = i % N + 1;

    for (int i = N - 1; i >= 1; i--) {
        if (T[i][0] == N)    continue;
        for (int j = 1; j < N; j++) {
            int p = T[i][j-1];
            int x;
            if (p == N) {
                x = T[i][0];
            } else {
                int M = T[p].size();
                int q = (T[i][0] - 1) % M;
                x = T[p][q];
            }
            T[i].push_back(x);
            if (x == N)    break;
        }
    }

    /*printf("%d", T[1][0]);
    for (size_t i = 1; i < T[1].size(); i++)
        printf(",%d", T[1][i]);
    printf("\n");*/
    for (size_t i = 1; i < T[1].size(); i++) {
        if (i == 1)
            printf("%d", T[1][i]/2 - T[1][i-1]/2);
        else
            printf(",%d", T[1][i]/2 - T[1][i-1]/2);
    }
    printf("\n");
}


int main()
{
    solve();
    return 0;
}
