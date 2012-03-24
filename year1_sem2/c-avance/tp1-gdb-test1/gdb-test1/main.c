#include<stdlib.h>
#include<stdio.h>

#include "myHeader.h"

int CountLine(FILE* fd);

int main(void) {
    char fileName[MAXLEN] = "data/input.dat";
    FILE *fd = NULL;
    int nbLines;
    int i = 0;
    char **lines;

    fd = fopen(fileName, "r");
    nbLines = CountLine(fd);
    printf("%d lines\n", nbLines);
    
    lines = (char **)malloc((nbLines + 1) * sizeof(char *));
    for (i = 0; i < nbLines; i++) {
        lines[i] = (char *)malloc(sizeof(char) * MAXLEN);
    }

    fseek(fd, 0, SEEK_SET);
    for (i = 0; i < nbLines; i++) {
    /*  char buf[MAXLEN] = ""; */
        if(fgets(lines[i], MAXLEN - 1, fd) == NULL){
            fprintf(stderr, "error: exit.\n");
            exit(EXIT_FAILURE);
        }
    }
    
    fclose(fd);
    return EXIT_SUCCESS;
}
