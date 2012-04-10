#ifndef __MESH_H__
#define __MESH_H__

typedef struct node_t node_t;
typedef struct edge_t edge_t;
typedef struct cell_t cell_t;
typedef struct mesh_t mesh_t;

struct node_t {
    /* x coordinate */
    double      x;
    /* y coordinate */
    double      y;
    /* number of node attributes (UNUSED)*/
    int         nb_attrs;
    /* attributes (UNUSED) */
    char        **attr;
    /* on which border of the mesh it is located (UNUSED) */
    int         border;
};

/*
 * An edge is formed by two nodes. By convetion if the edge is completely
 * horizontal the left node is down and the right node is up.
 *
 * */
struct edge_t {
    /* top node */
    node_t      *up;
    /* bottom node */
    node_t      *down;
    /* on which border are we located (UNUSED) */
    int         border;
    /* length of the edge (UNUSED) */
    double      length;
};

struct cell_t {
    /* Pointers to the nodes in the cell */
    node_t      **node;
    int         *nodes_id;
    /* Pointers to the edges in the cell */
    edge_t      **edge;
    /* Type of the cell. Also tells the number of nodes and edges */
    int         nb_nodes;
    /* Area of the cell (UNUSED) */
    double      area;
};

struct mesh_t {
    /* Dimension of the mesh (restricted to 2) */
    int         dim;
    /* Total number of nodes in the mesh */
    int         nb_nodes;
    /* Total number of edges in the mesh */
    int         nb_edges;
    /* Total number of cells in the mesh */
    int         nb_cells;
    /* Actual elements of the mesh */
    node_t      *node;
    edge_t      *edge;
    cell_t      *cell;
};

/* Initializes the mesh */
mesh_t *init_mesh();

/* Frees all the mesh */
void free_mesh(mesh_t *mesh);

/* Read data from all the files */
void read_data(mesh_t *mesh, const char *file_basename);

/* Transform it to the VTK format and write it to a file */
void write_data_to_vtk(mesh_t *mesh, const char *dst_file);

#endif /* __MESH_H__ */
