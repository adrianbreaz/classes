#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "readkey.h"

int readKey(const char *line, const char *key)
{
    int value = -1;
    int result;
    char fmtstr[MAXLINESIZE];
    
    sprintf(fmtstr, "%s = %%d", key);
    result = sscanf(line, fmtstr, &value);
    return result;
}

char *toUpper(const char *str)
{
    char *temp;
    int i = 0;

    temp = malloc(sizeof(*str) * (strlen(str) + 1));
    while(str[i] != '\0')
    {
        temp[i] = toupper(str[i]);
        i++;
    }

    return temp;
}
