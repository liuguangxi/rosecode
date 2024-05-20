#include <bits/stdc++.h>
using namespace std;


using ull = unsigned long long;
constexpr int N = 47;
vector<ull> Vseq;


string seqtosgn(ull n)
{
    string str;
    for (ull k = 1ULL << (N - 1); k != 0; k >>= 1)
        str += (k & n) ? "-" : "+";
    return str;
}


bool isbalance(ull x)
{
    constexpr int HalfNum = N * (N + 1) / 4;
    ull msk = (1ULL << N) - 1;
    int cnt = 0;
    while (x > 0) {
        cnt += __builtin_popcountll(x);
        msk >>= 1;
        x = (x ^ (x >> 1)) & msk;
    }
    return cnt == HalfNum;
}


void dfs(int tot, int used, int pos, ull num)
{
    int used_new;
    ull num_new;
    for (int x = 0; x <= 1; x++) {
        used_new = used + x;
        if (used_new <= tot) {
            num_new = num + ((ull)x << pos);
            if (used_new == tot) {
                if (isbalance(num_new))
                    Vseq.push_back(num_new);
            } else {
                if ((pos < N - 1) && (used_new + N - pos > tot))
                    dfs(tot, used_new, pos + 1, num_new);
            }
        }
    }
}


void solve()
{
    for (int k = 1; k <= N; k++) {
        printf("#'-' = %d\n", k);
        dfs(k, 0, 0, 0);
        if (Vseq.size() > 0) {
            printf("#'-' = %d, #'+' = %d\n", k, N - k);
            break;
        }
    }
    sort(Vseq.begin(), Vseq.end());
    int count = Vseq.size();
    ull seq  = Vseq[0];
    printf("%d,%s\n", count, seqtosgn(seq).c_str());
}


int main()
{
    solve();
    return 0;
}
