#include <bits/stdc++.h>
using namespace std;


using ull = unsigned long long;
using Tubes = struct tubes {
    unsigned state;    // 24 bits: {F[3:0], E[3:0], D[3:0], C[3:0], B[3:0], A[3:0]}
    int prev;
};

set<unsigned> set_tube;
vector<Tubes> vec_tube;


bool cmp(Tubes e1, Tubes e2)
{
    return e1.state < e2.state;
}


void solve()
{
    constexpr unsigned M = 1000000007;
    constexpr unsigned Cap[6] = {10, 10, 7, 7, 7, 7};    // A, B, C, D, E, F
    constexpr unsigned First[6] = {9, 7, 6, 5, 0, 0};    // A, B, C, D, E, F
    constexpr unsigned Last[6] = {9, 2, 2, 2, 5, 7};    // A, B, C, D, E, F
    constexpr unsigned StateFirst = First[0] | (First[1] << 4) | (First[2] << 8) | (First[3] << 12) | (First[4] << 16) | (First[5] << 20);
    constexpr unsigned StateLast = Last[0] | (Last[1] << 4) | (Last[2] << 8) | (Last[3] << 12) | (Last[4] << 16) | (Last[5] << 20);

    int lastidx = -1;
    Tubes t1 = {StateFirst, -1};
    Tubes t2;
    int head = 0, tail = 0;
    int tail_orig;
    unsigned state1, state2;
    bool found = false;
    vector<unsigned> vec_state;
    ull ans = 0;

    vec_tube.push_back(t1);
    set_tube.insert(StateFirst);
    while (head <= tail) {
        tail_orig = tail;
        t1 = vec_tube[head];
        state1 = t1.state;
        for (int i1 = 0; i1 <= 5; i1++) {
            for (int i2 = 0; i2 <= 5; i2++) {
                if (i1 == i2)    continue;
                unsigned c1 = (state1 >> (4 * i1)) & 0xF;
                unsigned c2 = (state1 >> (4 * i2)) & 0xF;
                if (c1 == 0 || c2 == Cap[i2])    continue;
                if (c1 > Cap[i2] - c2) {
                    c1 -= Cap[i2] - c2;
                    c2 = Cap[i2];
                } else {
                    c2 += c1;
                    c1 = 0;
                }
                state2 = state1 & (~(0xF << (4 * i1))) & (~(0xF << (4 * i2)));
                state2 |= (c1 << (4 * i1)) | (c2 << (4 * i2));
                if (set_tube.count(state2) == 0) {
                    set_tube.insert(state2);
                    t2.state = state2;
                    t2.prev = head;
                    vec_tube.push_back(t2);
                    tail++;
                }
            }
        }
        sort(&vec_tube[tail_orig + 1], &vec_tube[tail + 1], cmp);
        for (int i = tail_orig + 1; i <= tail; i++) {
            if (vec_tube[i].state == StateLast) {
                lastidx = i;
                found = true;
                break;
            }
        }
        if (found)    break;
        head++;
    }

    printf("vec_tube size = %d\n", (int)vec_tube.size());
    printf("set_tube size = %d\n", (int)set_tube.size());

    while (lastidx >= 0) {
        vec_state.push_back(vec_tube[lastidx].state);
        lastidx = vec_tube[lastidx].prev;
    }

    int len_state = vec_state.size();
    for (int i = len_state - 1; i >= 0; i--) {
        ans = (ans * (1ULL << 24) + (ull)vec_state[i]) % M;
        printf("[%d]    %06x\n", len_state - i, vec_state[i]);
    }
    printf("N mod %u = %llu\n", M, ans);
}


int main()
{
    solve();
    return 0;
}
