#include "checkutils.h"
#include <stdio.h>

int main(int argc, char **argv)
{
    int n, s, z;

    checker_in_open(argv[1]);
    checker_read_int_ex(f_arr[0], fatal_PE, "N", 1, &n);
    checker_read_int_ex(f_arr[0], fatal_PE, "S", 1, &s);
    checker_eof(f_arr[0], fatal_PE, "test input");
    checker_in_close();

    if (n < 3 || n > 10)
        fatal_PE("N is out of range");
    z = n * (n + 1) / 2;
    if (s < 0 || s > z)
        fatal_PE("S is out of range");

    return 0;
}

