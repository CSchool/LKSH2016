#include<iostream>
#include<vector>
using namespace std;

int main()
{
    int n, sum = 0, s, b = 0, c = 0;
    cin >> n >> s;
    for (int i = 0; i < n; i++)
        sum += i + 1;
    sum -= s;
    if (sum < 3)
        cout << "no" << endl;
    else
    {
        cout << "yes" << endl;
        if (sum % 2 == 0)
            cout << sum / 2 - 1 << " " << sum / 2 + 1 << endl;
        else
            cout << sum / 2 << " " << sum / 2 + 1 << endl;
    }
}
