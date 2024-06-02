/*
moves = 33848
g = 524212 524236 524260 524284 524308 524332 524356

33848,524212,524236,524260,524284,524308,524332,524356
*/


#include <bits/stdc++.h>
using namespace std;


using Node = struct _Node {int jug[3]; int mov;};
using pii = pair<int, int>;    // move, gallon

constexpr int J1 = 7;
constexpr int J2 = 31;
constexpr int J3 = 1048575;
constexpr int Jm = J3;


int jugtonum(int j[3])
{
    return ((j[0] << 25) | (j[1] << 20) | j[2]);
}


void solve()
{
    deque<Node> queue;
    set<int> setj;
    vector<pii> vmove(Jm + 1);
    int totg = 0;

    Node node = {{0, 0, 0}, 0};
    queue.push_back(node);
    setj.insert(jugtonum(node.jug));
    Node nodenew;
    int x;

    while (totg < Jm && queue.size() > 0) {
        node = queue.front();
        queue.pop_front();
        for (int j = 0; j < 3; j++) {
            if (1 <= node.jug[j] && node.jug[j] <= Jm && vmove[node.jug[j]].second == 0) {
                totg++;
                vmove[node.jug[j]] = make_pair(node.mov, node.jug[j]);
                if (totg % 10000 == 0)
                    printf("[%d] moves = %d, g = %d\n", totg, node.mov, node.jug[j]);
            }
        }
        nodenew.mov = node.mov + 1;

        // Full one jug
        nodenew.jug[0] = J1;    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = J2;    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = J3;
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }

        // Empty one jug
        nodenew.jug[0] = 0;    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = 0;    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = 0;
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }

        // Fill one jug with another
        nodenew.jug[0] = max(0, node.jug[0]+node.jug[1]-J2);    nodenew.jug[1] = min(node.jug[0]+node.jug[1], J2);    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = min(node.jug[0]+node.jug[1], J1);    nodenew.jug[1] = max(0, node.jug[0]+node.jug[1]-J1);    nodenew.jug[2] = node.jug[2];
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = max(0, node.jug[1]+node.jug[2]-J3);    nodenew.jug[2] = min(node.jug[1]+node.jug[2], J3);
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = node.jug[0];    nodenew.jug[1] = min(node.jug[1]+node.jug[2], J2);    nodenew.jug[2] = max(0, node.jug[1]+node.jug[2]-J2);
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = max(0, node.jug[0]+node.jug[2]-J3);    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = min(node.jug[0]+node.jug[2], J3);
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }
        nodenew.jug[0] = min(node.jug[0]+node.jug[2], J1);    nodenew.jug[1] = node.jug[1];    nodenew.jug[2] = max(0, node.jug[0]+node.jug[2]-J1);
        x = jugtonum(nodenew.jug);
        if (setj.count(x) == 0) {
            setj.insert(x);
            queue.push_back(nodenew);
        }

    }

    sort(vmove.begin(), vmove.end());
    int moves = vmove[Jm].first;

    printf("\nmoves = %d\n", moves);
    printf("g = ");
    for (int i = 1; i <= Jm; i++) {
        if (vmove[i].first == moves)
            printf("%d ", vmove[i].second);
    }
    printf("\n");
}


int main()
{
    solve();
    return 0;
}
