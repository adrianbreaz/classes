#include <stdio.h>
#include <stdlib.h>

#include "graph.h"

int main(int argc,char **argv)
{
    if(argc < 2) {
        printf("help! more args!\n");
        exit(1);
    }

    int v = atoi(argv[1]), e = atoi(argv[2]);
    graph_t *graph = graph_random(v, e);

    if(v < 20)
        graph_show(graph);

    printf("connected components: %d\n", graph_cc(graph));
    printf("connected %d and %d? %d\n", 2, 6, graph_connected_nodes(graph, 2, 6));
    printf("eulerian path between %d and %d? %d\n", 2, 6, graph_eulerian(graph, 2, 6));
    graph_delete(graph);
    return 0;
}
