#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "config-reader.h"

static void mfree(cnode_t *node)
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
    new->key = strdup(key);
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

int remove_key(creader_t *reader, const char *key)
{
    cnode_t *it = reader->keys;
    cnode_t *tmp;

    /* there's nothing here */
    if(!it)
        return 0;

    /* it's the first one! */
    if(!strcmp(it->key, key))
    {
        tmp = it;
        reader->keys = it->next;
        mfree(tmp);
        return 1;
    }

    /* look through the rest */
    while(it->next && strcmp(it->next->key, key))
        it = it->next;

    /* oh well, it wasn't meant to be */
    if(!it->next)
        return 0;

    tmp = it->next;
    it->next = it->next->next;
    free(tmp);

    return 1;
}

int get_value(const creader_t *reader, const char *key, int *value)
{
    cnode_t *it = reader->keys;

    /* there's nothing here */
    if(!it)
        return 0;

    /* look elsewhere */
    while(it && strcmp(it->key, key))
        it = it->next;

    /* still no luck */
    if(!it)
        return 0;

    *value = it->value;
    return 1;
}

creader_t *init_reader(const char *filename)
{
    /* iei. we're making a new reader */
    creader_t *reader;
    reader = (creader_t *)malloc(sizeof *reader);

    /* and now it has a home. */
    reader->filename = strdup(filename);
    reader->keys = NULL;

    return reader;
}

void read_config(creader_t *reader)
{
    /* first thing's first. */
    flush_config(reader);

    FILE *fd;
    char buf[MAXLINESIZE];
    char key[MAXKEYSIZE];
    int value;

    /* reading */
    fd = fopen(reader->filename, "r");
    while(fgets(buf, MAXLINESIZE, fd))
    {
        /* fancy reading:
         *      - first space is for ignoring all starting whitespace
         *      - [^= ] is a normal regular expression that reads until the
         *      first = or space to support x=0 and x = 0
         *      - ending whitespace is ignored automatically
         */
        sscanf(buf, " %[^= ] = %d", key, &value);
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
    printf("\n");
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
