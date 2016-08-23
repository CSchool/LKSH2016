#include<iostream>

using namespace std;

int main()
{
    int m[7][7],n,k,l,s,mx,mxi;
    for (int i=1;i<=6;i++)
        for (int j=1;j<=6;j++)
            cin >> m[i][j];
    cin >> k;
    cin >> n;
    mx=0;
    if (k==1) {
        for (int i=1; i<=6; i++) {
            if (m[n][i]>mx) {
                mx=m[n][i];
                mxi=i;
            }
        }
    }
    else {
       for (int i=1; i<=6; i++) {
            if (m[i][n]>mx) {
                mx=m[i][n];
                mxi=i;
            }
        }
    }
    cout << mxi;
    return 0;
}
