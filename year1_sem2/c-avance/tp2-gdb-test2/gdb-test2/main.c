#include <stdlib.h>
#include <stdio.h>
#include "io.h"
#include "myTypes.h"
#include "interpolate.h"

#define nx 1000

int main(void) {
	data_t data;
	char dataFileName[MAXLINESIZE];
	double x;
	double y;
	double a;
	double b;
	int i;
	double dx;

	ReadConfig(dataFileName);
	InitData(dataFileName, &data);
	ReadData(dataFileName, &data);

	a = -1;
	b = 1;
	dx = (b - a) / nx;
	for (i = 0; i < nx; i++) {
		x = a + i * dx;
		y = Interpolate(&data, x);
		printf("%f %f\n", x, y);
	}

    free(data.val);
    free(data.x);
	printf("# done\n");

	return EXIT_SUCCESS;
}
