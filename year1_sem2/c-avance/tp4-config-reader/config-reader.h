#ifndef __CONFIGREADER_H__
#define __CONFIGREADER_H__

/*
 * TODO: make the keys into a hash map and not a linked list.
 * never implemented a hash map before. :X
 * */

typedef struct cnode {
    char *key;
    int value;
    cnode_t *next_key;
} cnode_t;

typedef struct reader {
    char *config_file;
    cnode_t *keys;
} creader_t;

/*
 * Add a key to the configuration reader
 * */
void add_key(creader_t *reader, const char *key, const int value);

/*
 * Remove a key from the configuration. Returns -1 if the key didn't exist,
 * 1 otherwise;
 * */
int remove_key(creader_t *reader, const char *key);

/*
 * Returns. 
 * */
int get_value(const creader_t *reader, const char *key, int *value);

/*
 * Create a config reader for a specific file
 * */
creader_t *init_config(const char *filename);

/*
 * Read config from the file. (removes all the current keys and refreshes)
 * */
void read_config(creader_t *reader);

/*
 * Write current configs to the specificed file.
 * */
void write_config(const creader_t *reader);

/*
 * Remove all keys and values.
 * */
void flush_config(creader_t *reader);

#endif /* __CONFIGREADER_H__ */
