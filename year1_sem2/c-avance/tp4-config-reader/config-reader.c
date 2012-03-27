#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "config-reader.h"

void mstrcpy(char *dest, const char *src)
{
    int len = strlen(src) + 1;

    dest = (char *)malloc(sizeof(char) * len);
    strncpy(dest, src, len);
}

void add_key(creader_t *reader, const char *key, const int value)
{
    cnode_t new_node;
 
    new_node = (cnode_t *)malloc(sizeof(cnode_t));
    mstrcpy(new_node->key, key);
    new_node->value = value;
    new_node->next_key = NULL;

    if(!reader->keys)
    {
        reader->keys = new_node;
    } 
    else
    {
        new_node->next_key = reader->keys;
        reader->keys = new_node;
    }
}

int remove_key(creader_t *reader, const char *key)
{
    /* if it's empty */
    if(!reader->keys)
        return -1;

    /* if it's the first and only element */
    if(!reader->keys->next_key && !strcmp(reader->keys->key, key))
    {
        free(reader->keys->key);
        free(reader->keys);
        reader->keys = NULL;
        return 1;
    }

    cnode_t it = reader->keys;

    while()
        it = it->next_key;
    
}

creader_t *init_config(char *filename)
{
    creader_t *reader;

    reader = (creader_t *)malloc(sizeof *reader);
    mstrcpy(reader->config_file, filename;
    reader->keys = NULL;
    
    return reader;
}
