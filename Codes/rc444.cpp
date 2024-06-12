#include <bits/stdc++.h>
using namespace std;


typedef long long ll;
typedef pair<int, unsigned> tabkey;    // keylen, mask
typedef pair<pair<ll, ll>, unsigned> tabvalue;    // blklen, noa, mask


ll C(int a, int b, ll n)
{
    // Initialize parameters
    int maxab = max(a, b);
    int lenkey = (int)(log((double)n/(a+b)) / log(2.0*maxab) + 0.5) + 3;
    int lenkseq = max(maxab, (int)(1.5 * (double)n / pow(sqrt((double)(a*b)), lenkey - 1.0) + 0.5));

    // Initialize K(a, b)
    vector<bool> vkseq(lenkseq, false);
    if (a == 1)    vkseq[1] = true;
    int i1 = 1, i2 = a - 1;
    while (i2 < lenkseq - 1) {
        bool d = !vkseq[i2];
        int cnt = vkseq[i1] ? b : a;
        while (cnt > 0) {
            cnt--;
            i2++;
            if (i2 < lenkseq)    vkseq[i2] = d;
            else    break;
        }
        i1++;
    }

    // Initialize table
    map<tabkey, tabvalue> tabkseq;
    tabkseq[make_pair(1, 0U)] = make_pair(make_pair(1, 1), 0U);
    tabkseq[make_pair(1, 1U)] = make_pair(make_pair(1, 0), 0U);
    ll blklen, noa;
    unsigned v0;
    for (int i = 2; i <= lenkey; ++i) {
        for (unsigned x = 0; x < (1U << i); ++x) {
            blklen = 0;
            noa = 0;
            v0 = x & ((1U << (i-1)) - 1U);
            int cnt = (x & (1U << (i-1))) ? b : a;
            for (int j = 1; j <= cnt; ++j) {
                tabvalue z = tabkseq[make_pair(i-1, v0)];
                blklen += z.first.first;
                noa += z.first.second;
                v0 = z.second | (x & (1U << (i-2)));
            }
            unsigned dlast = (v0 & (1U << (i-2))) ? 0U : 1U;
            if (i == 2)    tabkseq[make_pair(i, x)] = make_pair(make_pair(blklen, noa), (dlast << (i-2)));
            else    tabkseq[make_pair(i, x)] = make_pair(make_pair(blklen, noa), ((v0 & ((1U << (i-2)) - 1U)) | (dlast << (i-2))));
        }
    }
    /*map<tabkey, tabvalue>::iterator piter;
    for (piter = tabkseq.begin(); piter != tabkseq.end(); ++piter) {
        printf("[%d, %u] -> [%lld, %lld, %u]\n", piter->first.first, piter->first.second,
            piter->second.first.first, piter->second.first.second, piter->second.second);
    }*/

    // Calculate C
    ll s = 0, len = 0;
    int idx = 0;
    unsigned v = 0;
    while (len < n) {
        tabvalue z = tabkseq[make_pair(lenkey, v)];
        if (len + z.first.first > n)    break;
        len += z.first.first;
        s += z.first.second;
        idx++;
        unsigned dlast = vkseq[idx] ? 1U : 0U;
        v = z.second | (dlast << (lenkey - 1));
    }
    if (len < n) {
        for (int k = lenkey - 1; k >= 1; --k) {
            if (k == 1) {
                if ((v & 1U) == 0)    s += n - len;
                break;
            } else {
                int cnt = (v & (1U << k)) ? b : a;
                for (int i = 1; i <= cnt; ++i) {
                    tabvalue z = tabkseq[make_pair(k, (v & ((1U << k) - 1U)))];
                    if (len + z.first.first <= n) {
                        len += z.first.first;
                        s += z.first.second;
                        v = z.second | (v & (1U << (k - 1)));
                    } else {
                        break;
                    }
                }
            }
            if (len == n)    break;
        }
    }
    printf("C_{%d, %d} (%lld) = %lld", a, b, n, s);
    printf("    [lenkey = %d, lenkseq = %d, idx = %d]\n", lenkey, lenkseq, idx);
    if (lenkseq <= idx) {
        printf("ERROR!\n");
        exit(-1);
    }

    return s;
}


ll S(int m, ll n)
{
    ll s = 0;
    for (int a = 2; a <= m - 1; ++a)
        for (int b = a + 1; b <= m; ++b)
            s += C(a, b, n);
    return s;
}


void solve()
{
    constexpr int M = 100;
    constexpr ll N = 1000000000000000LL;
    ll s = S(M, N);
    printf("S(%d, %lld) = %lld\n", M, N, s);    // S(100, 1000000000000000) = 2419496601287807219
}


int main()
{
    solve();
    return 0;
}
