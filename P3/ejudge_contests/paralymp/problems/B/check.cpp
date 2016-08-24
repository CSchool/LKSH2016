#include "testlib.h"

int main(int argc, char * argv[])
{
    registerTestlibCmd(argc, argv);
    int pa = ouf.readInt();
    if (pa != 100)
        quitf(_wa, "expected 100, found %d", pa);
    quitf(_ok, "answer is 100");
}
