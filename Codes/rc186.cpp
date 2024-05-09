/*
[1]    245589ab9a
[2]    045589ab9c
[3]    041589abdc
[4]    040589bbdc
[5]    004589bbdc
[6]    004769bbdc
[7]    00466abbdc
[8]    70466abb6c
[9]    76466abb0c
[10]    76466abbc0
[11]    764660bbca
[12]    064667bbca
[13]    764667bbc3
[14]    46466abbc3
[15]    464660bbcd
[16]    460664bbcd
N mod 1000000007 = 793288331
*/


#include <bits/stdc++.h>
using namespace std;


using ull = unsigned long long;
using Tubes = struct tubes {
    ull state;    // 40 bits: {J[3:0], I[3:0], H[3:0], G[3:0], F[3:0], E[3:0], D[3:0], C[3:0], B[3:0], A[3:0]}
    int prev;
};

set<ull> set_tube;
vector<Tubes> vec_tube;


bool cmp(Tubes e1, Tubes e2)
{
    return e1.state < e2.state;
}


void solve()
{
    constexpr unsigned M = 1000000007;
    constexpr unsigned Cap[10] = {14, 13, 12, 12, 10, 10, 7, 7, 7, 7};    // A, B, C, D, E, F, G, H, I, J
    constexpr ull First[10] = {10, 9, 11, 10, 9, 8, 5, 5, 4, 2};    // A, B, C, D, E, F, G, H, I, J
    constexpr ull Last[10] = {13, 12, 11, 11, 4, 6, 6, 0, 6, 4};    // A, B, C, D, E, F, G, H, I, J
    constexpr ull StateFirst = First[0] | (First[1] << 4) | (First[2] << 8) | (First[3] << 12) | (First[4] << 16) |
                               (First[5] << 20) | (First[6] << 24) | (First[7] << 28) | (First[8] << 32) | (First[9] << 36);
    constexpr ull StateLast = Last[0] | (Last[1] << 4) | (Last[2] << 8) | (Last[3] << 12) | (Last[4] << 16) |
                               (Last[5] << 20) | (Last[6] << 24) | (Last[7] << 28) | (Last[8] << 32) | (Last[9] << 36);

    int lastidx = -1;
    Tubes t1 = {StateFirst, -1};
    Tubes t2;
    int head = 0, tail = 0;
    int tail_orig;
    ull state1, state2;
    unsigned c1, c2, c1_new;
    bool found = false;
    vector<ull> vec_state;
    ull ans = 0;

    vec_tube.push_back(t1);
    set_tube.insert(StateFirst);
    while (head <= tail) {
        tail_orig = tail;
        t1 = vec_tube[head];
        state1 = t1.state;
        for (int i1 = 0; i1 <= 9; i1++) {
            c1 = (state1 >> (4 * i1)) & 0xF;
            if (c1 == 0)    continue;
            for (int i2 = 0; i2 <= 9; i2++) {
                if (i1 == i2)    continue;
                c2 = (state1 >> (4 * i2)) & 0xF;
                if (c2 == Cap[i2])    continue;
                if (c1 > Cap[i2] - c2) {
                    c1_new = c1 - Cap[i2] + c2;
                    c2 = Cap[i2];
                } else {
                    c1_new = 0;
                    c2 += c1;
                }
                state2 = state1 & (~(0xFULL << (4 * i1))) & (~(0xFULL << (4 * i2)));
                state2 |= ((ull)c1_new << (4 * i1)) | ((ull)c2 << (4 * i2));
                if (set_tube.count(state2) == 0) {
                    set_tube.insert(state2);
                    t2.state = state2;
                    t2.prev = head;
                    vec_tube.push_back(t2);
                    tail++;
                    if (tail % 1000000 == 0)    printf("tail = %d\n", tail);
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
    ull state_part;
    for (int i = len_state - 1; i >= 0; i--) {
        state_part = (ull)vec_state[i] >> 20;
        ans = (ans * (1ULL << 20) + state_part) % M;
        state_part = (ull)vec_state[i] & 0xFFFFF;
        ans = (ans * (1ULL << 20) + state_part) % M;
        printf("[%d]    %010llx\n", len_state - i, vec_state[i]);
    }
    printf("N mod %u = %llu\n", M, ans);
}


int main()
{
    solve();
    return 0;
}
