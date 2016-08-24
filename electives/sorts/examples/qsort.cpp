#include <iostream>
#include <cstdio>
#include <ctime>
#include <cstdlib>


int partition(int* a, int len) {
    int r = len;
    int l = 1;

    while (l < r) {
        if (a[l] > a[0]) {
            std::swap(a[l], a[--r]);
        } else {
            ++l;
        }
    }

    std::swap(a[0], a[l - 1]);
    return l - 1;
} 


void qsort(int* a, int len) {
    if (len <= 1) {
        return;
    } else if (len == 2) {
        if (a[0] > a[1]) {
            std::swap(a[0], a[1]);
        }
    } else {
        int i = rand() % len;
        std::swap(a[0], a[i]);
        int t = partition(a, len);
        qsort(a, t);
        qsort(a + t + 1, len - t - 1);        
    }
}


int main() {
    int a[5] = { 5, 3, 2, 4, 1 };

    for (int i = 0; i < 5; ++i) {
        std::cout << a[i] << ' ';
    }
    std::cout << '\n';

    qsort(a, 5);

    for (int i = 0; i < 5; ++i) {
        std::cout << a[i] << ' ';
    }

    return 0;
}


