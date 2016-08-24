#include "testlib.h"
#include <string>

int main(int argc, char * argv[])
{
    registerTestlibCmd(argc, argv);
    int n = inf.readInt();
    int s = inf.readInt();
    int mm = (n + 1) * n / 2;
    int q = mm - s;
    std::string st = ouf.readLine();
    if (st == "no")
    {
        if ((q > 2) && (q < 2 * n))
            quitf(_wa, "expected 'yes', found 'no'");
        quitf(_ok, "answer is 'no'");
    }

    if (st == "yes")
    {
        int a = ouf.readInt();
        int b = ouf.readInt();
        if ((a < 1) || (a > n))
            quitf(_pe, "answer %d is not in bounds [1..N]", a);
        if ((b < 1) || (b > n))
            quitf(_pe, "answer %d is not in bounds [1..N]", b);
        if (a == b)
            quitf(_pe, "two answers must not be equal (%d == %d)", a, b);
        if (mm - a - b != s)
            quitf(_wa, "answer (%d, %d) is wrong", a, b);
        quitf(_ok, "answer is (%d, %d)", a, b);
    }

    quitf(_pe, "expected 'yes' or 'no'", st);
    return 0;
}

