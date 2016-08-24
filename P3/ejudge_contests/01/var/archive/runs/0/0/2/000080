#include <iostream>
//#include <conio.h>

using namespace std;

int main() {
	int n, s, l;

	cin >> n >> s;

	l = (n + 1) * n / 2;

	if ((s >= l - ((n - 1) + n)) && (s <= l - 3)) {
		cout << "yes" << endl;
		if ((l - s) % 2 == 0) {
			cout << (l - s) / 2 - 1 << " " << (l - s) / 2 + 1 << endl;
		}
		else
			cout << (l - s) / 2 << " " << (l - s) / 2 + 1 << endl;
	}
	else
		cout << "no" << endl;

	//_getch();
	return 0;
}