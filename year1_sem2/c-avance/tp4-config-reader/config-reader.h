#ifndef __CONFIGREADER_H__
#define __CONFIGREADER_H__

#define MAXLINESIZE 256
#define MAXKEYSIZE 64

/*
 * TODO: make the keys into a hash map and not a linked list.
 * never implemented a hash map before. :X
 * */
typedef struct cnode cnode_t;
typedef struct creader creader_t;

struct cnode {
    char *key;
    int value;
    cnode_t *next;
};

struct creader {
    char *filename;
    cnode_t *keys;
};

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
 * Returns 1 if the key exists, -1 if not. The value is stored in value;
 * */
int get_value(const creader_t *reader, const char *key, int *value);

/*
 * Create a config reader for a specific file
 * */
creader_t *init_reader(const char *filename);

/*
 * Read config from the file. (removes all the current keys and refreshes)
 * */
void read_config(creader_t *reader);

/*
 * Write current configs to the specificed file.
 * */
void write_config(const creader_t *reader);

/*
 * Write current configs to stdout.
 * */
void print_config(const creader_t *reader);

/*
 * Remove all keys and values.
 * */
void flush_config(creader_t *reader);

/*
 * Free everything
 */
int free_reader(creader_t *reader);

#endif /* __CONFIGREADER_H__ */
