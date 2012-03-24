#include <stdio.h>

int main(void)
{
    int *p;
    printf("char %lu\n", sizeof(char));
    printf("short %lu\n", sizeof(short));
    printf("int %lu\n", sizeof(int));
    printf("long %lu\n", sizeof(long));
    printf("long long %lu\n", sizeof(long long));
    printf("float %lu\n", sizeof(float));
    printf("double %lu\n", sizeof(double)); 
    printf("pointer %lu\n", sizeof(p));
    printf("size_t %lu\n", sizeof(size_t));
    
    int i = 1;
    double j = 1.0;
    if(i == j) printf("pie!\n");
    return 0;
}
/*
 * At home on a 64bit system:
    char 1
    short 2
    int 4
    long 8
    long long 8
    float 4
    double 8
    pointer 8
    size_t 8
 * At school on a 32 bit system:
*/
