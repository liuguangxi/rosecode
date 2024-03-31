/*
liuguangxi : S(200000000) = 1364490690
execution time : 30.925 s

baihacker : S(200000000) = 1364490690
execution time : 1.230 s

sinan : S(200000000) = 1364490690
execution time : 4.430 s
*/


#include <cmath>
#include <iostream>
#include <vector>
#include <flint/nmod.h>

using namespace std;


using ll = long long;


// a^e mod m
int powmod(int a, int e, int m)
{
    ll d = 1, t = a;
    while (e > 0) {
        if (e & 1)
            d = (d * t) % m;
        e >>= 1;
        t = (t * t) % m;
    }
    return static_cast<int>(d);
}


// 1/a mod m
int invmod(int a, int m)
{
    int j = 1, i = 0, b = m, c = a, x, y;
    while (c) {
        x = b / c;    y = b - x * c;    b = c;    c = y;
        y = j;    j = i - j * x;    i = y;
    }
    if (i < 0)    i += m;
    return i;
}


void calc_liuguangxi(int n)
{
    const int M = 2147483647;
    ll s = 1;
    for (int x = 2; x <= n; x++)
        s = (s * powmod(x, x, M)) % M;
    cout << "S(" << n << ") = "<< s << endl;
}


void calc_baihacker(int n)
{
    const int M = 2147483647;
    ll a = 1, b = 1;
    for (int x = 1; x <= n; x++) {
        a = (a * x) % M;
        b = (b * a) % M;
    }
    a = powmod(static_cast<int>(a), n + 1, M);
    b = invmod(static_cast<int>(b), M);
    ll s = (a * b) % M;
    cout << "S(" << n << ") = "<< s << endl;
}


int ex(int n, int p)
{
    const int M1 = 2147483647 - 1;
    ll pe = 1;
    ll s = 0;
    while (1) {
        pe *= p;
        if (pe > n)
            break;
        ll ndivpe = n / pe;
        ll t = (ndivpe * (ndivpe + 1) / 2) % M1;
        t = (t * pe) % M1;
        s = (s + t) % M1;
    }
    return static_cast<int>(s);
}


void calc_sinan(int n)
{
    const int M = 2147483647;
    vector<bool> isprime(n + 1, true);
    int nsqrt = static_cast<int>(sqrt(n * 1.0) + 0.5);
    ll s = 1;
    for (int x = 2; x <= n; x++) {
        if (isprime[x]) {
            s = (s * powmod(x, ex(n, x), M)) % M;
            if (x <= nsqrt) {
                for (int k = x * x; k <= n; k += x)
                    isprime[k] = false;
            }
        }
    }
    cout << "S(" << n << ") = "<< s << endl;
}


void calc_flint(int n)
{
    const ulong M = UWORD(2147483647);
    nmod_t mod;
    nmod_init(&mod, M);
    ulong s = UWORD(1);
    ulong t;
    ulong xmax = static_cast<ulong>(n);
    for (ulong x = 2; x <= xmax; x++) {
        t = nmod_pow_ui(x, x, mod);
        s = nmod_mul(s, t, mod);
    }
    cout << "S(" << n << ") = "<< s << endl;
}


int main()
{
    //cout << "liuguangxi : ";
    //calc_liuguangxi(200000000);

    //cout << "baihacker : ";
    //calc_baihacker(200000000);

    //cout << "sinan : ";
    //calc_sinan(200000000);

    calc_flint(200000000);

    return 0;
}
