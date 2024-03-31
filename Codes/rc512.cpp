/*
S(1000000000000) = 2937682253212
execution time : 0.484 s

S(100000000000000) = 248491232039980
execution time : 5.725 s

S(10000000000000000) = 31647492723431868
execution time : 107.859 s

S(1000000000000000000) = 2413374506903069436
execution time : 2159.512 s

S(1000000000000000) = 3505008235606732
execution time : 24.710 s
*/


#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <flint/ulong_extras.h>

using namespace std;


typedef long long ll;

const ll N = 1000000000000000LL;
const int Nsqrt = 31622776;    // sqrtint(N)
int Pmax;
int T = 0;
ll S = 0;
vector<bool> isprime(Nsqrt+1);
vector<int> vp;


int sqrtint(ll x)
{
    if (x <= 0)
        return 0;
    int r = (int)sqrt(x - 0.1);
    while ((ll)r * (ll)r <= x)
        r++;
    return r - 1;
}


bool ispseudoprime(ll x)
{
    if (x <= Nsqrt)
        return isprime[x];
    return n_is_probabprime_BPSW(x);
}


void init()
{
    isprime[0] = isprime[1] = false;
    for (int i = 2; i <= Nsqrt; i++)
        isprime[i] = true;

    int maxp_sqrt = sqrtint(Nsqrt);
    for (int i = 2; i <= Nsqrt; i++) {
        if (isprime[i]) {
            vp.push_back(i);
            if (i <= maxp_sqrt) {
                for (int j = i*i; j <= Nsqrt; j += i)
                    isprime[j] = false;
            }
        }
    }

    Pmax = vp[vp.size()-1];
}


int find_pmax(double c, int lo, int hi, double val)
{
    double logc = log(c);
    int mi = 0;
    while (lo < hi) {
        mi = (lo + hi) / 2;
        double e = floor(logc/log((double)mi));
        double f = pow((double)mi / (mi-1), e);
        if (f < val)
            hi = mi;
        else
            lo = mi + 1;
    }
    return mi - 1;
}


bool calc_pminmax(int p, ll n, ll sn, int& pmin, int& pmax)
{
    double ndivn = (double)(N / n);
    double v1 = 2.0*n/sn;
    double v2 = 128.0/sn;
    double rmin = v1 + v2/ndivn;
    double rmax = v1 + v2/(p+1);
    double u = 1.0 + 1/ndivn;

    pmin = p + 1;
    pmax = Pmax;
    if (rmax < u)
        return false;
    pmin = max(p+1, (int)ceil(1/(rmax-1)));
    if (rmin < u)
        return true;
    pmax = find_pmax(ndivn, p, Pmax, rmin);
    if (pmax < pmin)
        return false;
    pmax = min(Pmax, pmax);
    return true;
}


void dfs(ll n0, ll sn0, int pmin, int pmax)
{
    // n = n0 * q
    ll u1 = 2*n0 - sn0;
    ll u2 = sn0 - 128;
    if (((u1 > 0 && u2 > 0) || (u1 < 0 && u2 < 0)) && (u2 % u1 == 0)) {
        ll q = u2 / u1;
        if (q >= pmin && q <= N / n0 && ispseudoprime(q)) {
            ll n0_new = n0 * q;
            T++;
            S += n0_new;
            printf("[%d]  %lld\n", T, n0_new);
        }
    }


    // n = n0 * p^e, e >= 1
    int pmin_new = 0;
    int pmax_new = 0;
    vector<int>::const_iterator ipmin = lower_bound(vp.begin(), vp.end(), pmin);
    for (vector<int>::const_iterator it = ipmin; it != vp.end(); it++) {
        int p = *it;
        if (p > pmax)
            break;
        ll pe = (ll)p * (ll)p;
        if (pe > N / n0)
            break;
        ll n0_new = n0 * p;
        ll mul_sn0 = 1 + p;
        ll sn0_new = sn0 * mul_sn0;
        if (calc_pminmax(p, n0_new, sn0_new, pmin_new, pmax_new))
            dfs(n0_new, sn0_new, pmin_new, pmax_new);

        n0_new = n0 * pe;
        mul_sn0 += pe;
        sn0_new = sn0 * mul_sn0;
        ll ndivp = N / p;
        while (1) {
            if (sn0_new - 2*n0_new == 128) {
                T++;
                S += n0_new;
                printf("[%d]  %lld\n", T, n0_new);
            }
            if (n0_new < ndivp) {
                if (calc_pminmax(p, n0_new, sn0_new, pmin_new, pmax_new))
                    dfs(n0_new, sn0_new, pmin_new, pmax_new);
                n0_new *= p;
                pe *= p;
                mul_sn0 += pe;
                sn0_new = sn0 * mul_sn0;
            } else {
                break;
            }
        }
    }
}


int main()
{
    init();
    dfs(1LL, 1LL, 2, 2);    // seems n must be even
    printf("S(%lld) = %lld\n", N, S);

    return 0;
}
