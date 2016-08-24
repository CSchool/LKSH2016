#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <utility>
#include <algorithm>
#include <string>
#include <vector>
#include <iostream>
#include <set>
#include <functional>
#include <iterator>
#include <cstring>
#include <queue>
#include <stack>
#include <map>
#include <list>
#include <iomanip>
#include "testlib.h"

using namespace std;


int main(int argc, char *argv[])
{
    registerTestlibCmd(argc, argv);
    int n = inf.readInt();

    vector<int> list(n);

    for (int i = 0; i < n; ++i)
    {
        list[i] = inf.readInt();
    }

    vector<int> dp(n + 1, INT32_MAX);

    dp[0] = INT32_MIN;

    int len = 0;

    for (int i = 0; i < n; ++i)
    {
        int idx = upper_bound(dp.begin(), dp.end(), list[i]) - dp.begin();
        if ((dp[idx - 1] < list[i]) && (list[i] < dp[idx]))
        {
            len = max(len, idx);
            dp[idx] = list[i];
        }
    }

    int pa = ouf.readInt();

    if (pa != len)
        quitf(_wa, "length is invalid. Expected %d, found %d", len, pa);

    vector<int> pl(pa);

    for (int i = 0; i < pa; ++i)
    {
        pl[i] = ouf.readInt();
        if (i > 0)
            if (pl[i] <= pl[i - 1])
                quit(_wa, "sequence is not increasing");
    }

    int idx = 0;

    for (int i = 0; i < pa; ++i)
    {
        while (pl[i] != list[idx])
        {
            idx++;
            if (idx >= n)
                quit(_wa, "sequence is not subsequence");
        }
        idx++;
    }

    quit(_ok, "");
    
    return 0;
}
