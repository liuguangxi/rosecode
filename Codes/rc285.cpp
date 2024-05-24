/*
array[n+1] = n mod 26
for k > 1: array[n+k] = 2*array[n+k-1] - array[k-1] mod 26
*/


#include <bits/stdc++.h>
using namespace std;


using s8 = signed char;


string decode(const string &str, int n, int offset)
{
    int len = str.size();
    s8 *array = new s8[offset + len + 1];
    string dec_str(len, 'a');

    for (int i = 1; i <= n; i++)    array[i] = 1;
    array[n + 1] = n % 26;
    for (int i = n + 2; i <= offset + len; i++) {
        int k = i - n;
        int t = 2*array[i - 1] - array[k - 1];
        array[i] = (t + 26) % 26;
    }
    for (int i  = 1; i <= len; i++) {
        int t = (str[i - 1] - 'a' - array[offset + i] + 26) % 26;
        dec_str[i - 1] = char(t + 'a');
    }

    delete [] array;
    return dec_str;
}


void solve()
{
    constexpr int N = 29101923;
    constexpr int Offset = 1000000000;
    const string Str("yparjcfwnixigfwzt");

    string dec_str = decode(Str, N, Offset);
    cout << dec_str << endl;
}


int main()
{
    solve();
    return 0;
}
