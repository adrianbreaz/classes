#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "graph.h"

node_t* node_new(node_t *node, int value)
{
    node_t *new_node = (node_t *)malloc(sizeof(node_t));
    new_node->id = value;
    new_node->next = node;

    return new_node;
}

void node_remove(node_t *node)
{
    if(node && node->next)
    {
        node_t *old_node = node->next;
        node->next = node->next->next;

        free(old_node);
    }
}

edge_t edge_create(int v, int w)
{
    edge_t new_edge = { v, w };

    return new_edge;
}

graph_t* graph_init(int n)
{
    graph_t *new_graph;
    int i;

    new_graph = (graph_t *)malloc(sizeof(graph_t));
    new_graph->nnodes = n;
    new_graph->nedges = 0;
    new_graph->dirty = 0;
    new_graph->list = (node_t **)malloc(n * sizeof(node_t));
    new_graph->cc = (int *)malloc(n * sizeof(int));
    new_graph->color = (int *)malloc(n * sizeof(int));
    for(i = 0; i < n; i++)
        new_graph->list[i] = NULL;

    return new_graph;
}

void graph_delete(graph_t *graph)
{
    if(graph)
    {
        int i;
        node_t *it;

        if(graph->list)
        {
            for(i = 0; i < graph->nnodes; i++)
            {
                it = graph->list[i];
                while(it->next)
                    node_remove(it);
                free(it);
            }
        }

        free(graph->list);
        free(graph->cc);
        free(graph);
    }
}

void graph_insert_edge(graph_t *graph, edge_t edge)
{
    graph->list[edge.source] = node_new(graph->list[edge.source], edge.target);
    graph->list[edge.target] = node_new(graph->list[edge.target], edge.source);
    graph->nedges++;
    graph->dirty = 1;
}

void graph_remove_edge(graph_t *graph, edge_t edge)
{
    node_t *slist = graph->list[edge.source];

    // find edge if it exists
    while(slist && slist->next && slist->next->id != edge.target)
        slist = slist->next;

    if(slist)
    {
        node_remove(slist);
        graph->nedges--;
        graph->dirty = 1;
    }
}

int graph_edges(graph_t *graph, edge_t *edges)
{
    int i, j = 0;
    node_t *it;
    edges = (edge_t *)malloc(graph->nedges * sizeof(edge_t));

    for(i = 0; i < graph->nnodes; i++)
    {
        it = graph->list[i];
        while(it)
            {
                edges[j++] = edge_create(i, it->id);
            it = it->next;
        }
    }

    return graph->nedges;
}

graph_t* graph_random(int v, int e)
{
    graph_t *rand_graph = graph_init(v);
    double p = 2.0 * e / v / (v - 1);
    int i, j;
    srand(time(NULL));

    for(i = 0; i < v; i++)
        for(j = 0; j < i; j++)
        {
            if(i == j) continue;
            if(p * RAND_MAX > rand())
                graph_insert_edge(rand_graph, edge_create(i, j));
        }
    return rand_graph;
}

void graph_show(graph_t *graph)
{
    int i;
    node_t *it;

    for(i = 0; i < graph->nnodes; i++)
    {
        printf("Node: %d Neighbours: ", i);
        it = graph->list[i];

        while(it)
        {
            printf("%d ", it->id);
            it = it->next;
        }
        printf("\n");
    }
}

// TODO: change to color graph
void graph_dfs(graph_t *graph, int node, int id, int color)
{
    node_t *it = graph->list[node];
    graph->cc[node] = id;

    while(it)
    {
        if(graph->cc[it->id] == -1)
            graph_dfs(graph, it->id, id);
        it = it->next;
    }
}

int graph_cc(graph_t *graph)
{
    int cc = 0, no_color = 0;
    int i;

    // if some edge was added/removed in the meantime
    if(graph->dirty)
    {
        // reset all ccs
        for(i = 0; i < graph->nnodes; i++) graph->cc[i] = -1;

        // compute new ones
        for(i = 0; i < graph->nnodes; i++)
        {
            if(graph->cc[i] == -1)
            {
                graph_dfs(graph, i, cc, no_color);
                cc++;
            }
        }

    }
    else
    {
        // if nothing happened the number of ccs is the max of graph->cc
        for(i = 0; i < graph->nnodes; i++)
            cc = (cc < graph->cc[i] ? graph->cc[i] : cc);
        ++cc;
    }

    for(i = 0;i < graph->nnodes; i++) printf("%d ", graph->cc[i]);
    printf("\n");
    graph->dirty = 0;
    return cc;
}

int graph_connected_nodes(graph_t *graph, int node1, int node2)
{
    if(graph->dirty)
        graph_cc(graph);

    return graph->cc[node1] == graph->cc[node2];
}

int graph_eulerian(graph_t *graph, int node1, int node2)
{
    int i, ct = 0;
    node_t *it;

    // degree of the nodes
    for(i = 0; i < graph->nnodes; i++)
    {
        it = graph->list[i];
        ct = 0;
        while(it)
        {
            ct++;
            it = it->next;
        }
        if((i == node1 || i == node2 ) && ct % 2 == 0) return 0;
        else if(ct % 2 == 1) return 0;
    }

    return 1;
}

int graph_bipartite(graph_t *graph)
{
    int i, c = 1;

    for(i = 0; i < graph->nnodes; i++) color[i] = -1;
    for(i = 0; i < graph->nnodes; i++)
    {
        if(graph->color[i] == -1)
            if(!graph_dfs(graph, i, 0, true))
                return 0;
    }

    return 1;
}
