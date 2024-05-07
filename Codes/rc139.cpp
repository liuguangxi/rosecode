#include <bits/stdc++.h>
using namespace std;


using ll =  long long;
constexpr int N = 30;
constexpr int T = 1000000000;
constexpr int TgtPeg = 2;

int a[N + 1] = {0,1,1,1,2,1,3,3,1,2,3,3,3,1,3,3,2,3,3,3,3,1,3,3,3,2,3,3,3,3,3};
ll total = 0;
int step = 0;


// Moving first n disks to peg-p
void moving(int n, int p)
{
    if (n == 1) {
        if (a[n] != p) {
            total += 10 * a[n] + p;
            a[n] = p;
            step++;
            if (step % 100000000 == 0)    printf("Step = %d\n", step);
            if (step == T)    return;
        }
    } else {
        if (a[n] == p) {
            moving(n - 1, p);
            if (step == T)    return;
        } else {
            moving(n - 1, 6 - a[n] - p);
            if (step == T)    return;
            total += 10 * a[n] + p;
            a[n] = p;
            step++;
            if (step % 100000000 == 0)    printf("Step = %d\n", step);
            if (step == T)    return;
            moving(n - 1, p);
            if (step == T)    return;
        }
    }
}


void print_res()
{
    for (int x = 1; x <= 3; x++) {
        for (int i = N; i >= 1; i--) {
            if (a[i] == x)    printf("%d", i);
        }
        printf(",");
    }
    printf("%lld\n", total);
}


int main()
{
    moving(N, TgtPeg);
    print_res();
    return 0;
}
