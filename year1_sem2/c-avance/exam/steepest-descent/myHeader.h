#ifndef _MYHEADER_H
#define _MYHEADER_H

/* the dimension of the vector and matrices are set by this macro */
#define DIM 5


/* the following functions are defined in steepDescent.c */
double norm(double *V, int size);
void ShowVect(double *X, int size);
void SolveLinearSystem( //
		double A[DIM][DIM], /* matrix */
		const double* b, /* right term of the system */
		const double* xStart, /* first iteration */
		double epsilon, /* precision */
		double* x);

#endif
