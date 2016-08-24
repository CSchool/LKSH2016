#include "testlib.h"
#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
    setName("game interactor");
    registerInteraction(argc, argv);
    
    // reads number of queries from test (input) file
    int n = inf.readInt();
    vector<int> x;
    for (int i = 0; i < n; i++)
    {
        int t = inf.readInt();
        x.push_back(t);
    }
    cout << n << endl;
    int processed = 0;
    while (!ouf.eof())
    {
        ouf.skipBlanks();
        char c = ouf.readChar();
        ouf.readSpace();

        if (c == '?')
        {
            int w = ouf.readInt(1, n);
            if (processed >= 100)
                quit(_pe, "too many requests");
            cout << x[w - 1] << endl;
            processed++;
        }
        else
        {
            if (c == '+')
            {
                int w = ouf.readInt();
                tout << w << endl;
                ouf.skipBlanks();
                if (!ouf.eof())
                    quit(_pe, "found '+' but there is still output to process");
                quitf(_ok, "%d queries processed", processed);
            }
            else
            {
                quitf(_pe, "found '%c', expected '+' or '?'", c);
            }
        }
    }
    quitf(_pe, "'+' not found");
    return 0;
}
