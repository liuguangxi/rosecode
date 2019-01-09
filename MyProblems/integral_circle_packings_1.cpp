#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>
#include <vector>
#include <set>

using namespace std;


typedef long long ll;
typedef struct quad {
    int c1, c2, c3, c4;
} Quad;

const int T = 50;
const int N = 10000000;

vector<bool> isprime(N + 1, false);
vector<Quad> vquad;
set<int> setp;
ll num;


int gcd(int a, int b)
{
    int r;
    while (b > 0) {
        r = a % b; a = b; b = r;
    }
    return a;
}


void init()
{
    fill(isprime.begin() + 2, isprime.end(), true);
    for (int i = 2; i <= N; ++i) {
        if (isprime[i]) {
            for (int j = i * 2; j <= N; j += i)    isprime[j] = false;
        }
    }
}


void gen_init_quad()
{
    for (int b = 1; b <= T; ++b) {
        for (int c = b; c <= T; ++c) {
            for (int d = c; d <= T; ++d) {
                int u2 = b*c + c*d + d*b;
                int u = (int)(sqrt((double)u2) + 0.5);
                if (u * u != u2)    continue;
                int a = b + c + d - 2*u;
                if (a < 0 && a + b + c >= d && gcd(gcd(a, b), gcd(c, d)) == 1) {
                    Quad quad = {a, b, c, d};
                    vquad.push_back(quad);
                }
            }
        }
    }
}


void rec(int k, int c1, int c2, int c3, int c4)
{
    int cnew;

    num++;
    if (k == 1) {
        if (isprime[-c1])    setp.insert(-c1);
        if (isprime[c2])    setp.insert(c2);
        if (isprime[c3])    setp.insert(c3);
        if (isprime[c4])    setp.insert(c4);
        cnew = 2*(c2+c3+c4)-c1;
        if (cnew <= N)    rec(k + 1, c2, c3, c4, cnew);
        cnew = 2*(c1+c3+c4)-c2;
        if (cnew <= N)    rec(k + 1, c1, c3, c4, cnew);
        cnew = 2*(c1+c2+c4)-c3;
        if (c3 != c2 && cnew <= N)    rec(k + 1, c1, c2, c4, cnew);
        cnew = 2*(c1+c2+c3)-c4;
        if (c4 != c3 && cnew != c4 && cnew <= N)    rec(k + 1, c1, c2, c3, cnew);
    } else {
        if (isprime[c4])    setp.insert(c4);
        cnew = 2*(c2+c3+c4)-c1;
        if (cnew <= N)    rec(k + 1, c2, c3, c4, cnew);
        cnew = 2*(c1+c3+c4)-c2;
        if (c2 != c1 && cnew <= N)    rec(k + 1, c1, c3, c4, cnew);
        cnew = 2*(c1+c2+c4)-c3;
        if (c3 != c2 && cnew <= N)    rec(k + 1, c1, c2, c4, cnew);
    }
}


void calc()
{
    int lenvquad = vquad.size();
    Quad quad;
    set<int>::iterator iter;
    ll s = 0;
    ll sump;

    for (int i = 0; i < lenvquad; ++i) {
        quad = vquad[i];
        num = 0;
        setp.clear();
        rec(1, quad.c1, quad.c2, quad.c3, quad.c4);
        sump = 0;
        for (iter = setp.begin(); iter != setp.end(); ++iter)    sump += *iter;
        s += sump;
        printf("[%2d]  (%3d, %2d, %2d, %2d)    #Node = %lld    PrimeSum = %lld\n",
            i + 1, quad.c1, quad.c2, quad.c3, quad.c4, num, sump);
    }
    printf("S(%d, %d) = %lld\n", T, N, s);    // S(50, 10000000) = 24267971528227
}


int main()
{
    clock_t t0 = clock();

    init();
    gen_init_quad();
    calc();

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
