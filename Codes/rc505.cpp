/*
13,12,11,10,8,8,4,4,4,4,4,4,4,4,4,4,4,4,3,2,2,1,1,1,1,1,1/42,34,18,9,6,5,3,3,2,1
*/


#include <bits/stdc++.h>
using namespace std;


constexpr int N = 123;
constexpr int P = 123456789;
int Vd[N];
int Cnt;
bool Done;


void print_vd(int k)
{
    cout << Vd[0];
    for (int i = 1; i <= k; i++)    cout << "," << Vd[i];
    cout << endl;
}


void dfs(int nrest, int nmax, int k)
{
    int xmax = min(nrest, nmax);
    for (int x = 1; x <= xmax; x++) {
        Vd[k] = x;
        int nrestnew = nrest - x;
        if (nrestnew == 0) {
            Cnt++;
            if (Cnt == P) {
                print_vd(k);
                Done = true;
                return;
            }
        } else {
            dfs(nrestnew, x, k + 1);
        }
        if (Done)    return;
    }
}


void dfs_anti(int nrest, int nmax, int k)
{
    int xmax = min(nrest, nmax);
    for (int x = xmax; x >= 1; x--) {
        Vd[k] = x;
        int nrestnew = nrest - x;
        if (nrestnew == 0) {
            Cnt++;
            if (Cnt == P) {
                print_vd(k);
                Done = true;
                return;
            }
        } else {
            dfs_anti(nrestnew, x, k + 1);
        }
        if (Done)    return;
    }
}


void solve()
{
    Cnt = 0;
    Done = false;
    dfs(N, N, 0);

    Cnt = 0;
    Done = false;
    dfs_anti(N, N, 0);
}


int main()
{
    solve();
    return 0;
}
