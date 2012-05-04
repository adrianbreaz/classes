#include<stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "myHeader.h"

int main(void) {
	double A[DIM][DIM] = { //
			{ 106., 85., 60., 99., 80. },   /**/
			{ 85., 117., 66., 98., 58. },   /**/
			{ 60., 66., 74., 75., 41. },    /**/
			{ 99., 98., 75., 138., 50. },   /**/
			{ 80., 58., 41., 50., 98. }     /**/
			};

	const double b[DIM] = { 1142., 1024., 822., 1083., 1002. };
	const double xStart[DIM] = { 1, 1, 1, 1, 1 };
	double x[DIM] = { 0, 0, 0, 0, 0 };
	const double epsilon = 1e-6;

	/*
	 * call to the Steepest Descent algorithm
	 * to solve the system Ax = b
	 * */
	SolveLinearSystem(  //
			A,          /* matrix */
			b,          /* right term of the system */
			xStart,     /* first iteration */
			epsilon,    /* precision */
			x);

	ShowVect(x, DIM);

	return EXIT_SUCCESS;

}
