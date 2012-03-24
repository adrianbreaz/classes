#ifndef __GRAPH_H__
#define __GRAPH_H__

typedef struct {
    int source;
    int target;
} edge_t;

typedef struct node {
    /* node 'data' */
    int id;
    /* linked list pointer. d'oh */
    struct node *next;
} node_t;

typedef struct {
    /* number of nodes */
    int nnodes;
    /* number of edges */
    int nedges;
    /* list of connected components in the graph */
    int *cc;
    /* node color for bipartite */
    int *color;
    /* node list (with adjacency list) */
    node_t **list;
    /* if true connected components are no longer valid */
    int dirty;
} graph_t;


/*
 * create an edge between the nodes v and w
 * */
edge_t edge_create(int v, int w);

/*
 * create a graph with n nodes
 * */
graph_t* graph_init(int n);

/*
 * deletes the graph
 * */
void graph_delete(graph_t *graph);

/*
 * insert an edge edge into the graph graph
 * */
void graph_insert_edge(graph_t *graph, edge_t edge);

/*
 * remove the edge edge from the graph graph
 * */
void graph_remove_edge(graph_t *graph, edge_t edge);

/*
 * return the number of edges in the graph and fill edges with all the edges.
 * */
int graph_edges(graph_t *graph, edge_t *edges);

/*
 * generate a random graph with n nodes and 'about' e edges
 *
 * NOTE: A graph with v nodes can have a maximum of v(v-1)/2 edges
 * to get around this we compute a probability p with which we add edges
 * to the graph.
 * */
graph_t* graph_random(int n, int e);

/*
 * pretty print the graph
 * */
void graph_show(graph_t *graph);

/*
 * number of connected components
 * */
int graph_cc(graph_t *graph);

/*
 * return 1 if there is a path from node1 to node2, 0 if not
 * */
int graph_connected_nodes(graph_t *graph, int node1, int node2);

/*
 * return 1 if there is an eulerian path from node1 to node2, 0 if not
 * */
int graph_eulerian(graph_t *graph, int node1, int node2);

/*
 * return 1 if graph is bipartite, 0 is not
 * */
int graph_bipartite(graph_t *graph);

#endif // __GRAPH_H__
