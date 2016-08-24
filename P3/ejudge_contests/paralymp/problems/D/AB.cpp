#include <iostream>
#include <vector>

int main()
{
    int a, b;
    std::cin >> a >> b;
    a += b;
    if (a == 0)
    {
        std::cout << "0\n";
    }
    else
    {
        std::vector<int> v;
        while (a)
        {
            v.push_back(a % 7);
            a /= 7;
        }
        for (int i = v.size() - 1 ; i >= 0 ; --i)
            std::cout << v[i];
        std::cout << "\n";
    }
	return 0;
}
