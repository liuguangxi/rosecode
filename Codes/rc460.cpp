#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>
#include <vector>
#include <complex>

using namespace std;


typedef long long ll;
typedef struct quad {
    int c1, c2, c3, c4;
} Quad;
typedef struct point {
   double x, y;
} Point;
typedef complex<double> Cmp;

const int T = 50;
const int G = 10;

vector<Quad> vquad;
vector<Point> vpt;


int gcd(int a, int b)
{
    int r;
    while (b > 0) {
        r = a % b; a = b; b = r;
    }
    return a;
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


void init_cord(int a, int b, int c, int d, Cmp &z1, Cmp &z2, Cmp &z3, Cmp &z4)
{
    z1 = 0;
    z2 = -1.0/a - 1.0/b;
    z3 = complex<double>(-1.0/a + 1.0*(a - b)/(a + b)/c, 1.0*(a + b + c - d)/(a + b)/c);
    z4 = complex<double>(-1.0/a + 1.0*(a - b)/(a + b)/d, -1.0*(a + b + d - c)/(a + b)/d);
}


void rec(int k, int c1, int c2, int c3, int c4, Cmp cz1, Cmp cz2, Cmp cz3, Cmp cz4)
{
    Point pt;
    int cnew;
    Cmp cznew;

    if (k == 1) {
        pt.x = cz1.real()/c1; pt.y = cz1.imag()/c1;
        vpt.push_back(pt);
        pt.x = cz2.real()/c2; pt.y = cz2.imag()/c2;
        vpt.push_back(pt);
        pt.x = cz3.real()/c3; pt.y = cz3.imag()/c3;
        vpt.push_back(pt);
        pt.x = cz4.real()/c4; pt.y = cz4.imag()/c4;
        vpt.push_back(pt);
        if (k < G) {
            cnew = 2*(c2+c3+c4)-c1;
            cznew = 2.0*(cz2+cz3+cz4)-cz1;
            rec(k + 1, c2, c3, c4, cnew, cz2, cz3, cz4, cznew);
            cnew = 2*(c1+c3+c4)-c2;
            cznew = 2.0*(cz1+cz3+cz4)-cz2;
            rec(k + 1, c1, c3, c4, cnew, cz1, cz3, cz4, cznew);
            cnew = 2*(c1+c2+c4)-c3;
            cznew = 2.0*(cz1+cz2+cz4)-cz3;
            rec(k + 1, c1, c2, c4, cnew, cz1, cz2, cz4, cznew);
            cnew = 2*(c1+c2+c3)-c4;
            cznew = 2.0*(cz1+cz2+cz3)-cz4;
            rec(k + 1, c1, c2, c3, cnew, cz1, cz2, cz3, cznew);
        }
    } else {
        pt.x = cz4.real()/c4; pt.y = cz4.imag()/c4;
        vpt.push_back(pt);
        if (k < G) {
            cnew = 2*(c2+c3+c4)-c1;
            cznew = 2.0*(cz2+cz3+cz4)-cz1;
            rec(k + 1, c2, c3, c4, cnew, cz2, cz3, cz4, cznew);
            cnew = 2*(c1+c3+c4)-c2;
            cznew = 2.0*(cz1+cz3+cz4)-cz2;
            rec(k + 1, c1, c3, c4, cnew, cz1, cz3, cz4, cznew);
            cnew = 2*(c1+c2+c4)-c3;
            cznew = 2.0*(cz1+cz2+cz4)-cz3;
            rec(k + 1, c1, c2, c4, cnew, cz1, cz2, cz4, cznew);
        }
    }
}


bool cmpvec(const Point &pt1, const Point &pt2)
{
    double c = pt1.y*pt2.x - pt2.y*pt1.x;
    if (c != 0)
        return c < 0;
    else
        return pt1.x*pt1.x + pt1.y*pt1.y < pt2.x*pt2.x + pt2.y*pt2.y;
}


double cross(const Point &pt10, const Point &pt11, const Point &pt20, const Point &pt21)
{
    return (pt11.x-pt10.x)*(pt21.y-pt20.y) - (pt11.y-pt10.y)*(pt21.x-pt20.x);
}


double area_convexhull(vector<Point> &v)
{
    int kmin;
    double xmin, ymin;
    int lenv = v.size();

    kmin = 0; xmin = v[0].x; ymin = v[0].y;
    for (int i = 1; i < lenv; ++i) {
        if (v[i].y < ymin || (v[i].y == ymin && v[i].x < xmin)) {
            kmin = i; xmin = v[i].x; ymin = v[i].y;
        }
    }
    if (kmin != 0)    swap(v[0], v[kmin]);
    for (int i = 0; i < lenv; ++i) {
        v[i].x -= xmin; v[i].y -= ymin;
    }
    sort(v.begin(), v.end(), &cmpvec);

    vector<Point> vch;
    int ktop;
    Point pnew, p1, p2;

    vch.push_back(v[0]);
    vch.push_back(v[1]);
    ktop = 1;
    for (int i = 2; i < lenv; ++i) {
        pnew = v[i];
        while (ktop > 0) {
            p1 = vch[ktop-1]; p2 = vch[ktop];
            if (cross(p2, pnew, p1, p2) >= 0) {
                vch.pop_back(); --ktop;
            } else {
                break;
            }
        }
        vch.push_back(pnew); ++ktop;
    }    

    double area = 0;
    int lenvch = vch.size();
    for (int i = 2; i < lenvch; ++i)
        area += fabs(0.5 * cross(vch[0], vch[i-1], vch[0], vch[i]));
    return area;
}


void calc()
{
    const double Pi = 3.14159265358979323846;
    int lenvquad = vquad.size();
    Quad quad;
    Cmp z1, z2, z3, z4;
    double area_ch, area_ratio;
    double s = 0;

    for (int i = 0; i < lenvquad; ++i) {
        quad = vquad[i];
        init_cord(quad.c1, quad.c2, quad.c3, quad.c4, z1, z2, z3, z4);
        vpt.clear();
        rec(1, quad.c1, quad.c2, quad.c3, quad.c4,
            (double)quad.c1*z1, (double)quad.c2*z2, (double)quad.c3*z3, (double)quad.c4*z4);
        area_ch = area_convexhull(vpt);
        area_ratio = area_ch * quad.c1 * quad.c1 / Pi;
        s += area_ratio;
        printf("[%2d]  (%3d, %2d, %2d, %2d)\n      AreaConvexHull = %.16f    AreaRatio = %.16f\n",
            i + 1, quad.c1, quad.c2, quad.c3, quad.c4, area_ch, area_ratio);
    }
    printf("S(%d, %d) = %.8f\n", T, G, s);    // S(50, 10) = 40.56007357
}


int main()
{
    clock_t t0 = clock();

    gen_init_quad();
    calc();

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
