/*
N = 100000
25501,565446417,1276167011
Elapsed time is 0.000 s

N = 1000000
254933,56473845380,127550790020
Elapsed time is 0.000 s

N = 10000000
2547908,5640334172757,12740634264867
Elapsed time is 0.031 s

N = 50000000
12738578,140985326874513,318469254709907
Elapsed time is 0.141 s
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <queue>
#include <algorithm>


using namespace std;


typedef long long ll;

struct Node {
    int x, y, k;
    Node() : x(0), y(0), k(0) {}
    Node(int x_in, int y_in, int k_in) : x(x_in), y(y_in), k(k_in) {}
};


/*
(x, y, k) -> (2*x-k, 2*x+y-1, x), (2*y+x-1, 2*y-k, y)
s.t. k >= 0, x > k, y > k
Init: (1, 1, 0)
*/
void calc(int n)
{
    queue<Node> qnode;
    Node node;
    int xx, yy, kk;
    ll s = 0, sx = 0, sy = 0;

    qnode.emplace(Node(1, 1, 0));
    while (!qnode.empty()) {
        node = qnode.front();
        qnode.pop();
        s++;
        sx += node.x;
        sy += node.y;
        xx = 2*node.x - node.k;
        yy = 2*node.x + node.y - 1;
        kk = node.x;
        if (xx > yy)
            swap(xx, yy);
        if (yy <= n)
            qnode.emplace(xx, yy, kk);
        if (node.x < node.y) {
            xx = 2*node.y + node.x - 1;
            yy = 2*node.y - node.k;
            kk = node.y;
            if (xx > yy)
                swap(xx, yy);
            if (yy <= n)
                qnode.emplace(xx, yy, kk);
        }
    }

    printf("N = %d\n", n);
    printf("%lld,%lld,%lld\n", s, sx, sy);
}


int main()
{
    clock_t t0 = clock();
    calc(10000000);
    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
