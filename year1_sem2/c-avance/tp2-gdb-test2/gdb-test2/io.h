#ifndef _IO_H_
#define _IO_H_

#include "myTypes.h"

#define MAXLINESIZE 1024

/* io.c */
void InitData(char *fileName, data_t* data);
void ReadData(char *fileName, data_t* data);
void ReadConfig(char *fileDataName) ;

#endif /*_IO_H_ */

