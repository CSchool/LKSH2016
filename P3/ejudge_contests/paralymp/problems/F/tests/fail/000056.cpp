#include<fstream>
#include<vector>
using namespace std;

int main()
{
    ifstream fin("input.txt");
    ofstream fout("output.txt");
    int n, sum = 0, s, b = 0, c = 0;
    fin >> n >> s;
    for (int i = 0; i < n; i++)
        sum += i + 1;
    sum -= s;
    if (sum < 3)
        fout << "no" << endl;
    else
    {
        fout << "yes" << endl;
        if (sum % 2 == 0)
            fout << sum / 2 - 1 << " " << sum / 2 + 1<< endl;
        else
            fout << sum / 2 << " " << sum / 2 + 1<< endl;
    }
}
