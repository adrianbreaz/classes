#include<stdlib.h>
#include<stdio.h>
#include "myTypes.h"

double Interpolate(data_t* data, double x) {
	double res;
	double theta;
	int k;

	if (x < data->x[0] || x > data->x[data->nbElt - 1]) {
		printf("error: x=%g is out of the bounds.\n",x);
		printf("bounds:\nmin = %g\nmax=%g\n", data->val[0], data->val[data->nbElt - 1]);
		free(data->val);
        free(data->x);
        exit(EXIT_FAILURE);
	}

	k = 0;
	while (x < data->x[k]) {
		k++;
	}

	theta = (x - data->val[k + 1]) / (data->val[k] - data->val[k + 1]);
	res = theta * data->val[k] + (1 + theta) * data->val[k + 1];

	return res;
}
