#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<assert.h>

#include "myHeader.h"

/*
 * this function computes the norm of a vector
 * arguments:
 *  - V [input]: (double*) elements that composes the vector coordinates
 *  - size [input]: (int) that defines the size of the vector
 * return value:
 *  - return a double that is the norm of the vector
 */
double norm(double *V, int size) {
	double res = 0.0;
	int i;

    /* compute the L2 norm */
    for(i = 0; i < size; i++)
        res += V[i] * V[i];
    res = sqrt(res);

	return res;
}

/*
 * this function displays the coordinates of a vector
 * arguments:
 *  - V [input]: (double*) elements that composes the vector coordinates
 *  - size [input]: (int) that defines the size of the vector
 * return value:
 *  - none
 */
void ShowVect(double *X, int size) {
	int i = 0;

	for(i = 0; i < size; i++)
        printf("%g ", X[i]);
    printf("\n");
}

/*
 * Compute the product between a matrix and a vector
 * Arguments:
 *  - A     - (double **) matrix
 *  - x     - (double *) vector
 *  - result- (double *) the reuslt of A*x
 *  - nxm   - size of matrix
 *  - m     - size of vector
 *  Output:
 *  - none
 * */
void MultiplyMatrixByVector(
        double A[DIM][DIM],
        const double *x,
        double *result,
        int n, int m) {
    int i, j;

    for(i = 0; i < n; i++)
        result[i] = 0.0;

    for(i = 0; i < n; i++)
        for(j = 0; j < m; j++)
            result[i] += A[i][j] * x[j];
}

/*
 * Computes the difference between x an y.
 * Arguments:
 *  - x      - (double *) vector
 *  - y      - (double *) vector
 *  - result - (double *) difference vector
 *  - size   - (int) size of x and y
 * Output:
 *  none
 * */
void SubstractVectors(
        const double *x, 
        const double *y, 
        double *result, 
        int size) {
    int i;

    for(i = 0; i < size; i++)
        result[i] = x[i] - y[i];
}

/*
 * this function solve the linear system Ax = b by a steepest descent method
 * arguments :
 *		- A [input]: double[][] array that defines the matrix
 *		- b [input]: (double*) that defines the right term of the system
 *      - xStart [input]: (double*) initial value of the sequence
 *      - epsilon [input]: (double) precision threshold
 *      - x[output]: (double*) stores the approximate solution
 *  return value:
 * - none
 */
void SolveLinearSystem(         //
		double A[DIM][DIM],     /* matrix */
		const double* b,        /* right term of the system */
		const double* xStart,   /* first iteration */
		double epsilon,         /* precision */
		double* x) {            /* output value: approximate solution */
	int nbStep = 0;
	double *r = NULL;
    double *tmp_result = NULL;
    double p, q, alpha;
    int i;

    /* allocate vectors and init to 0 */
	r = calloc(DIM, sizeof(double));
    tmp_result = calloc(DIM, sizeof(double));

	if (NULL == r) {
		printf("error.\n");
		exit(-1);
	}

    for(i = 0; i < DIM; i++)
        x[i] = xStart[i];

	do {
		printf("performing step = %d norm(r) = %g\n", nbStep, norm(r, DIM));

		/* Compute r = b - Ax */
        MultiplyMatrixByVector(A, x, tmp_result, DIM, DIM);
        SubstractVectors(b, tmp_result, r, DIM);

		/* Compute alpha = p/q = (r^T r) / (r^T A r)*/
        /*      Compute r^T r */
        p = 0.0;
        for(i = 0; i < DIM; i++)
            p += r[i] * r[i];

        /*      Compute r^T (A r) */
        MultiplyMatrixByVector(A, r, tmp_result, DIM, DIM);
        q = 0.0;
        for(i = 0; i < DIM; i++)
            q += r[i] * tmp_result[i];

        /*      finally alpha */
        alpha = p/q;

		/* Compute x := x + alpha*r */
        for(i = 0; i < DIM; i++)
            x[i] += alpha * r[i];

		nbStep++;
	} while (norm(r, DIM) > epsilon);

	free(r);
    free(tmp_result);
}
