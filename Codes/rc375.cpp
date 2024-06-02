#include <bits/stdc++.h>
using namespace std;


constexpr int Size = 6;
char Vnode[Size] = {0};
vector<int> Vmaxsz;


int proc()
{
    vector<char> v(Vnode, Vnode + Size);
    int maxsz = 0;

    for (int n = 1; n <= 100; n++) {
        int lenv = v.size();
        if (lenv == 1)    break;
        int idx1 = 0;
        for (int i = 1; i < lenv; i++) {
            if (v[i] > v[i - 1])    idx1 = i;
            else    break;
        }
        vector<char> v1;
        if (v[idx1] == 1) {
            v1.assign(v.begin(), v.begin() + idx1);
            v1.insert(v1.end(), v.begin() + idx1 + 1, v.end());
        } else {
            int idx2 = idx1;
            for (int i = idx1 + 1; i < lenv; i++) {
                if (v[i] >= v[idx1])    idx2 = i;
                else    break;
            }
            v1.assign(v.begin(), v.begin() + idx1 - 1);
            for (int k = 1; k <= n + 1; k++) {
                v1.push_back(v[idx1 - 1]);
                v1.insert(v1.end(), v.begin() + idx1 + 1, v.begin() + idx2 + 1);
            }
            v1.insert(v1.end(), v.begin() + idx2 + 1, v.end());
        }
        v.assign(v1.begin(), v1.end());
        if (v.size() > maxsz)    maxsz = v.size();
    }

    return maxsz;
}


void dfs(int k)
{
    for (int x = 1; x <= Vnode[k-1] + 1; x++) {
        Vnode[k] = x;
        if (k == Size - 1) {
            int maxsz = proc();
            Vmaxsz.push_back(maxsz);
            printf("(");
            for (int i = 0; i < Size - 1; i++)    printf("%d, ", Vnode[i]);
            printf("%d)    %d\n", Vnode[Size-1], maxsz);
        } else {
            dfs(k + 1);
        }
    }
}


void solve()
{
    dfs(1);
    sort(Vmaxsz.begin(), Vmaxsz.end(), greater<int>());
    printf("%d,%d,%d,%d,%d\n", Vmaxsz[0], Vmaxsz[1], Vmaxsz[2], Vmaxsz[3], Vmaxsz[4]);
}


int main()
{
    solve();
    return 0;
}
