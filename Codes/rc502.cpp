/*
OEIS A003477

Iteration 15
1,3,6,14,33,71,150,318,665,1375,2830,5798,1375,665,318,150,71,33,14,6,3,1
*/


#include <vector>
#include <set>
#include <utility>
#include <algorithm>
#include <iostream>

using namespace std;


using Pii = pair<int, int>;
vector<Pii> Vpt;


void gen_pt(int n)
{
    static const int Dx[4] = {1, 0, -1, 0};
    static const int Dy[4] = {0, -1, 0, 1};
    vector<int> seq((1 << n) - 1);

    seq[0] = 1;
    for (int k = 2; k <= n; k++) {
        int t = (1 << (k - 1)) - 1;
        seq[t] = 1;
        for (int i = 1; i <= t; i++)
            seq[t + i] = -seq[t - i];
    }

    Vpt.emplace_back(0, 0);
    Vpt.emplace_back(1, 0);
    int x = 1, y = 0, dir = 0;
    for (auto s : seq) {
        dir = (dir + s + 4) % 4;
        x += Dx[dir];
        y += Dy[dir];
        Vpt.emplace_back(x, y);
    }
}


void find_grp()
{
    static const int Dx2[4] = {1, 0, -1, 0};
    static const int Dy2[4] = {0, 1, 0, -1};
    static const int Dx3[4] = {1, -1, -1, 1};
    static const int Dy3[4] = {1, 1, -1, -1};
    static const int Dx4[4] = {0, -1, 0, 1};
    static const int Dy4[4] = {1, 0, -1, 0};
    static const int Mx[9] = {0, -1, -1, 0, 1, 1, 1, 0, -1};
    static const int My[9] = {0, 0, -1, -1, -1, 0, 1, 1, 1};
    set<pair<Pii, Pii>> sseg;
    vector<set<Pii>> vgrp;
    Pii p1, p2, p3, p4;

    p1 = Vpt[0];
    size_t len_vpt = Vpt.size();
    for (size_t i = 1; i < len_vpt; i++) {
        sseg.emplace(p1, Vpt[i]);
        sseg.emplace(Vpt[i], p1);
        p1 = Vpt[i];
    }

    for (const auto& p : Vpt) {
        p1 = p;
        for (int k = 0; k < 4; k++) {
            p2 = make_pair(p.first + Dx2[k], p.second + Dy2[k]);
            p3 = make_pair(p.first + Dx3[k], p.second + Dy3[k]);
            p4 = make_pair(p.first + Dx4[k], p.second + Dy4[k]);
            if (sseg.find(make_pair(p1, p2)) == sseg.end()
                    || sseg.find(make_pair(p2, p3)) == sseg.end()
                    || sseg.find(make_pair(p3, p4)) == sseg.end()
                    || sseg.find(make_pair(p4, p1)) == sseg.end())
                continue;

            bool isadj = false;
            Pii pbl;
            pbl = (k == 0) ? p1 : (k == 1) ? p4 : (k == 2) ? p3 : p2;
            for (auto& s : vgrp) {
                for (int i = 0; i < 9; i++) {
                    if (s.find(make_pair(pbl.first + Mx[i], pbl.second + My[i])) != s.end()) {
                        s.emplace(pbl);
                        isadj = true;
                        break;
                    }
                }
                if (isadj)
                    break;
            }
            if (!isadj)
                vgrp.emplace_back(set<Pii> {pbl});
        }
    }

    bool isfirst = true;
    for (auto& s : vgrp) {
        if (isfirst)
            isfirst = false;
        else
            cout << ",";
        cout << s.size();
    }
    cout << endl;
}


int main()
{
    const int N = 15;
    cout << "Iteration " << N << endl;

    gen_pt(N);
    find_grp();

    return 0;
}
