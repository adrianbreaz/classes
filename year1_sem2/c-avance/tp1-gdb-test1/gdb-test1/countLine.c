#include<stdio.h>

#include "myHeader.h"

int CountLine(FILE* fd) {
    char buf[MAXLEN] = "";
    int lineCounter = 0;

    while (fgets(buf, MAXLEN - 1, fd) == buf) {
        lineCounter++;
    }

    return lineCounter;
}
