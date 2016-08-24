#include <iostream>
#include <cstdio>

struct Heap {

private:
    int *my_a;
    int my_size;
    int my_capacity;

    int select_min_child(int p) {
        int c1 = p << 1;
        int c2 = (p << 1) + 1;
        return c2 <= my_size ? (std::min(my_a[c1], my_a[c2]) == my_a[c1] ? c1 : c2) : c1;
    }

    bool has_child(int idx) {
        return (idx << 1) <= my_size;
    }

public:
    void build(int* a, int size, int capacity) { // first elements is a[1]
        my_a = a;
        my_size = size;
        my_capacity = capacity;
        for (int i = size; i > 0; --i) {
            sift_down(i);
        }
    }

    void sift_down(int idx) {
        while (has_child(idx)) {
            int c = select_min_child(idx);
            if (my_a[c] < my_a[idx]) {
                std::swap(my_a[c], my_a[idx]);
            } else {
                break;
            }
            idx = c;
        }
    }

    /*
     void sift_up(int idx) {
        int p = idx >> 1;
        for (int p = idx >> 1; idx > 1 && my_a[p] > my_a[idx]; p >>= 1) {
            std::swap(my_a[p], my_a[idx]);
            idx = p;
        }
    }
    */

    int extract_min() {
        int r = my_a[1];
        my_a[1] = my_a[my_size--];
        sift_down(1);
        return r;
    }
};

void heap_sort(int *a, int len) {
    Heap heap;
    heap.build(a - 1, len, len + 1);
    for (int i = 1; i <= len; ++i) {
        int tmp = heap.extract_min();
        a[len - i] = tmp;
    }    
}

int main() {
    // changing input stream
    freopen("data.in", "r", stdin);
  
    // reading amount of numbers
    int n;
    std::cin >> n;
  
    // creating array and reading numbers
    int *a = new int[n];
    for (int i = 0; i < n; ++i) {
        std::cin >> a[i];
    }

    // calling the sort
    heap_sort(a, n);

    // checking result
    bool f = false;
    for (int i = 0; i < n - 1; ++i) {
        if (a[i] < a[i + 1]) {
            f = true;
        }
    }

    // printing result
    for (int i = 0; i < n; ++i) {
        std::cout << a[i] << ' ';
    }

    // checking status
    std::cout << (f ? "NO" : "YES") << "\n";
}
