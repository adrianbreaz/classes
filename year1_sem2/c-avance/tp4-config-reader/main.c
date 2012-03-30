#include <stdio.h>
#include <stdlib.h>

#include "config-reader.h"

int main(void)
{
    int v;
    creader_t *reader = init_reader("configrc");

    read_config(reader);

    print_config(reader);
    add_key(reader, "thisisworking", 42);
    print_config(reader);

    remove_key(reader, "thisisworking");
    print_config(reader);

    if(get_value(reader, "x", &v))
        printf("FOUND x = %d\n", v);
    else
        printf("NOT FOUND x\n");

    if(get_value(reader, "xadas", &v))
        printf("FOUND xadas = %d\n", v);
    else
        printf("NOT FOUND xadas\n");

    write_config(reader);
    free_reader(reader);

    return 0;
}
