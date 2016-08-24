#include "testlib.h"
#include <string>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <string>
#include <cstdlib>

int num(char c)
{
    if (c == 'R')
        return 0;
    if (c == 'G')
        return 1;
    if (c == 'B')
        return 2;
    return -1;
}

std::vector<std::pair<unsigned long long, int> > v;

unsigned long long w[3] = {0, 0, 0};
bool u[3] = {false, false, false};

char mp[3] = {'R', 'G', 'B'};

int main(int argc, char * argv[])
{
    registerTestlibCmd(argc, argv);
    int n = inf.readInt();
    for (int i = 0; i < n; ++i)
    {
        long long l = inf.readInt();
        inf.skipBlanks();
        char c = inf.readChar();
        int q = num(c);
        if (q == -1)
            quitf(_fail, "Invalid color '%c'", c);
        v.push_back(std::make_pair(l, q));
    }
    std::sort(v.rbegin(), v.rend());
    for (std::vector<std::pair<unsigned long long, int> >::iterator it = v.begin(); it != v.end(); ++it)
    {
        w[it->second] += 5 * it->first * it->first;
        if (it != v.begin())
            w[(it - 1)->second] -= it->first * it->first;
    }

    while (!ouf.eof())
    {
        ouf.skipBlanks();
        std::string s = ouf.readLine();
        if ((s[0] != 'R') && (s[0] != 'G') && (s[0] != 'B'))
            quitf(_pe, "Invalid color");
        if ((s[1] != ' ') || (s[2] != '-') || (s[3] != ' '))
            quitf(_pe, "Invalid output format");
        unsigned long long am = std::atoll(s.c_str() + 4);
        if (u[num(s[0])])
            quitf(_pe, "Color repetition %c", s[0]);
        if (am != w[num(s[0])])
            quitf(_wa, "Wrong amount of color %c, expected %lld, found %lld", s[0], w[num(s[0])], am);
        u[num(s[0])] = true;
    }   

    for (int i = 0; i < 3; ++i)
    {
        if ((w[i] > 0) && !u[i])
            quitf(_wa, "Color %c not specified in output, it should be %lld", mp[i], w[i]);
    }

    quitf(_ok, "ok");
    return 0;
}

