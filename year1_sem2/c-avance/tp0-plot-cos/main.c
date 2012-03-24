/*
 * TP1 - graph
 *
 * make a little thing that prints out the values of
 * cos for a certain interval for use with gnuplot.
 * */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define UNUSED(x) (void)x

int main(int argc, char **argv)
{
    UNUSED(argc);

    double x, step, a = -2.0, b = 1.6;
    int n = atoi(argv[1]);

    step = (b - a) / n;
    printf("#   X   Y\n");
    for(x = a; x <= b; x += step)
        printf("%.3g %.3g\n", x, cos(x));
    
    return 0;
}
