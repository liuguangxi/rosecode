/*
S(1234567654321) = 8077226371914
*/


#include <bits/stdc++.h>
using namespace std;


using u8 = unsigned char;
using u64 = unsigned long long;

constexpr u64 N = 1234567654321LL;
constexpr unsigned T = (1 << 25);
u8 F[T];
unsigned Va1[64];
u64 S = 0;


u64 trans(u64 x)
{
    static int b[64] = {0};
    int len = 0;
    unsigned xprev = x & 1;
    unsigned t = 1;
    u64 res = 1;

    x >>= 1;
    while (x > 0) {
        if ((x & 1) == xprev) {
            t++;
        } else {
            b[len++] = t;
            t = 1;
            xprev = 1 - xprev;
        }
        x >>= 1;
    }
    b[len++] = t;

    xprev = 1;
    for (int i = len - 2; i >= 0; i--) {
        if (b[i] != b[i + 1])
            xprev = 1 - xprev;
        res = (res << 1) + xprev;
    }
    return res;
}


u8 calc_m(u64 r)
{
    u8 res = 0;
    while (r >= T) {
        res++;
        r = trans(r);
    }
    return res + F[r];
}


void init()
{
    F[1] = 0;
    for (unsigned i = 2; i < T; i++) {
        u64 r = trans(i);
        F[i] = (r >= i) ? 2 : (F[r] + 1);
    }
    cout << "init done" << endl;
}


void calc_dfs2_param(u64 x, unsigned *r0, u64 *a1, unsigned *a1kprev)
{
    static int b[64] = {0};
    int len = 0;
    unsigned xprev = x & 1;
    unsigned t = 1;

    x >>= 1;
    while (x > 0) {
        if ((x & 1) == xprev) {
            t++;
        } else {
            b[len++] = t;
            t = 1;
            xprev = 1 - xprev;
        }
        x >>= 1;
    }
    b[len++] = t;
    *r0 = b[0];

    *a1 = 1;
    *a1kprev = 1;
    for (int i = len - 2; i >= 0; i--) {
        if (b[i] != b[i + 1])
            *a1kprev = 1 - *a1kprev;
        *a1 = ((*a1) << 1) + *a1kprev;
    }
}


void dfs(int k, unsigned rest, u64 a1, unsigned a1kprev)
{
    a1 <<= 1;
    if (k == 1) {
        S += rest - 1;
    } else {
        u64 c = rest;
        if (Va1[k - 1] <= rest) {
            S += 1 + calc_m(a1 + a1kprev);
            c--;
        }
        S += c * (1 + calc_m(a1 + 1 - a1kprev));
    }

    for (unsigned x = 1; x < rest; x++) {
        if (k == 1)    cout << "x = " << x << endl;
        Va1[k] = x;
        unsigned a1kprev_new = (Va1[k] == Va1[k - 1]) ? a1kprev : (1 - a1kprev);
        u64 a1_new = a1 + a1kprev_new;
        dfs(k + 1, rest - x, a1_new, a1kprev_new);
    }
}


void dfs2(int k, unsigned rest, u64 a1, unsigned a1kprev)
{
    a1 <<= 1;
    if (Va1[k - 1] == rest)
        S += 1 + calc_m(a1 + a1kprev);
    else
        S += 1 + calc_m(a1 + 1 - a1kprev);

    for (unsigned x = 1; x < rest; x++) {
        Va1[k] = x;
        unsigned a1kprev_new = (Va1[k] == Va1[k - 1]) ? a1kprev : (1 - a1kprev);
        u64 a1_new = a1 + a1kprev_new;
        dfs2(k + 1, rest - x, a1_new, a1kprev_new);
    }
}


void calc()
{
    unsigned vnbit[64];
    int bitcnt = 0;
    u64 x = N;
    while (x > 0) {
        vnbit[bitcnt++] = x & 1;
        x >>= 1;
    }

    Va1[0] = 0;
    dfs(1, bitcnt - 1, 0, 0);
    S += calc_m(1ULL << (bitcnt - 1));
    cout << "Part 1 done" << endl;

    u64 npre = 1;
    unsigned r0j;
    u64 a1j;
    unsigned a1kprevj;
    for (int i = bitcnt - 2; i >= 0; i--) {
        npre = (npre << 1) + vnbit[i];
        cout << "i = " << i << endl;
        if (vnbit[i] == 1) {
            S += calc_m(npre << i);
            u64 nprej = npre - vnbit[i];
            for (int j = i - 1; j >= 0; j--) {
                calc_dfs2_param(nprej, &r0j, &a1j, &a1kprevj);
                Va1[0] = r0j;
                dfs2(1, j + 1, a1j, a1kprevj);
                nprej <<= 1;
            }
        }
    }
    cout << "Part 2 done" << endl;

    cout << "S(" << N << ") = " << S << endl;
}


int main()
{
    init();
    calc();
    return 0;
}
