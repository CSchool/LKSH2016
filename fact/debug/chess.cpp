/*
  Определить одного ли цвета клетки шахматной доски.
*/
#include <iostream>

int main()
{
    int x, y, z, r;
    std::cin >> x >> y >> z >> r;

    if (x % 2 == 1)
    {
        if (y % 2 == 1)
            x = 1;
    }
    else
        if (y % 2 == 1)
            x = 0;

    if (z % 2 == 1)
    {
        if (r % 2 == 1) 
            z = 1;
    }
    else
        if (r % 2 == 1)
            z = 0;

    if (x == z)
        std::cout << "YES";
    else
        std::cout << "NO";
}
