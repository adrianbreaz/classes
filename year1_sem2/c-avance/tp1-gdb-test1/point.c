#include <stdio.h>

int main(void)
{
    int unsigned n = 5;
    unsigned int p = 5;

    printf("%d %ld\n", n, sizeof(n));
    printf("%d %ld\n", p, sizeof(p));
    return 0;
}
