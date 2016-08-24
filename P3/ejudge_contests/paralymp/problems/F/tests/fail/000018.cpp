#include<fstream>
#include<vector>
using namespace std;

int main()
{
    ifstream fin("input.txt");
    ofstream fout("output.txt");
    int n, sum = 0, s, max = 0, b = 0, c = 0;
    fin >> n >> s;
    vector < int > a(n);
    for (int i = 0; i < n; i++)
    {
        a[i] = i + 1;
        sum += a[i];
    }
    for (int j = 0; j < n; j++)
    {
        for (int k = j + 1; k < n; k++)
        {
            if (a[j] + a[k] == sum - s)
            {
                b = a[j];
                c = a[k];
            }
        }
    }
    if (c == 0 || b == 0)
        fout << "no" << endl;
    else
        fout << b << " " << c << endl;
}
