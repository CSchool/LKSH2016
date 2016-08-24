#include <iostream>

short fib(int n)
{
    if (n <= 1)
        return 1;
    short f1 = fib(n - 1);
    short f2 = fib(n - 2);
    short f = f1 + f2;
    return f;
}

int main()
{
    int n;
    std::cin >> n;
    int f = fib(n);
    std::cout << f << "\n";
}
