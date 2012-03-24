#include <stdio.h>
#include <stdlib.h>

#include "readkey.h"

char keys[5][30] = {
    "nx",
    "ny",
    "saveData",
    NULL
};

int main(void)
{
    FILE *fd;
    int i;
    char line[MAXLINESIZE];

    fd = fopen("configrc", "r");

    for(i = 0; i < 4; i++)
    {
        fgets(line, MAXLINESIZE, fd);
        printf("%s = %d", toUpper(keys[i]), readKey(line, keys[i]));
    }

    fclose(fd);
    return 0;
}
