#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "config-reader.h"

/*
 * A somewhat safer copy, I hope.
 */
void mstrcpy(char *dest, const char *src)
{
    int len = strlen(src) + 1;

    dest = (char *)malloc(sizeof(char) * len);
    strncpy(dest, src, len);
    dest[len] = '\0';
}

void mfree(cnode_t *node)
{
    /* free string */
    free(node->key);

    /* free node */
    free(node);
}

void add_key(creader_t *reader, const char *key, const int value)
{
    cnode_t *new;

    new = (cnode_t *)malloc(sizeof(cnode_t));
    mstrcpy(new->key, key);
    new->value = value;
    new->next = NULL;

    if(!reader->keys)
        reader->keys = new;
    else
    {
        new->next = reader->keys;
        reader->keys = new;
    }
}

cnode_t *get_node_by_key(const creader_t *reader, const char *key, int mode)
{
    cnode_t *it = reader->keys;

    /* if it's empty */
    if(!it)
        return it;

    /* if not we look for it */
    while(it->next && strcmp(it->next->key, key))
        it = it->next;

    /* NOTE: does this need breaks since i'm returning? */
    switch(mode)
    {
        case 0:
            return it;
            break;
        case 1:
            if(strcmp(it->key, key) == 0)
                return it;
            return it->next;
            break;
        default:
            return NULL;
            break;
    }
}

int remove_key(creader_t *reader, const char *key)
{
    cnode_t *it = get_node_by_key(reader, key, 0);
    cnode_t *tmp;

    /* we didn't find anything */
    if(!it || !it->next)
        return -1;

    /* we did and we're FINISHING IT!!! */
    tmp = it->next;
    it->next = it->next->next;
    mfree(tmp);

    return 1;
}

int get_value(const creader_t *reader, const char *key, int *value)
{
    cnode_t *it = get_node_by_key(reader, key, 1);

    /* we didn't find it */
    if(!it)
        return -1;

    *value = it->value;
    return 1;
}

creader_t *init_reader(const char *filename)
{
    /* iei. we're making a new reader */
    creader_t *reader;
    reader = (creader_t *)malloc(sizeof *reader);

    /* and now it has a home. */
    mstrcpy(reader->filename, filename);
    printf("%s\n", reader->filename);
    reader->keys = NULL;

    return reader;
}

void read_config(creader_t *reader)
{
    FILE *fd;
    char buf[MAXLINESIZE];
    char key[MAXKEYSIZE];
    int value;

    /* reading */
    fd = fopen(reader->filename, "r");
    while(fgets(buf, MAXLINESIZE, fd))
    {
        /* reading */
        sscanf(buf, "%s = %d", key, &value);
        add_key(reader, key, value);
    }

    /* not reading anymore. */
    fclose(fd);
}

void write_config(const creader_t *reader)
{
    FILE *fd;
    cnode_t *it = reader->keys;

    fd = fopen(reader->filename, "w");

    /* reading */
    while(it)
    {
        /* writing */
        fprintf(fd, "%s = %d\n", it->key, it->value);
        it = it->next;
    }
    /* and arithmetic */
    fclose(fd);
}

void print_config(const creader_t *reader)
{
    cnode_t *it = reader->keys;

    /* reading */
    while(it)
    {
        /* writing */
        printf("%s = %d\n", it->key, it->value);
        it = it->next;
    }
    /* no arithmetic */
}

void flush_config(creader_t *reader)
{
    cnode_t *it = reader->keys;
    cnode_t *tmp;

    /* one, little two, little three... */
    while(it)
    {
        tmp = it;
        it = it->next;
        mfree(tmp);
    }
}

int free_reader(creader_t *reader)
{
    if(!reader)
        return 0;

    /* gone, gone, without a trace */
    flush_config(reader);
    free(reader->filename);
    free(reader);

    return 1;
}






















