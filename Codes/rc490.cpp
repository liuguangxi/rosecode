/*
Stat(1234567890, 314159265358979323) = 160453095/236619041
Elapsed time is 32.933 s
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>
#include <vector>

using namespace std;


typedef long long ll;


int sqrtint(ll x)
{
    if (x <= 0)    return 0;
    int r = (int)sqrt((double)(x - 0.1));
    while ((ll)r * (ll)r <= x)    ++r;
    return r - 1;
}


/* sum(i = 1, n, floor((num/den)*i)) */
ll T(ll n, ll num, ll den)
{
    ll q, r, s;

    if (n == 0 || num == 0)    return 0;
    if (n >= den) {
        q = n / den;
        r = n % den;
        s = (q * (q * num * den - den + num + 1)) / 2 + r * q * num;
        s += T(r, num, den);
    } else if (num >= den) {
        q = num / den;
        r = num % den;
        s = ((n * (n + 1) * q) / 2) + T(n, r, den);
    } else {
        q = (__int128)num * (__int128)n / den;
        s = n * q - T(q, den, num);
    }

    return s;
}


/* #{p/q: p/q <= num/den, 1 <= q <= n, gcd(p, q) = 1} */
ll S(ll n, ll num, ll den)
{
    int nsqrt = sqrtint(n);
    vector<ll> vs_s(nsqrt + 1);    // S(i)
    vector<ll> vs_l(nsqrt + 1);    // S(n/i)
    ll x, s;
    int xsqrt;

    for (int i = 1; i <= nsqrt; ++i) {
        x = i;
        s = T(x, num, den);
        xsqrt = sqrtint(x);
        if (xsqrt < 2) {
            for (int m = 2; m <= x; ++m)
                s -= vs_s[x / m];
        } else {
            for (int m = 2; m <= xsqrt; ++m)
                s -= vs_s[x / m];
            int tmax = x / (xsqrt + 1);
            for (int t = 1; t <= tmax; ++t)
                s -= (x / t - x / (t + 1)) * vs_s[t];
        }
        vs_s[i] = s;
    }

    for (int i = nsqrt; i >= 1; --i) {
        x = n / i;
        s = T(x, num, den);
        xsqrt = sqrtint(x);
        if (xsqrt < 2) {
            for (int m = 2; m <= x; ++m)
                s -= vs_s[x / m];
        } else {
            for (int m = 2; m <= xsqrt; ++m)
                s -= (x / m <= nsqrt) ? vs_s[x / m] : vs_l[n / (x / m)];
            int tmax = x / (xsqrt + 1);
            for (int t = 1; t <= tmax; ++t)
                s -= (x / t - x / (t + 1)) * vs_s[t];
        }
        vs_l[i] = s;
    }

    return vs_l[1] + 1;
}


/* num1/den1 = max({p/q: p/q <= num/den, 1 <= q <= n, gcd(p, q) = 1}), 0 < num/den < 1 */
void farey_appr(ll n, ll num, ll den, ll &num1, ll &den1)
{
    vector<ll> vp, vq;
    ll a0, a1, ak, pk, qk;
    int k;
    ll m;
    ll num0 = num;
    ll den0 = den;

    a0 = 0;
    vp.push_back(a0);
    vq.push_back(1);
    swap(num0, den0);
    a1 = num0 / den0;
    vp.push_back(a1*a0+1);
    vq.push_back(a1);
    num0 = num0 % den0;
    swap(num0, den0);
    k = 1;
    while (1) {
        ++k;
        ak = num0 / den0;
        pk = ak * vp[k-1] + vp[k-2];
        qk = ak * vq[k-1] + vq[k-2];
        if (qk > n)    break;
        vp.push_back(pk);
        vq.push_back(qk);
        num0 = num0 % den0;
        swap(num0, den0);
    }

    if (vp[k - 1] * den < vq[k - 1] * num) {
        num1 = vp[k - 1];
        den1 = vq[k - 1];
    } else {
        m = (n - vq[k - 2]) / vq[k - 1];
        num1 = m * vp[k - 1] + vp[k - 2];
        den1 = m * vq[k - 1] + vq[k - 2];
    }
}


/* the k-th term in the Farey sequency of order n, 1 <= k <= S(n, 1, 1) */
void Stat(ll n, ll k, ll &p, ll &q)
{
    ll kmax = S(n, 1, 1);
    if (k < 1 || k > kmax) {
        printf("k must in the range [1, %lld]\n", kmax);
        return;
    }
    if (k == 1) {
        p = 0;    q = 1;
        return;
    }
    if (k == kmax) {
        p = 1;    q = 1;
        return;
    }

    ll lo, hi, mid;
    ll num, den;
    ll s;

    lo = 0;    hi = 1;    den = 2;
    while (1) {
        mid = lo + hi;
        s = S(n, mid, den);
        printf("S(%lld, %lld/%lld) = %lld\n", n, mid, den, s);
        fflush(stdout);
        if (s == k) {
            num = mid;
            break;
        } else if (s > k) {
            hi = mid;    lo *= 2;
        } else {
            lo = mid;    hi *= 2;
        }
        den *= 2;
    }

    if (den <= n) {
        p = num;    q = den;
    } else {
        farey_appr(n, num, den, p, q);
    }
}


int main()
{
    clock_t t0 = clock();

    const ll N = 1234567890LL;
    const ll K = 314159265358979323LL;
    ll p, q;
    Stat(N, K, p, q);

    if (S(N, p, q) == K)    printf("OK\n");    else    printf("ERROR\n");
    printf("Stat(%lld, %lld) = %lld/%lld\n", N, K, p, q);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
