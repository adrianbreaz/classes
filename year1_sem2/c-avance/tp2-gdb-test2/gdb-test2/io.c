#include<stdio.h>
#include<stdlib.h>

#include "io.h"

void InitData(char* fileName, data_t* data) {
	FILE* fd;
	int nbLines = 0;
	char buf[MAXLINESIZE];
    
	fd = fopen(fileName, "r");
	while (fgets(buf, MAXLINESIZE, fd)) {
		nbLines++;
	}
	fclose(fd);
    
	data->nbElt = nbLines;
	data->val = malloc(sizeof(*(data->val)) * nbLines);
	data->x = malloc(sizeof(*(data->val)) * nbLines);
}

void ReadData(char* fileName, data_t* data)
{
	FILE* fd;
	int i;
	char buf[MAXLINESIZE];

	fd = fopen(fileName, "r");

	for (i = 0; i < data->nbElt; i++)
    {
		fgets(buf, MAXLINESIZE, fd);
		sscanf(buf, "%lf %lf", &(data->x[i]), &(data->val[i]));
    }

	fclose(fd);
}

void ReadConfig(char *fileDataName) {
	FILE * fd;
	char buf[MAXLINESIZE];

	fd = fopen("data/config.dat", "r");
	fgets(buf, MAXLINESIZE, fd);
    sscanf(buf, "data = %s", fileDataName);
	fclose(fd);
}
