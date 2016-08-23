#include <iostream>
using namespace std;

int main () {

	int x,k,max;
	int a[6][6];
	for (int i=0;i<6;++i) {
		for (int j=0;j<6;++j)
			cin >> a[i][j]; }
	cin >> x;
	cin >> k;

	k--;
	int l = 0; 
	int s = 0; 
	int p = 0; 
	int e = 0; 
	int r = -6; 

	if (x==1) {
		int n = 6;
		for (int i=0;i<6;++i) {
			p = a[k][i];
			int m = -12;
			if (a[k][i] != 0) 
				for (int j=0;j<6;++j) 
					if ((a[j][i]>m) && (j != k)) m = a[j][i];
			if (((m < n) && (a[k][i]  != 0)) || ((m == n) && (a[k][l] < a[k][i]) && (a[k][i] != 0))) n = m;
			e = p - m;
			if ((e > r) && (a[k][i] != 0)) {
				l = i;
				r = e;
			}
		}
		cout << l + 1;
	}

	if (x==2) {
		int n = 6;
		for (int i=0;i<6;++i) {
			p = a[i][k];
			int m = -12;
			if (a[i][k] != 0) 
				for (int j=0;j<6;++j) 
					if ((a[i][j]>m) && (j != k)) m = a[i][j];
			if (((m < n) && (a[i][k]  != 0)) || ((m == n) && (a[l][k] < a[i][k]) && (a[i][k] != 0))) n = m;
			e = p - m;
			if ((e > r) && (a[i][k] != 0)) {
				l = i;
				r = e;
			}
		}
		cout << l + 1;
	}

	return 0;
}
