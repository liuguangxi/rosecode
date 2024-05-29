#include <bits/stdc++.h>
using namespace std;


constexpr int N = 20;
constexpr char Vstr[] = "ABCDEFGHIJKLMNOPQRST";
bool used[N + 1];
int num[2 * N + 1];
bool found = false;



void printstr()
{
    for (int i = 1; i <= 2 * N; i++)
        printf("%c", Vstr[num[i] - 1]);
    printf("\n");
}


void dfs(int k)
{
    int iempty = 0;
    for (int i = 1; i <= 2 * N; i++) {
        if (num[i] == 0) {
            iempty = i;
            break;
        }
    }
    for (int x = 1; x <= N; x++) {
        if (used[x])    continue;
        if (iempty + x + 1 > 2 * N)    continue;
        if (num[iempty + x + 1] != 0)    continue;
        used[x] = true;
        num[iempty] = x;
        num[iempty + x + 1] = x;
        if (k == N) {
            printstr();
            found = true;
            return;
        } else {
            dfs(k + 1);
        }
        if (found)    return;
        used[x] = false;
        num[iempty] = 0;
        num[iempty + x + 1] = 0;
    }
}


void solve()
{
    dfs(1);
}


int main()
{
    solve();
    return 0;
}
